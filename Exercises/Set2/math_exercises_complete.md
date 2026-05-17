---
title: "経営学への応用を目指すAI入門：数学演習問題集"
subtitle: "第1回〜第5回 講義内容完全準拠・論理展開追体験セット（完全版）"
author: "特殊講義1 補助資料"
date: "2026年5月"
geometry: margin=20mm
header-includes: |
  ```{=latex}
  \usepackage{amsmath,amssymb}
  \usepackage[most]{tcolorbox}
  \newcounter{question}[subsection]
  \newtcolorbox[use counter=question]{questionbox}[2][]{enhanced, breakable, colback=red!2!gray!3!white, colframe=red!50!gray, fonttitle=\bfseries, title={問\arabic{question}\ #2}, #1}
  \newtcolorbox{answerbox}[2][]{enhanced, breakable, colback=green!2!gray!3!white, colframe=green!45!gray, fonttitle=\bfseries, title={問\ref{#2}の解答・解説}, #1}
  ```
---

# 本演習問題集の進め方と活用法

本問題集は、講義スライドに登場する数式の「行間（省略された計算や証明）」を学生自身の手で動かして埋め、ブラックボックスを解消することを目的に設計されています。各セクションには講義スライドとの対応関係である**【該当内容】**と、その演習を行う目的である**【ねらい】**が記載されています。

また、各設問には以下の難易度が設定されています。

* **難易度：★0 (Basic)** ：スライドの定義そのものの確認や、直感的な代入問題。
* **難易度：★1 (Standard)** ：講義の数式展開を再現する標準的な手計算。
* **難易度：★2 (Advanced)** ：行列の微分や文字式による一般的な証明など、一歩進んだ数学的体力を要する問題。

---

# 【第1回】確率の基礎とリスク関数・ERM

## 1-1. 確率の基礎と期待値・分散の計算

\begin{questionbox}[label=q:1-1-1]{離散型確率分布での期待値・分散計算 \hfill \normalfont \small 難易度：★0}
ある離散確率変数 $X$ は、確率 $0.2$ で $0$、確率 $0.5$ で $1$、確率 $0.3$ で $2$ をとる。
(1) 期待値 $\mathbb{E}[X]$ を求めよ。
(2) $f(X) = X^2$ とするとき、その期待値 $\mathbb{E}[X^2]$ を求めよ。
(3) 公式 $\mathbb{V}[X] = \mathbb{E}[X^2] - (\mathbb{E}[X])^2$ を用いて分散 $\mathbb{V}[X]$ を計算せよ。

\hfill \hyperref[a:1-1-1]{\footnotesize [解答・解説へ]}
\end{questionbox}

\begin{questionbox}[label=q:1-1-2]{連続型確率分布での期待値・分散計算 \hfill \normalfont \small 難易度：★1}
連続確率変数 $X$ の確率密度関数が $p(x) = 2x \ (0 \le x \le 1)$ で与えられている（それ以外の範囲では $0$）。
(1) $\int_0^1 p(x) dx = 1$ （全確率が1）が満たされていることを示せ。
(2) 期待値 $\mathbb{E}[X] = \int_0^1 x p(x) dx$ を計算せよ。
(3) $\mathbb{E}[X^2] = \int_0^1 x^2 p(x) dx$ を計算し、分散 $\mathbb{V}[X]$ を求めよ。

\hfill \hyperref[a:1-1-2]{\footnotesize [解答・解説へ]}
\end{questionbox}

\begin{questionbox}[label=q:1-1-3]{共分散（Covariance）の2次形式的振る舞い \hfill \normalfont \small 難易度：★1}
確率変数 $X, Y, Z$ と定数 $a, b$ について、共分散の性質（双線形性） $Cov(aX+bY, Z) = a Cov(X,Z) + b Cov(Y,Z)$ および対称性 $Cov(X,Y) = Cov(Y,X)$ を用いて、次の式を展開せよ。
(1) $Cov(X, X+Y)$
(2) $\mathbb{V}[aX + bY]$ （ヒント：$\mathbb{V}[Z] = Cov(Z,Z)$ であることを利用せよ）

\hfill \hyperref[a:1-1-3]{\footnotesize [解答・解説へ]}
\end{questionbox}

### 1-1. の解答・解説
**【該当内容】** 第1回スライド34〜38「基本知識＞確率分布、期待値」
**【ねらい】** 期待値 $\mathbb{E}[\cdot]$ や分散 $\mathbb{V}[\cdot]$ の計算規則を、離散型・連続型の両面から手計算で確かめ、のちに登場する「リスク関数」の数学的実態を掴む。

\begin{answerbox}[label=a:1-1-1]{q:1-1-1}
(1) $\mathbb{E}[X] = 0 \times 0.2 + 1 \times 0.5 + 2 \times 0.3 = 0 + 0.5 + 0.6 = 1.1$
(2) $\mathbb{E}[X^2] = 0^2 \times 0.2 + 1^2 \times 0.5 + 2^2 \times 0.3 = 0 + 0.5 + 1.2 = 1.7$
(3) $\mathbb{V}[X] = 1.7 - (1.1)^2 = 1.7 - 1.21 = 0.49$

\hfill \hyperref[q:1-1-1]{\footnotesize [問題へ戻る]}
\end{answerbox}

\begin{answerbox}[label=a:1-1-2]{q:1-1-2}
(1) $\int_0^1 2x dx = \left[ x^2 \right]_0^1 = 1^2 - 0^2 = 1$ （証明終）
(2) $\mathbb{E}[X] = \int_0^1 x(2x) dx = \int_0^1 2x^2 dx = \left[ \frac{2}{3}x^3 \right]_0^1 = \frac{2}{3}$
(3) $\mathbb{E}[X^2] = \int_0^1 x^2(2x) dx = \int_0^1 2x^3 dx = \left[ \frac{1}{2}x^4 \right]_0^1 = \frac{1}{2}$
よって $\mathbb{V}[X] = \frac{1}{2} - \left(\frac{2}{3}\right)^2 = \frac{1}{2} - \frac{4}{9} = \frac{1}{18}$

