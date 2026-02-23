import re
import os
import time
import numpy as np
import soundfile as sf
import onnxruntime as ort
from kokoro_onnx import Kokoro
from concurrent.futures import ProcessPoolExecutor

# ワーカープロセス用グローバル
_KOKORO_INSTANCE = None

def init_worker(model_path, voices_path):
    global _KOKORO_INSTANCE
    # ONNX Runtime の並列実行設定を最適化 (M4の競合を防ぐ)
    sess_options = ort.SessionOptions()
    sess_options.intra_op_num_threads = 1
    sess_options.inter_op_num_threads = 1
    # プロセスごとに独立したインスタンスを生成
    _KOKORO_INSTANCE = Kokoro(model_path, voices_path, sess_options=sess_options)

def generate_chunk_audio(chunk_data):
    index, text = chunk_data
    start_time = time.time()
    
    try:
        # 音素変換（デバッグ用）
        p_count = len(_KOKORO_INSTANCE.tokenizer.phonemize(text, lang='ja'))
        samples, _ = _KOKORO_INSTANCE.create(text, voice="jf_alpha", speed=1.1, lang="ja")
        
        process_time = time.time() - start_time
        audio_duration = len(samples) / 24000
        rtf = process_time / audio_duration
        return index, samples, text, process_time, rtf, p_count, None
    except Exception as e:
        return index, None, text, 0, 0, 0, str(e)

def greedy_pack_phonemes(kokoro, text, max_phonemes=450): # 安全のため450に設定
    # 句点、改行、および「読点」でも積極的に分割してパッキングを最適化
    raw_sentences = re.split(r'(?<=[。？！、])\s*|\n+', text)
    packed_chunks = []
    buffer_text = ""
    for s in raw_sentences:
        s = s.strip()
        if not s: continue
        test_text = buffer_text + " " + s if buffer_text else s
        p_count = len(kokoro.tokenizer.phonemize(test_text, lang='ja'))
        if p_count < max_phonemes:
            buffer_text = test_text
        else:
            if buffer_text: packed_chunks.append(buffer_text)
            buffer_text = s
    if buffer_text: packed_chunks.append(buffer_text)
    return packed_chunks

def run_onnx_parallel_generation():
    model_path = "kokoro-v1.0.onnx"
    voices_path = "voices-v1.0.bin"
    smd_file = "lecture.smd"

    # パッキング用の仮インスタンス
    temp_kokoro = Kokoro(model_path, voices_path)
    with open(smd_file, "r", encoding="utf-8") as f:
        content = f.read()

    parts = re.split(r'(\(break: \d+(?:ms|s)\))', content)
    all_tasks = []
    sequence_map = []
    
    print("-" * 70)
    print("🚀 M4 Optimized Parallel Engine (v2: Contention Free)")
    print("-" * 70)

    for part in parts:
        part = part.strip()
        if not part: continue
        break_match = re.match(r'\(break: (\d+)(ms|s)\)', part)
        if break_match:
            val, unit = int(break_match.group(1)), break_match.group(2)
            sequence_map.append({'type': 'pause', 'duration': val / 1000 if unit == 'ms' else val})
        else:
            clean_text = re.sub(r'#\[\w+\]', '', part)
            clean_text = re.sub(r'^#.*$', '', clean_text, flags=re.MULTILINE).strip()
            if not clean_text: continue
            chunks = greedy_pack_phonemes(temp_kokoro, clean_text)
            for chunk in chunks:
                task_id = len(all_tasks)
                all_tasks.append((task_id, chunk))
                sequence_map.append({'type': 'audio', 'task_id': task_id})

    # M4/M4 Proならコア数の半分程度にするのが最もスループットが出る場合があります
    num_workers = max(1, os.cpu_count() // 2)
    print(f"[*] Dispatching to {num_workers} optimized workers...")
    
    total_start_time = time.time()
    results = {}
    
    with ProcessPoolExecutor(max_workers=num_workers, initializer=init_worker, initargs=(model_path, voices_path)) as executor:
        completed = 0
        for t_id, audio, text, p_time, rtf, p_count, err in executor.map(generate_chunk_audio, all_tasks):
            completed += 1
            if err:
                print(f"[{completed:03d}] ERROR: {err} at '{text[:20]}...'")
                continue
            
            results[t_id] = audio
            preview = (text[:25] + '..') if len(text) > 25 else text
            print(f"[{completed:03d}/{len(all_tasks):03d}] {preview:<30} | {p_count:3} ph | {p_time:.3f}s (RTF: {rtf:.4f})")

    # 再結合と保存
    final_audio_list = []
    sample_rate = 24000
    for item in sequence_map:
        if item['type'] == 'pause':
            final_audio_list.append(np.zeros(int(sample_rate * item['duration'])))
        else:
            if item['task_id'] in results:
                final_audio_list.append(results[item['task_id']])

    if final_audio_list:
        final_audio = np.concatenate(final_audio_list)
        sf.write("lecture_onnx_parallel.wav", final_audio, sample_rate)
        
        total_time = time.time() - total_start_time
        audio_dur = len(final_audio) / sample_rate
        print("\n" + "=" * 70)
        print(f"📊 PERFORMANCE: {audio_dur/total_time:.1f}x Real-time | System RTF: {total_time/audio_dur:.4f}")
        print("=" * 70)

if __name__ == "__main__":
    run_onnx_parallel_generation()