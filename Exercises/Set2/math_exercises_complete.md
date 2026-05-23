---
title: "経営学への応用を目指すAI入門：数学演習問題集"
subtitle: "第1回〜第6回 講義内容完全準拠・論理展開追体験セット（完全版）"
author: "特殊講義1 補助資料"
date: "2026年5月17日（最終更新）"
geometry: margin=20mm
numbersections: true
header-includes: |
  ```{=latex}
  \usepackage{amsmath,amssymb}
  \usepackage[most]{tcolorbox}
  \usepackage{tikz}
  \usetikzlibrary{arrows.meta, positioning}
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
\textbf{最終更新日：2026年5月17日 (v1.0)}
\end{flushright}

# 本演習問題集の進め方と活用法 {.unnumbered}

本問題集は、講義スライドに登場する数式の「行間（省略された計算や証明）」を学生自身の手で動かして埋め、ブラックボックスを解消することを目的に設計されています。各セクションには講義スライドとの対応関係である**【該当内容】**と、その演習を行う目的である**【ねらい】**が記載されています。

また、各設問には以下の難易度が設定されています。

* **難易度：★0 (不要)** ：解き方が分かるなら解かなくてもいい。
* **難易度：★1 (確認)** ：スライドの定義そのものの確認や、簡単な代入問題。
* **難易度：★2 (基礎)** ：必須。講義の論理展開の行間を埋める標準的な問題。
* **難易度：★3 (発展)** ：余裕があれば解くとよい。

---

# 確率の基礎とリスク関数・ERM

## 確率の基礎と期待値・分散の計算

### 指示関数（Indicator function）の理解 {#q:1-indicator-function .questionbox difficulty="★1"}

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

### 離散型確率分布での期待値・分散計算 {#q:1-discrete-expectation-variance .questionbox difficulty="★0"}

ある離散確率変数 $X$ は、確率 $0.2$ で $0$、確率 $0.5$ で $1$、確率 $0.3$ で $2$ をとる。

1. 期待値 $\mathbb{E}[X]$ を求めよ。
2. $f(x) = x^2$ とするとき、期待値 $\mathbb{E}[f(X)]$ を求めよ。
3. 分散 $\mathbb{V}[f(X)]$ を計算せよ。

::: {.right}
[（解答・解説へ）](#a:1-discrete-expectation-variance)
:::

### 連続型確率分布での期待値・分散計算 {#q:1-continuous-expectation-variance .questionbox difficulty="★0"}

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

### 共分散（Covariance）の2次形式的振る舞い {#q:1-variance-formula-proof .questionbox difficulty="★3"}

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

### 解答・解説

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

# 最適化と最小二乗法・偏微分

## 経験リスクの数式化（シグマを用いた書き下し）

### 経験リスクの立式 {#q:2-empirical-risk-formulation .questionbox difficulty="★2"}

$n$ 個の訓練データ $\{(x_i, y_i)\}_{i=1}^n$ が与えられている。モデルクラスとして1次関数 $f_{(w,b)}(x) = wx + b$ を採用し、損失関数を二乗誤差 $l(y, \hat{y}) = (y - \hat{y})^2$ とするとき、経験リスク $\hat{R}(f_{(w,b)})$ を書き下せ。
<!-- $\sum_{i=1}^n$ を用いて -->

::: {.right}
[（解答・解説へ）](#a:2-empirical-risk-formulation)
:::

### 最適化問題の定式化：穴埋め {#q:2-optimization-formulation-blank .questionbox difficulty="★2"}

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


### 目的関数のパラメータ関数化 {#q:2-erm-parameter-function .questionbox difficulty="★0"}

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

### 解答・解説

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

## 最小二乗法の真髄：偏微分から一階の条件へ

### 偏微分と勾配 {#q:3-multivariate-gradient .questionbox difficulty="★2"}

ベクトル $\mathbf{w} = (w_1, w_2, w_3)^\top \in \mathbb{R}^3$ に対する以下の関数 $g(\mathbf{w})$ について、勾配 $\nabla g(\mathbf{w})$ を求めよ。
$$
g(\mathbf{w}) = w_1^2 + 2w_2^2 + 3w_3^2 - 4w_1w_2 - 6w_2w_3
$$

::: {.right}
[（解答・解説へ）](#a:3-multivariate-gradient)
:::

### 線型単回帰モデルの最適パラメータ導出 {#q:2-partial-derivative-gradient .questionbox difficulty="★2"}

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
3. 上記の行列方程式を解くことで、最適なパラメータ $(\hat{w}, \hat{b})$ を求める式が
   $$
   \begin{pmatrix} \hat{w} \\ \hat{b} \end{pmatrix} = \begin{pmatrix} \sum_{i=1}^n x_i^2 & \sum_{i=1}^n x_i \\ \sum_{i=1}^n x_i & n \end{pmatrix}^{-1} \begin{pmatrix} \sum_{i=1}^n x_i y_i \\ \sum_{i=1}^n y_i \end{pmatrix}
   $$
   となることを示せ。

::: {.right}
[（解答・解説へ）](#a:2-partial-derivative-gradient)
:::

### 解答・解説

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

# 線型モデルの行列表現と正則化・モデル選択

## ベクトルの内積と性質

### 行列・ベクトルの積の計算練習 {#q:3-matrix-vector-multiplication-practice .questionbox difficulty="★0"}

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

### ベクトル・行列の積の頻出パターンと成分表示 {#q:3-matrix-vector-patterns .questionbox difficulty="★2"}

講義スライドで登場した行列・ベクトルの積に関する視覚的なパターンの意味を、成分表示を用いて確認せよ。

1. **【横ベクトル $\times$ 縦ベクトル $\to$ スカラー】**
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

行列は、行（横ベクトル）や列（縦ベクトル）が並んだものとしてイメージすると、複雑な計算も直感的に捉えやすくなります。

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
  通常のベクトル間の内積（成分同士を掛けて足す）のように振る舞います。

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
      \draw[->, orange!80!red, shorten >=2pt, thick] (0.55, 0.6) to[out=50, in=150] (2.5, 0.7);
      \draw[->, orange!80!red, shorten >=2pt, thick] (1.15, 0.2) to[out=40, in=160] (2.5, 0.1);
      \draw[->, orange!80!red, shorten >=2pt, thick] (1.75, -0.2) to[out=30, in=170] (2.5, -0.5);

      \node at (3.5, 0) {$=$};
      \node at (4.2, 0) {$\displaystyle \sum_{j=1}^3$};
      \draw[fill=colbg, draw=colborder] (4.8, -1.0) rectangle (5.1, 0.8);
      \node[anchor=south] at (4.95, 0.8) {$\boldsymbol{\beta}_j$};
      \draw[fill=vbg, draw=vborder] (5.4, -0.15) rectangle (5.7, 0.15);
      \node[anchor=south] at (5.55, 0.15) {$v_j$};
    \end{tikzpicture}
    \end{center}

### 【復習とヒント】ベクトルの内積と射影 {.tcolorbox option="enhanced, colback=blue!2!white, colframe=blue!60!black, fonttitle=\bfseries, drop shadow"}

内積 $\mathbf{a}^\top \mathbf{b}$ は、一方のベクトルを他方に「射影」したときの長さと、元のベクトルの長さの積として幾何学的に解釈できます。

\begin{center}
\begin{tikzpicture}[>=stealth, thick, scale=1.2]
  % ベクトルb
  \draw[->, blue!80!black, line width=1.2pt] (0,0) -- (4,0) node[below] {$\mathbf{b}$};
  % ベクトルa
  \draw[->, red!80!black, line width=1.2pt] (0,0) -- (2.5,2) node[above left] {$\mathbf{a}$};
  % 垂線
  \draw[dashed, gray] (2.5,2) -- (2.5,0);
  % 直角マーク
  \draw (2.3,0) -- (2.3,0.2) -- (2.5,0.2);
  % 角度
  \draw (0.6,0) arc (0:38.66:0.6);
  \node at (0.8, 0.3) {$\theta$};
  % 射影ベクトル
  \draw[->, orange, line width=1.5pt] (0,-0.05) -- (2.5,-0.05) node[midway, below] {$\mathbf{a}$ の $\mathbf{b}$ への射影};
\end{tikzpicture}
\end{center}

* \textbf{幾何学的定義}: $\mathbf{a}^\top \mathbf{b} = \|\mathbf{a}\| \|\mathbf{b}\| \cos \theta$
* \textbf{直交性}: 内積が $0$ ならば、$\cos \theta = 0$ となり、2つのベクトルは直交する（$\theta = 90^\circ$）。

### 内積の計算と幾何的解釈 {#q:3-inner-product-geometry .questionbox difficulty="★0"}

2つのベクトル $\mathbf{a} = (2, 3)^\top$, $\mathbf{b} = (-6, 4)^\top$ がある。

1. 内積 $\mathbf{a}^\top \mathbf{b}$ を計算せよ。
2. この2つのベクトルの幾何学的な位置関係（同じ方向、逆方向、直交のいずれか）を特定せよ。

::: {.right}
[（解答・解説へ）](#a:3-inner-product-geometry)
:::

### 射影成分の計算 {#q:3-projection-component .questionbox difficulty="★1"}

大きさ（ノルム）が $1$ である方向ベクトル $\mathbf{u} = (1, 0)^\top$ がある。任意のベクトル $\mathbf{x} = (5, -3)^\top$ を $\mathbf{u}$ 方向の成分に射影したときの係数（射影の長さ）を内積を用いて計算せよ。

::: {.right}
[（解答・解説へ）](#a:3-projection-component)
:::

### 内積の線形性と対称性の証明 {#q:3-inner-product-properties .questionbox difficulty="★3"}

任意の次元のベクトル $\mathbf{x}, \mathbf{y}$ およびスカラー $c$ について、
\begin{align*}
\mathbf{x}^\top \mathbf{y} &= \mathbf{y}^\top \mathbf{x} \quad \text{（対称性）} \\
(c\mathbf{x})^\top \mathbf{y} &= c(\mathbf{x}^\top \mathbf{y}) \quad \text{（線形性）}
\end{align*}
が成り立つことを、各成分を明示して確かめよ。

::: {.right}
[（解答・解説へ）](#a:3-inner-product-properties)
:::

### 解答・解説

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

### 問3-inner-product-geometry の解答・解説 {#a:3-inner-product-geometry .answerbox ref="q:3-inner-product-geometry"}

1. $$\mathbf{a}^\top \mathbf{b} = 2 \times (-6) + 3 \times 4 = -12 + 12 = 0$$
2. 内積が $0$ であるため、2つのベクトルは\textbf{直交している}。

::: {.right}
[（問題へ戻る）](#q:3-inner-product-geometry)
:::

### 問3-projection-component の解答・解説 {#a:3-projection-component .answerbox ref="q:3-projection-component"}

求める射影の長さは内積 $\mathbf{x}^\top \mathbf{u}$ で与えられる。
$$
\mathbf{x}^\top \mathbf{u} = 5 \times 1 + (-3) \times 0 = 5
$$
よって $\mathbf{u}$ 方向への射影の長さは $5$ である。

::: {.right}
[（問題へ戻る）](#q:3-projection-component)
:::

### 問3-inner-product-properties の解答・解説 {#a:3-inner-product-properties .answerbox ref="q:3-inner-product-properties"}

$\mathbf{x} = (x_1, \dots, x_d)^\top$, $\mathbf{y} = (y_1, \dots, y_d)^\top$ とおく。

1. 内積の定義より $\mathbf{x}^\top \mathbf{y} = \sum_{i=1}^d x_i y_i$ である。
        実数の積は可換（$x_i y_i = y_i x_i$）なので、
        $$
        \mathbf{x}^\top \mathbf{y} = \sum_{i=1}^d y_i x_i = \mathbf{y}^\top \mathbf{x}
        $$
        となり、対称性が成立する。
2. ベクトルのスカラー倍の定義より $c\mathbf{x} = (cx_1, \dots, cx_d)^\top$ である。
        $$
        (c\mathbf{x})^\top \mathbf{y} = \sum_{i=1}^d (cx_i)y_i = c \sum_{i=1}^d x_i y_i = c(\mathbf{x}^\top \mathbf{y})
        $$
        となり、線形性（スカラー倍の同伴性）が成立する。（証明終）

::: {.right}
[（問題へ戻る）](#q:3-inner-product-properties)
:::

## パラメータ線型モデルの表現（特徴写像）

### 多項式特徴写像による線型表現 {#q:3-polynomial-feature-mapping .questionbox difficulty="★1"}

1次元の入力 $x$ に対し、特徴写像を $\boldsymbol{\phi}(x) = (1, x, x^2)^\top$ と定義する。
パラメータベクトルを $\boldsymbol{\theta} = (\theta_0, \theta_1, \theta_2)^\top$ とする。

1. 線型モデル $f(x) = \boldsymbol{\theta}^\top \boldsymbol{\phi}(x)$ を書き下せ。
2. このモデルは、パラメータ $\boldsymbol{\theta}$ に着目すると何次式か。また、入力 $x$ に着目すると何次式か答えよ。
   （ただし，多変数多項式の次数は，最大の単項式の次数のことである．）

::: {.right}
[（解答・解説へ）](#a:3-polynomial-feature-mapping)
:::

### テキストデータへの適用（Bag-of-Words）と最小二乗法 {#q:3-bag-of-words-representation .questionbox difficulty="★2"}

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
3. このモデルに対して、最小二乗誤差の意味で最適なパラメータ $\hat{\boldsymbol{\theta}}$ を求める一般式を、計画行列 $\Phi$ とラベルベクトル $\mathbf{y}$ を用いて（逆行列の記号を用いて）書き下せ。
   （ただし，この設定において $\Phi^\top \Phi$ の逆行列が存在することは認めてよい．）

::: {.right}
[（解答・解説へ）](#a:3-bag-of-words-representation)
:::

### 解答・解説

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

## 多変数関数の経験リスクと勾配

### 3変数パラメータの経験リスク {#q:3-multivariate-empirical-risk .questionbox difficulty="★1"}

3つのデータポイント $(x_1, y_1) = (1, 2)$, $(x_2, y_2) = (2, 3)$, $(x_3, y_3) = (3, 5)$ が与えられている。予測モデルを3変数パラメータ $\boldsymbol{\theta} = (\theta_1, \theta_2, \theta_3)^\top$ を用いたモデル $f_{\boldsymbol{\theta}}(x) = \theta_1 + \theta_2 x + \theta_3 x^2$ とし、損失関数を二乗誤差とする。
このとき、経験リスク
$$
\hat{R}(f_{\boldsymbol{\theta}}) = \frac{1}{3} \sum_{i=1}^3 (y_i - f_{\boldsymbol{\theta}}(x_i))^2
$$
を $\boldsymbol{\theta}$ の関数として具体的な数値を用いて展開・書き下せ。（整理・簡略化までする必要はない。）

::: {.right}
[（解答・解説へ）](#a:3-multivariate-empirical-risk)
:::

## 最小二乗法の行列表記と一階の条件（最重要）

### 行列とベクトルによる目的関数の書き直し {#q:3-matrix-empirical-risk .questionbox difficulty="★2"}

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
   と書き直せることを、上記1の結果およびベクトルのノルムの定義 $\left(\|\mathbf{v}\|^2 = \sum_{i=1}^n v_i^2\right)$ を用いて確認せよ。

::: {.right}
[（解答・解説へ）](#a:3-matrix-empirical-risk)
:::

### 【復習とヒント】行列・ベクトルの転置と微分公式 {.tcolorbox option="enhanced, colback=blue!2!white, colframe=blue!60!black, fonttitle=\bfseries, drop shadow"}

* \textbf{転置の積の法則}: $(\mathbf{A}\mathbf{B})^\top = \mathbf{B}^\top \mathbf{A}^\top$
* \textbf{スカラーの転置}: 内積はスカラー（$1 \times 1$行列）なので、転置しても値は変わらない。 \\
          $(\mathbf{x}^\top \mathbf{y})^\top = \mathbf{y}^\top \mathbf{x} = \mathbf{x}^\top \mathbf{y}$
* \textbf{L2ノルムの2乗}: $\|\mathbf{x}\|^2 = \mathbf{x}^\top \mathbf{x}$
* \textbf{線形項の勾配}: $\nabla_{\mathbf{x}} (\mathbf{a}^\top \mathbf{x}) = \nabla_{\mathbf{x}} (\mathbf{x}^\top \mathbf{a}) = \mathbf{a}$
* \textbf{2次形式の勾配}: $\nabla_{\mathbf{x}} (\mathbf{x}^\top \mathbf{A} \mathbf{x}) = 2\mathbf{A}\mathbf{x}$ \quad （$\mathbf{A}$ が対称行列のとき）

### 一階の条件の行列導出 {#q:3-matrix-derivative-first-order .questionbox difficulty="★1"}

行列微分の公式
\begin{align*}
\nabla_{\boldsymbol{\theta}} (\mathbf{a}^\top \boldsymbol{\theta}) &= \mathbf{a} \\
\nabla_{\boldsymbol{\theta}} (\boldsymbol{\theta}^\top \mathbf{A} \boldsymbol{\theta}) &= 2\mathbf{A}\boldsymbol{\theta} \quad \text{（$\mathbf{A}$は対称行列）}
\end{align*}
を用いて、目的関数 $L(\boldsymbol{\theta}) = \frac{1}{2}(\Phi\boldsymbol{\theta} - \mathbf{y})^\top (\Phi\boldsymbol{\theta} - \mathbf{y})$ の勾配 $\nabla_{\boldsymbol{\theta}} L(\boldsymbol{\theta})$ を求め、一階の条件 $\nabla_{\boldsymbol{\theta}} L(\boldsymbol{\theta}) = \mathbf{0}$ から正規方程式
$$
\Phi^\top \Phi \boldsymbol{\theta} = \Phi^\top \mathbf{y}
$$
を導出せよ。

::: {.right}
[（解答・解説へ）](#a:3-matrix-derivative-first-order)
:::

### 解答・解説

**【該当内容】** 第3回スライド38〜44「線型モデルの最小二乗法、行列による表記」
**【ねらい】** データの羅列をデザイン行列 $\Phi$ とラベルベクトル $\mathbf{y}$ にまとめ、目的関数をベクトルのノルムとしてスッキリ表現するテクニックと、その微分プロセスを完全にマスターする。

### 問3-multivariate-empirical-risk の解答・解説 {#a:3-multivariate-empirical-risk .answerbox ref="q:3-multivariate-empirical-risk"}

与えられたデータポイントの各数値をモデル $f_{\boldsymbol{\theta}}(x) = \theta_1 + \theta_2 x + \theta_3 x^2$ および経験リスクの式に代入します。

* $f_{\boldsymbol{\theta}}(x_1) = f_{\boldsymbol{\theta}}(1) = \theta_1 + \theta_2 + \theta_3$
* $f_{\boldsymbol{\theta}}(x_2) = f_{\boldsymbol{\theta}}(2) = \theta_1 + 2\theta_2 + 4\theta_3$
* $f_{\boldsymbol{\theta}}(x_3) = f_{\boldsymbol{\theta}}(3) = \theta_1 + 3\theta_2 + 9\theta_3$

これらを二乗誤差の式に代入して平均をとると、求める経験リスクは以下のようになります：
$$
\hat{R}(f_{\boldsymbol{\theta}}) = \frac{1}{3} \left[ (\theta_1 + \theta_2 + \theta_3 - 2)^2 + (\theta_1 + 2\theta_2 + 4\theta_3 - 3)^2 + (\theta_1 + 3\theta_2 + 9\theta_3 - 5)^2 \right]
$$
これが、パラメータ $\boldsymbol{\theta} = (\theta_1, \theta_2, \theta_3)^\top$ に対する目的関数となります。（証明終）

::: {.right}
[（問題へ戻る）](#q:3-multivariate-empirical-risk)
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
   が導かれ、式が一致することが確認された。（証明終）

::: {.right}
[（問題へ戻る）](#q:3-matrix-empirical-risk)
:::

### 問3-matrix-derivative-first-order の解答・解説 {#a:3-matrix-derivative-first-order .answerbox ref="q:3-matrix-derivative-first-order"}

目的関数 $L(\boldsymbol{\theta})$ を展開する。内積はスカラーであり転置しても値が変わらないため、$\mathbf{y}^\top \Phi \boldsymbol{\theta} = (\mathbf{y}^\top \Phi \boldsymbol{\theta})^\top = \boldsymbol{\theta}^\top \Phi^\top \mathbf{y}$ が成り立ち、中央の項がまとめられる。
$$
L(\boldsymbol{\theta}) = \frac{1}{2} \left[ \boldsymbol{\theta}^\top \Phi^\top \Phi \boldsymbol{\theta} - 2 (\Phi^\top \mathbf{y})^\top \boldsymbol{\theta} + \mathbf{y}^\top \mathbf{y} \right]
$$
ここで、$\mathbf{A} = \Phi^\top \Phi$ とおくと、これは対称行列である。行列微分の公式を適用して $\boldsymbol{\theta}$ で勾配を計算する。
$$
\nabla_{\boldsymbol{\theta}} L(\boldsymbol{\theta}) = \frac{1}{2} \left[ 2 \Phi^\top \Phi \boldsymbol{\theta} - 2 \Phi^\top \mathbf{y} \right] = \Phi^\top \Phi \boldsymbol{\theta} - \Phi^\top \mathbf{y}
$$
一階の条件 $\nabla_{\boldsymbol{\theta}} L(\boldsymbol{\theta}) = \mathbf{0}$ より、
$$
\Phi^\top \Phi \boldsymbol{\theta} - \Phi^\top \mathbf{y} = \mathbf{0} \quad \Rightarrow \quad \Phi^\top \Phi \boldsymbol{\theta} = \Phi^\top \mathbf{y}
$$
が導出された。（証明終）

::: {.right}
[（問題へ戻る）](#q:3-matrix-derivative-first-order)
:::

## 正則化（Regularization）

### L2ノルムの性質と内積 {#q:3-l2-norm-properties .questionbox difficulty="★2"}

一般の $d$ 次元ベクトル $\mathbf{w} = (w_1, \dots, w_d)^\top$ について、L2ノルムの定義 $\|\mathbf{w}\| = \sqrt{\sum_{i=1}^d w_i^2}$ と内積の定義を用いて、以下の等式が成り立つことを確認せよ。
$$
\|\mathbf{w}\|^2 = \mathbf{w}^\top \mathbf{w}
$$

::: {.right}
[（解答・解説へ）](#a:3-l2-norm-properties)
:::

### L2正則化付き目的関数の書き下し {#q:3-l2-regularization-objective .questionbox difficulty="★1"}

損失関数を二乗誤差、正則化項をL2ノルムの2乗とし、正則化係数を $\lambda = 0.01$ とする。 $n$ 個のデータに対するL2正則化付き経験リスク最小化の目的関数 $L_{\text{reg}}(\boldsymbol{\theta})$ の式をシグマ表記で書き下せ。

::: {.right}
[（解答・解説へ）](#a:3-l2-regularization-objective)
:::

### 行列による書き直しと一階の条件 {#q:3-l2-regularization-gradient .questionbox difficulty="★1"}

目的関数を $L_{\text{reg}}(\boldsymbol{\theta}) = \frac{1}{2}\|\Phi\boldsymbol{\theta} - \mathbf{y}\|^2 + \frac{\lambda}{2}\|\boldsymbol{\theta}\|^2$ とする。全体の勾配を $\mathbf{0}$ と置く一階の条件から、最適解
$$
\hat{\boldsymbol{\theta}} = (\Phi^\top \Phi + \lambda \mathbf{I})^{-1}\Phi^\top \mathbf{y}
$$
を導出せよ。なぜ単位行列 $\mathbf{I}$ が必要なのか説明せよ（ただし逆行列は存在すると仮定する）。

::: {.right}
[（解答・解説へ）](#a:3-l2-regularization-gradient)
:::

### 解答・解説

**【該当内容】** 第3回スライド45〜50「過適合の対策＞正則化、L2正則化」
**【ねらい】** 過学習を防ぐL2正則化（Ridge）の目的関数について、代数表現と行列表現の一致を確かめ、単位行列 $I$ が出現する理由を数式変形で完全に理解する。

### 問3-l2-norm-properties の解答・解説 {#a:3-l2-norm-properties .answerbox ref="q:3-l2-norm-properties"}

L2ノルムの定義より、その2乗は各成分の2乗和となる。
$$
\|\mathbf{w}\|^2 = \left( \sqrt{\sum_{i=1}^d w_i^2} \right)^2 = \sum_{i=1}^d w_i^2
$$
一方、ベクトル $\mathbf{w}$ とそれ自身との内積は、対応する成分の積の和であるから、
$$
\mathbf{w}^\top \mathbf{w} = \sum_{i=1}^d w_i w_i = \sum_{i=1}^d w_i^2
$$
となる。
両者の結果が一致するため、$\|\mathbf{w}\|^2 = \mathbf{w}^\top \mathbf{w}$ が成り立つことが確認された。（証明終）

::: {.right}
[（問題へ戻る）](#q:3-l2-norm-properties)
:::

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
\nabla_{\boldsymbol{\theta}} L_{\text{reg}} = \Phi^\top \Phi \boldsymbol{\theta} - \Phi^\top \mathbf{y} + \lambda \boldsymbol{\theta} = \mathbf{0}
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

## モデル選択（交差検証）

### K-foldとLOOCVのインデックス計算 {#q:3-cross-validation-indices .questionbox difficulty="★0"}

1. $n=6$ 個のデータを $K=3$ 個のフォルダ
        $$
        D_1 = \{1, 2\}, \quad D_2 = \{3, 4\}, \quad D_3 = \{5, 6\}
        $$
        に分割する。第2イテレーション（$D_2$ が検証用）において、訓練に使用されるデータのインデックスをすべて答えよ。
2. サンプルサイズが $n=100$ のデータにLOOCV（一箇抜き交差検証）を行う場合、モデルの学習は合計で何回実行されるか。

::: {.right}
[（解答・解説へ）](#a:3-cross-validation-indices)
:::

### 解答・解説

**【該当内容】** 第3回スライド51〜70「モデル選択、交差検証」
**【ねらい】** ハイパーパラメータ選択の手続きを、インデックス操作を通じて厳密に理解する。

### 問3-cross-validation-indices の解答・解説 {#a:3-cross-validation-indices .answerbox ref="q:3-cross-validation-indices"}

1. 全体のデータ $\{1,2,3,4,5,6\}$ から検証用の $D_2 = \{3,4\}$ を除外した、\textbf{$\{1, 2, 5, 6\}$} が訓練用データとなる。
2. LOOCVはデータから1点だけを検証用として抜き出し、残りの $n-1$ 点で訓練する作業をデータの個数分だけ繰り返す。したがって、実行回数は合計で\textbf{100回}である。

::: {.right}
[（問題へ戻る）](#q:3-cross-validation-indices)
:::

# 確率モデルと分位点回帰

## 同時分布・条件付き分布・条件付き期待値

### 同時確率表からの条件付き分布と期待値 {#q:4-conditional-probability-table .questionbox difficulty="★1"}

離散確率変数 $X \in \{0,1\}$ と $Y \in \{1,2,3\}$ の同時確率 $P(X, Y)$ について、 $X=0$ のとき、$Y=1, 2, 3$ となる確率はそれぞれ $0.1, 0.2, 0.1$ である。

1. $X=0$ となる周辺確率（正規化定数） $P(X=0)$ を求めよ。
2. $X=0$ という条件のもとでの $Y$ の条件付き確率分布 $P(Y=y \mid X=0)$ を求めよ。
3. 上記の分布を用いて、条件付き期待値 $\mathbb{E}[Y \mid X=0]$ を計算せよ。

::: {.right}
[（解答・解説へ）](#a:4-conditional-probability-table)
:::

### 解答・解説

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

## 分位点（Quantile）と外れ値の影響

### 飛びのある分布の分位点とロバスト性 {#q:4-absolute-loss-mae .questionbox difficulty="★1"}

1. データセット $\{2, 3, 5, 7, 100\}$ の平均値と中央値を求めよ。
2. 外れ値の $100$ が $1000$ に化けたとする。このとき平均値と中央値はどう変化するか計算し、ピンボール損失（中央値の場合は絶対値損失）が外れ値に対して持つ優位性を説明せよ。

::: {.right}
[（解答・解説へ）](#a:4-absolute-loss-mae)
:::

### ピンボール損失のグラフ描写の理解 {#q:4-pinball-loss-calculation .questionbox difficulty="★0"}

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

### 解答・解説

**【該当内容】** 第4回スライド19〜35「分位点回帰、ピンボール損失」
**【ねらい】** 平均値が外れ値に引っ張られやすいのに対し、分位点（中央値など）が頑健（ロバスト）である理由を、実際のデータ操作を通じて数式ベースで理解する。

### 問4-absolute-loss-mae の解答・解説 {#a:4-absolute-loss-mae .answerbox ref="q:4-absolute-loss-mae"}

1. 平均値の計算：
        $$
        \frac{2 + 3 + 5 + 7 + 100}{5} = \frac{117}{5} = 23.4
        $$
        中央値の計算：データを昇順に並べた中央の値なので、\textbf{5}。
2. 外れ値が $1000$ になった場合の計算：
        $$
        \text{新平均値} = \frac{2 + 3 + 5 + 7 + 1000}{5} = \frac{1017}{5} = 203.4
        $$
        新中央値：順序関係は変わらないため、依然として\textbf{5}。

::: {.right}
[（問題へ戻る）](#q:4-absolute-loss-mae)
:::

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

# 確率論的二値分類と非線型最適化

## ロジスティック回帰の基礎と非線型目的関数の勾配

### 指示関数の期待値と確率の関係 {#q:5-indicator-expectation .questionbox difficulty="★1"}

事象（または条件） $A$ について、指示関数の期待値 $\mathbb{E}[\ind\{X \in A\}]$ は、事象 $\{X \in A\}$ が発生する確率 $\mathbb{P}(X \in A)$ と等しくなること、すなわち
$$
\mathbb{E}[\ind\{X \in A\}] = \mathbb{P}(X \in A)
$$
が常に成り立つことを示せ。

::: {.right}
[（解答・解説へ）](#a:5-indicator-expectation)
:::

## ロジスティック関数の微分と交差エントロピー

### シグモイド関数の微分証明 {#q:5-sigmoid-derivative .questionbox difficulty="★2"}

ロジスティック関数（シグモイド関数） $\sigma(z) = \frac{1}{1 + e^{-z}}$ について、

1. 商の微分公式を用いて $\sigma'(z) = \sigma(z)(1 - \sigma(z))$ になることを証明せよ。
2. 合成関数の微分則を用いて $\frac{d}{dz} \log \sigma(z) = 1 - \sigma(z)$ が成り立つことを示せ。

::: {.right}
[（解答・解説へ）](#a:5-sigmoid-derivative)
:::

### 交差エントロピーとチェインルールによる勾配導出 {#q:5-cross-entropy-gradient .questionbox difficulty="★2"}

交差エントロピー損失
$$
l = -y \log \sigma(z) - (1-y) \log(1 - \sigma(z)) \quad (\text{ただし } z = \boldsymbol{\theta}^\top \boldsymbol{\phi}(x))
$$
について、チェインルール $\nabla_{\boldsymbol{\theta}} l = \frac{\partial l}{\partial z} \cdot \nabla_{\boldsymbol{\theta}} z$ を用いて、勾配が
$$
\nabla_{\boldsymbol{\theta}} l = (\sigma(z) - y)\boldsymbol{\phi}(x)
$$
となることを導出せよ。

::: {.right}
[（解答・解説へ）](#a:5-cross-entropy-gradient)
:::

### 解答・解説

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

1. 商の微分公式 $\left( \frac{1}{g(z)} \right)' = -\frac{g'(z)}{(g(z))^2}$ を用いる。$g(z) = 1 + e^{-z}$ とおくと、$g'(z) = -e^{-z}$ である。
        $$
        \sigma'(z) = - \frac{-e^{-z}}{(1 + e^{-z})^2} = \frac{e^{-z}}{(1 + e^{-z})^2} = \left( \frac{1}{1 + e^{-z}} \right) \left( \frac{e^{-z}}{1 + e^{-z}} \right)
        $$
        ここで、右側の項の分子に $1 - 1$ を補う。
        $$
        \frac{e^{-z}}{1 + e^{-z}} = \frac{1 + e^{-z} - 1}{1 + e^{-z}} = \frac{1 + e^{-z}}{1 + e^{-z}} - \frac{1}{1 + e^{-z}} = 1 - \sigma(z)
        $$
        よって、
        $$
        \sigma'(z) = \sigma(z)(1 - \sigma(z))
        $$
        となる。（証明終）
2. 合成関数の微分公式 $(\log f(z))' = \frac{f'(z)}{f(z)}$ と、(1)の証明結果を用いる。
        $$
        \frac{d}{dz} \log \sigma(z) = \frac{\sigma'(z)}{\sigma(z)} = \frac{\sigma(z)(1 - \sigma(z))}{\sigma(z)} = 1 - \sigma(z)
        $$
        となり、成立する。（証明終）

::: {.right}
[（問題へ戻る）](#q:5-sigmoid-derivative)
:::

### 問5-cross-entropy-gradient の解答・解説 {#a:5-cross-entropy-gradient .answerbox ref="q:5-cross-entropy-gradient"}

対数尤度損失 $l$ を $z$ について偏微分する。
$$
\frac{\partial l}{\partial z} = -y \frac{d}{dz}(\log \sigma(z)) - (1-y) \frac{d}{dz}(\log(1 - \sigma(z)))
$$
第1項 of 微分は問9の(2)より $1 - \sigma(z)$。第2項 of 微分は同様に、
$$
\frac{d}{dz} \log(1 - \sigma(z)) = \frac{-\sigma'(z)}{1 - \sigma(z)} = \frac{-\sigma(z)(1 - \sigma(z))}{1 - \sigma(z)} = -\sigma(z)
$$
これらを代入して整理する。
\begin{align*}
\frac{\partial l}{\partial z} &= -y(1 - \sigma(z)) - (1-y)(-\sigma(z)) \\
&= -y + y\sigma(z) + \sigma(z) - y\sigma(z) \\
&= \sigma(z) - y
\end{align*}
次に、勾配 $\nabla_{\boldsymbol{\theta}} z$ を計算する。$z = \boldsymbol{\theta}^\top \boldsymbol{\phi}(x)$ はパラメータ $\boldsymbol{\theta}$ について線型であるため、
$$
\nabla_{\boldsymbol{\theta}} z = \boldsymbol{\phi}(x)
$$
チェインルールを適用して両者を掛け合わせる。
$$
\nabla_{\boldsymbol{\theta}} l = \frac{\partial l}{\partial z} \cdot \nabla_{\boldsymbol{\theta}} z = (\sigma(z) - y)\boldsymbol{\phi}(x)
$$
なり、導出された。（証明終）

::: {.right}
[（問題へ戻る）](#q:5-cross-entropy-gradient)
:::

# 確率論的多値分類とソフトマックス回帰

## ソフトマックス関数と多クラス交差エントロピー

### ソフトマックス損失の勾配公式の導出 {#q:6-softmax-gradient-derivation .questionbox difficulty="★1"}

多クラス分類問題において、入力 $\mathbf{x}$ に対するスコアベクトルを $s_{\boldsymbol{\theta}}(\mathbf{x}) \in \mathbb{R}^K$ とし、モデル $g_{\boldsymbol{\theta}}(\mathbf{x}) = \text{Softmax}(s_{\boldsymbol{\theta}}(\mathbf{x}))$ を考える。ここで、モデルの出力ベクトルの第 $k$ 成分 $g_{\boldsymbol{\theta}}(\mathbf{x})[k]$ は以下のように定義される。
$$
g_{\boldsymbol{\theta}}(\mathbf{x})[k] = \frac{\exp(s_{\boldsymbol{\theta}}(\mathbf{x})[k])}{\sum_{j=1}^K \exp(s_{\boldsymbol{\theta}}(\mathbf{x})[j])}
$$
正解クラスラベルを $y \in \{1, \dots, K\}$ とするとき、損失関数（負の対数尤度損失）を
$$
\ell((\mathbf{x}, y), g_{\boldsymbol{\theta}}) = -\log g_{\boldsymbol{\theta}}(\mathbf{x})[y]
$$
と定義する。このとき、以下の問いに答えよ。

1. 損失関数のパラメータ $\boldsymbol{\theta}$ に対する勾配が、以下のように表されることを示せ。
   $$
   \nabla_{\boldsymbol{\theta}} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}}) = -\nabla_{\boldsymbol{\theta}} s_{\boldsymbol{\theta}}(\mathbf{x})[y] + \sum_{k=1}^K g_{\boldsymbol{\theta}}(\mathbf{x})[k] \cdot \nabla_{\boldsymbol{\theta}} s_{\boldsymbol{\theta}}(\mathbf{x})[k]
   $$
2. 多クラスロジスティック回帰（ソフトマックス回帰）モデルにおいて、クラス $k$ のスコアが、クラス固有のパラメータベクトル $\boldsymbol{\theta}_k$ と特徴量 $\boldsymbol{\phi}(\mathbf{x})$ の内積
   $$
   s_{\boldsymbol{\theta}}(\mathbf{x})[k] = \boldsymbol{\theta}_k^\top \boldsymbol{\phi}(\mathbf{x})
   $$
   で与えられるとする。このとき、損失関数のパラメータ $\boldsymbol{\theta}_k$ に対する勾配 $\nabla_{\boldsymbol{\theta}_k} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}})$ が
   $$
   \nabla_{\boldsymbol{\theta}_k} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}}) = \left( g_{\boldsymbol{\theta}}(\mathbf{x})[k] - \mathbf{1}\{k = y\} \right) \boldsymbol{\phi}(\mathbf{x})
   $$
   となることを示せ。ただし、$\mathbf{1}\{\cdot\}$ は指示関数であり、条件が真のとき $1$、偽のとき $0$ をとる。

::: {.right}
[（解答・解説へ）](#a:6-softmax-gradient-derivation)
:::

### 解答・解説

**【該当内容】** 第6回スライド「確率論的多値分類＞ソフトマックスと最尤法＞勾配」
**【ねらい】** 多値分類で標準的に用いられるソフトマックス関数と負の対数尤度の組み合わせにおいて、その勾配が「予測確率と正解の差（誤差）×特徴量」という非常に直感的かつシンプルな形式で導かれるプロセスを数学的に理解する。

### 問6-softmax-gradient-derivation の解答・解説 {#a:6-softmax-gradient-derivation .answerbox ref="q:6-softmax-gradient-derivation"}

1. 負の対数尤度損失 $\ell((\mathbf{x}, y), g_{\boldsymbol{\theta}}) = -\log g_{\boldsymbol{\theta}}(\mathbf{x})[y]$ に、モデルの定義を代入して対数の分解を行う。
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

2. スコア関数が $s_{\boldsymbol{\theta}}(\mathbf{x})[j] = \boldsymbol{\theta}_j^\top \boldsymbol{\phi}(\mathbf{x})$ で与えられるとき、特定のパラメータ $\boldsymbol{\theta}_k$ に関する勾配を考える。

   まず、$\boldsymbol{\theta}_j^\top \boldsymbol{\phi}(\mathbf{x})$ を $\boldsymbol{\theta}_k$ で偏微分すると、
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

   これを用いて、(1)の勾配公式を $\boldsymbol{\theta}_k$ について適用する：
   \begin{align*}
   \nabla_{\boldsymbol{\theta}_k} \ell((\mathbf{x}, y), g_{\boldsymbol{\theta}}) &= -\nabla_{\boldsymbol{\theta}_k} s_{\boldsymbol{\theta}}[\mathbf{x}](y) + \sum_{j=1}^K g_{\boldsymbol{\theta}}[\mathbf{x}](j) \cdot \nabla_{\boldsymbol{\theta}_k} s_{\boldsymbol{\theta}}[\mathbf{x}](j) \\
   &= -\mathbf{1}\{y = k\} \boldsymbol{\phi}(\mathbf{x}) + \sum_{j=1}^K g_{\boldsymbol{\theta}}[\mathbf{x}](j) \cdot \mathbf{1}\{j = k\} \boldsymbol{\phi}(\mathbf{x}) \\
   &= -\mathbf{1}\{k = y\} \boldsymbol{\phi}(\mathbf{x}) + g_{\boldsymbol{\theta}}[\mathbf{x}](k) \boldsymbol{\phi}(\mathbf{x}) \\
   &= \left( g_{\boldsymbol{\theta}}[\mathbf{x}](k) - \mathbf{1}\{k = y\} \right) \boldsymbol{\phi}(\mathbf{x})
   \end{align*}
   となり、求める勾配が導出された。（証明終）

::: {.right}
[（問題へ戻る）](#q:6-softmax-gradient-derivation)
:::