\hfill \hyperref[q:1-1-2]{\footnotesize [問題へ戻る]}
\end{answerbox}

\begin{answerbox}[label=a:1-1-3]{q:1-1-3}
(1) $Cov(X, X+Y) = Cov(X,X) + Cov(X,Y) = \mathbb{V}[X] + Cov(X,Y)$
(2) $\mathbb{V}[aX+bY] = Cov(aX+bY, aX+bY)$
$= a^2 Cov(X,X) + ab Cov(X,Y) + ba Cov(Y,X) + b^2 Cov(Y,Y)$
対称性 $Cov(X,Y)=Cov(Y,X)$ より、
$= a^2 \mathbb{V}[X] + 2ab Cov(X,Y) + b^2 \mathbb{V}[Y]$
この展開の構造は、のちに行列やベクトルの内積（2次形式）を展開する際の論理構造と全く同じである。

\hfill \hyperref[q:1-1-3]{\footnotesize [問題へ戻る]}
\end{answerbox}

---

## 1-2. リスク関数と経験リスク

\begin{questionbox}[label=q:1-2-1]{分布が既知の場合の真のリスク関数 \hfill \normalfont \small 難易度：★1}
あるデータ生成分布において、入力 $X$ は常に $1$ で固定されており、ラベル $Y$ は確率 $0.6$ で $y=3$、確率 $0.4$ で $y=8$ をとるとする。予測器を定数 $c$ を出力するモデル $f(x)=c$ とし、損失関数を二乗誤差 $l(y, c) = (y-c)^2$ とする。
(1) このときの真のリスク関数 $R(c) = \mathbb{E}[l(Y, c)]$ の式を $c$ の関数として書き下せ。
(2) $c = 5$ のときの真のリスクの値を求めよ。

\hfill \hyperref[a:1-2-1]{\footnotesize [解答・解説へ]}
\end{questionbox}

\begin{questionbox}[label=q:1-2-2]{経験リスクの計算と予測値の代入 \hfill \normalfont \small 難易度：★0}
上記のデータ生成分布から、現実世界でランダムに $n=3$ 個のサンプルを収集したところ、偶然にも全て $y_1=3, y_2=3, y_3=3$ であったとする。
(1) この手元の標本に対する経験リスク $\hat{R}(c)$ の式を書き下せ。
(2) $c=5$ のときの経験リスクの値を計算し、問1の真のリスク値との違いを考察せよ。

\hfill \hyperref[a:1-2-2]{\footnotesize [解答・解説へ]}
\end{questionbox}

### 1-2. の解答・解説
**【該当内容】** 第1回スライド78〜86「予測系タスクの学習＞リスク関数、リスクの標本近似」
**【ねらい】** 未来のあらゆるデータを考慮した「真のリスク（期待値）」と、手元にあるデータから計算する「経験リスク（標本平均）」の関係を具体的に数値で比較し、そのギャップを理解する。

\begin{answerbox}[label=a:1-2-1]{q:1-2-1}
(1) $R(c) = 0.6 \times (3 - c)^2 + 0.4 \times (8 - c)^2$
(2) $c=5$ を代入すると、$R(5) = 0.6 \times (-2)^2 + 0.4 \times 3^2 = 2.4 + 3.6 = 6.0$

\hfill \hyperref[q:1-2-1]{\footnotesize [問題へ戻る]}
\end{answerbox}

\begin{answerbox}[label=a:1-2-2]{q:1-2-2}
(1) $\hat{R}(c) = \frac{1}{3} \sum_{i=1}^3 (y_i - c)^2 = \frac{1}{3} \left[ (3-c)^2 + (3-c)^2 + (3-c)^2 \right] = (3-c)^2$
(2) $c=5$ を代入すると、$\hat{R}(5) = (3-5)^2 = 4.0$
**【考察】** 真のリスク $R(5)=6.0$ に対し、経験リスクは $\hat{R}(5)=4.0$ となり大きく乖離している。これはデータ生成分布 $p(y)$ が未知で、手元のサンプリング（標本）に偏りがあるために生じる。機械学習では真のリスクが計算できないため、この経験リスクを代わりに最小化する（ERM）。

\hfill \hyperref[q:1-2-2]{\footnotesize [問題へ戻る]}
\end{answerbox}

---

## 1-3. ERM（経験リスク最小化）

\begin{questionbox}[label=q:1-3-1]{目的関数のパラメータ関数化 \hfill \normalfont \small 難易度：★0}
データポイント $(x_1, y_1) = (1, 2)$ および $(x_2, y_2) = (3, 4)$ がある。予測モデルを原点を通る直線 $f_\theta(x) = \theta x$ とし、損失関数を二乗誤差とする。このとき、経験リスク
$$\hat{R}(f_\theta) = \frac{1}{2} \sum_{i=1}^2 (y_i - f_\theta(x_i))^2$$
に具体的な数値を代入し、$\theta$ の2次関数 $A\theta^2 + B\theta + C$ の形に展開・整理せよ。

\hfill \hyperref[a:1-3-1]{\footnotesize [解答・解説へ]}
\end{questionbox}

### 1-3. の解答・解説
**【該当内容】** 第1回スライド86〜87「予測系タスクの学習＞経験リスク最小化（ERM）」
**【ねらい】** 経験リスクの式に具体的なモデル式を代入し、目的関数が「入力 $x$ の関数」から「最適化すべきパラメータ $\theta$ の関数」へと変貌する様子を確認する。

\begin{answerbox}[label=a:1-3-1]{q:1-3-1}
$$\hat{R}(\theta) = \frac{1}{2} \left[ (2 - \theta \cdot 1)^2 + (4 - \theta \cdot 3)^2 \right]$$
$$= \frac{1}{2} \left[ (4 - 4\theta + \theta^2) + (16 - 24\theta + 9\theta^2) \right]$$
$$= \frac{1}{2} (10\theta^2 - 28\theta + 20) = 5\theta^2 - 14\theta + 10$$
これによって、最適化（微分して最小値を求める）対象がパラメータ $\theta$ だけの関数になったことが示される。

