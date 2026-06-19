import pypdf

reader = pypdf.PdfReader("第05回.pdf")
for i, page in enumerate(reader.pages):
    text = page.extract_text().split("\n")
    print(f"--- Page {i+1} ---")
    for j in range(min(3, len(text))):
        print(text[j])
