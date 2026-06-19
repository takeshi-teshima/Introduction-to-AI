import glob
import re

files = sorted(glob.glob("1_2026_manuscript/09_sections/*.md"))

slide_pattern = re.compile(r'#\s*\[ID:\s*Slide\s*(\d+)/67\]')

found_slides = []

for fpath in files:
    if "改善提案" in fpath or "スライド一覧" in fpath:
        continue
    with open(fpath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    matches = slide_pattern.findall(content)
    for m in matches:
        found_slides.append(int(m))

found_slides.sort()
print("Found slides:", len(found_slides))
print("Slides:", found_slides)

# check duplicate
duplicates = [x for x in found_slides if found_slides.count(x) > 1]
print("Duplicates:", list(set(duplicates)))

# check missing
missing = [x for x in range(1, 68) if x not in found_slides]
print("Missing slides:", missing)