\hfill \hyperref[q:1-3-1]{\footnotesize [問題へ戻る]}
\end{answerbox}

---

# 【第2回】最適化と最小二乗法・偏微分

## 2-1. 経験リスクの数式化（シグマを用いた書き下し）

\begin{questionbox}[label=q:2-1-1]{経験リスクの立式 \hfill \normalfont \small 難易度：★0}
$n$ 個の訓練データ $\{(x_i, y_i)\}_{i=1}^n$ が与えられている。モデルクラスとして1次関数 $f_{(w,b)}(x) = wx + b$ を採用し、損失関数を二乗誤差 $l(y, \hat{y}) = (y - \hat{y})^2$ とするとき、目的関数 $L(w,b)$ を $\sum_{i=1}^n$ を用いて書き下せ。

\hfill \hyperref[a:2-1-1]{\footnotesize [解答・解説へ]}
\end{questionbox}

\begin{questionbox}[label=q:2-1-2]{最適化問題の定式化：穴埋め \hfill \normalfont \small 難易度：★0}
以下の文章が意味する最適化問題を、数式（$\min$ または $\arg\min$ および $\text{subject to}$）を用いて書き下せ。
(1) 【制約なし】 パラメータ $\theta$ を調整して、目的関数 $L(\theta)$ を最小にする「パラメータそのもの $\hat{\theta}$」を求めたい。
(2) 【制約あり】 パラメーターの大きさ（ノルム） $\|\theta\|$ が、ある定数 $C$ を超えないという制約の条件下で、目的関数 $L(\theta)$ の「最小化」を行いたい。

\hfill \hyperref[a:2-1-2]{\footnotesize [解答・解説へ]}
\end{questionbox}

### 2-1. の解答・解説
**【該当内容】** 第2回スライド27〜37「予測系タスクの具体例＞線型単回帰、最小二乗法」
**【ねらい】** $n$ 個の一般的なデータ表記に対して、二乗損失を用いた経験リスクの正確な数式をシグマ $\sum$ を用いて構築できるようにする。

\begin{answerbox}[label=a:2-1-1]{q:2-1-1}
$$L(w,b) = \frac{1}{n} \sum_{i=1}^n (y_i - (wx_i + b))^2$$

\hfill \hyperref[q:2-1-1]{\footnotesize [問題へ戻る]}
\end{answerbox}

\begin{answerbox}[label=a:2-1-2]{q:2-1-2}
(1) $\hat{\theta} = \arg\min_{\theta} L(\theta)$ （最小値を与える変数を意味するため）
(2) $\min_{\theta} L(\theta) \quad \text{subject to} \quad \|\theta\| \le C$

\hfill \hyperref[q:2-1-2]{\footnotesize [問題へ戻る]}
\end{answerbox}

---

## 2-2. 最小二乗法の真髄：偏微分から一階の条件へ

\begin{questionbox}[label=q:2-2-1]{偏微分と勾配ベクトルの書き下し \hfill \normalfont \small 難易度：★1}
目的関数 $L(w,b) = \frac{1}{n} \sum_{i=1}^n (y_i - wx_i - b)^2$ とする。
(1) $L(w,b)$ を $w$ について偏微分した式 $\frac{\partial L}{\partial w}$ を求めよ。（合成関数の微分に注意せよ）
(2) $L(w,b)$ を $b$ について偏微分した式 $\frac{\partial L}{\partial b}$ を求めよ。
(3) 勾配ベクトル $\nabla L(w,b)$ の定義に従い、(1)(2)の結果を並べた列ベクトルを表記せよ。

\hfill \hyperref[a:2-2-1]{\footnotesize [解答・解説へ]}
\end{questionbox}

\begin{questionbox}[label=q:2-2-2]{一階の条件からの式変形 \hfill \normalfont \small 難易度：★2}
最適解において勾配ベクトルがゼロになるという一階の条件 $\nabla L(w,b) = \mathbf{0}$ のうち、$\frac{\partial L}{\partial b} = 0$ の式を変形し、最適な切片 $\hat{b}$ が、サンプルの平均値 $\bar{x} = \frac{1}{n}\sum_{i=1}^n x_i$, $\bar{y} = \frac{1}{n}\sum_{i=1}^n y_i$ を用いて $\hat{b} = \bar{y} - w\bar{x}$ と表せることを証明せよ。

\hfill \hyperref[a:2-2-2]{\footnotesize [解答・解説へ]}
\end{questionbox}

\begin{questionbox}[label=q:2-2-3]{学習済みパラメータによる新規データの予測 \hfill \normalfont \small 難易度：★0}
あるデータセットに対して最小二乗法を適用したところ、学習済みパラメータが $\hat{w} = 2.5, \hat{b} = 1.0$ と求まった。このとき、新規に観測された特徴量 $x_{\text{new}} = 6$ に対する予測値 $\hat{y}_{\text{new}}$ を計算せよ。

\hfill \hyperref[a:2-2-3]{\footnotesize [解答・解説へ]}
\end{questionbox}

### 2-2. の解答・解説
**【該当内容】** 第2回スライド38〜45「一階の条件、偏微分・勾配」
**【ねらい】** スライドで省略されている目的関数 $L(w,b)$ の偏微分から勾配ベクトルの構築、一階の条件による正規方程式のスカラ版の導出を完全に追体験する。

