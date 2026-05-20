import re
import sys

def clean_sub(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Remove SRT/VTT timestamps and numbers
    content = re.sub(r'(?m)^\d+$\n', '', content)
    content = re.sub(r'(?m)^WEBVTT$\n', '', content)
    content = re.sub(r'(?m)^.*?\d{2}:\d{2}:\d{2}.*?$\n', '', content)
    content = re.sub(r'<[^>]+>', '', content)
    
    # Remove empty lines
    lines = [line.strip() for line in content.split('\n') if line.strip()]
    return ' '.join(lines)

files = [
    "../0_Lecture_transcription/2025/Lecture_04.vtt",
    "../0_Lecture_transcription/2025/Lecture_05.vtt",
    "../0_YouTube_transcription/【AI入門#01-10】予測系タスク②分類.srt",
    "../0_YouTube_transcription/【AI入門#01-11】分類タスクへの確率論的アプローチ.srt",
    "../0_YouTube_transcription/【AI入門#01-13】2クラスの確率論的分類.srt",
    "../0_YouTube_transcription/【AI入門#01-14】多クラスの確率論的分類.srt"
]

with open("05_sections/all_transcripts.txt", 'w', encoding='utf-8') as out:
    for file in files:
        out.write(f"\n--- {file} ---\n")
        try:
            text = clean_sub(file)
            out.write(text + "\n")
        except Exception as e:
            out.write(f"Error reading {file}: {e}\n")

