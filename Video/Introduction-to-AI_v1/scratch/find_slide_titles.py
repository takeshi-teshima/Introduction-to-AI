import pypdf
import re

reader = pypdf.PdfReader("1_2026_manuscript/第09回_pre.pdf")
print("Total slides:", len(reader.pages))

for idx, page in enumerate(reader.pages):
    text = page.extract_text()
    if not text:
        print(f"Slide {idx+1}: [No text]")
        continue
    
    # Let's extract first few lines and clean them
    lines = [line.strip() for line in text.split('\n') if line.strip()]
    print(f"Slide {idx+1}:")
    for line in lines[:3]:
        print("  ", repr(line))