\begin{answerbox}[label=a:2-2-1]{q:2-2-1}
(1) 合成関数の微分（チェインルール）を用いる。カッコの中身を $w$ で微分した $-x_i$ が外に出る。
$$\frac{\partial L}{\partial w} = \frac{1}{n} \sum_{i=1}^n 2(y_i - wx_i - b) \cdot (-x_i) = -\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b)x_i$$
(2) 同様に、中身を $b$ で微分した $-1$ が外に出る。
$$\frac{\partial L}{\partial b} = \frac{1}{n} \sum_{i=1}^n 2(y_i - wx_i - b) \cdot (-1) = -\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b)$$
(3) 勾配ベクトルは偏微分を縦に並べたもの。
$$\nabla L(w,b) = \begin{pmatrix} \frac{\partial L}{\partial w} \\ \frac{\partial L}{\partial b} \end{pmatrix} = \begin{pmatrix} -\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b)x_i \\ -\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b) \end{pmatrix}$$

\hfill \hyperref[q:2-2-1]{\footnotesize [問題へ戻る]}
\end{answerbox}

\begin{answerbox}[label=a:2-2-2]{q:2-2-2}
一階の条件 $\frac{\partial L}{\partial b} = 0$ より、
$$-\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b) = 0$$
両辺を $-\frac{2}{n}$ で割り、和を分割する。
$$\sum_{i=1}^n y_i - w \sum_{i=1}^n x_i - \sum_{i=1}^n b = 0$$
定数 $b$ を $n$ 回足すと $nb$ になるので、
$$\sum_{i=1}^n y_i - w \sum_{i=1}^n x_i - nb = 0$$
両辺を $n$ で割ると、
$$\frac{1}{n}\sum y_i - w \frac{1}{n}\sum x_i - b = 0 \quad \Rightarrow \quad \bar{y} - w\bar{x} - b = 0$$
よって、$\hat{b} = \bar{y} - w\bar{x}$ が導かれる。（証明終）

\hfill \hyperref[q:2-2-2]{\footnotesize [問題へ戻る]}
\end{answerbox}

\begin{answerbox}[label=a:2-2-3]{q:2-2-3}
$\hat{y}_{\text{new}} = \hat{w}x_{\text{new}} + \hat{b} = 2.5 \times 6 + 1.0 = 15.0 + 1.0 = 16.0$

\hfill \hyperref[q:2-2-3]{\footnotesize [問題へ戻る]}
\end{answerbox}

---

# 【第3回】線型モデルの行列表現と正則化・モデル選択

## 3-1. ベクトルの内積と性質

\begin{questionbox}[label=q:3-1-1]{内積の計算と幾何的解釈 \hfill \normalfont \small 難易度：★0}
2つのベクトル $\mathbf{a} = (2, 3)^\top$, $\mathbf{b} = (-6, 4)^\top$ がある。
(1) 内積 $\mathbf{a}^\top \mathbf{b}$ を計算せよ。
(2) この2つのベクトルの幾何学的な位置関係（同じ方向、逆方向、直交のいずれか）を特定せよ。

\hfill \hyperref[a:3-1-1]{\footnotesize [解答・解説へ]}
\end{questionbox}

\begin{questionbox}[label=q:3-1-2]{射影成分の計算 \hfill \normalfont \small 難易度：★1}
大きさ（ノルム）が $1$ である方向ベクトル $\mathbf{u} = (1, 0)^\top$ がある。任意のベクトル $\mathbf{x} = (5, -3)^\top$ を $\mathbf{u}$ 方向の成分に射影したときの係数（射影の長さ）を内積を用いて計算せよ。

\hfill \hyperref[a:3-1-2]{\footnotesize [解答・解説へ]}
\end{questionbox}

\begin{questionbox}[label=q:3-1-3]{内積の線形性と対称性の証明 \hfill \normalfont \small 難易度：★1}
任意の次元のベクトル $\mathbf{x}, \mathbf{y}$ およびスカラー $c$ について、$\mathbf{x}^\top \mathbf{y} = \mathbf{y}^\top \mathbf{x}$ （対称性）および $(c\mathbf{x})^\top \mathbf{y} = c(\mathbf{x}^\top \mathbf{y})$ が成り立つことを、各成分を明示して確かめよ。

\hfill \hyperref[a:3-1-3]{\footnotesize [解答・解説へ]}
\end{questionbox}

### 3-1. の解答・解説
**【該当内容】** 第3回スライド22〜26「線型モデルの幾何学的解釈、内積の性質」
**【ねらい】** 機械学習における予測の基本演算である「内積」について、重み付き和、幾何的な向きの検出、射影という3つの側面を手計算を通じて習得する。

\begin{answerbox}[label=a:3-1-1]{q:3-1-1}
(1) $\mathbf{a}^\top \mathbf{b} = 2 \times (-6) + 3 \times 4 = -12 + 12 = 0$
(2) 内積が $0$ であるため、2つのベクトルは**直交している**。

\hfill \hyperref[q:3-1-1]{\footnotesize [問題へ戻る]}
\end{answerbox}

\begin{answerbox}[label=a:3-1-2]{q:3-1-2}
$\mathbf{x}^\top \mathbf{u} = 5 \times 1 + (-3) \times 0 = 5$。よって $\mathbf{u}$ 方向への射影の長さは $5$ である。

\hfill \hyperref[q:3-1-2]{\footnotesize [問題へ戻る]}
\end{answerbox}

\begin{answerbox}[label=a:3-1-3]{q:3-1-3}
$\mathbf{x} = (x_1, \dots, x_d)^\top, \mathbf{y} = (y_1, \dots, y_d)^\top$ とおくと、
$\mathbf{x}^\top \mathbf{y} = \sum_{i=1}^d x_i y_i$ 。実数の積は可換（$x_i y_i = y_i x_i$）なので、$\sum_{i=1}^d y_i x_i = \mathbf{y}^\top \mathbf{x}$。
また、$(c\mathbf{x})^\top \mathbf{y} = \sum_{i=1}^d (cx_i)y_i = c\sum_{i=1}^d x_i y_i = c(\mathbf{x}^\top \mathbf{y})$ （証明終）。

\hfill \hyperref[q:3-1-3]{\footnotesize [問題へ戻る]}
\end{answerbox}

---

## 3-2. パラメータ線型モデルの表現（特徴写像）

