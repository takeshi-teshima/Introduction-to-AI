import re
import os
import time
import numpy as np
import soundfile as sf
from kokoro import KPipeline
from concurrent.futures import ProcessPoolExecutor

# ワーカープロセスでパイプラインを保持
_PIPELINE_INSTANCE = None

def init_worker():
    """各プロセスで日本語パイプラインを初期化"""
    global _PIPELINE_INSTANCE
    # PyTorch版は内部でスレッド管理が優秀なので、そのまま初期化します
    _PIPELINE_INSTANCE = KPipeline(lang_code='j')

def generate_chunk_pytorch(chunk_data):
    """KPipelineを使用して音声を生成するワーカー関数"""
    index, text = chunk_data
    start_time = time.time()
    
    try:
        # KPipeline は内部で自動的に長文を分割してくれるため、
        # 510トークンの制限を気にする必要がありません
        generator = _PIPELINE_INSTANCE(text, voice='jf_alpha', speed=1.1)
        audio_segments = []
        for _, _, audio in generator:
            audio_segments.append(audio)
        
        if not audio_segments:
            return index, None, text, 0, 0, "No audio generated"
            
        samples = np.concatenate(audio_segments)
        process_time = time.time() - start_time
        audio_duration = len(samples) / 24000
        rtf = process_time / audio_duration
        
        return index, samples, text, process_time, rtf, None
    except Exception as e:
        return index, None, text, 0, 0, str(e)

def run_parallel_pytorch():
    smd_file = "lecture.smd"
    if not os.path.exists(smd_file):
        print(f"Error: {smd_file} が見つかりません。")
        return

    with open(smd_file, "r", encoding="utf-8") as f:
        content = f.read()

    # セクション分割
    parts = re.split(r'(\(break: \d+(?:ms|s)\))', content)
    all_tasks = []
    sequence_map = []
    
    print("-" * 75)
    print("🚀 M4 Multi-Core PyTorch Engine: Parallelizing KPipeline")
    print("-" * 75)

    # タスクの構成
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
            
            # PyTorch版は自動分割が優秀なので、大きな塊のままタスクに投げます
            task_id = len(all_tasks)
            all_tasks.append((task_id, clean_text))
            sequence_map.append({'type': 'audio', 'task_id': task_id})

    # M4のコア数に合わせてプロセスを起動
    num_workers = min(len(all_tasks), os.cpu_count())
    print(f"[*] Dispatching {len(all_tasks)} tasks to {num_workers} workers...")
    
    total_start_time = time.time()
    results = {}
    
    with ProcessPoolExecutor(max_workers=num_workers, initializer=init_worker) as executor:
        completed = 0
        for t_id, audio, text, p_time, rtf, err in executor.map(generate_chunk_pytorch, all_tasks):
            completed += 1
            if err:
                print(f"[{completed:03d}] ERROR: {err}")
                continue
            
            results[t_id] = audio
            # 全文表示（長すぎる場合は適宜カット）
            display_text = text.replace('\n', ' ')
            print(f"[{completed:03d}/{len(all_tasks):03d}] {display_text[:40]:<40} | {p_time:.3f}s (RTF: {rtf:.4f})")

    # 再結合
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
        sf.write("lecture_full.wav", final_audio, sample_rate)
        
        total_time = time.time() - total_start_time
        audio_dur = len(final_audio) / sample_rate
        print("\n" + "=" * 75)
        print(f"📊 FINAL PERFORMANCE: {audio_dur/total_time:.1f}x Real-time speed on M4")
        print(f"Total Time: {total_time:.2f}s | Audio: {audio_dur:.1f}s | System RTF: {total_time/audio_dur:.4f}")
        print("=" * 75)

if __name__ == "__main__":
    run_parallel_pytorch()