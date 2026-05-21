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
  \titleformat{\section}[block]{\normalfont\Large\bfseries}{【第\thesection 回】}{0.5em}{}
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

* **難易度：★0 (Basic)** ：スライドの定義そのものの確認や、直感的な代入問題。
* **難易度：★1 (Standard)** ：講義の数式展開を再現する標準的な手計算。
* **難易度：★2 (Advanced)** ：行列の微分や文字式による一般的な証明など、一歩進んだ数学的体力を要する問題。

---

# 確率の基礎とリスク関数・ERM

## 確率の基礎と期待値・分散の計算

### 離散型確率分布での期待値・分散計算 {#q:1-discrete-expectation-variance .questionbox difficulty="★0"}

ある離散確率変数 $X$ は、確率 $0.2$ で $0$、確率 $0.5$ で $1$、確率 $0.3$ で $2$ をとる。

1. 期待値 $\mathbb{E}[X]$ を求めよ。
2. $f(x) = x^2$ とするとき、期待値 $\mathbb{E}[f(X)]$ を求めよ。
3. 分散 $\mathbb{V}[f(X)]$ を計算せよ。

::: {.right}
[（解答・解説へ）](#a:1-discrete-expectation-variance)
:::

### 指示関数（Indicator function）の理解 {#q:1-indicator-function .questionbox difficulty="★0"}

機械学習の理論（特に損失関数や分類問題の評価など）では、ある条件が満たされているか否かを表す**指示関数（定義関数）** $\ind$ が頻出する。条件（または事象） $A$ に対して、指示関数 $\ind_A$ または $\ind\{A\}$ は以下のように定義される。
$$
\ind\{A\} = \begin{cases}
1 & (\text{条件 } A \text{ が真のとき}) \\
0 & (\text{条件 } A \text{ が偽のとき})
\end{cases}
$$

1. 確率変数 $X$ が次の値をとるときの指示関数 $\ind\{X \ge 1\}$ の値をそれぞれ求めよ。
   (a) $X = 0$
   (b) $X = 2$
2. 確率変数 $Y = \ind\{X \ge 1\}$ がとり得る値と、それぞれの値をとる確率（確率分布）を求めよ。
3. 指示関数の期待値 $\mathbb{E}[\ind\{X \in A\}]$ は、事象 $\{X \in A\}$ が発生する確率 $\mathbb{P}(X \in A)$ と等しくなること、すなわち
   $$
   \mathbb{E}[\ind\{X \in A\}] = \mathbb{P}(X \in A)
   $$
   が常に成り立つことを示せ。

::: {.right}
[（解答・解説へ）](#a:1-indicator-function)
:::

### 連続型確率分布での期待値・分散計算 {#q:1-continuous-expectation-variance .questionbox difficulty="★1"}

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

### 共分散（Covariance）の2次形式的振る舞い {#q:1-variance-formula-proof .questionbox difficulty="★1"}

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

   まとめると、確率分布は以下の通りです：
   $$
   Y = \begin{cases}
   1 & (\text{確率 } 0.8) \\
   0 & (\text{確率 } 0.2)
   \end{cases}
   $$

3. 確率変数 $Y = \ind\{X \in A\}$ は、$X \in A$ のときに $1$ をとり、$X \notin A$ のときに $0$ をとる確率変数（ベルヌーイ分布に従う確率変数）です。
   それぞれの値をとる確率は以下の通りです：
   * $\mathbb{P}(Y = 1) = \mathbb{P}(X \in A)$
   * $\mathbb{P}(Y = 0) = 1 - \mathbb{P}(X \in A)$

   したがって、離散型確率変数の期待値の定義に従って $\mathbb{E}[Y]$ を計算すると：
   \begin{align*}
   \mathbb{E}[\ind\{X \in A\}] = \mathbb{E}[Y] &= 1 \cdot \mathbb{P}(Y = 1) + 0 \cdot \mathbb{P}(Y = 0) \\
   &= 1 \cdot \mathbb{P}(X \in A) + 0 \cdot (1 - \mathbb{P}(X \in A)) \\
   &= \mathbb{P}(X \in A)
   \end{align*}
   となり、指示関数の期待値は事象の発生確率と完全に等しくなることが示されました。（証明終）

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

---

# 最適化と最小二乗法・偏微分

## 経験リスクの数式化（シグマを用いた書き下し）

### 経験リスクの立式 {#q:2-empirical-risk-formulation .questionbox difficulty="★0"}

$n$ 個の訓練データ $\{(x_i, y_i)\}_{i=1}^n$ が与えられている。モデルクラスとして1次関数 $f_{(w,b)}(x) = wx + b$ を採用し、損失関数を二乗誤差 $l(y, \hat{y}) = (y - \hat{y})^2$ とするとき、目的関数 $L(w,b)$ を $\sum_{i=1}^n$ を用いて書き下せ。

::: {.right}
[（解答・解説へ）](#a:2-empirical-risk-formulation)
:::

### 目的関数のパラメータ関数化 {#q:2-erm-parameter-function .questionbox difficulty="★0"}

以下の2つのデータポイントが与えられている。

\begin{center}
\begin{tabular}{cc}
$x$ & $y$ \\ \hline
$1$ & $2$ \\
$3$ & $4$
\end{tabular}
\end{center}

予測モデルを原点を通る直線 $f_\theta(x) = \theta x$ とし、損失関数を二乗誤差とする。このとき、経験リスク
$$
\hat{R}(f_\theta) = \frac{1}{2} \sum_{i=1}^2 (y_i - f_\theta(x_i))^2
$$
に具体的な数値を代入し、$\theta$ の2次関数 $A\theta^2 + B\theta + C$ の形に展開・整理せよ。

::: {.right}
[（解答・解説へ）](#a:2-erm-parameter-function)
:::

### 最適化問題の定式化：穴埋め {#q:2-optimization-formulation-blank .questionbox difficulty="★0"}

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

---

## 最小二乗法の真髄：偏微分から一階の条件へ

### 偏微分と勾配ベクトルの書き下し {#q:2-partial-derivative-gradient .questionbox difficulty="★1"}

目的関数 $L(w,b) = \frac{1}{n} \sum_{i=1}^n (y_i - wx_i - b)^2$ とする。この目的関数について、勾配ベクトル $\nabla_{(w,b)} L(w,b)$ を求めよ。

::: {.right}
[（解答・解説へ）](#a:2-partial-derivative-gradient)
:::

### 一階の条件からの式変形 {#q:2-first-order-conditions-scalar .questionbox difficulty="★2"}

最適解において勾配ベクトルがゼロになるという一階の条件 $\nabla L(w,b) = \mathbf{0}$ のうち、$\frac{\partial L}{\partial b} = 0$ の式を変形し、最適な切片 $\hat{b}$ が、サンプルの平均値 $\bar{x} = \frac{1}{n}\sum_{i=1}^n x_i$, $\bar{y} = \frac{1}{n}\sum_{i=1}^n y_i$ を用いて
$$
\hat{b} = \bar{y} - w\bar{x}
$$
と表せることを証明せよ。

::: {.right}
[（解答・解説へ）](#a:2-first-order-conditions-scalar)
:::

### 学習済みパラメータによる新規データの予測 {#q:2-prediction-with-learned-parameters .questionbox difficulty="★0"}

あるデータセットに対して最小二乗法を適用したところ、学習済みパラメータが $\hat{w} = 2.5, \hat{b} = 1.0$ と求まった。このとき、新規に観測された特徴量 $x_{\text{new}} = 6$ に対する予測値 $\hat{y}_{\text{new}}$ を計算せよ。

::: {.right}
[（解答・解説へ）](#a:2-prediction-with-learned-parameters)
:::

### 解答・解説

**【該当内容】** 第2回スライド38〜45「一階の条件、偏微分・勾配」
**【ねらい】** スライドで省略されている目的関数 $L(w,b)$ の偏微分から勾配ベクトルの構築、一階の条件による正規方程式のスカラ版の導出を完全に追体験する。

### 問2-partial-derivative-gradient の解答・解説 {#a:2-partial-derivative-gradient .answerbox ref="q:2-partial-derivative-gradient"}

勾配ベクトル $\nabla_{(w,b)} L(w,b)$ は、各変数に対する偏微分を縦に並べたものである：
$$
\nabla_{(w,b)} L(w,b) = \begin{pmatrix} \frac{\partial L}{\partial w} \\ \frac{\partial L}{\partial b} \end{pmatrix}
$$
それぞれの偏微分を計算する。

1. **$w$ についての偏微分：**
   合成関数の微分（チェインルール）を用いる。カッコの中身を $w$ で微分した $-x_i$ が外に出る。
        $$
        \frac{\partial L}{\partial w} = \frac{1}{n} \sum_{i=1}^n 2(y_i - wx_i - b) \cdot (-x_i) = -\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b)x_i
        $$
2. **$b$ についての偏微分：**
   同様に、中身を $b$ で微分した $-1$ が外に出る。
        $$
        \frac{\partial L}{\partial b} = \frac{1}{n} \sum_{i=1}^n 2(y_i - wx_i - b) \cdot (-1) = -\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b)
        $$

これらを縦に並べることで、求める勾配ベクトルは以下のようになる：
$$
\nabla_{(w,b)} L(w,b) = \begin{pmatrix} -\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b)x_i \\ -\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b) \end{pmatrix}
$$

::: {.right}
[（問題へ戻る）](#q:2-partial-derivative-gradient)
:::

### 問2-first-order-conditions-scalar の解答・解説 {#a:2-first-order-conditions-scalar .answerbox ref="q:2-first-order-conditions-scalar"}

一階の条件 $\frac{\partial L}{\partial b} = 0$ より、
$$
-\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b) = 0
$$
両辺を $-\frac{2}{n}$ で割り、和を分割する。
$$
\sum_{i=1}^n y_i - w \sum_{i=1}^n x_i - \sum_{i=1}^n b = 0
$$
定数 $b$ を $n$ 回足すと $nb$ になるので、
$$
\sum_{i=1}^n y_i - w \sum_{i=1}^n x_i - nb = 0
$$
両辺を $n$ で割ると、
$$
\frac{1}{n}\sum_{i=1}^n y_i - w \left( \frac{1}{n}\sum_{i=1}^n x_i \right) - b = 0
$$
平均値の定義 $\bar{x}, \bar{y}$ を代入すると、
$$
\bar{y} - w\bar{x} - b = 0 \quad \Rightarrow \quad \hat{b} = \bar{y} - w\bar{x}
$$
が導かれる。（証明終）

::: {.right}
[（問題へ戻る）](#q:2-first-order-conditions-scalar)
:::

### 問2-prediction-with-learned-parameters の解答・解説 {#a:2-prediction-with-learned-parameters .answerbox ref="q:2-prediction-with-learned-parameters"}

学習済みモデル $f(x) = \hat{w}x + \hat{b}$ に数値を代入する。
$$
\hat{y}_{\text{new}} = 2.5 \times 6 + 1.0 = 15.0 + 1.0 = 16.0
$$

::: {.right}
[（問題へ戻る）](#q:2-prediction-with-learned-parameters)
:::

---

# 線型モデルの行列表現と正則化・モデル選択

## ベクトルの内積と性質

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

### 内積の線形性と対称性の証明 {#q:3-inner-product-properties .questionbox difficulty="★1"}

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

---

## パラメータ線型モデルの表現（特徴写像）

### 多項式特徴写像による線型表現 {#q:3-polynomial-feature-mapping .questionbox difficulty="★1"}

1次元の入力 $x$ に対し、特徴写像を $\boldsymbol{\phi}(x) = (1, x, x^2)^\top$ と定義する。
パラメータベクトルを $\boldsymbol{\theta} = (\theta_0, \theta_1, \theta_2)^\top$ とする。

1. 内積によるモデル表現 $f(x) = \boldsymbol{\theta}^\top \boldsymbol{\phi}(x)$ を書き下せ。
2. このモデルは、パラメータ $\boldsymbol{\theta}$ に着目すると何次式か。また、入力 $x$ に着目すると何次式か答えよ。
   （ただし，多変数多項式の次数は，最大の単項式の次数のことである．）

::: {.right}
[（解答・解説へ）](#a:3-polynomial-feature-mapping)
:::

### テキストデータへの適用（Bag-of-Words）と最小二乗法 {#q:3-bag-of-words-representation .questionbox difficulty="★1"}

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

語彙となる名詞のリストを $V = \{\text{「AI」}, \text{「ビジネス」}, \text{「犬」}\}$ とし、特徴ベクトル $\boldsymbol{\phi}(x)$ を以下のように定義します。
$$
\boldsymbol{\phi}(x) = \begin{pmatrix} \text{「AI」の出現回数} \\ \text{「ビジネス」の出現回数} \\ \text{「犬」の出現回数} \end{pmatrix}
$$

この特徴ベクトルを用いた線型モデル $f(x) = \boldsymbol{\theta}^\top \boldsymbol{\phi}(x)$ （ただし $\boldsymbol{\theta} = (\theta_1, \theta_2, \theta_3)^\top$）について、以下の問いに答えよ。

1. 各文書 $x_1, x_2, x_3, x_4$ に対する特徴ベクトル $\boldsymbol{\phi}(x_1), \boldsymbol{\phi}(x_2), \boldsymbol{\phi}(x_3), \boldsymbol{\phi}(x_4)$ をそれぞれ具体的に求めよ。
2. 全体のデータに対するデザイン行列 $\Phi \in \mathbb{R}^{4 \times 3}$ と、ラベルベクトル $\mathbf{y} \in \mathbb{R}^4$ を具体的に数値で書き下せ。
   ここで，
   $$\Phi = \begin{pmatrix} \boldsymbol{\phi}(x_1)^\top \\ \boldsymbol{\phi}(x_2)^\top \\ \boldsymbol{\phi}(x_3)^\top \\ \boldsymbol{\phi}(x_4)^\top \end{pmatrix}$$
   である．
3. このモデルに対して、最小二乗誤差の意味で最適なパラメータ $\hat{\boldsymbol{\theta}}$ を求める一般式を、デザイン行列 $\Phi$ とラベルベクトル $\mathbf{y}$ を用いて（逆行列の記号を用いて）書き下せ。
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

---

## 多変数関数の経験リスクと勾配ベクトル

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

### 3変数関数の勾配ベクトル {#q:3-multivariate-gradient .questionbox difficulty="★1"}

実数上の3変数ベクトル $\mathbf{w} = (w_1, w_2, w_3)^\top \in \mathbb{R}^3$ に対する以下の関数 $g(\mathbf{w})$ について、それぞれの変数で偏微分し、勾配ベクトル $\nabla g(\mathbf{w})$ を求めよ。
$$
g(\mathbf{w}) = w_1^2 + 2w_2^2 + 3w_3^2 - 4w_1w_2 - 6w_2w_3
$$

::: {.right}
[（解答・解説へ）](#a:3-multivariate-gradient)
:::

---

## 最小二乗法の行列表記と一階の条件（最重要）

### 行列とベクトルによる目的関数の書き直し {#q:3-matrix-empirical-risk .questionbox difficulty="★1"}

$n=2$ 個のデータがあり、それぞれの特徴ベクトルと正解ラベルが、
$$
\boldsymbol{\phi}(x_1) = \begin{pmatrix} 1 \\ 2 \end{pmatrix}, y_1 = 4, \quad \boldsymbol{\phi}(x_2) = \begin{pmatrix} 1 \\ 5 \end{pmatrix}, y_2 = 7
$$
である。デザイン行列 $\Phi = \begin{pmatrix} \boldsymbol{\phi}(x_1)^\top \\ \boldsymbol{\phi}(x_2)^\top \end{pmatrix}$ およびラベルベクトル $\mathbf{y} = (y_1, y_2)^\top$ を具体的に数字で書き下し、目的関数
$$
L(\boldsymbol{\theta}) = \frac{1}{2} \|\Phi\boldsymbol{\theta} - \mathbf{y}\|^2
$$
が個別の二乗誤差の和 $\frac{1}{2}\sum_{i=1}^2 (y_i - \boldsymbol{\theta}^\top \boldsymbol{\phi}(x_i))^2$ と完全に等しいことを展開して確かめよ。

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

### 一階の条件の行列導出 {#q:3-matrix-derivative-first-order .questionbox difficulty="★2"}

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

これらをベクトルとしてまとめると、求める勾配ベクトルは以下のようになります：
$$
\nabla g(\mathbf{w}) = \begin{pmatrix} 2w_1 - 4w_2 \\ -4w_1 + 4w_2 - 6w_3 \\ -6w_2 + 6w_3 \end{pmatrix}
$$
（証明終）

::: {.right}
[（問題へ戻る）](#q:3-multivariate-gradient)
:::

### 問3-matrix-empirical-risk の解答・解説 {#a:3-matrix-empirical-risk .answerbox ref="q:3-matrix-empirical-risk"}

デザイン行列 $\Phi$ とラベルベクトル $\mathbf{y}$ は以下のようになる。
$$
\Phi = \begin{pmatrix} 1 & 2 \\ 1 & 5 \end{pmatrix}, \quad \mathbf{y} = \begin{pmatrix} 4 \\ 7 \end{pmatrix}
$$
パラメータを $\boldsymbol{\theta} = (\theta_0, \theta_1)^\top$ とすると、
$$
\Phi\boldsymbol{\theta} - \mathbf{y} = \begin{pmatrix} 1 & 2 \\ 1 & 5 \end{pmatrix} \begin{pmatrix} \theta_0 \\ \theta_1 \end{pmatrix} - \begin{pmatrix} 4 \\ 7 \end{pmatrix} = \begin{pmatrix} \theta_0 + 2\theta_1 - 4 \\ \theta_0 + 5\theta_1 - 7 \end{pmatrix}
$$
ベクトルのL2ノルムの2乗は各成分の2乗和なので、
$$
\frac{1}{2}\|\Phi\boldsymbol{\theta} - \mathbf{y}\|^2 = \frac{1}{2} \left[ (\theta_0 + 2\theta_1 - 4)^2 + (\theta_0 + 5\theta_1 - 7)^2 \right]
$$
これは各データの誤差二乗和 $\frac{1}{2} \sum_{i=1}^2 (\boldsymbol{\theta}^\top \boldsymbol{\phi}(x_i) - y_i)^2$ と完全に一致する。（証明終）

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

---

## 正則化（Regularization）

### L2ノルムの性質 {#q:3-l2-norm-properties .questionbox difficulty="★0"}

ベクトル $\mathbf{w} = (3, -4)^\top$ のL2ノルム $\|\mathbf{w}\|$ を計算し、それが自身との内積の平方根 $\sqrt{\mathbf{w}^\top \mathbf{w}}$ と等しいことを示せ。

::: {.right}
[（解答・解説へ）](#a:3-l2-norm-properties)
:::

### L2正則化付き目的関数の書き下し {#q:3-l2-regularization-objective .questionbox difficulty="★1"}

損失関数を二乗誤差、正則化項をL2ノルムの2乗とし、正則化係数を $\lambda = 0.01$ とする。 $n$ 個のデータに対するL2正則化付き経験リスク最小化の目的関数 $L_{\text{reg}}(\boldsymbol{\theta})$ の式をシグマ表記で書き下せ。

::: {.right}
[（解答・解説へ）](#a:3-l2-regularization-objective)
:::

### 行列による書き直しと一階の条件 {#q:3-l2-regularization-gradient .questionbox difficulty="★2"}

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

L2ノルムの計算：
$$
\|\mathbf{w}\| = \sqrt{3^2 + (-4)^2} = \sqrt{9 + 16} = \sqrt{25} = 5
$$
内積の平方根の計算：
$$
\mathbf{w}^\top \mathbf{w} = 3 \times 3 + (-4) \times (-4) = 9 + 16 = 25 \quad \Rightarrow \quad \sqrt{\mathbf{w}^\top \mathbf{w}} = 5
$$
よって $\|\mathbf{w}\| = \sqrt{\mathbf{w}^\top \mathbf{w}} = 5$ となり、一致する。

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

---

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

---

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

---

## 分位点（Quantile）と外れ値の影響

### 飛びのある分布の分位点とロバスト性 {#q:4-absolute-loss-mae .questionbox difficulty="★1"}

1. データセット $\{2, 3, 5, 7, 100\}$ の平均値と中央値を求めよ。
2. 外れ値の $100$ が $1000$ に化けたとする。このとき平均値と中央値はどう変化するか計算し、ピンボール損失（中央値の場合は絶対値損失）が外れ値に対して持つ優位性を説明せよ。

::: {.right}
[（解答・解説へ）](#a:4-absolute-loss-mae)
:::

### ピンボール損失のグラフ描写の理解 {#q:4-pinball-loss-calculation .questionbox difficulty="★1"}

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

---

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
について、チェインルール $\nabla_{\boldsymbol{\theta}} l = \frac{\partial l}{\partial z} \cdot \nabla_{\boldsymbol{\theta}} z$ を用いて、勾配ベクトルが
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

---

# 確率論的多値分類とソフトマックス回帰

## ソフトマックス関数と多クラス交差エントロピー

### ソフトマックス損失の勾配公式の導出 {#q:6-softmax-gradient-derivation .questionbox difficulty="★2"}

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
