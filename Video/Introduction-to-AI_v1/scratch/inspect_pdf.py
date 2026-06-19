import pypdf
import sys

def extract_pdf_text(pdf_path):
    reader = pypdf.PdfReader(pdf_path)
    print(f"File: {pdf_path}")
    print(f"Total Pages: {len(reader.pages)}")
    for i, page in enumerate(reader.pages):
        text = page.extract_text()
        print(f"\n--- Page {i+1} ---")
        if text:
            print(text.strip())
        else:
            print("[No text found]")

if __name__ == "__main__":
    pdf_path = "1_2026_manuscript/第09回_pre.pdf"
    if len(sys.argv) > 1:
        pdf_path = sys.argv[1]
    extract_pdf_text(pdf_path)
