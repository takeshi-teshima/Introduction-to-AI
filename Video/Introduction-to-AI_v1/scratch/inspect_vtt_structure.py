import re

def parse_timestamps(filepath):
    print(f"=== {filepath} ===")
    with open(filepath, 'r') as f:
        lines = f.readlines()
    
    current_time = ""
    for idx, line in enumerate(lines):
        if "-->" in line:
            current_time = line.strip()
        elif "Takeshi Teshima:" in line:
            text = line.replace("Takeshi Teshima:", "").strip()
            # print first few sentences of major transitions
            if any(k in text for k in ["次元の呪い", "大規模モデル", "表現学習", "二番目", "戦略の二"]):
                print(f"Time: {current_time} | {text[:100]}")

parse_timestamps("0_Lecture_transcription/2025/Lecture_09.vtt")
parse_timestamps("0_Lecture_transcription/2025/Lecture_10.vtt")