\begin{questionbox}[label=q:3-2-1]{多項式特徴写像による線型表現 \hfill \normalfont \small 難易度：★1}
1次元の入力 $x$ に対し、特徴写像を $\boldsymbol{\phi}(x) = (1, x, x^2)^\top$ と定義する。パラメータベクトルを $\boldsymbol{\theta} = (\theta_0, \theta_1, \theta_2)^\top$ とする。
(1) 内積によるモデル表現 $f(x) = \boldsymbol{\theta}^\top \boldsymbol{\phi}(x)$ を書き下せ。
(2) このモデルは、パラメータ $\boldsymbol{\theta}$ に着目すると何次式か。また、入力 $x$ に着目すると何次式か答えよ。

\hfill \hyperref[a:3-2-1]{\footnotesize [解答・解説へ]}
\end{questionbox}

\begin{questionbox}[label=q:3-2-2]{テキストデータへの適用（Bag-of-Words） \hfill \normalfont \small 難易度：★0}
語彙として「AI」「経営」「データ」の3語のみを考える。ある文書から抽出した頻度ベクトル（特徴写像）が $\boldsymbol{\phi} = (2, 0, 3)^\top$ であり、モデルの重みパラメータが $\boldsymbol{\theta} = (5, -2, 4)^\top$ のとき、この文書に対するスコア（内積）を計算せよ。

\hfill \hyperref[a:3-2-2]{\footnotesize [解答・解説へ]}
\end{questionbox}

### 3-2. の解答・解説
**【該当内容】** 第3回スライド27〜37「一般の線型モデル、特徴写像」
**【ねらい】** 「パラメータには線型（1次式）だが、入力データに対しては非線型」という機械学習モデルの柔軟性を、多項式写像やBag-of-Wordsなどの具体例を通じて体感する。

\begin{answerbox}[label=a:3-2-1]{q:3-2-1}
(1) $f(x) = \theta_0 \cdot 1 + \theta_1 \cdot x + \theta_2 \cdot x^2 = \theta_0 + \theta_1 x + \theta_2 x^2$
(2) パラメータ $\boldsymbol{\theta}$ に対しては**1次式（線型）**、入力 $x$ に対しては**2次式（非線型）**である。

\hfill \hyperref[q:3-2-1]{\footnotesize [問題へ戻る]}
\end{answerbox}

\begin{answerbox}[label=a:3-2-2]{q:3-2-2}
$\boldsymbol{\theta}^\top \boldsymbol{\phi} = 5 \times 2 + (-2) \times 0 + 4 \times 3 = 10 + 0 + 12 = 22$

\hfill \hyperref[q:3-2-2]{\footnotesize [問題へ戻る]}
\end{answerbox}

---

## 3-3. 最小二乗法の行列表記と一階の条件（最重要）

\begin{questionbox}[label=q:3-3-1]{行列とベクトルによる目的関数の書き直し \hfill \normalfont \small 難易度：★1}
$n=2$ 個のデータがあり、それぞれの特徴ベクトルと正解ラベルが、
$\boldsymbol{\phi}(x_1) = (1, 2)^\top, y_1 = 4$, $\boldsymbol{\phi}(x_2) = (1, 5)^\top, y_2 = 7$ である。
デザイン行列 $\Phi = \begin{pmatrix} \boldsymbol{\phi}(x_1)^\top \\ \boldsymbol{\phi}(x_2)^\top \end{pmatrix}$ およびラベルベクトル $\mathbf{y} = (y_1, y_2)^\top$ を具体的に数字で書き下し、目的関数 $L(\boldsymbol{\theta}) = \frac{1}{2} \|\Phi\boldsymbol{\theta} - \mathbf{y}\|^2$ が個別の二乗誤差の和 $\frac{1}{2}\sum_{i=1}^2 (y_i - \boldsymbol{\theta}^\top \boldsymbol{\phi}(x_i))^2$ と完全に等しいことを展開して確かめよ。

\hfill \hyperref[a:3-3-1]{\footnotesize [解答・解説へ]}
\end{questionbox}

\begin{questionbox}[label=q:3-3-2]{一階の条件の行列導出 \hfill \normalfont \small 難易度：★2}
行列微分の公式 $\nabla_{\boldsymbol{\theta}} (\mathbf{a}^\top \boldsymbol{\theta}) = \mathbf{a}$ および $\nabla_{\boldsymbol{\theta}} (\boldsymbol{\theta}^\top \mathbf{A} \boldsymbol{\theta}) = 2\mathbf{A}\boldsymbol{\theta}$ （$\mathbf{A}$は対称行列）を用いて、目的関数 $L(\boldsymbol{\theta}) = \frac{1}{2}(\Phi\boldsymbol{\theta} - \mathbf{y})^\top (\Phi\boldsymbol{\theta} - \mathbf{y})$ の勾配 $\nabla_{\boldsymbol{\theta}} L(\boldsymbol{\theta})$ を求め、一階の条件 $\nabla_{\boldsymbol{\theta}} L(\boldsymbol{\theta}) = \mathbf{0}$ から正規方程式 $\Phi^\top \Phi \boldsymbol{\theta} = \Phi^\top \mathbf{y}$ を導出せよ。

\hfill \hyperref[a:3-3-2]{\footnotesize [解答・解説へ]}
\end{questionbox}

### 3-3. の解答・解説
**【該当内容】** 第3回スライド38〜44「線型モデルの最小二乗法、行列による表記」
**【ねらい】** データの羅列をデザイン行列 $\Phi$ とラベルベクトル $\mathbf{y}$ にまとめ、目的関数をベクトルのノルムとしてスッキリ表現するテクニックと、その微分プロセスを完全にマスターする。

