with open("/Users/teshima/Koofr/2026/Introduction-to-AI/Video/Introduction-to-AI_v1/1_2026_manuscript/nn_pdf_pdftotext.txt", "r", encoding="utf-8") as f:
    content = f.read()

pages = content.split("\x0c")
with open("/Users/teshima/Koofr/2026/Introduction-to-AI/Video/Introduction-to-AI_v1/1_2026_manuscript/nn_clean_pages.txt", "w", encoding="utf-8") as f_out:
    for idx, page in enumerate(pages):
        f_out.write(f"=========================================\n")
        f_out.write(f"=== PAGE {idx+1} ===\n")
        f_out.write(f"=========================================\n")
        f_out.write(page.strip())
        f_out.write("\n\n")
print("Wrote nn_clean_pages.txt successfully.")
