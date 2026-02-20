import os
import sys
import logging

# --- 1. ノイズ抑制 (インポートより先に実行) ---
os.environ["HF_HUB_OFFLINE"] = "1"
os.environ["TOKENIZERS_PARALLELISM"] = "false"
logging.getLogger("huggingface_hub").setLevel(logging.ERROR)
logging.getLogger("torch").setLevel(logging.ERROR)

import warnings
warnings.filterwarnings("ignore")

import re
import json
import hashlib
import time
import click
import numpy as np
import soundfile as sf
from kokoro import KPipeline
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

SAMPLE_RATE = 24000

# モデルを一度だけロード (スレッド間で共有)
GLOBAL_PIPELINE = KPipeline(lang_code='j', repo_id='hexgrad/Kokoro-82M')

def clean_smd_text(text):
    """SpeechMarkdownの制御記号をパース"""
    text = re.sub(r'\(note:.*?\)', '', text, flags=re.DOTALL)
    text = re.sub(r'\(comment:.*?\)', '', text, flags=re.DOTALL)
    text = re.sub(r'#\[\w+\]', '', text)
    return text.strip()

def generate_section_audio(task):
    """スレッド並列用のワーカー関数"""
    idx, raw_text, output_path, voice, speed, heading = task
    start_time = time.time()
    
    try:
        parts = re.split(r'(\(break:\s*[\d\.]+[ms]*\))', raw_text)
        slide_audio = []
        for part in parts:
            part = part.strip()
            if not part: continue
            break_match = re.match(r'\(break:\s*([\d\.]+)(ms|s)\)', part)
            if break_match:
                val, unit = float(break_match.group(1)), break_match.group(2)
                slide_audio.append(np.zeros(int(SAMPLE_RATE * (val / 1000 if unit == 'ms' else val))))
            else:
                clean_t = clean_smd_text(part)
                if not clean_t: continue
                # 共有インスタンスによる推論
                generator = GLOBAL_PIPELINE(clean_t, voice=voice, speed=speed)
                for _, _, audio in generator:
                    slide_audio.append(audio)
        
        if not slide_audio: return idx, False, heading, "No audio data"
        
        final_samples = np.concatenate(slide_audio)
        sf.write(output_path, final_samples, SAMPLE_RATE)
        
        audio_dur = len(final_samples) / SAMPLE_RATE
        rtf = (time.time() - start_time) / audio_dur
        return idx, True, heading, rtf
    except Exception as e:
        return idx, False, heading, str(e)

@click.command()
@click.argument('input_file', type=click.Path(exists=True, path_type=Path))
@click.option('--gap', default=1.5, type=float, help='スライド間の無音(秒)', envvar='SMD_SECTION_GAP')
@click.option('--threads', default=10, type=int, help='同時実行スレッド数')
def main(input_file, gap, threads):
    """M4 SMD Processor (Visual Progress & Shared-Memory)"""
    base_dir = input_file.parent / input_file.stem
    cache_dir = base_dir / "cache"
    cache_dir.mkdir(parents=True, exist_ok=True)

    with open(input_file, "r", encoding="utf-8") as f:
        content = f.read()

    # パース
    pattern = r'(^#\s*\[.*?\]|^#\s+.*?$)'
    parts = re.split(pattern, content, flags=re.MULTILINE)
    
    sections, tasks, final_sequence = [], [], []
    current_heading = "Intro"

    click.secho(f"\n🚀 Processing: {input_file.name}", fg='cyan', bold=True)
    click.echo(f"[*] Project directory: {base_dir}")

    for part in parts:
        if re.match(pattern, part):
            current_heading = part.strip("# [] \n\t").replace(" ", "_")
        elif part.strip():
            h = hashlib.sha256((current_heading + clean_smd_text(part)).encode('utf-8')).hexdigest()[:12]
            sec_info = {'heading': current_heading, 'filename': f"{current_heading}_{h}.wav", 'text': part}
            sections.append(sec_info)
            out_path = cache_dir / sec_info['filename']
            final_sequence.append(out_path)
            
            # ここで見やすくステータスを表示
            if out_path.exists():
                click.secho(f"  [Cache Hit]  {current_heading}", fg='green')
            else:
                click.secho(f"  [New Task ]  {current_heading}", fg='yellow')
                tasks.append((len(sections)-1, part, str(out_path), 'jf_alpha', 1.1, current_heading))

    # 並列生成開始の宣言
    if tasks:
        click.echo(f"[*] Starting parallel generation with {threads} threads...")
        with ThreadPoolExecutor(max_workers=threads) as executor:
            futures = {executor.submit(generate_section_audio, t): t for t in tasks}
            for future in as_completed(futures):
                idx, success, label, info = future.result()
                if success:
                    # リアルタイムでの完了報告
                    click.echo(f"      -> Finished: {label:<25} (RTF: {info:.4f})")
                else:
                    click.secho(f"      !! Error in {label}: {info}", fg='red')

    # 結合
    click.echo("\n[*] Finalizing audio and manifest...")
    combined_audio, manifest, current_time = [], [], 0.0
    gap_samples = np.zeros(int(SAMPLE_RATE * gap))

    for i, path in enumerate(final_sequence):
        if path.exists():
            audio, _ = sf.read(path)
            dur = len(audio) / SAMPLE_RATE
            manifest.append({"slide": sections[i]['heading'], "start": round(current_time, 3), "duration": round(dur, 3)})
            combined_audio.append(audio)
            current_time += dur + gap
            if i < len(final_sequence) - 1:
                combined_audio.append(gap_samples)

    if combined_audio:
        final_file = base_dir / f"{input_file.stem}_full.wav"
        sf.write(final_file, np.concatenate(combined_audio), SAMPLE_RATE)
        with open(base_dir / "manifest.json", "w", encoding="utf-8") as f:
            json.dump(manifest, f, indent=2, ensure_ascii=False)
        
        click.secho(f"\n✅ Build Success: {final_file.name}", fg='green', bold=True)

if __name__ == "__main__":
    main()