\begin{answerbox}[label=a:3-3-1]{q:3-3-1}
$\Phi = \begin{pmatrix} 1 & 2 \\ 1 & 5 \end{pmatrix}$, $\mathbf{y} = \begin{pmatrix} 4 \\ 7 \end{pmatrix}$ である。パラメータを $\boldsymbol{\theta} = (\theta_0, \theta_1)^\top$ とすると、
$$\Phi\boldsymbol{\theta} - \mathbf{y} = \begin{pmatrix} \theta_0 + 2\theta_1 - 4 \\ \theta_0 + 5\theta_1 - 7 \end{pmatrix}$$
ベクトルのL2ノルムの2乗は各成分の2乗和なので、
$$\frac{1}{2}\|\Phi\boldsymbol{\theta} - \mathbf{y}\|^2 = \frac{1}{2} \left[ (\theta_0 + 2\theta_1 - 4)^2 + (\theta_0 + 5\theta_1 - 7)^2 \right]$$
これは $\frac{1}{2} \sum_{i=1}^2 (\boldsymbol{\theta}^\top \boldsymbol{\phi}(x_i) - y_i)^2$ と等しい（証明終）。

\hfill \hyperref[q:3-3-1]{\footnotesize [問題へ戻る]}
\end{answerbox}

\begin{answerbox}[label=a:3-3-2]{q:3-3-2}
$L(\boldsymbol{\theta})$ の括弧を展開する。内積はスカラーので転置しても不変であるから、$\mathbf{y}^\top \Phi \boldsymbol{\theta} = (\mathbf{y}^\top \Phi \boldsymbol{\theta})^\top = \boldsymbol{\theta}^\top \Phi^\top \mathbf{y}$ となり、中央の項がまとめられる。
$$L(\boldsymbol{\theta}) = \frac{1}{2} \left[ \boldsymbol{\theta}^\top \Phi^\top \Phi \boldsymbol{\theta} - 2 (\Phi^\top \mathbf{y})^\top \boldsymbol{\theta} + \mathbf{y}^\top \mathbf{y} \right]$$
$\boldsymbol{\theta}$ で微分（勾配を計算）する。
$$\nabla_{\boldsymbol{\theta}} L(\boldsymbol{\theta}) = \frac{1}{2} \left[ 2 \Phi^\top \Phi \boldsymbol{\theta} - 2 \Phi^\top \mathbf{y} \right] = \Phi^\top \Phi \boldsymbol{\theta} - \Phi^\top \mathbf{y}$$
一階の条件より、$\Phi^\top \Phi \boldsymbol{\theta} - \Phi^\top \mathbf{y} = \mathbf{0} \Rightarrow \Phi^\top \Phi \boldsymbol{\theta} = \Phi^\top \mathbf{y}$ が導出された。

\hfill \hyperref[q:3-3-2]{\footnotesize [問題へ戻る]}
\end{answerbox}

---

## 3-4. 正則化（Regularization）

\begin{questionbox}[label=q:3-4-1]{L2ノルムの性質 \hfill \normalfont \small 難易度：★0}
ベクトル $\mathbf{w} = (3, -4)^\top$ のL2ノルム $\|\mathbf{w}\|$ を計算し、それが自身との内積の平方根 $\sqrt{\mathbf{w}^\top \mathbf{w}}$ と等しいことを示せ。

\hfill \hyperref[a:3-4-1]{\footnotesize [解答・解説へ]}
\end{questionbox}

\begin{questionbox}[label=q:3-4-2]{L2正則化付き目的関数の書き下し \hfill \normalfont \small 難易度：★1}
損失関数を二乗誤差、正則化項をL2ノルムの2乗とし、正則化係数を $\lambda = 0.01$ とする。 $n$ 個のデータに対するL2正則化付き経験リスク最小化の目的関数 $L_{\text{reg}}(\boldsymbol{\theta})$ の式をシグマ表記で書き下せ。

\hfill \hyperref[a:3-4-2]{\footnotesize [解答・解説へ]}
\end{questionbox}

\begin{questionbox}[label=q:3-4-3]{行列による書き直しと一階の条件 \hfill \normalfont \small 難易度：★2}
目的関数を $L_{\text{reg}}(\boldsymbol{\theta}) = \frac{1}{2}\|\Phi\boldsymbol{\theta} - \mathbf{y}\|^2 + \frac{\lambda}{2}\|\boldsymbol{\theta}\|^2$ とする。
全体の勾配を $\mathbf{0}$ と置く一階の条件から、最適解 $\hat{\boldsymbol{\theta}} = (\Phi^\top \Phi + \lambda \mathbf{I})^{-1}\Phi^\top \mathbf{y}$ を導出せよ。なぜ単位行列 $\mathbf{I}$ が必要なのか説明せよ（ただし逆行列は存在すると仮定する）。

\hfill \hyperref[a:3-4-3]{\footnotesize [解答・解説へ]}
\end{questionbox}

### 3-4. の解答・解説
**【該当内容】** 第3回スライド45〜50「過適合の対策＞正則化、L2正則化」
**【ねらい】** 過学習を防ぐL2正則化（Ridge）の目的関数について、代数表現と行列表現の一致を確かめ、単位行列 $I$ が出現する理由を数式変形で完全に理解する。

\begin{answerbox}[label=a:3-4-1]{q:3-4-1}
$\|\mathbf{w}\| = \sqrt{3^2 + (-4)^2} = \sqrt{9 + 16} = 5$
$\mathbf{w}^\top \mathbf{w} = 3(3) + (-4)(-4) = 25$。よって $\sqrt{25} = 5$ となり一致する。

\hfill \hyperref[q:3-4-1]{\footnotesize [問題へ戻る]}
\end{answerbox}

\begin{answerbox}[label=a:3-4-2]{q:3-4-2}
$$L_{\text{reg}}(\boldsymbol{\theta}) = \frac{1}{n} \sum_{i=1}^n (y_i - \boldsymbol{\theta}^\top \boldsymbol{\phi}(x_i))^2 + 0.01 \|\boldsymbol{\theta}\|^2$$

\hfill \hyperref[q:3-4-2]{\footnotesize [問題へ戻る]}
\end{answerbox}

