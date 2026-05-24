---
title: "経営学への応用を目指すAI入門：数学演習問題集"
subtitle: "第1回〜第6回 講義内容完全準拠・論理展開追体験セット（完全版）"
author: "特殊講義1 補助資料"
date: \today
geometry: margin=20mm
numbersections: true
header-includes: |
  ```{=latex}
  \usepackage{amsmath,amssymb}
  \usepackage[most]{tcolorbox}
  \usepackage{tikz}
  \usetikzlibrary{arrows.meta, positioning}
  \usepackage{fontawesome5}
  \newcounter{question}
  \newtcolorbox[use counter=question]{questionbox}[2][]{enhanced, breakable, colback=red!2!gray!3!white, colframe=red!50!gray, fonttitle=\bfseries, title={問\arabic{question}\ #2}, #1}
  \newtcolorbox{answerbox}[2][]{enhanced, breakable, colback=green!2!gray!3!white, colframe=green!45!gray, fonttitle=\bfseries, title={問\ref{#2}の解答・解説}, #1}
  \usepackage{titlesec}
  \titleformat{\section}[display]{\normalfont\Large\bfseries}{【第\thesection 回】}{0.2em}{}
  \titleformat{\subsection}[block]{\normalfont\large\bfseries}{\thesection-\arabic{subsection}.}{0.5em}{}
  \newcommand{\ind}{\mathbf{1}}
  ```
---

\begin{flushright}
\textbf{最終更新日：\today{} (v1.0)}
\end{flushright}

# 本演習問題集の進め方と活用法 {.unnumbered}

本問題集は、講義スライドに登場する数式の「行間（省略された計算や証明）」を学生自身の手で動かして埋め、ブラックボックスを解消することを目的に設計されています。各セクションには講義スライドとの対応関係である**【該当内容】**と、その演習を行う目的である**【ねらい】**が記載されています。

また、各設問には以下の難易度が設定されています。

* **スキップ可** ：解き方が分かるなら解かなくてもいい。
* **確認** ：定義を簡単な代入問題で辿る確認や、立式などの最低限の確認。
* **必須** ：講義の行間を埋める標準的な問題。
* **発展** ：余裕があれば解くとよい。

---

# 確率の基礎とリスク関数・ERM

## 確率の基礎と期待値・分散の計算

### 指示関数（Indicator function）の理解 {#q:1-indicator-function .questionbox tags="確認\faCheck"}

機械学習の理論（特に損失関数や分類問題の評価など）では、ある条件が満たされているか否かを表す**指示関数（定義関数）** $\ind$ が頻出する。条件（または事象） $A$ に対して、指示関数 $\ind\{A\}$ は以下のように定義される。
$$
\ind\{A\} = \begin{cases}
1 & (\text{条件 } A \text{ が真のとき}) \\
0 & (\text{条件 } A \text{ が偽のとき})
\end{cases}
$$

1. $x$ が次の値のとき、指示関数 $\ind\{x \ge 1\}$ の値をそれぞれ求めよ。
   (a) $x = 0$
   (b) $x = 2$
2. 確率変数 $Y := \ind\{X \ge 1\}$ の確率分布表（とり得る値と、それぞれの値をとる確率の表）の空欄（ア）〜（エ）を埋めよ。

| $y$ | $\mathbb{P}(Y=y)$ |
| :---: | :---: |
| （ア） | （ウ） |
| （イ） | （エ） |

