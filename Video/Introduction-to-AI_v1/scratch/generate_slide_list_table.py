import pypdf
import re

reader = pypdf.PdfReader("1_2026_manuscript/第09回_pre.pdf")

# Map of garbled title strings to clean titles based on context
TITLE_MAP = {
    "ୈ9ճ": "第9回",
    "ϩʔυϚοϓ": "ロードマップ",
    "Աͱ༧ଌʢલճͷଓ͖ʣ": "類似度と予測（前回の続き）",
    "͜Ε·Ͱͷ͋Β͢͡": "これまでのあらすじ",
    "୯७ͳ๏ଇ͕͋Ε": "単純な法則があれば汎化しやすい",
    "ੑೳͱ͞ΕΔϞσϧ": "過剰パラメーター化されたモデル",
    "ա৒ύϥϝʔλʔԽ": "過剰パラメーター化 (Overparameterization)",
    "ཱ͞Ε͍ͯͳ͍": "過剰パラメーター化されたモデルは汎化し得るのか？",
    "దԽͷṖ": "最適化の謎",
    "ೋ৅߹": "二重降下 (Double Descent)",
    "োนΛ": "局所解を回避しやすい",
    "शͷোนᶄ": "次元の呪い (The Curse of Dimensionality)",
    "ܘ": "d次元超球の体積",
    "৅": "球面上への集中",
    "֯": "直交性",
    "ͷढ͍": "次元の呪い",
    "शʢΞϓϩʔν": "表現学習（アプローチとタスク）",
    "शʢTJNJMBSJUZ": "表現学習 (Similarity learning)",
    "ೝূ": "顔認証 (Face Verification)",
    "Φʔϓϯηοτ": "オープンセット分類 (Open-set Classification)",
    "ผλεΫ": "他タスクへのアプローチ",
    "JOGPSNBUJPO": "情報検索 (Information Retrieval)",
    "शઓུᶃ": "表現学習の戦略1 (分類損失の利用)",
    "शઓུᶄ": "表現学習の戦略2 (対照学習の利用)",
    "शʢDPOUSBTUJWF": "対照学習 (Contrastive learning)",
    "Թ౓": "温度パラメーター",
    "Softmax": "Softmax with Temperature",
    "Ԡ༻ྖҬ": "第一部終了・第二部への案内"
}

def clean_garbled(text):
    if not text:
        return "[No text]"
    # Clean up whitespace
    text = re.sub(r'\s+', ' ', text).strip()
    return text

print("| スライド番号 | 対応PDFページ | スライドタイトル (推測) | 鍵となるセンテンス / 主な内容 |")
print("| :--- | :--- | :--- | :--- |")

for idx, page in enumerate(reader.pages):
    text = page.extract_text()
    cleaned = clean_garbled(text)
    
    # Try to find a matched title
    title = ""
    for k, v in TITLE_MAP.items():
        if k in cleaned:
            title = v
            break
    
    if not title:
        # fallback to first 25 chars of cleaned text
        title = cleaned[:30] + "..." if len(cleaned) > 30 else cleaned
        
    print(f"| Slide {idx+1}/67 | Page {idx+1} | {title} | [内容の要約を入力してください] |")
