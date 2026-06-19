with open("/Users/teshima/Koofr/2026/Introduction-to-AI/Video/Introduction-to-AI_v1/1_2026_manuscript/nn_pdf_pdftotext.txt", "r", encoding="utf-8") as f:
    content = f.read()

pages = content.split("\x0c")
for idx, page in enumerate(pages):
    print(f"=== PAGE {idx+1} ===")
    lines = [line.strip() for line in page.split("\n") if line.strip()]
    for line in lines[:8]:
        print("  " + line)
    if len(lines) > 8:
        print(f"  ... ({len(lines)-8} more lines)")
    print()
