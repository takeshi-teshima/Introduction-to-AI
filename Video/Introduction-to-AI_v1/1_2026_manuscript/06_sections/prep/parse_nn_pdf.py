import pypdf

reader = pypdf.PdfReader("/Users/teshima/Koofr/2026/Introduction-to-AI/Video/Introduction-to-AI_v1/1_2026_manuscript/第06回_NN.pdf")
with open("/Users/teshima/Koofr/2026/Introduction-to-AI/Video/Introduction-to-AI_v1/1_2026_manuscript/nn_pdf_pages.txt", "w", encoding="utf-8") as f:
    for i, page in enumerate(reader.pages):
        text = page.extract_text()
        f.write(f"--- Page {i+1} ---\n")
        f.write(text)
        f.write("\n\n")
print(f"Successfully extracted {len(reader.pages)} pages.")
