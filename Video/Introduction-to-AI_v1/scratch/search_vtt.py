import sys
import re

def search_vtt(filepath, keywords):
    print(f"=== Searching {filepath} ===")
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # split into blocks
    blocks = content.split('\n\n')
    for block in blocks:
        lines = block.strip().split('\n')
        if len(lines) >= 3:
            time_range = lines[1]
            text = " ".join(lines[2:])
            for kw in keywords:
                if kw in text:
                    print(f"Time: {time_range} | Match '{kw}': {text}")
                    break

if __name__ == "__main__":
    keywords = ["質問と回答", "大規模モデル", "記憶と予測", "次元の呪い", "表現学習", "第十回", "第10回", "第九回", "第9回", "カーネル法の補足"]
    search_vtt("0_Lecture_transcription/2025/Lecture_09.vtt", keywords)
    search_vtt("0_Lecture_transcription/2025/Lecture_10.vtt", keywords)