\begin{answerbox}[label=a:3-4-3]{q:3-4-3}
$\|\boldsymbol{\theta}\|^2 = \boldsymbol{\theta}^\top \boldsymbol{\theta}$ より、$\nabla_{\boldsymbol{\theta}} (\frac{\lambda}{2} \boldsymbol{\theta}^\top \boldsymbol{\theta}) = \lambda \boldsymbol{\theta}$。
全体の勾配は、$\nabla_{\boldsymbol{\theta}} L_{\text{reg}} = \Phi^\top \Phi \boldsymbol{\theta} - \Phi^\top \mathbf{y} + \lambda \boldsymbol{\theta} = \mathbf{0}$。
$\boldsymbol{\theta}$ でくくる際、行列 $\Phi^\top \Phi$ とスカラー $\lambda$ は直接足せない。そのため $\lambda \boldsymbol{\theta} = \lambda \mathbf{I} \boldsymbol{\theta}$ と変換する。
$(\Phi^\top \Phi + \lambda \mathbf{I})\boldsymbol{\theta} = \Phi^\top \mathbf{y}$
左から逆行列を掛けて、$\hat{\boldsymbol{\theta}} = (\Phi^\top \Phi + \lambda \mathbf{I})^{-1}\Phi^\top \mathbf{y}$ となる。

\hfill \hyperref[q:3-4-3]{\footnotesize [問題へ戻る]}
\end{answerbox}

---

## 3-5. モデル選択（交差検証）

\begin{questionbox}[label=q:3-5-1]{K-foldとLOOCVのインデックス計算 \hfill \normalfont \small 難易度：★0}
(1) $n=6$ 個のデータを $K=3$ 個のフォルダ $\{D_1, D_2\}, \{D_3, D_4\}, \{D_5, D_6\}$ に分割する。第2イテレーション（$\{D_3, D_4\}$ が検証用）において、訓練に使用されるデータのインデックスをすべて答えよ。
(2) サンプルサイズが $n=100$ のデータにLOOCVを行う場合、モデルの学習は合計で何回実行されるか。

\hfill \hyperref[a:3-5-1]{\footnotesize [解答・解説へ]}
\end{questionbox}

### 3-5. の解答・解説
**【該当内容】** 第3回スライド51〜70「モデル選択、交差検証」
**【ねらい】** ハイパーパラメータ選択の手続きを、インデックス操作を通じて厳密に理解する。

\begin{answerbox}[label=a:3-5-1]{q:3-5-1}
(1) 訓練用インデックスは $\{1, 2, 5, 6\}$。
(2) LOOCVは検証用データを1つずつずらすため、学習は合計で $100$ 回実行される。

\hfill \hyperref[q:3-5-1]{\footnotesize [問題へ戻る]}
\end{answerbox}

---

# 【第4回】確率モデルと分位点回帰

## 4-1. 同時分布・条件付き分布・条件付き期待値

\begin{questionbox}[label=q:4-1-1]{同時確率表からの条件付き分布と期待値 \hfill \normalfont \small 難易度：★1}
離散変数 $X \in \{0,1\}$ と $Y \in \{1,2,3\}$ の同時確率 $P(X, Y)$ が与えられている。
$X=0$ のとき、$Y=1, 2, 3$ となる確率はそれぞれ $0.1, 0.2, 0.1$ である。
(1) $X=0$ となる周辺確率（正規化定数） $P(X=0)$ を求めよ。
(2) $X=0$ という条件のもとでの $Y$ の条件付き確率分布 $P(Y=y \mid X=0)$ を求めよ。
(3) 上記の分布を用いて、条件付き期待値 $\mathbb{E}[Y \mid X=0]$ を計算せよ。

\hfill \hyperref[a:4-1-1]{\footnotesize [解答・解説へ]}
\end{questionbox}

### 4-1. の解答・解説
**【該当内容】** 第4回スライド5〜18「基本知識＞同時確率分布、条件付き確率」
**【ねらい】** 条件付き確率・条件付き期待値を、クロス集計表の計算から完全に理解する。

\begin{answerbox}[label=a:4-1-1]{q:4-1-1}
(1) $P(X=0) = 0.1 + 0.2 + 0.1 = 0.4$
(2) $P(Y=1 \mid X=0) = \frac{0.1}{0.4} = 0.25$, $P(Y=2 \mid X=0) = \frac{0.2}{0.4} = 0.50$, $P(Y=3 \mid X=0) = \frac{0.1}{0.4} = 0.25$
(3) $\mathbb{E}[Y \mid X=0] = 1 \times 0.25 + 2 \times 0.50 + 3 \times 0.25 = 0.25 + 1.0 + 0.75 = 2.0$

\hfill \hyperref[q:4-1-1]{\footnotesize [問題へ戻る]}
\end{answerbox}

---

## 4-2. 分位点（Quantile）と外れ値の影響

\begin{questionbox}[label=q:4-2-1]{飛びのある分布の分位点とロバスト性 \hfill \normalfont \small 難易度：★1}
(1) データセット $\{2, 3, 5, 7, 100\}$ の平均値と中央値を求めよ。
(2) 外れ値の $100$ が $1000$ に化けたとする。このとき平均値と中央値はどう変化するか計算し、ピンボール損失（中央値の場合は絶対値損失）が外れ値に対して持つ優位性を説明せよ。

\hfill \hyperref[a:4-2-1]{\footnotesize [解答・解説へ]}
\end{questionbox}

