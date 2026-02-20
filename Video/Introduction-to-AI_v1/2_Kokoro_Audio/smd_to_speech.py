import re
import numpy as np
import soundfile as sf
from kokoro import KPipeline

def run_generation():
    # パイプライン初期化
    pipeline = KPipeline(lang_code='j')
    
    # SMDファイルの読み込み
    with open("lecture.smd", "r", encoding="utf-8") as f:
        content = f.read()

    # コメント行やスライド見出しを除去
    lines = [l for l in content.splitlines() if not l.startswith("#")]
    full_text = "\n".join(lines)

    # (break: 1s) などのタグで分割
    parts = re.split(r'(\(break: [\d\w]+\))', full_text)
    
    combined_audio = []
    sample_rate = 24000

    print("音声生成を開始します...")

    for part in parts:
        part = part.strip()
        if not part:
            continue

        # breakタグの解析
        break_match = re.match(r'\(break: (\d+)(ms|s)\)', part)
        if break_match:
            val, unit = int(break_match.group(1)), break_match.group(2)
            duration = val / 1000 if unit == 'ms' else val
            print(f"  [Pause] {duration}s")
            silence = np.zeros(int(sample_rate * duration))
            combined_audio.append(silence)
        else:
            # タグを除去してテキスト生成
            clean_text = re.sub(r'#\[\w+\]', '', part).strip()
            if not clean_text:
                continue
            
            print(f"  [Text] {clean_text[:20]}...")
            generator = pipeline(clean_text, voice='jf_alpha', speed=1.1)
            for _, _, audio in generator:
                combined_audio.append(audio)

    if combined_audio:
        final_audio = np.concatenate(combined_audio)
        output_file = "lecture_full.wav"
        sf.write(output_file, final_audio, sample_rate)
        print(f"\n完了！ {output_file} を書き出しました。")

if __name__ == "__main__":
    run_generation()