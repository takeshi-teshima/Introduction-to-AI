with open("math_exercises_complete.md", "r", encoding="utf-8") as f:
    text = f.read()

import re

# Find the problem block
prob_pattern = re.compile(r'### 内積の線形性と対称性の証明.*?(?=\n### |$)', re.DOTALL)
prob_match = prob_pattern.search(text)
if prob_match:
    prob_text = prob_match.group(0)
    text = text.replace(prob_text, "")

# Find the answer block
ans_pattern = re.compile(r'### 問3-inner-product-properties の解答・解説.*?(?=\n### |$)', re.DOTALL)
ans_match = ans_pattern.search(text)
if ans_match:
    ans_text = ans_match.group(0)
    text = text.replace(ans_text, "")

with open("math_exercises_complete.md", "w", encoding="utf-8") as f:
    f.write(text)

with open("math_exercises_unused.md", "a", encoding="utf-8") as f:
    f.write("\n\n# 第3回: 線型モデルの行列表現と正則化・モデル選択\n\n## ベクトルの内積と性質\n\n")
    if prob_match:
        f.write(prob_text)
    f.write("\n### 解答・解説\n\n")
    if ans_match:
        f.write(ans_text)