\begin{questionbox}[label=q:4-2-2]{ピンボール損失のグラフ描写の理解 \hfill \normalfont \small 難易度：★1}
ピンボール損失関数 $l_\alpha(y, y') = (\alpha - 1)(y - y')$ (if $y - y' < 0$), $\alpha(y - y')$ (if $y - y' \ge 0$) について、$\alpha = 0.3$ とする。誤差 $e = y - y'$ が $e = -2$ のときと $e = 4$ のときの損失の値をそれぞれ計算し、グラフの形状を説明せよ。

\hfill \hyperref[a:4-2-2]{\footnotesize [解答・解説へ]}
\end{questionbox}

### 4-2. の解答・解説
**【該当内容】** 第4回スライド19〜35「分位点回帰、ピンボール損失」
**【ねらい】** 平均値が外れ値に引っ張られやすいのに対し、分位点（中央値など）が頑健（ロバスト）である理由を、実際のデータ操作を通じて数式ベースで理解する。

\begin{answerbox}[label=a:4-2-1]{q:4-2-1}
(1) 平均値 $= 117 / 5 = 23.4$。中央値 $= 5$。
(2) 新平均値 $= 1017 / 5 = 203.4$。新中央値 $= 5$。
**【優位性】** 二乗誤差による平均値は外れ値に極端に引っ張られるが、絶対誤差による中央値は「自分より右か左か」しか見ないため外れ値に頑健（ロバスト）である。

\hfill \hyperref[q:4-2-1]{\footnotesize [問題へ戻る]}
\end{answerbox}

\begin{answerbox}[label=a:4-2-2]{q:4-2-2}
$e = -2 < 0$ のとき： $l_{0.3} = (0.3 - 1) \times (-2) = (-0.7) \times (-2) = 1.4$
$e = 4 \ge 0$ のとき： $l_{0.3} = 0.3 \times 4 = 1.2$
グラフは $e=0$ を境に、負の領域では傾き $-0.7$、正の領域では傾き $0.3$ の非対称なV字型となる。

\hfill \hyperref[q:4-2-2]{\footnotesize [問題へ戻る]}
\end{answerbox}

---

# 【第5回】確率論的二値分類と非線型最適化

## 5-1. ロジスティック関数の微分と交差エントロピー

\begin{questionbox}[label=q:5-1-1]{シグモイド関数の微分証明 \hfill \normalfont \small 難易度：★2}
ロジスティック関数（シグモイド関数） $\sigma(z) = \frac{1}{1 + e^{-z}}$ について、
(1) 商の微分公式を用いて $\sigma'(z) = \sigma(z)(1 - \sigma(z))$ になることを証明せよ。
(2) 合成関数の微分則を用いて $\frac{d}{dz} \log \sigma(z) = 1 - \sigma(z)$ が成り立つことを示せ。

\hfill \hyperref[a:5-1-1]{\footnotesize [解答・解説へ]}
\end{questionbox}

\begin{questionbox}[label=q:5-1-2]{交差エントロピーとチェインルール \hfill \normalfont \small 難易度：★2}
(1) 尤度関数（確率の積）ではなく、$\log$ をとって対数尤度を最小化（最大化）する計算機上の理由を説明せよ。
(2) 交差エントロピー損失 $l = -y \log \sigma(z) - (1-y) \log(1 - \sigma(z))$ （ただし $z = \boldsymbol{\theta}^\top \boldsymbol{\phi}(x)$）について、チェインルール $\nabla_{\boldsymbol{\theta}} l = \frac{\partial l}{\partial z} \cdot \nabla_{\boldsymbol{\theta}} z$ を用いて、勾配ベクトルが $\nabla_{\boldsymbol{\theta}} l = (\sigma(z) - y)\boldsymbol{\phi}(x)$ となることを導出せよ。

\hfill \hyperref[a:5-1-2]{\footnotesize [解答・解説へ]}
\end{questionbox}

### 5-1. の解答・解説
**【該当内容】** 第5回スライド50〜89「確率論的二値分類、交差エントロピー、勾配の導出」
**【ねらい】** 天下り的に与えられるシグモイド関数の微分公式を自力で完全に導出し、交差エントロピー損失のパラメータ微分（チェインルール）を実行して、アルゴリズムの動作を数式で裏付ける。

\begin{answerbox}[label=a:5-1-1]{q:5-1-1}
(1) $g(z) = 1 + e^{-z}$ とおくと、$g'(z) = -e^{-z}$。
$\frac{d}{dz}\sigma(z) = - \frac{-e^{-z}}{(1 + e^{-z})^2} = \frac{e^{-z}}{(1 + e^{-z})^2} = \left( \frac{1}{1 + e^{-z}} \right) \left( \frac{e^{-z}}{1 + e^{-z}} \right)$
分子に $1 - 1$ を補うと、$\frac{1 + e^{-z} - 1}{1 + e^{-z}} = 1 - \frac{1}{1 + e^{-z}} = 1 - \sigma(z)$。よって $\sigma(z)(1 - \sigma(z))$ （証明終）。
(2) $(\log \sigma(z))' = \frac{1}{\sigma(z)} \sigma'(z) = \frac{\sigma(z)(1 - \sigma(z))}{\sigma(z)} = 1 - \sigma(z)$ （証明終）。

\hfill \hyperref[q:5-1-1]{\footnotesize [問題へ戻る]}
\end{answerbox}

\begin{answerbox}[label=a:5-1-2]{q:5-1-2}
(1) 確率（$1$未満）を掛け続けると値がゼロに近づき、計算機内でアンダーフロー（情報落ち）を起こすため。$\log$ を取れば和に変換でき、数値的安定性と微分の容易さが得られる。
(2) $\frac{\partial l}{\partial z} = -y \frac{\partial}{\partial z}(\log \sigma(z)) - (1-y) \frac{\partial}{\partial z}(\log(1 - \sigma(z)))$
問1(2)の結果等を利用すると、
$\frac{\partial l}{\partial z} = -y(1 - \sigma(z)) - (1-y)(-\sigma(z)) = -y + y\sigma(z) + \sigma(z) - y\sigma(z) = \sigma(z) - y$
$\nabla_{\boldsymbol{\theta}} z = \boldsymbol{\phi}(x)$ なので、これらを掛け合わせて $\nabla_{\boldsymbol{\theta}} l = (\sigma(z) - y)\boldsymbol{\phi}(x)$ となる（証明終）。

\hfill \hyperref[q:5-1-2]{\footnotesize [問題へ戻る]}
\end{answerbox}