::: {.right}
[（解答・解説へ）](#a:1-indicator-function)
:::

### 離散型確率分布での期待値・分散計算 {#q:1-discrete-expectation-variance .questionbox tags="スキップ可"}

ある離散確率変数 $X$ は、確率 $0.2$ で $0$、確率 $0.5$ で $1$、確率 $0.3$ で $2$ をとる。

1. 期待値 $\mathbb{E}[X]$ を求めよ。
2. $f(x) = x^2$ とするとき、期待値 $\mathbb{E}[f(X)]$ を求めよ。
3. 分散 $\mathbb{V}[f(X)]$ を計算せよ。

::: {.right}
[（解答・解説へ）](#a:1-discrete-expectation-variance)
:::

### 連続型確率分布での期待値・分散計算 {#q:1-continuous-expectation-variance .questionbox tags="スキップ可"}

連続確率変数 $X$ の確率密度関数 $p(x)$ が、指示関数 $\ind$ を用いて実数全体 $\mathbb{R}$ 上で以下のように定義されている。
$$
p(x) = 2x \cdot \ind\{0 \le x \le 1\}
$$

1. $\int_{-\infty}^\infty p(x) dx = 1$ （全確率が1）が満たされていることを示せ。
2. 期待値 $\mathbb{E}[X] = \int_{-\infty}^\infty x p(x) dx$ を計算せよ。
3. $\mathbb{E}[X^2] = \int_{-\infty}^\infty x^2 p(x) dx$ を計算し、分散 $\mathbb{V}[X]$ を求めよ。

---

**ヒント：** $\int_{-\infty}^\infty 2x \cdot \ind\{0 \le x \le 1\} dx = \int_0^1 2x dx$ である。

::: {.right}
[（解答・解説へ）](#a:1-continuous-expectation-variance)
:::

### 【復習とヒント】期待値・分散・共分散の性質 {.tcolorbox option="enhanced, colback=blue!2!white, colframe=blue!60!black, fonttitle=\bfseries, drop shadow"}

* \textbf{線形性}: $\mathbb{E}[aX + bY] = a\mathbb{E}[X] + b\mathbb{E}[Y]$
* \textbf{分散の定義}: $\mathbb{V}[X] = \mathbb{E}[(X - \mathbb{E}[X])^2] = \mathbb{E}[X^2] - (\mathbb{E}[X])^2$
* \textbf{共分散の定義}: $Cov(X,Y) = \mathbb{E}[(X - \mathbb{E}[X])(Y - \mathbb{E}[Y])]$
* \textbf{分散と共分散の関係}: $\mathbb{V}[X] = Cov(X,X)$
* \textbf{共分散の双線形性}: $Cov(aX+bY, Z) = aCov(X,Z) + bCov(Y,Z)$

### 共分散（Covariance）の2次形式的振る舞い {#q:1-variance-formula-proof .questionbox tags="発展\faRocket"}

確率変数 $X, Y, Z$ と定数 $a, b$ について、共分散の性質（双線形性・対称性）
\begin{align*}
Cov(aX+bY, Z) &= a Cov(X,Z) + b Cov(Y,Z) \\
Cov(X,Y) &= Cov(Y,X)
\end{align*}
を用いて、次の式を展開せよ。

1. $Cov(X, X+Y)$
2. $\mathbb{V}[aX + bY]$ （ヒント：$\mathbb{V}[Z] = Cov(Z,Z)$ であることを利用せよ）

::: {.right}
[（解答・解説へ）](#a:1-variance-formula-proof)
:::

# 最適化と最小二乗法・偏微分

## 経験リスクの数式化（シグマを用いた書き下し）

### 経験リスクの立式 {#q:2-empirical-risk-formulation .questionbox tags="必須\faStar"}

$n$ 個の訓練データ $\{(x_i, y_i)\}_{i=1}^n$ が与えられている。モデルクラスとして1次関数 $f_{(w,b)}(x) = wx + b$ を採用し、損失関数を二乗誤差 $l(y, \hat{y}) = (y - \hat{y})^2$ とするとき、経験リスク $\hat{R}(f_{(w,b)})$ を書き下せ。
<!-- $\sum_{i=1}^n$ を用いて -->

::: {.right}
[（解答・解説へ）](#a:2-empirical-risk-formulation)
:::

### 最適化問題の定式化：穴埋め {#q:2-optimization-formulation-blank .questionbox tags="必須\faStar"}

以下の最適化問題の定式化について、空欄 (ア) 〜 (エ) に入る適切な数式や記号を答えよ。

1. \textbf{【制約なし】} パラメータ $\boldsymbol{\theta}$ を調整して、目的関数 $L(\boldsymbol{\theta})$ を最小にする「最適なパラメータ $\hat{\boldsymbol{\theta}}$」を求める問題：
        $$
        \mathop{\mathrm{Min}}_{(ア)} (イ)
        $$
        ただし、$\boldsymbol{\theta}$ が値をとる範囲は $\mathbb{R}^d$ である。
2. \textbf{【制約あり】} パラメータの大きさ（L2ノルム） $\|\boldsymbol{\theta}\|$ が定数 $C$ を超えないという制約のもとで、目的関数 $L(\boldsymbol{\theta})$ の最小値を求める問題：
        $$
        \mathop{\mathrm{Min}}_{(ウ)} (エ)
        $$

::: {.right}
[（解答・解説へ）](#a:2-optimization-formulation-blank)
:::


### 目的関数のパラメータ関数化 {#q:2-erm-parameter-function .questionbox tags="スキップ可"}

以下の2つのデータポイントが与えられている。

| $x$ | $y$ |
| :---: | :---: |
| $1$ | $2$ |
| $3$ | $4$ |

予測モデルを原点を通る直線 $f_\theta(x) = \theta x$ とし、損失関数を二乗誤差とする。このとき、経験リスク
$$
\hat{R}(f_\theta) = \frac{1}{2} \sum_{i=1}^2 (y_i - f_\theta(x_i))^2
$$
に具体的な数値を代入し、$\theta$ の2次関数 $A\theta^2 + B\theta + C$ の形に展開・整理せよ。

::: {.right}
[（解答・解説へ）](#a:2-erm-parameter-function)
:::

## 最小二乗法の真髄：偏微分から一階の条件へ

### 偏微分と勾配 {#q:3-multivariate-gradient .questionbox tags="必須\faStar"}

ベクトル $\mathbf{w} = (w_1, w_2, w_3)^\top \in \mathbb{R}^3$ に対する以下の関数 $g(\mathbf{w})$ について、勾配 $\nabla g(\mathbf{w})$ を求めよ。
$$
g(\mathbf{w}) = w_1^2 + 2w_2^2 + 3w_3^2 - 4w_1w_2 - 6w_2w_3
$$

::: {.right}
[（解答・解説へ）](#a:3-multivariate-gradient)
:::

### 線型単回帰モデルの最適パラメータ導出 {#q:2-partial-derivative-gradient .questionbox tags="必須\faStar"}

1次元の入力 $x$ に対する線型単回帰モデル $f_{w,b}(x) = wx + b$ を考える。$n$ 個の訓練データ $\{(x_i, y_i)\}_{i=1}^n$ に対する目的関数（経験リスク）を二乗誤差を用いて
$$
L(w,b) = \frac{1}{n} \sum_{i=1}^n (y_i - (wx_i + b))^2
$$
と定義する。この目的関数を最小化する最適なパラメータ $(\hat{w}, \hat{b})$ を、以下の誘導に従って導出せよ。

1. 目的関数 $L(w,b)$ を $w$ および $b$ について偏微分し、勾配 $\nabla L(w,b) = \begin{pmatrix} \frac{\partial L}{\partial w} \\ \frac{\partial L}{\partial b} \end{pmatrix}$ を求めよ。
2. 一階の条件 $\nabla L(w,b) = \mathbf{0}$ を用いて、パラメータ $w, b$ に関する連立方程式を導き、それを行列とベクトルを用いた以下の形に整理せよ。
   $$
   \begin{pmatrix} ? & ? \\ ? & ? \end{pmatrix} \begin{pmatrix} w \\ b \end{pmatrix} = \begin{pmatrix} ? \\ ? \end{pmatrix}
   $$
3. 上記の方程式を解くことで、最適なパラメータ $(\hat{w}, \hat{b})$ を求める式が
   $$
   \begin{pmatrix} \hat{w} \\ \hat{b} \end{pmatrix} = \begin{pmatrix} \sum_{i=1}^n x_i^2 & \sum_{i=1}^n x_i \\ \sum_{i=1}^n x_i & n \end{pmatrix}^{-1} \begin{pmatrix} \sum_{i=1}^n x_i y_i \\ \sum_{i=1}^n y_i \end{pmatrix}
   $$
   となることを示せ。ただし、上式の右辺にある逆行列は存在することを仮定する。

::: {.right}
[（解答・解説へ）](#a:2-partial-derivative-gradient)
:::

# 線型モデルの行列表現と正則化・モデル選択

## ベクトルと行列の計算

### 行列・ベクトルの積の計算練習 {#q:3-matrix-vector-multiplication-practice .questionbox tags="スキップ可"}

以下の行列・ベクトルの積を計算せよ。

1. **【行列 $\times$ 行列】**
   $$
   \begin{pmatrix} 1 & 2 \\ 3 & 4 \end{pmatrix} \begin{pmatrix} 2 & 0 & 1 \\ 1 & 3 & -1 \end{pmatrix}
   $$
2. **【行列 $\times$ 縦ベクトル】**
   $$
   \begin{pmatrix} 1 & -1 & 2 \\ 0 & 3 & 1 \end{pmatrix} \begin{pmatrix} 2 \\ 1 \\ -1 \end{pmatrix}
   $$
3. **【横ベクトル $\times$ 行列 $\times$ 縦ベクトル（二次形式）】**
   $$
   \begin{pmatrix} 1 & 2 \end{pmatrix} \begin{pmatrix} 2 & 0 \\ 0 & 3 \end{pmatrix} \begin{pmatrix} 1 \\ 2 \end{pmatrix}
   $$
4. **【横ベクトル $\times$ 縦ベクトル（内積）】**
   $$
   \begin{pmatrix} 1 & 3 & -2 \end{pmatrix} \begin{pmatrix} 4 \\ -1 \\ 2 \end{pmatrix}
   $$
5. **【縦ベクトル $\times$ 横ベクトル】**
   $$
   \begin{pmatrix} 2 \\ -1 \\ 3 \end{pmatrix} \begin{pmatrix} 1 & 4 \end{pmatrix}
   $$

::: {.right}
[（解答・解説へ）](#a:3-matrix-vector-multiplication-practice)
:::

### 【復習とヒント】ベクトル・行列の掛け算の頻出パターン {.tcolorbox option="enhanced, colback=blue!2!white, colframe=blue!60!black, fonttitle=\bfseries, drop shadow"}

ベクトルや行列の掛け算は、それぞれの「形状」を意識することで、結果がどのような形になるか（スカラー、ベクトル、行列）を視覚的に捉えることができます。

- **横ベクトル・縦ベクトルの掛け算 $\rightarrow$ スカラーができる**

    \begin{center}
    \begin{tikzpicture}[>=stealth, thick, scale=0.9, every node/.style={align=center}]
      \colorlet{vecbg}{cyan!10} \colorlet{vecborder}{cyan!70!blue}
      \draw[fill=vecbg, draw=vecborder] (0, -0.25) rectangle (2, 0.25) node[midway, font=\small] {ベクトル};
      \draw[fill=vecbg, draw=vecborder] (2.3, -1) rectangle (2.8, 1) node[midway, font=\small, align=center] {ベ\\ク\\ト\\ル};
      \node at (3.3, 0) {$=$};
      \node at (4.3, 0) {スカラー};
      \node[anchor=west] at (5.3, 0) {$\mathbf{a}^\top \mathbf{b} = c$};
    \end{tikzpicture}
    \end{center}

- **縦ベクトル・横ベクトルの掛け算 $\rightarrow$ 行列ができる**

    \begin{center}
    \begin{tikzpicture}[>=stealth, thick, scale=0.9, every node/.style={align=center}]
      \colorlet{vecbg}{cyan!10} \colorlet{vecborder}{cyan!70!blue}
      \colorlet{matbg}{magenta!10} \colorlet{matborder}{magenta!70!purple}
      \draw[fill=vecbg, draw=vecborder] (0, -1) rectangle (0.5, 1) node[midway, font=\small, align=center] {ベ\\ク\\ト\\ル};
      \draw[fill=vecbg, draw=vecborder] (0.8, -0.25) rectangle (2.8, 0.25) node[midway, font=\small] {ベクトル};
      \node at (3.3, 0) {$=$};
      \draw[fill=matbg, draw=matborder] (3.8, -1) rectangle (5.8, 1) node[midway, font=\small] {行列};
      \node[anchor=west] at (6.3, 0) {$\mathbf{a} \mathbf{b}^\top = M$};
    \end{tikzpicture}
    \end{center}

- **行列を縦ベクトルに掛ける $\rightarrow$ 縦ベクトルになる**

    \begin{center}
    \begin{tikzpicture}[>=stealth, thick, scale=0.9, every node/.style={align=center}]
      \colorlet{vecbg}{cyan!10} \colorlet{vecborder}{cyan!70!blue}
      \colorlet{matbg}{magenta!10} \colorlet{matborder}{magenta!70!purple}
      \draw[fill=matbg, draw=matborder] (0, -1) rectangle (2, 1) node[midway, font=\small] {行列};
      \draw[fill=vecbg, draw=vecborder] (2.3, -1) rectangle (2.8, 1) node[midway, font=\small, align=center] {ベ\\ク\\ト\\ル};
      \node at (3.3, 0) {$=$};
      \draw[fill=vecbg, draw=vecborder] (3.8, -1) rectangle (4.3, 1) node[midway, font=\small, align=center] {ベ\\ク\\ト\\ル};
      \node[anchor=west] at (4.8, 0) {$M \mathbf{x} = \mathbf{y}$};
    \end{tikzpicture}
    \end{center}

- **横ベクトル・行列・縦ベクトルの順に掛ける $\rightarrow$ スカラーになる**

    \begin{center}
    \begin{tikzpicture}[>=stealth, thick, scale=0.9, every node/.style={align=center}]
      \colorlet{vecbg}{cyan!10} \colorlet{vecborder}{cyan!70!blue}
      \colorlet{matbg}{magenta!10} \colorlet{matborder}{magenta!70!purple}
      \draw[fill=vecbg, draw=vecborder] (0, -0.25) rectangle (2, 0.25) node[midway, font=\small] {ベクトル};
      \draw[fill=matbg, draw=matborder] (2.3, -1) rectangle (4.3, 1) node[midway, font=\small] {行列};
      \draw[fill=vecbg, draw=vecborder] (4.6, -1) rectangle (5.1, 1) node[midway, font=\small, align=center] {ベ\\ク\\ト\\ル};
      \node at (5.6, 0) {$=$};
      \node at (6.6, 0) {スカラー};
      \node[anchor=west] at (7.6, 0) {$\mathbf{a}^\top M \mathbf{b} = c$};
    \end{tikzpicture}
    \end{center}

【注意】いずれも、行列やベクトルの形状が掛け算可能なように整合していることを前提としています。

### ベクトル・行列の積の頻出パターンと成分表示 {#q:3-matrix-vector-patterns .questionbox tags="必須\faStar"}

講義スライドで登場した行列・ベクトルの積に関する視覚的なパターンの意味を、成分表示を用いて確認せよ。

1. **【横ベクトル $\times$ 縦ベクトル $\to$ 内積】**
   $$
   \mathbf{a}^\top \mathbf{b} =
   \begin{pmatrix} a_1 & a_2 & \dots & a_d \end{pmatrix}
   \begin{pmatrix} b_1 \\ b_2 \\ \vdots \\ b_d \end{pmatrix}
   = c
   $$
   この結果 $c$ が内積 $\langle \mathbf{a}, \mathbf{b} \rangle = a_1b_1 + \dots + a_db_d$ と一致することを、成分計算により確認せよ。また、同様にして $\mathbf{a}^\top \mathbf{b} = \mathbf{b}^\top \mathbf{a}$ となること（内積の順序の入れ替え可能性）も確認せよ。ただし、$1\times 1$行列はスカラーと同一視してよい。

2. **【行列 $\times$ 縦ベクトル $\to$ 縦ベクトル】**
   行列 $B \in \mathbb{R}^{m \times d}$ を、横ベクトルを縦に並べたブロック行列、および縦ベクトルを横に並べたブロック行列としてそれぞれ解釈する。つまり、
   $$
   B = \begin{pmatrix} B_{11} & \dots & B_{1d} \\ \vdots & \ddots & \vdots \\ B_{m1} & \dots & B_{md} \end{pmatrix}
   = \begin{pmatrix} \quad \mathbf{b}_1^\top \quad \\ \vdots \\ \quad \mathbf{b}_m^\top \quad \end{pmatrix}
   = \begin{pmatrix} \boldsymbol{\beta}_1 & \cdots & \boldsymbol{\beta}_d \end{pmatrix}
   $$
   と捉えるとき、縦ベクトル $\mathbf{v} \in \mathbb{R}^d$ との積 $B\mathbf{v}$ について次の等式がそれぞれ成り立つことを成分計算により確認せよ。

   - **横ベクトルが縦に並んでいるとみなす場合（内積の縦並び）：**
     $$
     B\mathbf{v} =
     \begin{pmatrix} \quad \mathbf{b}_1^\top \quad \\ \vdots \\ \quad \mathbf{b}_m^\top \quad \end{pmatrix} \mathbf{v}
     = \begin{pmatrix} \mathbf{b}_1^\top \mathbf{v} \\ \vdots \\ \mathbf{b}_m^\top \mathbf{v} \end{pmatrix}
     $$

   - **縦ベクトルが横に並んでいるとみなす場合（列ベクトルの重み付き和）：**
     $$
     B\mathbf{v} =
     \begin{pmatrix} \boldsymbol{\beta}_1 & \cdots & \boldsymbol{\beta}_d \end{pmatrix}
     \begin{pmatrix} v_1 \\ \vdots \\ v_d \end{pmatrix}
     = v_1 \boldsymbol{\beta}_1 + \cdots + v_d \boldsymbol{\beta}_d
     $$


::: {.right}
[（解答・解説へ）](#a:3-matrix-vector-patterns)
:::

### 【復習とヒント】ベクトル・行列の積のコツ {.tcolorbox option="enhanced, colback=blue!2!white, colframe=blue!60!black, fonttitle=\bfseries, drop shadow"}

行列は、いくつかの計算パターンでは、行（横ベクトル）や列（縦ベクトル）が並んだものとしてイメージすると、複雑な計算も直感的に捉えやすくなります。

- **行列の行ベクトル・列ベクトル表現**
  行列は横ベクトルが縦に並んだものとも、縦ベクトルが横に並んだものとも思えます。

    \begin{center}
    \begin{tikzpicture}[>=stealth, thick, scale=0.9, every node/.style={align=center}]
      \colorlet{vecbg}{cyan!10} \colorlet{vecborder}{cyan!70!blue}
      \colorlet{colbg}{magenta!10} \colorlet{colborder}{magenta!70!purple}

      \node at (-1.5, 0) {$B =$};
      \draw[draw=black, thick] (0, 1.2) -- (-0.4, 1.2) -- (-0.4, -1.2) -- (0, -1.2);
      \draw[draw=black, thick] (2.0, 1.2) -- (2.2, 1.2) -- (2.2, -1.2) -- (2.0, -1.2);
      \foreach \y/\i in {0.75/1, 0.25/2, -0.25/3, -0.75/4} {
        \node[anchor=east] at (0.3, \y) {$\mathbf{b}_\i^\top$};
        \draw[fill=vecbg, draw=vecborder] (0.4, \y-0.15) rectangle (1.8, \y+0.15);
      }
      \node at (2.8, 0) {$=$};
      \draw[draw=black, thick] (3.4, 1.2) -- (3.2, 1.2) -- (3.2, -1.2) -- (3.4, -1.2);
      \draw[draw=black, thick] (5.4, 1.2) -- (5.6, 1.2) -- (5.6, -1.2) -- (5.4, -1.2);
      \foreach \x/\i in {3.8/1, 4.4/2, 5.0/3} {
        \node[anchor=south] at (\x, 0.9) {$\boldsymbol{\beta}_\i$};
        \draw[fill=colbg, draw=colborder] (\x-0.2, -1.0) rectangle (\x+0.2, 0.8);
      }
    \end{tikzpicture}
    \end{center}

- **横ベクトルが縦に並んでいると思うと**
  各「横成分」に右のベクトルが分配されたように振る舞います。

    \begin{center}
    \begin{tikzpicture}[>=stealth, thick, scale=0.9, every node/.style={align=center}]
      \colorlet{vecbg}{cyan!10} \colorlet{vecborder}{cyan!70!blue}
      \colorlet{vbg}{orange!10} \colorlet{vborder}{orange!80!red}

      \node at (-1.7, 0) {$B \mathbf{v} =$};
      \draw[draw=black, thick] (0, 1.2) -- (-0.4, 1.2) -- (-0.4, -1.2) -- (0, -1.2);
      \draw[draw=black, thick] (1.8, 1.2) -- (2.0, 1.2) -- (2.0, -1.2) -- (1.8, -1.2);
      \foreach \y/\i in {0.75/1, 0.25/2, -0.25/3, -0.75/4} {
        \node[anchor=east] at (0.3, \y) {$\mathbf{b}_\i^\top$};
        \draw[fill=vecbg, draw=vecborder] (0.4, \y-0.15) rectangle (1.6, \y+0.15);
      }
      \draw[fill=vbg, draw=vborder] (2.4, -0.75) rectangle (2.8, 0.75);
      \node at (2.6, 1.0) {$\mathbf{v}$};
      \foreach \y in {0.75, 0.25, -0.25, -0.75} {
        \draw[->, orange!80!red, shorten >=2pt] (2.4, 0) to[out=180, in=0] (1.6, \y);
      }
      \node at (3.5, 0) {$=$};
      \draw[draw=black, thick] (4.0, 1.2) -- (3.8, 1.2) -- (3.8, -1.2) -- (4.0, -1.2);
      \draw[draw=black, thick] (5.6, 1.2) -- (5.8, 1.2) -- (5.8, -1.2) -- (5.6, -1.2);
      \foreach \y/\i in {0.75/1, 0.25/2, -0.25/3, -0.75/4} {
        \node[anchor=west] at (3.9, \y) {$\mathbf{b}_\i^\top \mathbf{v}$};
        \draw[fill=vbg, draw=vborder] (5.2, \y-0.1) rectangle (5.4, \y+0.1);
      }
    \end{tikzpicture}
    \end{center}

- **縦ベクトルが横に並んでいると思うと**
  あたかも通常のベクトル間の内積（成分同士を掛けて足す）かのように振る舞います。

    \begin{center}
    \begin{tikzpicture}[>=stealth, thick, scale=0.9, every node/.style={align=center}]
      \colorlet{colbg}{magenta!10} \colorlet{colborder}{magenta!70!purple}
      \colorlet{vbg}{orange!10} \colorlet{vborder}{orange!80!red}

      \node at (-1.5, 0) {$B \mathbf{v} =$};
      \draw[draw=black, thick] (0, 1.2) -- (-0.2, 1.2) -- (-0.2, -1.2) -- (0, -1.2);
      \draw[draw=black, thick] (2.0, 1.2) -- (2.2, 1.2) -- (2.2, -1.2) -- (2.0, -1.2);
      \foreach \x/\i in {0.4/1, 1.0/2, 1.6/3} {
        \node[anchor=south, inner sep=1pt] at (\x, 1.0) {\small $\boldsymbol{\beta}_\i$};
        \draw[fill=colbg, draw=colborder] (\x-0.15, -1.0) rectangle (\x+0.15, 0.8);
      }
      \draw[draw=black, thick] (2.4, 1.2) -- (2.3, 1.2) -- (2.3, -1.2) -- (2.4, -1.2);
      \draw[draw=black, thick] (3.0, 1.2) -- (3.1, 1.2) -- (3.1, -1.2) -- (3.0, -1.2);
      \node at (2.7, 1.4) {$\mathbf{v}$};
      \foreach \y/\i in {0.6/1, 0.0/2, -0.6/3} {
        \draw[fill=vbg, draw=vborder] (2.55, \y-0.15) rectangle (2.85, \y+0.15);
      }
      \draw[dashed, orange!80!red, shorten >=2pt, thick] (0.55, 0.6) to[out=50, in=150] (2.5, 0.7);
      \draw[dashed, orange!80!red, shorten >=2pt, thick] (1.15, 0.2) to[out=40, in=160] (2.5, 0.1);
      \draw[dashed, orange!80!red, shorten >=2pt, thick] (1.75, -0.2) to[out=30, in=170] (2.5, -0.5);

      \node at (3.5, 0) {$=$};
      \node at (4.2, 0) {$\displaystyle \sum_{j=1}^3$};
      \draw[fill=colbg, draw=colborder] (4.8, -1.0) rectangle (5.1, 0.8);
      \node[anchor=south] at (4.95, 0.8) {$\boldsymbol{\beta}_j$};
      \draw[fill=vbg, draw=vborder] (5.4, -0.15) rectangle (5.7, 0.15);
      \node[anchor=south] at (5.55, 0.15) {$v_j$};
    \end{tikzpicture}
    \end{center}

## ベクトルの内積と性質

### 【復習とヒント】ベクトルの内積の主な出番 {.tcolorbox option="enhanced, colback=blue!2!white, colframe=blue!60!black, fonttitle=\bfseries, drop shadow"}

内積の主な出番は3つあります。
内積は $\langle \cdot, \cdot \rangle$ や $\mathbf{x}^\top \mathbf{y}$ で表します。

- **重み付き和を簡潔に表す**（成分ごとの重み $\mathbf{w} = (w_1, \dots, w_d)^\top$）
  $$ \mathbf{w}^\top \mathbf{x} = w_1 x_1 + \dots + w_d x_d $$

- **2つのベクトルの向きの揃い具合**（同じ向きで最大、逆向きで最小）
  長さ1のベクトル同士なら、
  $$ \langle \textcolor{orange!80!red}{\nwarrow}, \textcolor{green!70!black}{\searrow} \rangle = -1, \quad \langle \textcolor{orange!80!red}{\nwarrow}, \textcolor{green!70!black}{\nearrow} \rangle = 0, \quad \langle \textcolor{orange!80!red}{\nwarrow}, \textcolor{green!70!black}{\nwarrow} \rangle = 1 \quad \text{（長さ1の場合）} $$
  【補足】同じ向きを向いている場合に内積が最も大きくなるという主張はコーシー・シュワルツの不等式から従う。ここでベクトルの長さは $\|\cdot\| = \sqrt{\langle\cdot, \cdot\rangle}$ で測る。

- **特定の方向の成分の抽出**（ベクトル $\mathbf{a}$ の「ベクトル $\mathbf{b}$ 方向成分」）
  $$ \mathbf{a} = \frac{\langle \mathbf{a}, \mathbf{b} \rangle}{\langle \mathbf{b}, \mathbf{b} \rangle} \mathbf{b} + (\mathbf{b}\text{に直交する成分}) $$

    \begin{center}
    \begin{tikzpicture}[>=stealth, thick, scale=1.0]
      \draw[->, orange!80!red, line width=1.2pt] (0,0) -- (4,1.5) node[right] {$\mathbf{b}$};
      \draw[->, cyan!70!blue, line width=1.2pt] (0,0) -- (1,2) node[above] {$\mathbf{a}$};
      \draw[dashed, black!70] (1,2) -- (1.52,0.57);
      \fill[orange!80!red] (1.52,0.57) circle (2pt);
      \node[below left] at (0,0) {$0$};
    \end{tikzpicture}
    \end{center}
  【補足】最後の $\mathbf{a} = \frac{\langle \mathbf{a}, \mathbf{b} \rangle}{\langle \mathbf{b}, \mathbf{b} \rangle} \mathbf{b} + (\mathbf{b}\text{に直交する成分})$ という分解は、$\langle \mathbf{a} - \frac{\langle \mathbf{a}, \mathbf{b} \rangle}{\langle \mathbf{b}, \mathbf{b} \rangle} \mathbf{b}, \mathbf{b} \rangle = 0$ により確かめられる。

### 内積の役割と計算 {#q:3-inner-product-roles .questionbox tags="スキップ可"}

以下の小問に答えよ。

1. **【重み付き和の計算】**
   ある商品の3つの特徴量が $\mathbf{x} = (2, -1, 4)^\top$ であり、各特徴量に対する重みが $\mathbf{w} = (3, 2, 1)^\top$ であるとする。この商品のスコアを内積 $\mathbf{w}^\top \mathbf{x}$ として計算せよ。
2. **【ベクトルの揃い具合と直交性 (1)】**
   長さが1のベクトル $\mathbf{a} = (\frac{2}{3}, \frac{2}{3}, \frac{1}{3})^\top$ と $\mathbf{b} = (\frac{2}{3}, -\frac{1}{3}, -\frac{2}{3})^\top$ について、内積 $\mathbf{a}^\top \mathbf{b}$ を計算し、これら2つのベクトルの幾何学的な位置関係（同じ方向、真逆の方向、直交、それらのどれでもない、のいずれか）を特定せよ。
3. **【ベクトルの揃い具合と直交性 (2)】**
   長さが1のベクトル $\mathbf{a} = (\frac{2}{3}, \frac{2}{3}, \frac{1}{3})^\top$ と $\mathbf{c} = (\frac{1}{3}, \frac{2}{3}, \frac{2}{3})^\top$ について、内積 $\mathbf{a}^\top \mathbf{c}$ を計算し、位置関係（同じ方向、真逆の方向、直交、それらのどれでもない、のいずれか）を特定せよ。
4. **【直交分解の係数】**
   ベクトル $\mathbf{x} = (5, 2, -1)^\top$ と $\mathbf{u} = (1, -1, 2)^\top$ がある。ベクトル $\mathbf{x}$ を、$\mathbf{u}$ と平行な成分と $\mathbf{u}$ に直交する成分 $\mathbf{v}$ を用いて
   $$ \mathbf{x} = \beta \mathbf{u} + \mathbf{v} \quad (\mathbf{v} \text{ は } \mathbf{u} \text{ と直交}) $$
   と分解するとき、係数 $\beta$ を内積を用いて求めよ。

::: {.right}
[（解答・解説へ）](#a:3-inner-product-roles)
:::


## パラメータ線型モデルの表現（特徴写像）

### 多項式特徴写像による線型表現 {#q:3-polynomial-feature-mapping .questionbox tags="確認\faCheck"}

1次元の入力 $x$ に対し、特徴写像を $\boldsymbol{\phi}(x) = (1, x, x^2)^\top$ と定義する。
パラメータベクトルを $\boldsymbol{\theta} = (\theta_0, \theta_1, \theta_2)^\top$ とする。

1. 線型モデル $f(x) = \boldsymbol{\theta}^\top \boldsymbol{\phi}(x)$ を書き下せ。
2. このモデルは、パラメータ $\boldsymbol{\theta}$ に着目すると何次式か。また、入力 $x$ に着目すると何次式か答えよ。
   （ただし，多変数多項式の次数は，最大の単項式の次数のことである．）

::: {.right}
[（解答・解説へ）](#a:3-polynomial-feature-mapping)
:::

### テキストデータへの適用（Bag-of-Words）と最小二乗法 {#q:3-bag-of-words-representation .questionbox tags="必須\faStar"}

テキストの文書分類や数値予測を行う際、文書中の単語の出現頻度をもとに特徴ベクトルを作る手法を**Bag-of-Words**と呼びます。

今、以下の4つのテキスト（文書）と、それぞれの正解ラベル（重要度スコアなど）の表が与えられているとします。

```{=latex}
\smallskip
\begin{center}
\begin{tabular}{|c|p{9cm}|c|}
\hline
文書番号 ($i$) & \multicolumn{1}{c|}{文書の内容 ($x_i$)} & 正解ラベル ($y_i$) \\
\hline
1 & 最新の AI 技術は急速に発展しています。多くの研究者が新しい AI モデルを開発しています。 & 5 \\
2 & 今朝の人気ニュース番組で、有名な俳優の最新映画が紹介されました。多くのファンが劇場に詰めかけています。 & 0 \\
3 & AI の活用はビジネスに変革をもたらします。企業経営において AI を導入するビジネス戦略が不可欠です。 & 10 \\
4 & ペット関連のビジネスが盛んです。特に犬向けのサービスは市場規模が拡大しています。 & 15 \\
\hline
\end{tabular}
\end{center}
\smallskip
```
<!-- 語彙となる名詞のリストを $V = \{\text{「AI」}, \text{「ビジネス」}, \text{「犬」}\}$ とし、 -->
特徴ベクトル $\boldsymbol{\phi}(x)$ を以下のように定義します。
$$
\boldsymbol{\phi}(x) = \begin{pmatrix} \text{「AI」の出現回数} \\ \text{「ビジネス」の出現回数} \\ \text{「犬」の出現回数} \end{pmatrix}
$$

この特徴ベクトルを用いた線型モデル $f(x) = \boldsymbol{\theta}^\top \boldsymbol{\phi}(x)$ （ただし $\boldsymbol{\theta} = (\theta_1, \theta_2, \theta_3)^\top$）について、以下の問いに答えよ。

1. 各文書 $x_1, x_2, x_3, x_4$ に対応する特徴ベクトル $\boldsymbol{\phi}(x_1), \boldsymbol{\phi}(x_2), \boldsymbol{\phi}(x_3), \boldsymbol{\phi}(x_4)$ をそれぞれ具体的に求めよ。
2. 計画行列 $\Phi \in \mathbb{R}^{4 \times 3}$ と、ラベルベクトル $\mathbf{y} \in \mathbb{R}^4$ をそれぞれ具体的に数値で書き下せ。
   なお，計画行列とは，ここでは，
   $$\Phi = \begin{pmatrix} \boldsymbol{\phi}(x_1)^\top \\ \boldsymbol{\phi}(x_2)^\top \\ \boldsymbol{\phi}(x_3)^\top \\ \boldsymbol{\phi}(x_4)^\top \end{pmatrix}$$
   のことである．

---

補足： ここで計算した $\Phi$ は，後にパラメーターの最適化において現れる．

::: {.right}
[（解答・解説へ）](#a:3-bag-of-words-representation)
:::

## 多変数関数の経験リスクと勾配

### 2変数関数の偏微分と勾配ベクトル {#q:3-bivariate-gradient .questionbox tags="確認\faCheck"}

2変数関数 $f(x, y) = x^2 + 3xy + 2y^2$ について、以下の問いに答えよ。

1. 関数 $f$ の $x$ に関する偏微分 $\frac{\partial f}{\partial x}$ を求めよ。
2. 関数 $f$ の $y$ に関する偏微分 $\frac{\partial f}{\partial y}$ を求めよ。
3. 求めた偏微分を縦ベクトルに並べて、関数 $f$ の勾配ベクトル $\nabla f(x, y) = \begin{pmatrix} \frac{\partial f}{\partial x} \\ \frac{\partial f}{\partial y} \end{pmatrix}$ を書き下せ。
4. 点 $(x, y) = (1, 2)$ における勾配ベクトル $\nabla f(1, 2)$ の値を計算せよ。

::: {.right}
[（解答・解説へ）](#a:3-bivariate-gradient)
:::

## 最小二乗法の行列表記と一階の条件（最重要）

### 行列とベクトルによる目的関数の書き直し {#q:3-matrix-empirical-risk .questionbox tags="必須\faStar"}

$n$ 個のデータ $(x_1, y_1), \dots, (x_n, y_n)$ に対して、線型モデルを $f_{\boldsymbol{\theta}}(x) = \boldsymbol{\theta}^\top \boldsymbol{\phi}(x)$ とする。また、計画行列 $\Phi \in \mathbb{R}^{n \times d}$ とラベルベクトル $\mathbf{y} \in \mathbb{R}^n$ を次のように定義する。
$$
\Phi = \begin{pmatrix} \quad \boldsymbol{\phi}(x_1)^\top \quad \\ \vdots \\ \quad \boldsymbol{\phi}(x_n)^\top \quad \end{pmatrix}, \quad \mathbf{y} = \begin{pmatrix} y_1 \\ \vdots \\ y_n \end{pmatrix}
$$

1. **【予測値の行列表現】**
   モデルの出力値を各データについて計算し、縦に並べた予測値ベクトル
   $$
   \begin{pmatrix} f_{\boldsymbol{\theta}}(x_1) \\ \vdots \\ f_{\boldsymbol{\theta}}(x_n) \end{pmatrix}
   $$
   が、 $\Phi \boldsymbol{\theta}$ と表せることを確認せよ。

2. **【平均二乗誤差のノルム表現】**
   平均二乗誤差
   $$
   \hat{R}(f_{\boldsymbol{\theta}}) = \frac{1}{n} \sum_{i=1}^n (f_{\boldsymbol{\theta}}(x_i) - y_i)^2
   $$
   が、行列とベクトルの積およびノルムを用いて
   $$
   \hat{R}(f_{\boldsymbol{\theta}}) = \frac{1}{n} \|\Phi \boldsymbol{\theta} - \mathbf{y}\|^2
   $$
   と書き直せることを、上記1の結果を用いて確認せよ。

<!-- およびベクトルのノルムの定義 $\left(\|\mathbf{v}\|^2 = \sum_{i=1}^n v_i^2\right)$  -->

::: {.right}
[（解答・解説へ）](#a:3-matrix-empirical-risk)
:::

### 【復習とヒント】ベクトルによる微分の公式 {.tcolorbox option="enhanced, colback=blue!2!white, colframe=blue!60!black, fonttitle=\bfseries, drop shadow"}

- **内積の微分** $\rightarrow$ 係数が残る（1次元でいう $(ax)' = a$ の一般化）
  $$
  \nabla_{\mathbf{x}} (\mathbf{a}^\top \mathbf{x}) = \nabla_{\mathbf{x}} (\mathbf{x}^\top \mathbf{a}) = \mathbf{a}
  $$

- **二次形式の微分** $\rightarrow$ 一次の項が残る（1次元でいう $(ax^2)' = 2ax$ の一般化）
  $$
  \nabla_{\mathbf{x}} (\mathbf{x}^\top \mathbf{A} \mathbf{x}) = (\mathbf{A} + \mathbf{A}^\top)\mathbf{x}
  $$
  特に対称行列（$\mathbf{A} = \mathbf{A}^\top$）の場合は、
  $$\nabla_{\mathbf{x}} (\mathbf{x}^\top \mathbf{A} \mathbf{x}) = 2\mathbf{A}\mathbf{x}$$
  となる。

<!-- 行列微分の公式
\begin{align*}
\nabla_{\boldsymbol{\theta}} (\mathbf{a}^\top \boldsymbol{\theta}) &= \mathbf{a} \\
\nabla_{\boldsymbol{\theta}} (\boldsymbol{\theta}^\top \mathbf{A} \boldsymbol{\theta}) &= 2\mathbf{A}\boldsymbol{\theta} \quad \text{（$\mathbf{A}$は対称行列）}
\end{align*}
を用いて、 -->
### 行列・ベクトルでの二次形式の展開と平方完成 {#q:3-quadratic-form-completing-square .questionbox tags="必須\faStar"}

一変数関数における平方完成 $(x - b)^2 = x^2 - 2bx + b^2$ の行列・ベクトル版を確認する。
対称行列 $\mathbf{A}$（すなわち $\mathbf{A} = \mathbf{A}^\top$）と、ベクトル $\mathbf{x}, \mathbf{b}$ があるとする。

1. **【展開】**
   二次形式 $(\mathbf{x} - \mathbf{b})^\top \mathbf{A} (\mathbf{x} - \mathbf{b})$ を展開し、以下の式となることを示せ。
   $$
   \mathbf{x}^\top \mathbf{A} \mathbf{x} - 2\mathbf{b}^\top \mathbf{A} \mathbf{x} + \mathbf{b}^\top \mathbf{A} \mathbf{b}
   $$

2. **【平方完成】**
   逆に、以下の二次式が与えられたとき、
   $$
   \mathbf{x}^\top \mathbf{A} \mathbf{x} - 2\mathbf{c}^\top \mathbf{x}
   $$
   これを平方完成して $(\mathbf{x} - \boldsymbol{\mu})^\top \mathbf{A} (\mathbf{x} - \boldsymbol{\mu}) + \text{定数}$ の形にしたい。

   $\mathbf{A}$ が正則（逆行列 $\mathbf{A}^{-1}$ を持つ）であると仮定し、$\boldsymbol{\mu} = \mathbf{A}^{-1}\mathbf{c}$ とおくことで平方完成を完了させよ。

---

**ヒント：** スカラー $\mathbf{b}^\top \mathbf{A} \mathbf{x}$ は転置しても同じ値になること、および $\mathbf{A}^\top = \mathbf{A}$ を用いる。

::: {.right}
[（解答・解説へ）](#a:3-quadratic-form-completing-square)
:::

## 正則化（Regularization）

### 【復習とヒント】L2ノルムの性質と内積 {.tcolorbox option="enhanced, colback=blue!2!white, colframe=blue!60!black, fonttitle=\bfseries, drop shadow"}

一般の $d$ 次元ベクトル $\mathbf{w} = (w_1, \dots, w_d)^\top$ について、L2ノルムの定義 $\|\mathbf{w}\| = \sqrt{\sum_{i=1}^d w_i^2}$ と内積の定義より、以下の等式が成り立ちます。
$$
\|\mathbf{w}\|^2 = \mathbf{w}^\top \mathbf{w}
$$

### L2正則化付き目的関数の書き下し {#q:3-l2-regularization-objective .questionbox tags="確認\faCheck"}

損失関数を二乗誤差、正則化項をL2ノルムの2乗とし、正則化係数を $\lambda = 0.01$ とする。 $n$ 個のデータに対するL2正則化付き経験リスク最小化の目的関数 $L_{\text{reg}}(\boldsymbol{\theta})$ の式をシグマ表記で書き下せ。

::: {.right}
[（解答・解説へ）](#a:3-l2-regularization-objective)
:::

## L2正則化付き線型最小二乗回帰の解

### 目的関数の展開と勾配の導出 {#q:3-matrix-derivative-first-order .questionbox tags="必須\faStar"}

L2正則化なしの目的関数 $L(\boldsymbol{\theta}) = \frac{1}{2}\|\Phi\boldsymbol{\theta} - \mathbf{y}\|^2$ の展開と勾配について考える。（次問の正則化付きの問題の準備となる。）

1. **【ノルムの展開】**
   $\|\Phi\boldsymbol{\theta} - \mathbf{y}\|^2 = (\Phi\boldsymbol{\theta} - \mathbf{y})^\top (\Phi\boldsymbol{\theta} - \mathbf{y})$ の右辺を展開し、目的関数が以下のように展開されることを確認せよ。
   $$
   L(\boldsymbol{\theta}) = \frac{1}{2}\boldsymbol{\theta}^\top \Phi^\top \Phi \boldsymbol{\theta} - \mathbf{y}^\top \Phi \boldsymbol{\theta} + \frac{1}{2}\mathbf{y}^\top \mathbf{y}
   $$

2. **【勾配の導出】**
   展開した式を用いて、目的関数の勾配 $\nabla_{\boldsymbol{\theta}} L(\boldsymbol{\theta})$ が以下のように表されることを導出せよ。
   $$
   \nabla_{\boldsymbol{\theta}} L(\boldsymbol{\theta}) = \Phi^\top \Phi \boldsymbol{\theta} - \Phi^\top \mathbf{y}
   $$

---

**ヒント：**

- ノルムの展開では、転置の公式 $(\mathbf{A}\mathbf{B})^\top = \mathbf{B}^\top \mathbf{A}^\top$ と、スカラーの内積 $\mathbf{a}^\top \mathbf{b} = \mathbf{b}^\top \mathbf{a}$ を用いる。
- 勾配の導出では、二次形式の微分 $\nabla_{\boldsymbol{\theta}}(\boldsymbol{\theta}^\top \mathbf{A} \boldsymbol{\theta}) = 2\mathbf{A}\boldsymbol{\theta}$ （今回は $\mathbf{A} = \Phi^\top \Phi$ が対称行列）と、内積の微分 $\nabla_{\boldsymbol{\theta}}(\mathbf{a}^\top \boldsymbol{\theta}) = \mathbf{a}$ を用いる。

::: {.right}
[（解答・解説へ）](#a:3-matrix-derivative-first-order)
:::

### 行列による書き直しと一階の条件 {#q:3-l2-regularization-gradient .questionbox tags="必須\faStar"}
L2正則化付き経験リスク最小化の目的関数 $L(\boldsymbol{\theta})$ を考える（$\boldsymbol{\theta}$ は $d$ 次元のパラメーターとする）．
$$
L(\boldsymbol{\theta}) = \frac{1}{2}\|\Phi\boldsymbol{\theta} - \mathbf{y}\|^2 + \frac{\lambda}{2}\|\boldsymbol{\theta}\|^2
$$

最適化問題
$$
\mathop{\mathrm{Min}}_{\boldsymbol{\theta} \in \mathbb{R}^d} \ L(\boldsymbol{\theta})
$$
の最適解が
$$\hat{\boldsymbol{\theta}} = (\Phi^\top \Phi + \lambda \mathbf{I})^{-1}\Phi^\top \mathbf{y}$$
で与えられることを示せ（ただし上式の逆行列は存在すると仮定する。また、$\mathbf{I}$ は $d$ 次元の単位行列である）。

---

まずは自力で試みてほしいが、以下に段階的なヒントを記載する。

**ヒント1：** L2ノルムの2乗は内積を用いて $\|\boldsymbol{\theta}\|^2 = \boldsymbol{\theta}^\top \boldsymbol{\theta}$ と書ける。これを用いて、間に単位行列 $\mathbf{I}$ を挟んで $\frac{\lambda}{2}\|\boldsymbol{\theta}\|^2 = \boldsymbol{\theta}^\top \left(\frac{\lambda}{2}\mathbf{I}\right) \boldsymbol{\theta}$ とみなすことができる。

**ヒント2：** 目的関数全体の勾配 $\nabla L(\boldsymbol{\theta})$ を計算し、それが $\mathbf{0}$ になるという方程式（一階の条件）を立てる。

**ヒント3：** 方程式を $\boldsymbol{\theta}$ について解くために、$\boldsymbol{\theta}$ でくくれる項をまとめ、左から逆行列を掛ける。

::: {.right}
[（解答・解説へ）](#a:3-l2-regularization-gradient)
:::

## モデル選択（交差検証）

### K-foldとLOOCVのインデックス計算 {#q:3-cross-validation-indices .questionbox tags="スキップ可"}

1. $n=6$ 個のデータを $K=3$ 個のまとまり
        $$
        D_1 = \{1, 2\}, \quad D_2 = \{3, 4\}, \quad D_3 = \{5, 6\}
        $$
        に分割する。第2イテレーション（$D_2$ が検証用）において、訓練に使用されるデータのインデックスをすべて答えよ。
2. サンプルサイズが $n=100$ のデータにLOOCV（一箇抜き交差検証）を行う場合、モデルの学習は合計で何回実行されるか。

::: {.right}
[（解答・解説へ）](#a:3-cross-validation-indices)
:::

# 確率モデルと分位点回帰

## 同時分布・条件付き分布・条件付き期待値

### 同時確率表からの条件付き分布と期待値 {#q:4-conditional-probability-table .questionbox tags="スキップ可"}

離散確率変数 $X \in \{0,1\}$ と $Y \in \{1,2,3\}$ の同時確率 $P(X, Y)$ について、 $X=0$ のとき、$Y=1, 2, 3$ となる確率はそれぞれ $0.1, 0.2, 0.1$ である。

1. $X=0$ となる周辺確率（正規化定数） $P(X=0)$ を求めよ。
2. $X=0$ という条件のもとでの $Y$ の条件付き確率分布 $P(Y=y \mid X=0)$ を求めよ。
3. 上記の分布を用いて、条件付き期待値 $\mathbb{E}[Y \mid X=0]$ を計算せよ。

::: {.right}
[（解答・解説へ）](#a:4-conditional-probability-table)
:::

## 分位点（Quantile）と外れ値の影響

### ピンボール損失のグラフ描写の理解 {#q:4-pinball-loss-calculation .questionbox tags="スキップ可"}

ピンボール損失関数
$$
l_\alpha(y, y') =
\begin{cases}
(\alpha - 1)(y - y') & (y - y' < 0) \\
\alpha(y - y') & (y - y' \ge 0)
\end{cases}
$$
において、$\alpha = 0.3$ とする。誤差 $e = y - y'$ が $e = -2$ のときと $e = 4$ のときの損失の値をそれぞれ計算し、グラフの形状を説明せよ。

::: {.right}
[（解答・解説へ）](#a:4-pinball-loss-calculation)
:::

# 確率論的二値分類と非線型最適化

## ロジスティック回帰の基礎と非線型目的関数の勾配

### 指示関数の期待値と確率の関係 {#q:5-indicator-expectation .questionbox tags="必須\faStar"}

確率変数 $X$ の値が集合 $A$ に入るという事象について、
$$
\mathbb{E}[\ind\{X \in A\}] = \mathbb{P}(X \in A)
$$
が成り立つことを示せ。

<!-- 指示関数 $\ind\{X \in A\}$ の期待値 $\mathbb{E}[\ind\{X \in A\}]$ は、事象 $\{X \in A\}$ が発生する確率 $\mathbb{P}(X \in A)$ と等しくなること、すなわち -->

::: {.right}
[（解答・解説へ）](#a:5-indicator-expectation)
:::

## ロジスティック関数の微分と交差エントロピー

### シグモイド関数の微分証明 {#q:5-sigmoid-derivative .questionbox tags="必須\faStar"}

ロジスティック関数（シグモイド関数）について、
$$
\sigma(z) = \frac{1}{1 + \exp(-z)}
$$
として以下の問いに答えよ。

1. $\sigma(z) \exp(-z) = 1 - \sigma(z)$ が成り立つことを示せ。
2. $\frac{d}{dz} \sigma(z) = \sigma(z)^2 \exp(-z)$ になることを示せ。
3. 以上の結果から、$\frac{d}{dz} \log \sigma(z) = 1 - \sigma(z)$ を導出せよ。

::: {.right}
[（解答・解説へ）](#a:5-sigmoid-derivative)
:::

### 交差エントロピーとチェインルールによる勾配導出 {#q:5-cross-entropy-gradient .questionbox tags="必須\faStar"}

2クラス分類の交差エントロピー損失は、モデルの出力（ロジット）を $z$、シグモイド関数を $\sigma(z)$ とすると、次のように表される。
$$
\ell(z) = -y \log \sigma(z) - (1-y) \log(1 - \sigma(z))
$$

以下の手順に従って、この損失関数のパラメーターに関する勾配を丁寧に変形して導出せよ。

1. まず、線型モデルなどの具体的なモデルの形を仮定せず、一般のロジット $z$ に対する損失 $\ell(z)$ の微分 $\frac{\partial \ell(z)}{\partial z}$ を求め、
   $$
   \frac{\partial \ell(z)}{\partial z} = \sigma(z) - y
   $$
   となることを示せ。（必要に応じて前問の $\sigma'(z)$ や $\frac{d}{dz} \log \sigma(z)$ の結果を利用してよい）

2. 次に、モデルが線型モデルであり、$z = \boldsymbol{\theta}^\top \boldsymbol{\phi}(x)$ と表されるとする。このとき、チェインルール $\nabla_{\boldsymbol{\theta}} \ell(z) = \frac{\partial \ell(z)}{\partial z} \cdot \nabla_{\boldsymbol{\theta}} z$ を用いて、パラメーター $\boldsymbol{\theta}$ に対する勾配が
   $$
   \nabla_{\boldsymbol{\theta}} \ell(z) = (\sigma(z) - y)\boldsymbol{\phi}(x)
   $$
   となることを導出せよ。

::: {.right}
[（解答・解説へ）](#a:5-cross-entropy-gradient)
:::

## 勾配降下法と正則化

### 勾配降下法による最適化（アルゴリズムの構成） {#q:6-gradient-descent-algorithm .questionbox tags="確認\faCheck"}

以下の勾配降下法のアルゴリズム中の各空欄 $\fbox{\,ア\,}$ 〜 $\fbox{\,ク\,}$ に当てはまる最も適切なものを、以下のそれぞれの語群から一つずつ選び、番号で答えよ。

【説明文の語群】（空欄 $\fbox{\,ア\,}, \fbox{\,ウ\,}, \fbox{\,オ\,}, \fbox{\,キ\,}$）

① パラメーターを更新する　② 勾配を計算する　③ 初期化する　④ 反復を中断する

【数式・操作の語群】（空欄 $\fbox{\,イ\,}, \fbox{\,エ\,}, \fbox{\,カ\,}, \fbox{\,ク\,}$）

⑤ $\boldsymbol{\theta} \leftarrow \boldsymbol{\theta} - \eta \mathbf{g}$　⑥ `exit loop`　⑦ $\mathbf{g} \leftarrow \nabla L(\boldsymbol{\theta})$　⑧ $\boldsymbol{\theta} \leftarrow \text{ランダムな値}$

【勾配降下法のアルゴリズム】

> **`Algorithm: Gradient Descent`**
>
> - `Step 1`: ( 目的: $\fbox{\,ア\,}$ )  ( 操作: $\fbox{\,イ\,}$ )
> - `Step 2`: `Loop` （以下の処理を繰り返す）
>     - `Step 2-1`: ( 目的: $\fbox{\,ウ\,}$ )  ( 操作: $\fbox{\,エ\,}$ )
>     - `Step 2-2`: ( 目的: $\fbox{\,オ\,}$ )  ( 操作: $\fbox{\,カ\,}$ )
>     - `Step 2-3`: もし 早期停止条件を満たしたら、( 目的: $\fbox{\,キ\,}$ )  ( 操作: $\fbox{\,ク\,}$ )
> - `Step 3`: 終了して $\boldsymbol{\theta}$ を出力 （最適化されたパラメーター）

::: {.right}
[（解答・解説へ）](#a:6-gradient-descent-algorithm)
:::

### 重み減衰（Weight Decay）の導出 {#q:6-weight-decay-derivation .questionbox tags="必須\faStar"}

勾配法で最適化を行う場合、L2正則化は重み減衰（weight decay）とも呼ばれる。
目的関数が経験リスク $\hat{R}(\boldsymbol{\theta})$ とL2正則化項の和である $L(\boldsymbol{\theta}) = \hat{R}(\boldsymbol{\theta}) + \lambda \|\boldsymbol{\theta}\|^2$ で与えられるとする（$\lambda > 0$ は正則化係数）。

1. この目的関数に対する勾配 $\nabla L(\boldsymbol{\theta})$ を、$\nabla \hat{R}(\boldsymbol{\theta})$ と $\boldsymbol{\theta}$ を用いて表せ。
2. 勾配降下法の更新式 $\boldsymbol{\theta} \leftarrow \boldsymbol{\theta} - \eta \nabla L(\boldsymbol{\theta})$ に上記で求めた勾配を代入し、「単に経験リスク $\hat{R}$ を小さくする方向に進むだけでなく、現在のパラメーターを原点に向けて一定割合で縮小する」という直感的な解釈が成り立つことを、数式を用いて説明せよ。

::: {.right}
[（解答・解説へ）](#a:6-weight-decay-derivation)
:::

### ロジスティック回帰＋L2正則化の更新式と具体例計算 {#q:6-logistic-l2-update .questionbox tags="確認\faCheck"}

二値分類タスクにおいて、ロジスティックモデル $f_\theta(x) = \sigma(\theta x)$ を考える（バイアス項は無視し、特徴量も1次元のスカラー $x$ とする）。
損失関数を負の対数尤度（交差エントロピー損失）とし、L2正則化項を加えた目的関数は以下のようになる。
$$L(\theta) = - \frac{1}{n} \sum_{i=1}^n \left\{ y_i \log \sigma(\theta x_i) + (1-y_i) \log(1-\sigma(\theta x_i)) \right\} + \lambda \theta^2$$

1. これまでの章で導出した交差エントロピーの勾配の公式を用いて、この目的関数に対する勾配降下法の更新式（パラメーター $\theta$ の更新則）を書き下せ。
2. 簡単な数値例として、$n=2$ のデータ $\{(x_1, y_1) = (1, 1), (x_2, y_2) = (-1, 0)\}$ を考える。現在のパラメーターが $\theta = 0$、学習率が $\eta = 0.5$、正則化係数が $\lambda = 0.1$ のとき、1回目の更新後のパラメーター $\theta$ の値を計算せよ。

---

**ヒント（問2）：** $\theta=0$ のとき、シグモイド関数の値は $\sigma(0) = 0.5$ となることに注意して計算せよ。

::: {.right}
[（解答・解説へ）](#a:6-logistic-l2-update)
:::

# 確率論的多値分類とソフトマックス回帰

## ソフトマックス関数と多クラス交差エントロピー

### Log-Softmax 関数の勾配 {#q:6-log-softmax-gradient .questionbox tags="必須\faStar"}

ベクトル $\mathbf{z} = (z_1, \dots, z_K)^\top$ を入力とするソフトマックス関数 $\text{Softmax}(\mathbf{z})$ について、以下が成り立つことを導出せよ。

$$
\nabla_{\mathbf{z}} \log \text{Softmax}(\mathbf{z})[k] =
\begin{pmatrix}
\mathbf{1}\{k=1\} - \text{Softmax}(\mathbf{z})[1] \\
\vdots \\
\mathbf{1}\{k=K\} - \text{Softmax}(\mathbf{z})[K]
\end{pmatrix}
$$

---

**ヒント：** その第 $k$ 成分の対数 $\log \text{Softmax}(\mathbf{z})[k]$ は、対数の性質から
$$
\log \text{Softmax}(\mathbf{z})[k] = \log \left( \frac{\exp(z_k)}{\sum_{m=1}^K \exp(z_m)} \right) = z_k - \log \sum_{m=1}^K \exp(z_m) \quad (k = 1, \dots, K)
$$
と分解できる。合成関数の微分則を用いて $\log \text{Softmax}(\mathbf{z})[k]$ の $\mathbf{z}$ に対する勾配ベクトル $\nabla_{\mathbf{z}} \log \text{Softmax}(\mathbf{z})[k]$ を計算してみよう。

::: {.right}
[（解答・解説へ）](#a:6-log-softmax-gradient)
:::

### ソフトマックス損失の勾配公式の導出 {#q:6-softmax-gradient-derivation .questionbox tags="必須\faStar"}

多クラス分類問題において、入力 $\mathbf{x}$ に対するスコアベクトルを $s_{\boldsymbol{\theta}}(\mathbf{x}) \in \mathbb{R}^K$ とし、モデル $g_{\boldsymbol{\theta}}(\mathbf{x}) = \text{Softmax}(s_{\boldsymbol{\theta}}(\mathbf{x}))$ を考える。ここで、モデルの出力ベクトルの第 $k$ 成分 $g_{\boldsymbol{\theta}}(\mathbf{x})[k]$ は以下のように定義される。
$$
g_{\boldsymbol{\theta}}(\mathbf{x})[k] = \frac{\exp(s_{\boldsymbol{\theta}}(\mathbf{x})[k])}{\sum_{j=1}^K \exp(s_{\boldsymbol{\theta}}(\mathbf{x})[j])}
$$
正解クラスラベルを $y \in \{1, \dots, K\}$ とするとき、損失関数（負の対数尤度損失）を
$$
\ell((\mathbf{x}, y), g_{\boldsymbol{\theta}}) = -\log g_{\boldsymbol{\theta}}(\mathbf{x})[y]
$$
と定義する。このとき、損失関数のパラメータ $\boldsymbol{\theta}$ に対する勾配が、以下のように表されることを示せ。
$$
\nabla_{\boldsymbol{\theta}} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}}) = -\nabla_{\boldsymbol{\theta}} s_{\boldsymbol{\theta}}(\mathbf{x})[y] + \sum_{k=1}^K g_{\boldsymbol{\theta}}(\mathbf{x})[k] \cdot \nabla_{\boldsymbol{\theta}} s_{\boldsymbol{\theta}}(\mathbf{x})[k]
$$

::: {.right}
[（解答・解説へ）](#a:6-softmax-gradient-derivation)
:::

### 多クラスロジスティック回帰の勾配公式 {#q:6-multiclass-logistic-gradient .questionbox tags="確認\faCheck"}

前問「ソフトマックス損失の勾配公式の導出」に引き続き、多クラスロジスティック回帰（ソフトマックス回帰）モデルを考える。このモデルでは、クラス $j$ のスコアがクラス固有のパラメータベクトル $\boldsymbol{\theta}_j$ と特徴量 $\boldsymbol{\phi}(\mathbf{x})$ の内積
$$
s_{\boldsymbol{\theta}}(\mathbf{x})[j] = \boldsymbol{\theta}_j^\top \boldsymbol{\phi}(\mathbf{x})
$$
で与えられる。特定のクラス $k$ のパラメータ $\boldsymbol{\theta}_k$ に対する損失関数の勾配 $\nabla_{\boldsymbol{\theta}_k} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}})$ を、以下の手順で導出せよ。

1. **【スコア関数の偏微分】**
   スコア $s_{\boldsymbol{\theta}}(\mathbf{x})[j]$ の $\boldsymbol{\theta}_k$ による勾配 $\nabla_{\boldsymbol{\theta}_k} s_{\boldsymbol{\theta}}(\mathbf{x})[j]$ を求め、指示関数 $\mathbf{1}\{\cdot\}$ を用いて
   $$
   \nabla_{\boldsymbol{\theta}_k} s_{\boldsymbol{\theta}}(\mathbf{x})[j] = \mathbf{1}\{j = k\} \boldsymbol{\phi}(\mathbf{x})
   $$
   と表せることを確認せよ。
2. **【勾配公式の適用と整理】**
   前問で求めた勾配公式の $\nabla_{\boldsymbol{\theta}}$ を $\nabla_{\boldsymbol{\theta}_k}$ に置き換え、(1) の結果を代入せよ。和 $\sum_{j=1}^K$ を整理することで、最終的な勾配が
   $$
   \nabla_{\boldsymbol{\theta}_k} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}}) = \left( g_{\boldsymbol{\theta}}(\mathbf{x})[k] - \mathbf{1}\{k = y\} \right) \boldsymbol{\phi}(\mathbf{x})
   $$
   となることを示せ。
3. **【パラメータ全体での勾配のブロックベクトル表現】**
   パラメータ全体を縦に並べたベクトル $\boldsymbol{\theta} = (\boldsymbol{\theta}_1^\top, \dots, \boldsymbol{\theta}_K^\top)^\top$ を考える。このとき、損失関数の $\boldsymbol{\theta}$ 全体に対する勾配 $\nabla_{\boldsymbol{\theta}} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}})$ が、各 $\boldsymbol{\theta}_k$ に関する勾配を縦に並べたブロックベクトルとして次のように表されることを確認せよ。
   $$
   \nabla_{\boldsymbol{\theta}} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}}) = \begin{pmatrix} \nabla_{\boldsymbol{\theta}_1} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}}) \\ \vdots \\ \nabla_{\boldsymbol{\theta}_K} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}}) \end{pmatrix} = \begin{pmatrix} (g_{\boldsymbol{\theta}}(\mathbf{x})[1] - \mathbf{1}\{1 = y\}) \boldsymbol{\phi}(\mathbf{x}) \\ \vdots \\ (g_{\boldsymbol{\theta}}(\mathbf{x})[K] - \mathbf{1}\{K = y\}) \boldsymbol{\phi}(\mathbf{x}) \end{pmatrix}
   $$

---

**ヒント：** 全体の勾配ベクトルは単純にそれぞれの $\nabla_{\boldsymbol{\theta}_k} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}})$ を並べたものになる。

::: {.right}
[（解答・解説へ）](#a:6-multiclass-logistic-gradient)
:::


# 解答・解説

## 確率の基礎とリスク関数・ERM

### 確率の基礎と期待値・分散の計算

**【該当内容】** 第1回スライド34〜38「基本知識＞確率分布、期待値」
**【ねらい】** 期待値 $\mathbb{E}[\cdot]$ や分散 $\mathbb{V}[\cdot]$ の計算規則を、離散型・連続型の両面から手計算で確かめ、のちに登場する「リスク関数」の数学的実態を掴む。

### 問1-discrete-expectation-variance の解答・解説 {#a:1-discrete-expectation-variance .answerbox ref="q:1-discrete-expectation-variance"}

1. $\mathbb{E}[X] = 0 \times 0.2 + 1 \times 0.5 + 2 \times 0.3 = 0 + 0.5 + 0.6 = 1.1$
2. $\mathbb{E}[f(X)] = \mathbb{E}[X^2] = 0^2 \times 0.2 + 1^2 \times 0.5 + 2^2 \times 0.3 = 0 + 0.5 + 1.2 = 1.7$
3. 分散 $\mathbb{V}[f(X)]$ の計算方法には、定義から計算する方法と、公式を用いる方法の2通りがあります。

    **方法1：定義から直接計算する方法**
    分散の定義 $\mathbb{V}[Y] = \mathbb{E}[(Y - \mathbb{E}[Y])^2]$ において、$Y = f(X)$ と置くと、
    $$
    \mathbb{V}[f(X)] = \mathbb{E}\left[ (f(X) - \mathbb{E}[f(X)])^2 \right]
    $$
    となります。(2) より $\mathbb{E}[f(X)] = 1.7$ であるため、各 $X$ の値における $f(X)$ の値から期待値 $1.7$ を引き、その2乗の期待値をとります。
    \begin{align*}
    \mathbb{V}[f(X)] &= (f(0) - 1.7)^2 \times 0.2 + (f(1) - 1.7)^2 \times 0.5 + (f(2) - 1.7)^2 \times 0.3 \\
    &= (0^2 - 1.7)^2 \times 0.2 + (1^2 - 1.7)^2 \times 0.5 + (2^2 - 1.7)^2 \times 0.3 \\
    &= (-1.7)^2 \times 0.2 + (-0.7)^2 \times 0.5 + (2.3)^2 \times 0.3 \\
    &= 2.89 \times 0.2 + 0.49 \times 0.5 + 5.29 \times 0.3 \\
    &= 0.578 + 0.245 + 1.587 \\
    &= 2.41
    \end{align*}

    **方法2：公式 $\mathbb{V}[f(X)] = \mathbb{E}[(f(X))^2] - (\mathbb{E}[f(X)])^2$ を用いる方法**
    まず、$\mathbb{E}[(f(X))^2] = \mathbb{E}[X^4]$ を計算します。
    $$
    \mathbb{E}[X^4] = 0^4 \times 0.2 + 1^4 \times 0.5 + 2^4 \times 0.3 = 0 + 0.5 + 16 \times 0.3 = 5.3
    $$
    これと (2) の結果 $\mathbb{E}[f(X)] = 1.7$ を公式に代入します。
    $$
    \mathbb{V}[f(X)] = 5.3 - (1.7)^2 = 5.3 - 2.89 = 2.41
    $$

::: {.right}
[（問題へ戻る）](#q:1-discrete-expectation-variance)
:::

### 問1-indicator-function の解答・解説 {#a:1-indicator-function .answerbox ref="q:1-indicator-function"}

1. 指示関数の定義「条件が真なら $1$、偽なら $0$」に基づいて計算します。
   * (a) $X = 0$ のとき：条件 $X \ge 1$ は偽（不成立）となるため、$\ind\{0 \ge 1\} = 0$ です。
   * (b) $X = 2$ のとき：条件 $X \ge 1$ は真（成立）となるため、$\ind\{2 \ge 1\} = 1$ です。

2. $Y = \ind\{X \ge 1\}$ がとり得る値は、定義より $0$ または $1$ です。
   * $Y = 0$ となるのは、条件 $X \ge 1$ が偽のとき、すなわち $X = 0$ のときです。
     したがって、$\mathbb{P}(Y = 0) = \mathbb{P}(X = 0) = 0.2$ となります。
   * $Y = 1$ となるのは、条件 $X \ge 1$ が真のとき、すなわち $X = 1$ または $X = 2$ のときです。
     したがって、$\mathbb{P}(Y = 1) = \mathbb{P}(X = 1) + \mathbb{P}(X = 2) = 0.5 + 0.3 = 0.8$ となります。

   まとめると、確率分布の空欄に入る値は以下の通りです：
   * （ア） $0$
   * （イ） $1$
   * （ウ） $0.2$
   * （エ） $0.8$

::: {.right}
[（問題へ戻る）](#q:1-indicator-function)
:::

### 問1-continuous-expectation-variance の解答・解説 {#a:1-continuous-expectation-variance .answerbox ref="q:1-continuous-expectation-variance"}

1. 指示関数の定義より、$\ind\{0 \le x \le 1\}$ は $0 \le x \le 1$ のとき $1$、それ以外の範囲では $0$ となります。したがって、実数全体 $(-\infty, \infty)$ の積分を $[0, 1]$ の範囲に絞ることができます。
    $$
    \int_{-\infty}^\infty p(x) dx = \int_{-\infty}^\infty 2x \cdot \ind\{0 \le x \le 1\} dx = \int_0^1 2x dx = \left[ x^2 \right]_0^1 = 1^2 - 0^2 = 1 \quad \text{（証明終）}
    $$
2. 期待値 $\mathbb{E}[X]$ も同様に指示関数を用いて積分範囲を絞って計算します。
    $$
    \mathbb{E}[X] = \int_{-\infty}^\infty x \cdot p(x) dx = \int_{-\infty}^\infty x \cdot 2x \cdot \ind\{0 \le x \le 1\} dx = \int_0^1 2x^2 dx = \left[ \frac{2}{3}x^3 \right]_0^1 = \frac{2}{3}
    $$
3. $\mathbb{E}[X^2]$ の計算：
    $$
    \mathbb{E}[X^2] = \int_{-\infty}^\infty x^2 \cdot p(x) dx = \int_{-\infty}^\infty x^2 \cdot 2x \cdot \ind\{0 \le x \le 1\} dx = \int_0^1 2x^3 dx = \left[ \frac{1}{2}x^4 \right]_0^1 = \frac{1}{2}
    $$
    よって分散 $\mathbb{V}[X]$ は、
    $$
    \mathbb{V}[X] = \mathbb{E}[X^2] - (\mathbb{E}[X])^2 = \frac{1}{2} - \left(\frac{2}{3}\right)^2 = \frac{1}{2} - \frac{4}{9} = \frac{1}{18}
    $$

::: {.right}
[（問題へ戻る）](#q:1-continuous-expectation-variance)
:::

### 問1-variance-formula-proof の解答・解説 {#a:1-variance-formula-proof .answerbox ref="q:1-variance-formula-proof"}

1. $$Cov(X, X+Y) = Cov(X,X) + Cov(X,Y) = \mathbb{V}[X] + Cov(X,Y)$$
2. \begin{align*}
        \mathbb{V}[aX+bY] &= Cov(aX+bY, aX+bY) \\
        &= a^2 Cov(X,X) + ab Cov(X,Y) + ba Cov(Y,X) + b^2 Cov(Y,Y) \\
        &= a^2 \mathbb{V}[X] + 2ab Cov(X,Y) + b^2 \mathbb{V}[Y] \quad \text{（対称性より）}
        \end{align*}
        この展開の構造は、のちに行列やベクトルの内積（2次形式）を展開する際の論理構造と全く同じである。

::: {.right}
[（問題へ戻る）](#q:1-variance-formula-proof)
:::


## 最適化と最小二乗法・偏微分

### 経験リスクの数式化（シグマを用いた書き下し）

**【該当内容】** 第2回スライド27〜37「予測系タスクの具体例＞線型単回帰、最小二乗法」
**【ねらい】** $n$ 個の一般的なデータ表記に対して、二乗損失を用いた経験リスクの正確な数式をシグマ $\sum$ を用いて構築できるようにする。

### 問2-empirical-risk-formulation の解答・解説 {#a:2-empirical-risk-formulation .answerbox ref="q:2-empirical-risk-formulation"}

モデルの出力 $\hat{y}_i = wx_i + b$ を損失関数に代入し、その標本平均をとる。
$$
L(w,b) = \frac{1}{n} \sum_{i=1}^n (y_i - (wx_i + b))^2
$$

::: {.right}
[（問題へ戻る）](#q:2-empirical-risk-formulation)
:::

### 問2-erm-parameter-function の解答・解説 {#a:2-erm-parameter-function .answerbox ref="q:2-erm-parameter-function"}

与えられた数値を代入して整理する。
\begin{align*}
\hat{R}(\theta) &= \frac{1}{2} \left[ (2 - \theta \cdot 1)^2 + (4 - \theta \cdot 3)^2 \right] \\
&= \frac{1}{2} \left[ (4 - 4\theta + \theta^2) + (16 - 24\theta + 9\theta^2) \right] \\
&= \frac{1}{2} (10\theta^2 - 28\theta + 20) \\
&= 5\theta^2 - 14\theta + 10
\end{align*}
これによって、最適化（微分して最小値を求める）対象がパラメータ $\theta$ だけの関数になったことが示される。

::: {.right}
[（問題へ戻る）](#q:2-erm-parameter-function)
:::

### 問2-optimization-formulation-blank の解答・解説 {#a:2-optimization-formulation-blank .answerbox ref="q:2-optimization-formulation-blank"}

* **(ア)** $\boldsymbol{\theta} \in \mathbb{R}^d$
* **(イ)** $L(\boldsymbol{\theta})$
        よって全体の式は $\mathop{\mathrm{Min}}_{\boldsymbol{\theta} \in \mathbb{R}^d} L(\boldsymbol{\theta})$ となる。最適化を行う範囲（定義域）を $\mathrm{Min}$ の下に記述する。
* **(ウ)** $\boldsymbol{\theta} \in \{\boldsymbol{\theta} \in \mathbb{R}^d : \|\boldsymbol{\theta}\| \le C\}$ （または $\boldsymbol{\theta} \in \mathbb{R}^d \text{ s.t. } \|\boldsymbol{\theta}\| \le C$）
* **(エ)** $L(\boldsymbol{\theta})$
        よって全体の式は $\mathop{\mathrm{Min}}_{\boldsymbol{\theta} \in \{\boldsymbol{\theta} \in \mathbb{R}^d : \|\boldsymbol{\theta}\| \le C\}} L(\boldsymbol{\theta})$ となる。制約条件は変数が属する集合（定義域）として $\mathrm{Min}$ の下に記述することができる。

::: {.right}
[（問題へ戻る）](#q:2-optimization-formulation-blank)
:::


### 最小二乗法の真髄：偏微分から一階の条件へ

**【該当内容】** 第2回スライド38〜45「一階の条件、偏微分・勾配」
**【ねらい】** スライドで省略されている目的関数 $L(w,b)$ の偏微分から勾配の構築、一階の条件による正規方程式のスカラ版の導出を完全に追体験する。

### 問3-multivariate-gradient の解答・解説 {#a:3-multivariate-gradient .answerbox ref="q:3-multivariate-gradient"}

各変数 $\mathit{w}_1, \mathit{w}_2, \mathit{w}_3$ について偏微分を行います。

* $w_1$ についての偏微分：
  $$
  \frac{\partial g}{\partial w_1} = 2w_1 - 4w_2
  $$
* $w_2$ についての偏微分：
  $$
  \frac{\partial g}{\partial w_2} = 4w_2 - 4w_1 - 6w_3
  $$
* $w_3$ についての偏微分：
  $$
  \frac{\partial g}{\partial w_3} = 6w_3 - 6w_2
  $$

これらをベクトルとしてまとめると、求める勾配は以下のようになります：
$$
\nabla g(\mathbf{w}) = \begin{pmatrix} 2w_1 - 4w_2 \\ -4w_1 + 4w_2 - 6w_3 \\ -6w_2 + 6w_3 \end{pmatrix}
$$
（証明終）

::: {.right}
[（問題へ戻る）](#q:3-multivariate-gradient)
:::

### 問2-partial-derivative-gradient の解答・解説 {#a:2-partial-derivative-gradient .answerbox ref="q:2-partial-derivative-gradient"}

1. **偏微分と勾配の計算：**
   合成関数の微分（チェインルール）を用いて、それぞれ $w$ と $b$ について偏微分を行う。
        $$
        \frac{\partial L}{\partial w} = \frac{1}{n} \sum_{i=1}^n 2(y_i - wx_i - b) \cdot (-x_i) = -\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b)x_i
        $$
        $$
        \frac{\partial L}{\partial b} = \frac{1}{n} \sum_{i=1}^n 2(y_i - wx_i - b) \cdot (-1) = -\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b)
        $$
   これらを縦に並べたものが勾配である。
        $$
        \nabla L(w,b) = \begin{pmatrix} -\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b)x_i \\ -\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b) \end{pmatrix}
        $$

2. **一階の条件からの連立方程式の導出：**
   一階の条件 $\nabla L(w,b) = \mathbf{0}$ より、各成分が $0$ となる。
        $$
        \begin{cases}
        -\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b)x_i = 0 \\
        -\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b) = 0
        \end{cases}
        $$
   両辺に $-\frac{n}{2}$ を掛けて整理し、$w, b$ を含む項を左辺に、含まない項を右辺にまとめる。
        $$
        \begin{cases}
        w \sum_{i=1}^n x_i^2 + b \sum_{i=1}^n x_i = \sum_{i=1}^n x_i y_i \\
        w \sum_{i=1}^n x_i + b \sum_{i=1}^n 1 = \sum_{i=1}^n y_i
        \end{cases}
        $$
   ここで $\sum_{i=1}^n 1 = n$ であることに注意し、これを行列とベクトルを用いた形に書き直すと以下のようになる。
        $$
        \begin{pmatrix} \sum_{i=1}^n x_i^2 & \sum_{i=1}^n x_i \\ \sum_{i=1}^n x_i & n \end{pmatrix} \begin{pmatrix} w \\ b \end{pmatrix} = \begin{pmatrix} \sum_{i=1}^n x_i y_i \\ \sum_{i=1}^n y_i \end{pmatrix}
        $$

3. **最適なパラメータの導出：**
   求めた行列方程式の両辺の左から、係数行列の逆行列を掛けることで、目的の式が導かれる。
        $$
        \begin{pmatrix} \hat{w} \\ \hat{b} \end{pmatrix} = \begin{pmatrix} \sum_{i=1}^n x_i^2 & \sum_{i=1}^n x_i \\ \sum_{i=1}^n x_i & n \end{pmatrix}^{-1} \begin{pmatrix} \sum_{i=1}^n x_i y_i \\ \sum_{i=1}^n y_i \end{pmatrix}
        $$
   （証明終）

::: {.right}
[（問題へ戻る）](#q:2-partial-derivative-gradient)
:::


## 線型モデルの行列表現と正則化・モデル選択

### ベクトルの内積と性質

**【該当内容】** 第3回スライド22〜26「線型モデルの幾何学的解釈、内積の性質」
**【ねらい】** 機械学習における予測の基本演算である「内積」について、重み付き和、幾何的な向きの検出、射影という3つの側面を手計算を通じて習得する。

### 問3-matrix-vector-multiplication-practice の解答・解説 {#a:3-matrix-vector-multiplication-practice .answerbox ref="q:3-matrix-vector-multiplication-practice"}

1. **【行列 $\times$ 行列】**
   $$
   \begin{pmatrix} 1 \cdot 2 + 2 \cdot 1 & 1 \cdot 0 + 2 \cdot 3 & 1 \cdot 1 + 2 \cdot (-1) \\ 3 \cdot 2 + 4 \cdot 1 & 3 \cdot 0 + 4 \cdot 3 & 3 \cdot 1 + 4 \cdot (-1) \end{pmatrix} = \begin{pmatrix} 4 & 6 & -1 \\ 10 & 12 & -1 \end{pmatrix}
   $$
2. **【行列 $\times$ 縦ベクトル】**
   $$
   \begin{pmatrix} 1 \cdot 2 + (-1) \cdot 1 + 2 \cdot (-1) \\ 0 \cdot 2 + 3 \cdot 1 + 1 \cdot (-1) \end{pmatrix} = \begin{pmatrix} -1 \\ 2 \end{pmatrix}
   $$
3. **【横ベクトル $\times$ 行列 $\times$ 縦ベクトル（二次形式）】**
   先に後ろの「行列 $\times$ 縦ベクトル」を計算すると、
   $$
   \begin{pmatrix} 2 & 0 \\ 0 & 3 \end{pmatrix} \begin{pmatrix} 1 \\ 2 \end{pmatrix} = \begin{pmatrix} 2 \\ 6 \end{pmatrix}
   $$
   これに横ベクトルを掛けるとスカラーになる。
   $$
   \begin{pmatrix} 1 & 2 \end{pmatrix} \begin{pmatrix} 2 \\ 6 \end{pmatrix} = 1 \cdot 2 + 2 \cdot 6 = 14
   $$
4. **【横ベクトル $\times$ 縦ベクトル（内積）】**
   $$
   1 \cdot 4 + 3 \cdot (-1) + (-2) \cdot 2 = 4 - 3 - 4 = -3
   $$
5. **【縦ベクトル $\times$ 横ベクトル】**
   $3 \times 1$ 行列と $1 \times 2$ 行列の積となり、$3 \times 2$ の行列が生成される。
   $$
   \begin{pmatrix} 2 \cdot 1 & 2 \cdot 4 \\ -1 \cdot 1 & -1 \cdot 4 \\ 3 \cdot 1 & 3 \cdot 4 \end{pmatrix} = \begin{pmatrix} 2 & 8 \\ -1 & -4 \\ 3 & 12 \end{pmatrix}
   $$

::: {.right}
[（問題へ戻る）](#q:3-matrix-vector-multiplication-practice)
:::

### 問3-matrix-vector-patterns の解答・解説 {#a:3-matrix-vector-patterns .answerbox ref="q:3-matrix-vector-patterns"}

1. $\mathbf{a}^\top = \begin{pmatrix} a_1 & \dots & a_d \end{pmatrix}$ は $1 \times d$ 行列、$\mathbf{b}$ は $d \times 1$ 行列である。行列の積の定義より、これらを掛けるとスカラー（$1 \times 1$ 行列）となる。
   $$
   \mathbf{a}^\top \mathbf{b} = a_1 b_1 + a_2 b_2 + \dots + a_d b_d = \sum_{i=1}^d a_i b_i
   $$
   これは内積 $\langle \mathbf{a}, \mathbf{b} \rangle$ の定義そのものである。また、同様に計算すると $\mathbf{b}^\top \mathbf{a} = \sum_{i=1}^d b_i a_i$ であり、実数の積は順序を入れ替えても値が変わらない（$a_i b_i = b_i a_i$）ため、$\mathbf{a}^\top \mathbf{b} = \mathbf{b}^\top \mathbf{a}$ となる。
2.
   - **横ベクトルが縦に並んでいるとみなす場合：**
     行列の積の定義より、各行 $\mathbf{b}_i^\top$ と列ベクトル $\mathbf{v}$ を掛けたものが結果のベクトルの各成分になるため、
     $$
     B\mathbf{v} = \begin{pmatrix} \mathbf{b}_1^\top \mathbf{v} \\ \vdots \\ \mathbf{b}_m^\top \mathbf{v} \end{pmatrix}
     $$
     となり、各成分が内積 $\mathbf{b}_i^\top \mathbf{v}$ として計算されることがわかる。
   - **縦ベクトルが横に並んでいるとみなす場合：**
     列ベクトル $\boldsymbol{\beta}_j$ の成分ごとの和として展開される。
     $$
     B\mathbf{v} = \begin{pmatrix} \boldsymbol{\beta}_1 & \dots & \boldsymbol{\beta}_d \end{pmatrix} \begin{pmatrix} v_1 \\ \vdots \\ v_d \end{pmatrix} = v_1 \boldsymbol{\beta}_1 + \dots + v_d \boldsymbol{\beta}_d = \sum_{j=1}^d v_j \boldsymbol{\beta}_j
     $$


::: {.right}
[（問題へ戻る）](#q:3-matrix-vector-patterns)
:::

### 問3-inner-product-roles の解答・解説 {#a:3-inner-product-roles .answerbox ref="q:3-inner-product-roles"}

1. **【重み付き和の計算】**
   $\mathbf{w}^\top \mathbf{x} = 3 \times 2 + 2 \times (-1) + 1 \times 4 = 6 - 2 + 4 = 8$
2. **【ベクトルの揃い具合と直交性 (1)】**
   $\mathbf{a}^\top \mathbf{b} = \frac{2}{3} \times \frac{2}{3} + \frac{2}{3} \times \left(-\frac{1}{3}\right) + \frac{1}{3} \times \left(-\frac{2}{3}\right) = \frac{4}{9} - \frac{2}{9} - \frac{2}{9} = 0$
   内積が $0$ であるため、2つのベクトルは\textbf{直交}している。
3. **【ベクトルの揃い具合と直交性 (2)】**
   $\mathbf{a}^\top \mathbf{c} = \frac{2}{3} \times \frac{1}{3} + \frac{2}{3} \times \frac{2}{3} + \frac{1}{3} \times \frac{2}{3} = \frac{2}{9} + \frac{4}{9} + \frac{2}{9} = \frac{8}{9}$
   内積が $1, -1, 0$ のいずれでもないため、位置関係は\textbf{それらのどれでもない}。
4. **【直交分解の係数】**
   $\mathbf{x} = \beta \mathbf{u} + \mathbf{v}$ の両辺について、右から $\mathbf{u}$ との内積をとる（$\mathbf{u}$ を掛ける）と、
   $$ \mathbf{x}^\top \mathbf{u} = (\beta \mathbf{u} + \mathbf{v})^\top \mathbf{u} = \beta \mathbf{u}^\top \mathbf{u} + \mathbf{v}^\top \mathbf{u} $$
   $\mathbf{v}$ は $\mathbf{u}$ と直交するため、$\mathbf{v}^\top \mathbf{u} = 0$ となる。
   したがって、$\mathbf{x}^\top \mathbf{u} = \beta \|\mathbf{u}\|^2$ となり、$\beta = \frac{\mathbf{x}^\top \mathbf{u}}{\|\mathbf{u}\|^2}$ となる。
   各内積を計算すると、
   $\mathbf{x}^\top \mathbf{u} = 5 \times 1 + 2 \times (-1) + (-1) \times 2 = 5 - 2 - 2 = 1$
   $\|\mathbf{u}\|^2 = \mathbf{u}^\top \mathbf{u} = 1^2 + (-1)^2 + 2^2 = 1 + 1 + 4 = 6$
   よって、$\beta = \frac{1}{6}$ である。

::: {.right}
[（問題へ戻る）](#q:3-inner-product-roles)
:::



### パラメータ線型モデルの表現（特徴写像）

**【該当内容】** 第3回スライド27〜37「一般の線型モデル、特徴写像」
**【ねらい】** 「パラメータには線型（1次式）だが、入力データに対しては非線型」という機械学習モデルの柔軟性を、多項式写像やBag-of-Wordsなどの具体例を通じて体感する。

### 問3-polynomial-feature-mapping の解答・解説 {#a:3-polynomial-feature-mapping .answerbox ref="q:3-polynomial-feature-mapping"}

1. $$f(x) = \theta_0 \cdot 1 + \theta_1 \cdot x + \theta_2 \cdot x^2 = \theta_0 + \theta_1 x + \theta_2 x^2$$
2. パラメータ $\boldsymbol{\theta}$ に対しては\textbf{1次式（線型）}、入力 $x$ に対しては\textbf{2次式（非線型）}である。

   **【補足：多変数多項式の次数】** 一般に，複数の変数を含む多項式の次数は，各単項式の次数の最大値で定義される．単項式の次数は各変数の指数の和である（例：$x_1^2 x_2$ は $2+1=3$ 次の単項式）．
   本問の $f(x) = \theta_0 + \theta_1 x + \theta_2 x^2$ において，
   * $\boldsymbol{\theta}$ に着目すると：各項は $\theta_0$（1次），$\theta_1 x$（$\theta_1$ について1次），$\theta_2 x^2$（$\theta_2$ について1次）であり，最大次数は**1次**（線型）。
   * $x$ に着目すると：各項は定数項（0次），$x$（1次），$x^2$（2次）であり，最大次数は**2次**（非線型）。

::: {.right}
[（問題へ戻る）](#q:3-polynomial-feature-mapping)
:::

### 問3-bag-of-words-representation の解答・解説 {#a:3-bag-of-words-representation .answerbox ref="q:3-bag-of-words-representation"}

1. 各文書に含まれる名詞 $V = \{\text{「AI」}, \text{「ビジネス」}, \text{「犬」}\}$ の出現回数をカウントします。
   * $x_1$ (AIの技術ニュース) $\rightarrow$ 「AI」が2回出現します。
     $$\boldsymbol{\phi}(x_1) = \begin{pmatrix} 2 \\ 0 \\ 0 \end{pmatrix}$$
   * $x_2$ (芸能ニュース) $\rightarrow$ 指定された名詞 $V$ はいずれも出現しません。
     $$\boldsymbol{\phi}(x_2) = \begin{pmatrix} 0 \\ 0 \\ 0 \end{pmatrix}$$
   * $x_3$ (AIとビジネスのニュース) $\rightarrow$ 「AI」が2回、「ビジネス」が2回出現します。
     $$\boldsymbol{\phi}(x_3) = \begin{pmatrix} 2 \\ 2 \\ 0 \end{pmatrix}$$
   * $x_4$ (犬のビジネスニュース) $\rightarrow$ 「ビジネス」が1回、「犬」が2回出現します。
     $$\boldsymbol{\phi}(x_4) = \begin{pmatrix} 0 \\ 1 \\ 2 \end{pmatrix}$$

2. デザイン行列 $\Phi$ は各データの特徴ベクトルを転置して行として並べた行列、ラベルベクトル $\mathbf{y}$ は正解ラベルを縦に並べたベクトルです。
   $$\Phi = \begin{pmatrix} \boldsymbol{\phi}(x_1)^\top \\ \boldsymbol{\phi}(x_2)^\top \\ \boldsymbol{\phi}(x_3)^\top \\ \boldsymbol{\phi}(x_4)^\top \end{pmatrix} = \begin{pmatrix} 2 & 0 & 0 \\ 0 & 0 & 0 \\ 2 & 2 & 0 \\ 0 & 1 & 2 \end{pmatrix}, \quad \mathbf{y} = \begin{pmatrix} 5 \\ 0 \\ 10 \\ 15 \end{pmatrix}$$

3. **【最適なパラメータの一般式】**
   最小二乗回帰における正規方程式 $\Phi^\top \Phi \boldsymbol{\theta} = \Phi^\top \mathbf{y}$ より、（$\Phi^\top \Phi$ の逆行列が存在すれば）最適なパラメータ $\hat{\boldsymbol{\theta}}$ は以下のように表されます。
   $$\hat{\boldsymbol{\theta}} = (\Phi^\top \Phi)^{-1} \Phi^\top \mathbf{y}$$

   この設定において $\Phi^\top \Phi$ の逆行列が存在すること（正則であること）は、例えば行列式の計算や列ベクトルの独立性などを用いて確かめられる．

   * **アプローチ1：列ベクトルの線形独立性による説明**
     デザイン行列 $\Phi$ の3つの列ベクトルを $\mathbf{a}_1 = (2, 0, 2, 0)^\top$, $\mathbf{a}_2 = (0, 0, 2, 1)^\top$, $\mathbf{a}_3 = (0, 0, 0, 2)^\top$ とします。
     線形結合 $c_1 \mathbf{a}_1 + c_2 \mathbf{a}_2 + c_3 \mathbf{a}_3 = \mathbf{0}$ とおくと、
     * 第1成分（行1）より $2 c_1 = 0 \Rightarrow c_1 = 0$
     * 第3成分（行3）より $2 c_1 + 2 c_2 = 0$。$c_1=0$ なので $2 c_2 = 0 \Rightarrow c_2 = 0$
     * 第4成分（行4）より $c_2 + 2 c_3 = 0$。$c_2=0$ なので $2 c_3 = 0 \Rightarrow c_3 = 0$
     したがって $c_1 = c_2 = c_3 = 0$ のみが成り立ち、3つの列ベクトルは互いに線形独立（一次独立）です。
     $\Phi$ （$4 \times 3$ 行列）の列ベクトルが線形独立である（列フルランクである）とき、正方行列 $\Phi^\top \Phi$ （$3 \times 3$ 行列）は正則行列となり、**逆行列が必ず存在します**。

   * **アプローチ2：行列式の直接計算による説明**
     $\Phi^\top \Phi$ を計算すると以下のようになります。
     $$\Phi^\top \Phi = \begin{pmatrix} 2 & 0 & 2 & 0 \\ 0 & 0 & 2 & 1 \\ 0 & 0 & 0 & 2 \end{pmatrix} \begin{pmatrix} 2 & 0 & 0 \\ 0 & 0 & 0 \\ 2 & 2 & 0 \\ 0 & 1 & 2 \end{pmatrix} = \begin{pmatrix} 8 & 4 & 0 \\ 4 & 5 & 2 \\ 0 & 2 & 4 \end{pmatrix}$$
     この $3 \times 3$ 行列の行列式 $\det(\Phi^\top \Phi)$ をサラスの公式等を用いて計算します。
     $$\det(\Phi^\top \Phi) = 8 \times (5 \times 4 - 2 \times 2) - 4 \times (4 \times 4 - 2 \times 0) + 0 = 8 \times 16 - 4 \times 16 = 64 \neq 0$$
     行列式が 0 でないため、$\Phi^\top \Phi$ は正則であり、**逆行列が存在します**。

::: {.right}
[（問題へ戻る）](#q:3-bag-of-words-representation)
:::


### 最小二乗法の行列表記と一階の条件（最重要）

**【該当内容】** 第3回スライド38〜44「線型モデルの最小二乗法、行列による表記」
**【ねらい】** データの羅列をデザイン行列 $\Phi$ とラベルベクトル $\mathbf{y}$ にまとめ、目的関数をベクトルのノルムとしてスッキリ表現するテクニックと、その微分プロセスを完全にマスターする。

### 問3-bivariate-gradient の解答・解説 {#a:3-bivariate-gradient .answerbox ref="q:3-bivariate-gradient"}

1. $y$ を定数とみなして $x$ で微分する。
   $$
   \frac{\partial f}{\partial x} = 2x + 3y
   $$
2. $x$ を定数とみなして $y$ で微分する。
   $$
   \frac{\partial f}{\partial y} = 3x + 4y
   $$
3. 求めた偏微分を縦ベクトルに並べる。
   $$
   \nabla f(x, y) = \begin{pmatrix} 2x + 3y \\ 3x + 4y \end{pmatrix}
   $$
4. $x=1, y=2$ を代入する。
   $$
   \nabla f(1, 2) = \begin{pmatrix} 2(1) + 3(2) \\ 3(1) + 4(2) \end{pmatrix} = \begin{pmatrix} 8 \\ 11 \end{pmatrix}
   $$

::: {.right}
[（問題へ戻る）](#q:3-bivariate-gradient)
:::


### 問3-matrix-empirical-risk の解答・解説 {#a:3-matrix-empirical-risk .answerbox ref="q:3-matrix-empirical-risk"}

1. 各データに対する予測値 $f_{\boldsymbol{\theta}}(x_i) = \boldsymbol{\theta}^\top \boldsymbol{\phi}(x_i) = \boldsymbol{\phi}(x_i)^\top \boldsymbol{\theta}$ を縦に並べたベクトルは、計画行列の定義とブロック行列の積の性質（横ベクトルが縦に並んでいるブロック行列と縦ベクトルの積）から次のように書ける。
   $$
   \begin{pmatrix} f_{\boldsymbol{\theta}}(x_1) \\ \vdots \\ f_{\boldsymbol{\theta}}(x_n) \end{pmatrix}
   = \begin{pmatrix} \boldsymbol{\phi}(x_1)^\top \boldsymbol{\theta} \\ \vdots \\ \boldsymbol{\phi}(x_n)^\top \boldsymbol{\theta} \end{pmatrix}
   = \begin{pmatrix} \quad \boldsymbol{\phi}(x_1)^\top \quad \\ \vdots \\ \quad \boldsymbol{\phi}(x_n)^\top \quad \end{pmatrix} \boldsymbol{\theta}
   = \Phi \boldsymbol{\theta}
   $$
   したがって出力値のベクトルが $\Phi \boldsymbol{\theta}$ と表せることが確認された。

2. 上記1の結果より、予測値と正解ラベルの差を並べたベクトルは
   $$
   \Phi \boldsymbol{\theta} - \mathbf{y} = \begin{pmatrix} f_{\boldsymbol{\theta}}(x_1) - y_1 \\ \vdots \\ f_{\boldsymbol{\theta}}(x_n) - y_n \end{pmatrix}
   $$
   となる。ベクトルのL2ノルムの2乗は各成分の2乗和なので、このベクトルのノルムの2乗を計算すると
   $$
   \|\Phi\boldsymbol{\theta} - \mathbf{y}\|^2 = \sum_{i=1}^n (f_{\boldsymbol{\theta}}(x_i) - y_i)^2
   $$
   となる。両辺を $n$ で割ることで、
   $$
   \frac{1}{n}\|\Phi\boldsymbol{\theta} - \mathbf{y}\|^2 = \frac{1}{n} \sum_{i=1}^n (f_{\boldsymbol{\theta}}(x_i) - y_i)^2 = \hat{R}(f_{\boldsymbol{\theta}})
   $$
   が導かれ、式が一致することが確認された。

::: {.right}
[（問題へ戻る）](#q:3-matrix-empirical-risk)
:::

### 問3-quadratic-form-completing-square の解答・解説 {#a:3-quadratic-form-completing-square .answerbox ref="q:3-quadratic-form-completing-square"}

1. 前から順に展開する。
   \begin{align*}
   (\mathbf{x} - \mathbf{b})^\top \mathbf{A} (\mathbf{x} - \mathbf{b})
   &= (\mathbf{x} - \mathbf{b})^\top (\mathbf{A}\mathbf{x} - \mathbf{A}\mathbf{b}) \\
   &= \mathbf{x}^\top \mathbf{A}\mathbf{x} - \mathbf{x}^\top \mathbf{A}\mathbf{b} - \mathbf{b}^\top \mathbf{A}\mathbf{x} + \mathbf{b}^\top \mathbf{A}\mathbf{b}
   \end{align*}
   ここで $\mathbf{x}^\top \mathbf{A}\mathbf{b}$ はスカラーであるため、転置しても値が変わらない。$\mathbf{A}$ が対称行列（$\mathbf{A}^\top = \mathbf{A}$）であることを用いると、
   $$
   (\mathbf{x}^\top \mathbf{A}\mathbf{b})^\top = \mathbf{b}^\top \mathbf{A}^\top \mathbf{x} = \mathbf{b}^\top \mathbf{A}\mathbf{x}
   $$
   となる。したがって、第2項と第3項が等しくなり、
   $$
   \mathbf{x}^\top \mathbf{A} \mathbf{x} - 2\mathbf{b}^\top \mathbf{A} \mathbf{x} + \mathbf{b}^\top \mathbf{A} \mathbf{b}
   $$
   となることが示された。（証明終）
2. $(\mathbf{x} - \boldsymbol{\mu})^\top \mathbf{A} (\mathbf{x} - \boldsymbol{\mu})$ を(1)と同様に展開すると、
   $$
   \mathbf{x}^\top \mathbf{A} \mathbf{x} - 2\boldsymbol{\mu}^\top \mathbf{A} \mathbf{x} + \boldsymbol{\mu}^\top \mathbf{A} \boldsymbol{\mu}
   $$
   となる。これと元の式 $\mathbf{x}^\top \mathbf{A} \mathbf{x} - 2\mathbf{c}^\top \mathbf{x}$ の $\mathbf{x}$ の1次の項を比較すると、
   $$
   \boldsymbol{\mu}^\top \mathbf{A} = \mathbf{c}^\top \iff \mathbf{A}\boldsymbol{\mu} = \mathbf{c} \quad \text{（両辺の転置をとり、$\mathbf{A}^\top=\mathbf{A}$を用いた）}
   $$
   となればよい。$\mathbf{A}$ が正則であるから、$\boldsymbol{\mu} = \mathbf{A}^{-1}\mathbf{c}$ とおく。
   このとき、元の式は以下のように平方完成される。
   $$
   \mathbf{x}^\top \mathbf{A} \mathbf{x} - 2\mathbf{c}^\top \mathbf{x} = (\mathbf{x} - \mathbf{A}^{-1}\mathbf{c})^\top \mathbf{A} (\mathbf{x} - \mathbf{A}^{-1}\mathbf{c}) - \mathbf{c}^\top \mathbf{A}^{-1} \mathbf{c}
   $$

::: {.right}
[（問題へ戻る）](#q:3-quadratic-form-completing-square)
:::

### 問3-matrix-derivative-first-order の解答・解説 {#a:3-matrix-derivative-first-order .answerbox ref="q:3-matrix-derivative-first-order"}

1. 展開の各ステップは以下の通りである。
   \begin{align*}
   (\Phi\boldsymbol{\theta} - \mathbf{y})^\top (\Phi\boldsymbol{\theta} - \mathbf{y})
   &= (\Phi\boldsymbol{\theta} - \mathbf{y})^\top (\Phi\boldsymbol{\theta}) - (\Phi\boldsymbol{\theta} - \mathbf{y})^\top \mathbf{y} \\
   &= (\Phi\boldsymbol{\theta})^\top (\Phi\boldsymbol{\theta}) - \mathbf{y}^\top (\Phi\boldsymbol{\theta}) - (\Phi\boldsymbol{\theta})^\top \mathbf{y} + \mathbf{y}^\top \mathbf{y}
   \end{align*}
   ここで、第1項は $(\Phi\boldsymbol{\theta})^\top (\Phi\boldsymbol{\theta}) = \boldsymbol{\theta}^\top \Phi^\top \Phi \boldsymbol{\theta}$ となる。
   また、第3項 $(\Phi\boldsymbol{\theta})^\top \mathbf{y}$ はスカラー（内積）であるため、転置しても値が変わらない。よって $\mathbf{y}^\top (\Phi\boldsymbol{\theta})$ と等しくなる。
   したがって、第2項と第3項がまとまり $-2\mathbf{y}^\top \Phi \boldsymbol{\theta}$ となる。これらを全体に $1/2$ 掛けたものが目的関数 $L(\boldsymbol{\theta})$ となるため、与えられた式が得られる。

2. $L(\boldsymbol{\theta}) = \frac{1}{2}\boldsymbol{\theta}^\top \Phi^\top \Phi \boldsymbol{\theta} - \mathbf{y}^\top \Phi \boldsymbol{\theta} + \frac{1}{2}\mathbf{y}^\top \mathbf{y}$ において、$\mathbf{A} = \Phi^\top \Phi$ とおくと、これは対称行列である。行列微分の公式を適用して $\boldsymbol{\theta}$ で勾配を計算する。
   $$
   \nabla_{\boldsymbol{\theta}} L(\boldsymbol{\theta}) = \frac{1}{2} \left[ 2 \Phi^\top \Phi \boldsymbol{\theta} \right] - \Phi^\top \mathbf{y} = \Phi^\top \Phi \boldsymbol{\theta} - \Phi^\top \mathbf{y}
   $$
   以上より、目的関数の勾配が導出された。

::: {.right}
[（問題へ戻る）](#q:3-matrix-derivative-first-order)
:::


### 正則化（Regularization）

**【該当内容】** 第3回スライド45〜50「過適合の対策＞正則化、L2正則化」
**【ねらい】** 過学習を防ぐL2正則化（Ridge）の目的関数について、代数表現と行列表現の一致を確かめ、単位行列 $I$ が出現する理由を数式変形で完全に理解する。


### 問3-l2-regularization-objective の解答・解説 {#a:3-l2-regularization-objective .answerbox ref="q:3-l2-regularization-objective"}

経験誤差の平均と、パラメータのL2ノルム平方に正則化係数を掛けたものを合算する。
$$
L_{\text{reg}}(\boldsymbol{\theta}) = \frac{1}{n} \sum_{i=1}^n (y_i - \boldsymbol{\theta}^\top \boldsymbol{\phi}(x_i))^2 + 0.01 \|\boldsymbol{\theta}\|^2
$$

::: {.right}
[（問題へ戻る）](#q:3-l2-regularization-objective)
:::

### 問3-l2-regularization-gradient の解答・解説 {#a:3-l2-regularization-gradient .answerbox ref="q:3-l2-regularization-gradient"}

$\|\boldsymbol{\theta}\|^2 = \boldsymbol{\theta}^\top \boldsymbol{\theta}$ より、第2項の勾配は $\nabla_{\boldsymbol{\theta}} \left( \frac{\lambda}{2} \boldsymbol{\theta}^\top \boldsymbol{\theta} \right) = \lambda \boldsymbol{\theta}$ である。
これと二乗誤差項の勾配を合わせ、全体の勾配を一階の条件に従って $\mathbf{0}$ と置く。
$$
\nabla_{\boldsymbol{\theta}} L(\boldsymbol{\theta}) = \Phi^\top \Phi \boldsymbol{\theta} - \Phi^\top \mathbf{y} + \lambda \boldsymbol{\theta} = \mathbf{0}
$$
ここで $\boldsymbol{\theta}$ でまとめる際、行列 $\Phi^\top \Phi$ とスカラー $\lambda$ は直接足し算できない。そのため、$\lambda \boldsymbol{\theta} = \lambda \mathbf{I} \boldsymbol{\theta}$（$\mathbf{I}$は単位行列）と変形する。
$$
(\Phi^\top \Phi + \lambda \mathbf{I})\boldsymbol{\theta} = \Phi^\top \mathbf{y}
$$
両辺に左から逆行列を掛けることで、最適解が得られる。
$$
\hat{\boldsymbol{\theta}} = (\Phi^\top \Phi + \lambda \mathbf{I})^{-1}\Phi^\top \mathbf{y}
$$
\textbf{【単位行列 $\mathbf{I}$ の必要性】}
行列（サイズ $d \times d$）とスカラー（単なる数値）は代数的に直接加算できないため、同じサイズで対角線上にスカラーを配置する単位行列 $\mathbf{I}$ を仲介させることで、正則化項を行列演算に統合している。

::: {.right}
[（問題へ戻る）](#q:3-l2-regularization-gradient)
:::


### モデル選択（交差検証）

**【該当内容】** 第3回スライド51〜70「モデル選択、交差検証」
**【ねらい】** ハイパーパラメータ選択の手続きを、インデックス操作を通じて厳密に理解する。

### 問3-cross-validation-indices の解答・解説 {#a:3-cross-validation-indices .answerbox ref="q:3-cross-validation-indices"}

1. 全体のデータ $\{1,2,3,4,5,6\}$ から検証用の $D_2 = \{3,4\}$ を除外した、\textbf{$\{1, 2, 5, 6\}$} が訓練用データとなる。
2. LOOCVはデータから1点だけを検証用として抜き出し、残りの $n-1$ 点で訓練する作業をデータの個数分だけ繰り返す。したがって、実行回数は合計で\textbf{100回}である。

::: {.right}
[（問題へ戻る）](#q:3-cross-validation-indices)
:::


## 確率モデルと分位点回帰

### 同時分布・条件付き分布・条件付き期待値

**【該当内容】** 第4回スライド5〜18「基本知識＞同時確率分布、条件付き確率」
**【ねらい】** 条件付き確率・条件付き期待値を、クロス集計表の計算から完全に理解する。

### 問4-conditional-probability-table の解答・解説 {#a:4-conditional-probability-table .answerbox ref="q:4-conditional-probability-table"}

1. 周辺確率は、与えられた $X=0$ における $Y$ のすべての確率の和である。
        $$
        P(X=0) = P(X=0, Y=1) + P(X=0, Y=2) + P(X=0, Y=3) = 0.1 + 0.2 + 0.1 = 0.4
        $$
2. 条件付き確率の定義 $P(Y=y \mid X=0) = \frac{P(X=0, Y=y)}{P(X=0)}$ より、
        \begin{align*}
        P(Y=1 \mid X=0) &= \frac{0.1}{0.4} = 0.25 \\
        P(Y=2 \mid X=0) &= \frac{0.2}{0.4} = 0.50 \\
        P(Y=3 \mid X=0) &= \frac{0.1}{0.4} = 0.25
        \end{align*}
3. 条件付き期待値は、求めた条件付き確率を用いた期待値計算である。
        \begin{align*}
        \mathbb{E}[Y \mid X=0] &= 1 \times P(Y=1 \mid X=0) + 2 \times P(Y=2 \mid X=0) + 3 \times P(Y=3 \mid X=0) \\
        &= 1 \times 0.25 + 2 \times 0.50 + 3 \times 0.25 \\
        &= 0.25 + 1.0 + 0.75 = 2.0
        \end{align*}

::: {.right}
[（問題へ戻る）](#q:4-conditional-probability-table)
:::


### 分位点（Quantile）と外れ値の影響

**【該当内容】** 第4回スライド19〜35「分位点回帰、ピンボール損失」
**【ねらい】** 平均値が外れ値に引っ張られやすいのに対し、分位点（中央値など）が頑健（ロバスト）である理由を、実際のデータ操作を通じて数式ベースで理解する。

### 問4-pinball-loss-calculation の解答・解説 {#a:4-pinball-loss-calculation .answerbox ref="q:4-pinball-loss-calculation"}

誤差 $e = y - y'$ を用いてそれぞれの場合を計算する。

1. $e = -2 < 0$ のとき：
        $$
        l_{0.3} = (0.3 - 1) \times (-2) = (-0.7) \times (-2) = 1.4
        $$
2. $e = 4 \ge 0$ のとき：
        $$
        l_{0.3} = 0.3 \times 4 = 1.2
        $$

\textbf{【グラフの形状】}
誤差 $e=0$ （予測値と正解ラベルが一致している点）を最下点（損失 $0$）とし、負の領域（予測過剰）では傾き $-0.7$ の急な直線、正の領域（予測不足）では傾き $0.3$ の緩やかな直線となる、非対称なV字型の形状をとる。

::: {.right}
[（問題へ戻る）](#q:4-pinball-loss-calculation)
:::


## 確率論的二値分類と非線型最適化

### ロジスティック関数の微分と交差エントロピー

**【該当内容】** 第5回スライド50〜89「確率論的二値分類、交差エントロピー、勾配の導出」
**【ねらい】** 天下り的に与えられるシグモイド関数の微分公式を自力で完全に導出し、交差エントロピー損失のパラメータ微分（チェインルール）を実行して、アルゴリズムの動作を数式で裏付ける。

### 問5-indicator-expectation の解答・解説 {#a:5-indicator-expectation .answerbox ref="q:5-indicator-expectation"}

指示変数 $Y = \ind\{X \in A\}$ は、事象 $\{X \in A\}$ が発生したとき（確率 $\mathbb{P}(X \in A)$）に $1$ をとり、発生しなかったとき（確率 $1 - \mathbb{P}(X \in A)$）に $0$ をとる離散確率変数である。
離散確率変数の期待値の定義 $\mathbb{E}[Y] = \sum_{y} y \cdot \mathbb{P}(Y = y)$ に基づいて計算すると、
\begin{align*}
\mathbb{E}[\ind\{X \in A\}] &= 1 \times \mathbb{P}(\ind\{X \in A\} = 1) + 0 \times \mathbb{P}(\ind\{X \in A\} = 0) \\
&= 1 \times \mathbb{P}(X \in A) + 0 \times (1 - \mathbb{P}(X \in A)) \\
&= \mathbb{P}(X \in A)
\end{align*}
よって、常に $\mathbb{E}[\ind\{X \in A\}] = \mathbb{P}(X \in A)$ が成り立つ。（証明終）

\smallskip
\noindent\textit{（測度論的確率論を学んだことのある読者へ：測度論的確率論では，確率測度 $\mathbb{P}$ に関する積分として期待値が $\mathbb{E}[Y] = \int Y \, d\mathbb{P}$ と定義されるため，$\mathbb{E}[\mathbf{1}_A] = \int \mathbf{1}_A \, d\mathbb{P} = \mathbb{P}(A)$ は証明するまでもなく期待値の定義から直ちに従う．）}

::: {.right}
[（問題へ戻る）](#q:5-indicator-expectation)
:::

### 問5-sigmoid-derivative の解答・解説 {#a:5-sigmoid-derivative .answerbox ref="q:5-sigmoid-derivative"}

1. $\sigma(z)$ の定義から計算する。
        $$
        \sigma(z) \exp(-z) = \frac{\exp(-z)}{1 + \exp(-z)} = \frac{1 + \exp(-z) - 1}{1 + \exp(-z)} = \frac{1 + \exp(-z)}{1 + \exp(-z)} - \frac{1}{1 + \exp(-z)} = 1 - \sigma(z)
        $$
        となる。（証明終）
2. $g(z) = 1 + \exp(-z)$ とおくと、$g'(z) = -\exp(-z)$ であるから、
        $$
        \frac{d}{dz} \sigma(z) = - \frac{-\exp(-z)}{(1 + \exp(-z))^2} = \frac{\exp(-z)}{(1 + \exp(-z))^2} = \left( \frac{1}{1 + \exp(-z)} \right)^2 \exp(-z) = \sigma(z)^2 \exp(-z)
        $$
        となる。（証明終）
3. (2) および (1) の証明結果を順に用いる。
        $$
        \frac{d}{dz} \log \sigma(z) = (\sigma(z))^{-1} \cdot \left(\frac{d}{dz} \sigma(z)\right) = \frac{1}{\sigma(z)} \cdot \left(\sigma(z)^2 \exp(-z)\right) = \sigma(z) \exp(-z) = 1 - \sigma(z)
        $$
        となり、導出できた。（証明終）
::: {.right}
[（問題へ戻る）](#q:5-sigmoid-derivative)
:::

### 問5-cross-entropy-gradient の解答・解説 {#a:5-cross-entropy-gradient .answerbox ref="q:5-cross-entropy-gradient"}

1. 交差エントロピー損失 $\ell(z)$ を $z$ について偏微分する。
   $$
   \frac{\partial \ell(z)}{\partial z} = -y \frac{d}{dz}(\log \sigma(z)) - (1-y) \frac{d}{dz}(\log(1 - \sigma(z)))
   $$
   第1項の微分は前問の(2)より $1 - \sigma(z)$。第2項の微分は同様に、
   $$
   \frac{d}{dz} \log(1 - \sigma(z)) = \frac{-\sigma'(z)}{1 - \sigma(z)} = \frac{-\sigma(z)(1 - \sigma(z))}{1 - \sigma(z)} = -\sigma(z)
   $$
   これらを代入して整理する。
   \begin{align*}
   \frac{\partial \ell(z)}{\partial z} &= -y(1 - \sigma(z)) - (1-y)(-\sigma(z)) \\
   &= -y + y\sigma(z) + \sigma(z) - y\sigma(z) \\
   &= \sigma(z) - y
   \end{align*}
   となる。（証明終）

2. 次に、勾配 $\nabla_{\boldsymbol{\theta}} z$ を計算する。$z = \boldsymbol{\theta}^\top \boldsymbol{\phi}(x)$ はパラメータ $\boldsymbol{\theta}$ について線型であるため、
   $$
   \nabla_{\boldsymbol{\theta}} z = \boldsymbol{\phi}(x)
   $$
   チェインルールを適用して両者を掛け合わせる。
   $$
   \nabla_{\boldsymbol{\theta}} \ell(z) = \frac{\partial \ell(z)}{\partial z} \cdot \nabla_{\boldsymbol{\theta}} z = (\sigma(z) - y)\boldsymbol{\phi}(x)
   $$
   となり、導出された。（証明終）

::: {.right}
[（問題へ戻る）](#q:5-cross-entropy-gradient)
:::


## 確率論的多値分類とソフトマックス回帰

### ソフトマックス関数と多クラス交差エントロピー

**【該当内容】** 第6回スライド「確率論的多値分類＞ソフトマックスと最尤法＞勾配」
**【ねらい】** 多値分類で標準的に用いられるソフトマックス関数と負の対数尤度の組み合わせにおいて、その勾配が「予測確率と正解の差（誤差）×特徴量」という非常に直感的かつシンプルな形式で導かれるプロセスを数学的に理解する。

### 問6-log-softmax-gradient の解答・解説 {#a:6-log-softmax-gradient .answerbox ref="q:6-log-softmax-gradient"}

まず、勾配ベクトルの第 $j$ 成分である偏微分 $\frac{\partial \log \text{Softmax}(\mathbf{z})[k]}{\partial z_j}$ を計算する。右辺第2項の偏微分には、対数関数の微分公式 $(\log f(x))' = \frac{f'(x)}{f(x)}$ を用いる。$\sum_{m=1}^K \exp(z_m)$ を $z_j$ で微分するとどうなるかに注意して計算を進める。

$\log \text{Softmax}(\mathbf{z})[k] = z_k - \log \sum_{m=1}^K \exp(z_m)$ の第1項の $z_k$ は、$z_j$ で微分すると $k=j$ のとき $1$、$k \neq j$ のとき $0$ となるため、指示関数を用いて $\mathbf{1}\{k=j\}$ となる。

第2項は合成関数の微分則を用いて計算する。分母の和の項のうち、$z_j$ に依存するのは $\exp(z_j)$ だけであることに注意すると、
\begin{align*}
\frac{\partial}{\partial z_j} \left( \log \sum_{m=1}^K \exp(z_m) \right) &= \frac{\frac{\partial}{\partial z_j} \sum_{m=1}^K \exp(z_m)}{\sum_{m=1}^K \exp(z_m)} \\
&= \frac{\exp(z_j)}{\sum_{m=1}^K \exp(z_m)} \\
&= \text{Softmax}(\mathbf{z})[j]
\end{align*}
となる。

したがって、これらを合わせると各成分は
$$
\frac{\partial \log \text{Softmax}(\mathbf{z})[k]}{\partial z_j} = \mathbf{1}\{k=j\} - \text{Softmax}(\mathbf{z})[j]
$$
となる。これらを縦ベクトルとして並べると、
$$
\nabla_{\mathbf{z}} \log \text{Softmax}(\mathbf{z})[k] =
\begin{pmatrix}
\mathbf{1}\{k=1\} - \text{Softmax}(\mathbf{z})[1] \\
\vdots \\
\mathbf{1}\{k=K\} - \text{Softmax}(\mathbf{z})[K]
\end{pmatrix}
$$
となる。（証明終）

::: {.right}
[（問題へ戻る）](#q:6-log-softmax-gradient)
:::

### 問6-softmax-gradient-derivation の解答・解説 {#a:6-softmax-gradient-derivation .answerbox ref="q:6-softmax-gradient-derivation"}

負の対数尤度損失 $\ell((\mathbf{x}, y), g_{\boldsymbol{\theta}}) = -\log g_{\boldsymbol{\theta}}(\mathbf{x})[y]$ に、モデルの定義を代入して対数の分解を行う。
\begin{align*}
\ell((\mathbf{x}, y), g_{\boldsymbol{\theta}}) &= -\log \left( \frac{\exp(s_{\boldsymbol{\theta}}[\mathbf{x}](y))}{\sum_{j=1}^K \exp(s_{\boldsymbol{\theta}}[\mathbf{x}](j))} \right) \\
&= -\left( \log \exp(s_{\boldsymbol{\theta}}[\mathbf{x}](y)) - \log \sum_{j=1}^K \exp(s_{\boldsymbol{\theta}}[\mathbf{x}](j)) \right) \\
&= -s_{\boldsymbol{\theta}}[\mathbf{x}](y) + \log \left( \sum_{j=1}^K \exp(s_{\boldsymbol{\theta}}[\mathbf{x}](j)) \right)
\end{align*}
両辺の $\boldsymbol{\theta}$ に対する勾配をとる：
$$
\nabla_{\boldsymbol{\theta}} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}}) = -\nabla_{\boldsymbol{\theta}} s_{\boldsymbol{\theta}}(\mathbf{x})[y] + \nabla_{\boldsymbol{\theta}} \log \left( \sum_{j=1}^K \exp(s_{\boldsymbol{\theta}}(\mathbf{x})[j]) \right)
$$
ここで、第2項の勾配を合成関数の微分公式 $(\log f(\boldsymbol{\theta}))' = \frac{\nabla f(\boldsymbol{\theta})}{f(\boldsymbol{\theta})}$ を用いて計算する：
\begin{align*}
\nabla_{\boldsymbol{\theta}} \log \left( \sum_{j=1}^K \exp(s_{\boldsymbol{\theta}}[\mathbf{x}](j)) \right) &= \frac{\nabla_{\boldsymbol{\theta}} \left( \sum_{k=1}^K \exp(s_{\boldsymbol{\theta}}[\mathbf{x}](k)) \right)}{\sum_{j=1}^K \exp(s_{\boldsymbol{\theta}}[\mathbf{x}](j))} \\
&= \frac{\sum_{k=1}^K \exp(s_{\boldsymbol{\theta}}[\mathbf{x}](k)) \cdot \nabla_{\boldsymbol{\theta}} s_{\boldsymbol{\theta}}[\mathbf{x}](k)}{\sum_{j=1}^K \exp(s_{\boldsymbol{\theta}}[\mathbf{x}](j))} \\
&= \sum_{k=1}^K \frac{\exp(s_{\boldsymbol{\theta}}[\mathbf{x}](k))}{\sum_{j=1}^K \exp(s_{\boldsymbol{\theta}}[\mathbf{x}](j))} \cdot \nabla_{\boldsymbol{\theta}} s_{\boldsymbol{\theta}}[\mathbf{x}](k) \\
&= \sum_{k=1}^K g_{\boldsymbol{\theta}}[\mathbf{x}](k) \cdot \nabla_{\boldsymbol{\theta}} s_{\boldsymbol{\theta}}[\mathbf{x}](k)
\end{align*}
これを元の式に代入すると、求める勾配公式が得られる：
$$
\nabla_{\boldsymbol{\theta}} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}}) = -\nabla_{\boldsymbol{\theta}} s_{\boldsymbol{\theta}}(\mathbf{x})[y] + \sum_{k=1}^K g_{\boldsymbol{\theta}}(\mathbf{x})[k] \cdot \nabla_{\boldsymbol{\theta}} s_{\boldsymbol{\theta}}(\mathbf{x})[k] \quad \text{（証明終）}
$$

::: {.right}
[（問題へ戻る）](#q:6-softmax-gradient-derivation)
:::

### 問6-multiclass-logistic-gradient の解答・解説 {#a:6-multiclass-logistic-gradient .answerbox ref="q:6-multiclass-logistic-gradient"}

1. $\boldsymbol{\theta}_j^\top \boldsymbol{\phi}(\mathbf{x})$ を $\boldsymbol{\theta}_k$ で偏微分すると、
   $$
   \nabla_{\boldsymbol{\theta}_k} \left( \boldsymbol{\theta}_j^\top \boldsymbol{\phi}(\mathbf{x}) \right) = \begin{cases}
   \boldsymbol{\phi}(\mathbf{x}) & (j = k \text{ のとき}) \\
   \mathbf{0} & (j \neq k \text{ のとき})
   \end{cases}
   $$
   となる。これは指示関数 $\mathbf{1}$ を用いて以下のように簡潔に書ける：
   $$
   \nabla_{\boldsymbol{\theta}_k} s_{\boldsymbol{\theta}}(\mathbf{x})[j] = \mathbf{1}\{j = k\} \boldsymbol{\phi}(\mathbf{x})
   $$

2. 前問で求めた勾配公式を $\boldsymbol{\theta}_k$ について適用し、(1) の結果を代入する：
   \begin{align*}
   \nabla_{\boldsymbol{\theta}_k} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}}) &= -\nabla_{\boldsymbol{\theta}_k} s_{\boldsymbol{\theta}}[\mathbf{x}](y) + \sum_{j=1}^K g_{\boldsymbol{\theta}}[\mathbf{x}](j) \cdot \nabla_{\boldsymbol{\theta}_k} s_{\boldsymbol{\theta}}[\mathbf{x}](j) \\
   &= -\mathbf{1}\{y = k\} \boldsymbol{\phi}(\mathbf{x}) + \sum_{j=1}^K g_{\boldsymbol{\theta}}[\mathbf{x}](j) \cdot \mathbf{1}\{j = k\} \boldsymbol{\phi}(\mathbf{x})
   \end{align*}
   ここで、右辺の第2項の和（$\sum_{j=1}^K$）の中身は $j = k$ のとき以外は $0$ になるため、和が外れて $j=k$ の項だけが残る。
   \begin{align*}
   \dots &= -\mathbf{1}\{k = y\} \boldsymbol{\phi}(\mathbf{x}) + g_{\boldsymbol{\theta}}[\mathbf{x}](k) \boldsymbol{\phi}(\mathbf{x}) \\
   &= \left( g_{\boldsymbol{\theta}}[\mathbf{x}](k) - \mathbf{1}\{k = y\} \right) \boldsymbol{\phi}(\mathbf{x})
   \end{align*}
   となり、求める勾配が導出された。（証明終）

3. 全体のパラメータ $\boldsymbol{\theta}$ に対する勾配 $\nabla_{\boldsymbol{\theta}} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}})$ は、各パラメータ成分ごとの偏微分を並べたベクトルである。パラメータ $\boldsymbol{\theta}$ が $\boldsymbol{\theta}_1, \dots, \boldsymbol{\theta}_K$ を縦に結合したベクトル（ブロックベクトル）であるため、その勾配も各 $\boldsymbol{\theta}_k$ に関する勾配 $\nabla_{\boldsymbol{\theta}_k} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}})$ を同じように縦に並べたブロックベクトルとなる。
   (2) の結果より、各ブロック $\nabla_{\boldsymbol{\theta}_k} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}})$ は $(g_{\boldsymbol{\theta}}(\mathbf{x})[k] - \mathbf{1}\{k = y\}) \boldsymbol{\phi}(\mathbf{x})$ で与えられるため、これを各行（各ブロック）に代入することで、
   $$
   \nabla_{\boldsymbol{\theta}} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}}) = \begin{pmatrix} (g_{\boldsymbol{\theta}}(\mathbf{x})[1] - \mathbf{1}\{1 = y\}) \boldsymbol{\phi}(\mathbf{x}) \\ \vdots \\ (g_{\boldsymbol{\theta}}(\mathbf{x})[K] - \mathbf{1}\{K = y\}) \boldsymbol{\phi}(\mathbf{x}) \end{pmatrix}
   $$
   が得られる。（証明終）

::: {.right}
[（問題へ戻る）](#q:6-multiclass-logistic-gradient)
:::

### 問6-gradient-descent-algorithm の解答・解説 {#a:6-gradient-descent-algorithm .answerbox ref="q:6-gradient-descent-algorithm"}

正しい組み合わせは以下の通り。

- `Step 1`　: ( 目的: ア = **③** ) \quad ( 操作: イ = **⑧** )
- `Step 2-1`: ( 目的: ウ = **②** ) \quad ( 操作: エ = **⑦** )
- `Step 2-2`: ( 目的: オ = **①** ) \quad ( 操作: カ = **⑤** )
- `Step 2-3`: ( 目的: キ = **④** ) \quad ( 操作: ク = **⑥** )

::: {.right}
[（問題へ戻る）](#q:6-gradient-descent-algorithm)
:::

### 問6-weight-decay-derivation の解答・解説 {#a:6-weight-decay-derivation .answerbox ref="q:6-weight-decay-derivation"}

1. $\nabla \|\boldsymbol{\theta}\|^2 = 2\boldsymbol{\theta}$ であるため、全体の勾配は
   $$ \nabla L(\boldsymbol{\theta}) = \nabla \hat{R}(\boldsymbol{\theta}) + 2\lambda \boldsymbol{\theta} $$
   となる。

2. 勾配降下法の更新式にこれを代入すると、
   \begin{align*}
   \boldsymbol{\theta} &\leftarrow \boldsymbol{\theta} - \eta \left( \nabla \hat{R}(\boldsymbol{\theta}) + 2\lambda \boldsymbol{\theta} \right) \\
   &= \boldsymbol{\theta} - 2\eta\lambda \boldsymbol{\theta} - \eta \nabla \hat{R}(\boldsymbol{\theta}) \\
   &= (1 - 2\eta\lambda) \boldsymbol{\theta} - \eta \nabla \hat{R}(\boldsymbol{\theta})
   \end{align*}
   となる。
   この式において、$(1 - 2\eta\lambda) \boldsymbol{\theta}$ の部分は現在のパラメーター $\boldsymbol{\theta}$ を $1 - 2\eta\lambda$ 倍（通常 $0 < 1 - 2\eta\lambda < 1$ となるように $\eta, \lambda$ が設定される）して、原点に少し近づける（縮小する）働きをしている。その上で、$-\eta \nabla \hat{R}(\boldsymbol{\theta})$ によって経験リスクを減少させる方向へ更新が行われている。これが L2正則化が重み減衰（Weight Decay）と呼ばれる理由である。

::: {.right}
[（問題へ戻る）](#q:6-weight-decay-derivation)
:::

### 問6-logistic-l2-update の解答・解説 {#a:6-logistic-l2-update .answerbox ref="q:6-logistic-l2-update"}

1. 前章で導出したように、1データ $(x_i, y_i)$ あたりの交差エントロピー損失の勾配は $(\sigma(\theta x_i) - y_i)x_i$ である。また正則化項 $\lambda \theta^2$ の勾配は $2\lambda \theta$ である。
   よって目的関数全体の勾配は
   $$ \nabla L(\theta) = \frac{1}{n} \sum_{i=1}^n (\sigma(\theta x_i) - y_i)x_i + 2\lambda \theta $$
   となる。
   更新式はこれを用いて
   $$ \theta \leftarrow \theta - \eta \left( \frac{1}{n} \sum_{i=1}^n (\sigma(\theta x_i) - y_i)x_i + 2\lambda \theta \right) $$
   と書き下せる。

2. $\theta = 0$ のとき $\sigma(\theta x_1) = \sigma(0) = 0.5$、$\sigma(\theta x_2) = \sigma(0) = 0.5$ である。
   $n=2$, $(x_1, y_1) = (1, 1)$, $(x_2, y_2) = (-1, 0)$ を代入して勾配を計算する。
   \begin{align*}
   \nabla L(0) &= \frac{1}{2} \left[ (0.5 - 1) \times 1 + (0.5 - 0) \times (-1) \right] + 2 \times 0.1 \times 0 \\
   &= \frac{1}{2} \left[ -0.5 - 0.5 \right] + 0 \\
   &= \frac{1}{2} \times (-1.0) = -0.5
   \end{align*}
   更新後のパラメーターは
   $$ \theta \leftarrow 0 - 0.5 \times (-0.5) = 0.25 $$
   となる。

::: {.right}
[（問題へ戻る）](#q:6-logistic-l2-update)
:::
