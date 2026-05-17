---
title: "経営学への応用を目指すAI入門：数学演習問題集"
subtitle: "第1回〜第5回 講義内容完全準拠・論理展開追体験セット"
author: "特殊講義1 補助資料"
date: "2026年5月"
geometry: margin=20mm
header-includes:
  - \usepackage{amsmath,amssymb}
  - \usepackage{booktabs}
  - \usepackage{graphicx}
  - \font\busans=cmss10
---

# 本演習問題集の進め方と活用法

本問題集は、講義スライドに登場する数式の「行間（省略された計算や証明）」を学生自身の手で動かして埋め、ブラックボックスを解消することを目的に設計されています。各問題にはスライドとの対応関係、および以下の難易度が設定されています。

* **難易度：★0 (Basic)** ：スライドの定義そのものの確認や、直感的な代入問題。
* **難易度：★1 (Standard)** ：講義の数式展開を再現する標準的な手計算。
* **難易度：★2 (Advanced)** ：行列の微分や文字式による一般的な証明など、一歩進んだ数学的体力を要する問題。

---

# 【第1回】確率の基礎とリスク関数・ERM

## 1-1. 確率の基礎と期待値・分散の計算
**【該当内容】第1回スライド34〜38「基本知識＞確率分布、期待値」**
**【狙い】** 期待値 $\mathbb{E}[\cdot]$ や分散 $\mathbb{V}[\cdot]$ の計算規則を、離散型・連続型の両面から手計算で確かめ、のちに登場する「リスク関数」の数学的実態を掴む。

### [問1] 離散型確率分布での期待値・分散計算（難易度：★0）
ある離散確率変数 $X$ の確率分布が以下のように与えられている。
| $x$ | $0$ | $1$ | $2$ |
| :---: | :---: | :---: | :---: |
| $P(X=x)$ | $0.2$ | $0.5$ | $0.3$ |

(1) 期待値 $\mathbb{E}[X]$ を求めよ。
(2) $f(X) = X^2$ とするとき、その期待値 $\mathbb{E}[X^2]$ を求めよ。
(3) 公式 $\mathbb{V}[X] = \mathbb{E}[X^2] - (\mathbb{E}[X])^2$ を用いて分散 $\mathbb{V}[X]$ を計算せよ。

### [問2] 連続型確率分布での期待値・分散計算（難易度：★1）
連続確率変数 $X$ の確率密度関数が $p(x) = 2x \ (0 \le x \le 1)$ で与えられている（それ以外の範囲では $0$）。
(1) $\int_0^1 p(x) dx = 1$ （全確率が1）が満たされていることを示せ。
(2) 期待値 $\mathbb{E}[X] = \int_0^1 x p(x) dx$ を計算せよ。
(3) $\mathbb{E}[X^2] = \int_0^1 x^2 p(x) dx$ を計算し、分散 $\mathbb{V}[X]$ を求めよ。

### [問3] 共分散（Covariance）の2次形式的振る舞い（難易度：★1）
**【添付画像：期待値・分散・共分散の性質の統合】**
確率変数 $X, Y, Z$ と定数 $a, b$ について、共分散の性質（双線形性） $Cov(aX+bY, Z) = a Cov(X,Z) + b Cov(Y,Z)$ および $Cov(X,Y) = Cov(Y,X)$ を用いて、次の式を展開せよ。
(1) $Cov(X, X+Y)$
(2) $\mathbb{V}[aX + bY]$ （ヒント：$\mathbb{V}[Z] = Cov(Z,Z)$ であることを利用せよ）

---

### 【解答・解説】
#### [問1]
(1) $\mathbb{E}[X] = 0 \times 0.2 + 1 \times 0.5 + 2 \times 0.3 = 0 + 0.5 + 0.6 = 1.1$
(2) $\mathbb{E}[X^2] = 0^2 \times 0.2 + 1^2 \times 0.5 + 2^2 \times 0.3 = 0 + 0.5 + 1.2 = 1.7$
(3) $\mathbb{V}[X] = 1.7 - (1.1)^2 = 1.7 - 1.21 = 0.49$

#### [問2]
(1) $\int_0^1 2x dx = \left[ x^2 \right]_0^1 = 1^2 - 0^2 = 1$ （証明終）
(2) $\mathbb{E}[X] = \int_0^1 x(2x) dx = \int_0^1 2x^2 dx = \left[ \frac{2}{3}x^3 \right]_0^1 = \frac{2}{3}$
(3) $\mathbb{E}[X^2] = \int_0^1 x^2(2x) dx = \int_0^1 2x^3 dx = \left[ \frac{1}{2}x^4 \right]_0^1 = \frac{1}{2}$
$\mathbb{V}[X] = \frac{1}{2} - \left(\frac{2}{3}\right)^2 = \frac{1}{2} - \frac{4}{9} = \frac{1}{18}$

#### [問3]
(1) $Cov(X, X+Y) = Cov(X,X) + Cov(X,Y) = \mathbb{V}[X] + Cov(X,Y)$
(2) $\mathbb{V}[aX+bY] = Cov(aX+bY, aX+bY) = a^2 Cov(X,X) + ab Cov(X,Y) + ba Cov(Y,X) + b^2 Cov(Y,Y)$
対称性 $Cov(X,Y)=Cov(Y,X)$ より、$= a^2 \mathbb{V}[X] + 2ab Cov(X,Y) + b^2 \mathbb{V}[Y]$

---

## 1-2. リスク関数と経験リスク
**【該当内容】第1回スライド78〜86「予測系タスクの学習＞リスク関数、リスクの標本近似」**
**【狙い】** 未来のあらゆるデータを考慮した「真のリスク（期待値）」と、手元にあるデータから計算する「経験リスク（標本平均）」の関係を具体的に数値で比較し、そのギャップを理解する。

### [問1] 分布が既知の場合の真のリスク関数（難易度：★1）
あるデータ生成分布において、入力 $X$ は常に $1$ で固定されており、ラベル $Y$ は確率 $0.7$ で $y=2$、確率 $0.3$ で $y=12$ をとるとする。予測器を定数 $c$ を出力するモデル $f(x)=c$ とし、損失関数を二乗誤差 $l(y, c) = (y-c)^2$ とする。
(1) このときの真のリスク関数 $R(c) = \mathbb{E}[l(Y, c)]$ の式を $c$ の関数として書き下せ。
(2) $c = 4$ のときの真のリスクの値を求めよ。

### [問2] 経験リスクの計算と予測値の代入（難易度：★0）
上記のデータ生成分布から、現実世界でランダムに $n=3$ 個のサンプルを収集したところ、偶然にも全て $y_1=2, y_2=2, y_3=2$ であったとする。
(1) この手元の標本に対する経験リスク $\hat{R}(c)$ の式を書き下せ。
(2) $c=4$ のときの経験リスクの値を計算し、問1(2)の真のリスク値との違いを考察せよ。

---

### 【解答・解説】
#### [問1]
(1) $R(c) = 0.7 \times (2-c)^2 + 0.3 \times (12-c)^2$
(2) $c=4$ を代入する。
$R(4) = 0.7 \times (2-4)^2 + 0.3 \times (12-4)^2 = 0.7 \times 4 + 0.3 \times 64 = 2.8 + 19.2 = 22.0$

#### [問2]
(1) $\hat{R}(c) = \frac{1}{3} \sum_{i=1}^3 (y_i - c)^2 = \frac{1}{3} \left[ (2-c)^2 + (2-c)^2 + (2-c)^2 \right] = (2-c)^2$
(2) $c=4$ を代入すると、$\hat{R}(4) = (2-4)^2 = 4.0$
**【考察】** 真のリスク $R(4)=22.0$ に対し、経験リスクは $\hat{R}(4)=4.0$ となり大きく乖離している。これはデータ生成分布 $p(y)$ が未知で、手元のサンプリング（標本）に偏りがあるために生じる。機械学習では真のリスクが計算できないため、この経験リスクを代わりに最小化する（ERM）。

---

## 1-3. ERM（経験リスク最小化）
**【該当内容】第1回スライド86〜87「予測系タスクの学習＞経験リスク最小化（ERM）」**
**【狙い】** 経験リスクの式に具体的なモデル式を代入し、目的関数が「入力 $x$ の関数」から「最適化すべきパラメータ $	heta$ の関数」へと変貌する様子を確認する。

### [問1] 目的関数のパラメータ関数化（難易度：★0）
2つの訓練データ $(x_1, y_1) = (1, 3)$, $(x_2, y_2) = (2, 5)$ がある。予測モデルを原点を通る直線 $f_\theta(x) = \theta x$ とし、損失関数を二乗誤差とする。このとき、経験リスク
$$\hat{R}(f_\theta) = \frac{1}{2} \sum_{i=1}^2 (y_i - f_\theta(x_i))^2$$
に具体的な数値を代入し、$\theta$ の関数 $\hat{R}(\theta) = A\theta^2 + B\theta + C$ の形に整理せよ。

---

### 【解答・解説】
#### [問1]
$$\hat{R}(\theta) = \frac{1}{2} \left[ (3 - \theta \cdot 1)^2 + (5 - \theta \cdot 2)^2 \right]$$
$$= \frac{1}{2} \left[ (9 - 6\theta + \theta^2) + (25 - 20\theta + 4\theta^2) \right] = \frac{1}{2} (5\theta^2 - 26\theta + 34) = 2.5\theta^2 - 13\theta + 17$$
これによって、最適化（微分して最小値を求める）対象がパラメータ $\theta$ になったことが示される。

---
---

# 【第2回】最適化と最小二乗法・偏微分

## 2-1. 経験リスクのシグマ書き下しと定式化
**【該当内容】第2回スライド27〜37「予測系タスクの具体例＞線型単回帰、最小二乗法」**
**【狙い】** $n$ 個の一般的なデータ表記に対して、二乗損失を用いた経験リスクの正確な数式をシグマ $\sum$ を用いて構築できるようにする。

### [問1] 経験リスクの立式（難易度：★0）
$n$ 個の訓練データ $\{(x_i, y_i)\}_{i=1}^n$ が与えられている。モデルクラスとして1次関数 $f_{(w,b)}(x) = wx + b$ を採用し、損失関数を二乗誤差とする。このとき、学習の目的関数となる経験リスク $L(w,b)$ をシグマ記号を用いて書き下せ。

### [問2] 最適化問題の定式化：穴埋め（難易度：★0）
以下のそれぞれの要件を意味する最適化問題の数式について、空欄 [ A ] 〜 [ D ] に当てはまる数式記号（$\min, \arg\min$ など）や条件を答えよ。
(1) 【制約なし】 パラメータ $\theta$ を調整して、目的関数 $L(\theta)$ を最小にする「パラメータそのもの $\hat{\theta}$」を求めたい。
$$\hat{\theta} = \underline{\quad [\text{ A }] \quad}_{\theta} L(\theta)$$
(2) 【制約あり】 パラメーターの大きさ（ノルム） $\|\theta\|$ が、ある定数 $C$ を超えないという制約の条件下で、目的関数 $L(\theta)$ の「最小値そのもの」を求めたい。
$$\underline{\quad [\text{ B }] \quad}_{\theta} L(\theta) \quad \underline{\quad [\text{ C }] \quad} \quad [\text{ D }]$$

---

### 【解答・解説】
#### [問1]
$$L(w,b) = \frac{1}{n} \sum_{i=1}^n (y_i - (wx_i + b))^2$$

#### [問2]
[ A ] $\arg\min$ （最小値を与える変数を意味するため）
[ B ] $\min$ （最小値そのものを意味するため）
[ C ] $\text{subject to}$ （または $\text{s.t.}$ , 条件を示す）
[ D ] $\|\theta\| \le C$

---

## 2-2. 1次関数モデルの最小二乗解と偏微分・勾配
**【該当内容】第2回スライド38〜45「一階の条件、偏微分・勾配」**
**【狙い】** スライドで省略されている、2変数関数 $L(w,b)$ の偏微分の実行から勾配ベクトルの構築、そして一階の条件を用いたパラメータの具体的な導出プロセスを完全に追体験する。

### [問1] 偏微分と勾配ベクトルの書き下し（難易度：★1）
目的関数 $L(w,b) = \frac{1}{n} \sum_{i=1}^n (y_i - wx_i - b)^2$ とする。
(1) $L(w,b)$ を $w$ で偏微分した式 $\frac{\partial L}{\partial w}$ を求めよ。（合成関数の微分に注意せよ）
(2) $L(w,b)$ を $b$ で偏微分した式 $\frac{\partial L}{\partial b}$ を求めよ。
(3) 勾配ベクトル $\nabla L(w,b)$ の定義に従い、(1)(2)の結果を並べた列ベクトルを表記せよ。

### [問2] 勾配を使った一階の条件と式変形（難易度：★2）
最適解において勾配ベクトルがゼロベクトルになるという一階の条件 $\nabla L(w,b) = \mathbf{0}$ を考える。
(1) 一階の条件から導かれる $w, b$ に関する連立方程式（正規方程式のスカラ版）を書き下せ。
(2) $\frac{\partial L}{\partial b} = 0$ の式を変形して、最適な切片 $\hat{b}$ が、サンプルの平均値 $\bar{x} = \frac{1}{n}\sum_{i=1}^n x_i$, $\bar{y} = \frac{1}{n}\sum_{i=1}^n y_i$ を用いて $\hat{b} = \bar{y} - w\bar{x}$ と表せることを証明せよ。

### [問3] 学習済みパラメータによる新規データの予測（難易度：★0）
あるデータセットに対して最小二乗法を適用したところ、学習済みパラメータが $\hat{w} = 2.5, \hat{b} = 1.0$ と求まった。このとき、新規に観測された特徴量 $x_{\text{new}} = 6$ に対する予測値 $\hat{y}_{\text{new}}$ を計算せよ。

---

### 【解答・解説】
#### [問1]
(1) カッコの2乗の微分なので、$2(y_i - wx_i - b)$ に、中身を $w$ で微分した $-x_i$ が掛け合わされる。
$$\frac{\partial L}{\partial w} = \frac{1}{n} \sum_{i=1}^n 2(y_i - wx_i - b) \cdot (-x_i) = -\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b)x_i$$
(2) 同様に、中身を $b$ で微分した $-1$ が掛け合わされる。
$$\frac{\partial L}{\partial b} = \frac{1}{n} \sum_{i=1}^n 2(y_i - wx_i - b) \cdot (-1) = -\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b)$$
(3) $\nabla L(w,b) = \begin{pmatrix} \frac{\partial L}{\partial w} \\ \frac{\partial L}{\partial b} \end{pmatrix} = \begin{pmatrix} -\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b)x_i \\ -\frac{2}{n} \sum_{i=1}^n (y_i - wx_i - b) \end{pmatrix}$

#### [問2]
(1) $\nabla L(w,b) = \begin{pmatrix} 0 \\ 0 \end{pmatrix}$ より、以下の連立方程式を得る。
$$\begin{cases} \sum_{i=1}^n (y_i - wx_i - b)x_i = 0 \\ \sum_{i=1}^n (y_i - wx_i - b) = 0 \end{cases}$$
(2) 2つ目の式を展開する。
$$\sum_{i=1}^n y_i - w \sum_{i=1}^n x_i - \sum_{i=1}^n b = 0$$
定数 $b$ を $n$ 回足すと $nb$ となるので、$\sum_{i=1}^n y_i - w \sum_{i=1}^n x_i - nb = 0$。
両辺を $n$ で割ると、$\bar{y} - w\bar{x} - b = 0$。よって $\hat{b} = \bar{y} - w\bar{x}$ （証明終）。

#### [問3]
$\hat{y}_{\text{new}} = \hat{w}x_{\text{new}} + \hat{b} = 2.5 \times 6 + 1.0 = 15.0 + 1.0 = 16.0$

---
---

# 【第3回】線型モデルの行列表現と正則化・モデル選択

## 3-1. ベクトルの内積と性質
**【該当内容】第3回スライド22〜26「線型モデルの幾何学的解釈、内積の性質」**
**【狙い】** 機械学習における予測の基本演算である「内積」について、重み付き和、幾何的な向きの検出、射影という3つの側面を手計算を通じて習得する。

### [問1] 内積の計算と幾何的解釈（難易度：★0）
**【添付画像：内積・ノルムの性質の統合】**
2つのベクトル $\mathbf{a} = \begin{pmatrix} 2 \\ 3 \end{pmatrix}$, $\mathbf{b} = \begin{pmatrix} -6 \\ 4 \end{pmatrix}$ がある。
(1) 内積 $\mathbf{a}^\top \mathbf{b}$ を計算せよ。
(2) この2つのベクトルの幾何学的な位置関係（同じ方向、逆方向、直交のいずれか）を理由とともに特定せよ。

### [問2] 射影成分の計算（難易度：★1）
大きさ（ノルム）が $1$ である方向ベクトル $\mathbf{u} = \begin{pmatrix} 1 \\ 0 \end{pmatrix}$ がある。任意のベクトル $\mathbf{x} = \begin{pmatrix} 5 \\ -3 \end{pmatrix}$ を $\mathbf{u}$ 方向の成分に射影したときの係数（射影の長さ）を内積 $\mathbf{x}^\top \mathbf{u}$ を用いて計算せよ。

### [問3] 内積の線形性と対称性の証明（難易度：★1）
任意の次元のベクトル $\mathbf{x}, \mathbf{y}, \mathbf{z}$ およびスカラー $c$ について、$\mathbf{x}^\top \mathbf{y} = \mathbf{y}^\top \mathbf{x}$ （対称性）および $(c\mathbf{x})^\top \mathbf{y} = c(\mathbf{x}^\top \mathbf{y})$ が成り立つことを、各成分を明示して確かめよ。

---

### 【解答・解説】
#### [問1]
(1) $\mathbf{a}^\top \mathbf{b} = 2 \times (-6) + 3 \times 4 = -12 + 12 = 0$
(2) 内積が $0$ であるため、2つのベクトルは**「直交している」**。

#### [問2]
$\mathbf{x}^\top \mathbf{u} = 5 \times 1 + (-3) \times 0 = 5$。よって $\mathbf{u}$ 方向への射影の大きさは $5$ である。

#### [問3]
$\mathbf{x} = (x_1, \dots, x_d)^	op, \mathbf{y} = (y_1, \dots, y_d)^	op$ とおくと、
$\mathbf{x}^\top \mathbf{y} = \sum_{i=1}^d x_i y_i$ 。実数の積は可換（$x_i y_i = y_i x_i$）なので、$\sum_{i=1}^d y_i x_i = \mathbf{y}^\top \mathbf{x}$。
また、$(c\mathbf{x})^\top \mathbf{y} = \sum_{i=1}^d (cx_i)y_i = c\sum_{i=1}^d x_i y_i = c(\mathbf{x}^\top \mathbf{y})$ （証明終）。

---

## 3-2. パラメータ線型モデルの表現（特徴写像）
**【該当内容】第3回スライド27〜37「一般の線型モデル、特徴写像」**
**【狙い】** 「パラメータには線型（1次式）だが、入力データに対しては非線型」という機械学習モデルの柔軟性を、多項式写像やBag-of-Wordsなどの具体例を通じて体感する。

### [問1] 多項式特徴写像による線型表現（難易度：★1）
1次元の入力 $x$ に対し、特徴写像を $\boldsymbol{\phi}(x) = \begin{pmatrix} 1 \\ x \\ x^2 \end{pmatrix}$ と定義する。パラメータベクトルを $\boldsymbol{\theta} = \begin{pmatrix} \theta_0 \\ \theta_1 \\ \theta_2 \end{pmatrix}$ とする。
(1) 内積によるモデル表現 $f(x) = \boldsymbol{\theta}^\top \boldsymbol{\phi}(x)$ を書き下せ。
(2) このモデルは、パラメータ $\boldsymbol{\theta}$ に着目すると何次式か。また、入力 $x$ に着目すると何次式か答えよ。

### [問2] テキストデータへの適用（Bag-of-Words）（難易度：★0）
語彙として「AI」「経営」「データ」の3語のみを考える。ある文書から抽出した頻度ベクトル（特徴写像）が $\boldsymbol{\phi}(\text{文書}) = \begin{pmatrix} 2 \\ 0 \\ 3 \end{pmatrix}$ であり、モデルの重みパラメータが $\boldsymbol{\theta} = \begin{pmatrix} 5 \\ -2 \\ 4 \end{pmatrix}$（3つ目はバイアスではなく『データ』の重み）のとき、この文書に対するスコア（内積）を計算せよ。

---

### 【解答・解説】
#### [問1]
(1) $f(x) = \theta_0 \cdot 1 + \theta_1 \cdot x + \theta_2 \cdot x^2 = \theta_0 + \theta_1 x + \theta_2 x^2$
(2) パラメータ $\boldsymbol{\theta}$ に対着目すると**1次式（線型）**、入力 $x$ に着目すると**2次式（非線型）**である。
**【解説】** これが「パラメータ線型モデル」の真意である。特徴写像 $\boldsymbol{\phi}$ を高度に設計すれば、線型モデルの計算枠組みのまま、複雑な曲線を学習できる。

#### [問2]
$\boldsymbol{\theta}^\top \boldsymbol{\phi}(\text{文書}) = 5 \times 2 + (-2) \times 0 + 4 \times 3 = 10 + 0 + 12 = 22$

---

## 3-3. 最小二乗法の行列表記と一階の条件（最重要）
**【該当内容】第3回スライド38〜44「線型モデルの最小二乗法、行列による表記」**
**【狙い】** データの羅列をデザイン行列 $\Phi$ とラベルベクトル $\mathbf{y}$ にまとめ、目的関数をベクトルのノルムとしてスッキリ表現するテクニックと、その微分プロセスを完全にマスターする。

### [問1] 行列とベクトルによる目的関数の書き直し（難易度：★1）
$n=2$ 個のデータがあり、それぞれの特徴ベクトルと正解ラベルが、
$\boldsymbol{\phi}(x_1) = \begin{pmatrix} 1 \\ 2 \end{pmatrix}, y_1 = 4$, $\boldsymbol{\phi}(x_2) = \begin{pmatrix} 1 \\ 5 \end{pmatrix}, y_2 = 7$ である。
デザイン行列 $\Phi = \begin{pmatrix} \boldsymbol{\phi}(x_1)^\top \\ \boldsymbol{\phi}(x_2)^\top \end{pmatrix}$ およびラベルベクトル $\mathbf{y} = \begin{pmatrix} y_1 \\ y_2 \end{pmatrix}$ を具体的に数字で書き下し、目的関数 $L(\boldsymbol{\theta}) = \frac{1}{2} \|\Phi\boldsymbol{\theta} - \mathbf{y}\|^2$ が個別の二乗誤差の和 $\frac{1}{2}\sum_{i=1}^2 (y_i - \boldsymbol{\theta}^\top \boldsymbol{\phi}(x_i))^2$ と完全に等しいことを展開して確かめよ。

### [問2] 一階の条件の行列導出（難易度：★2）
**【添付画像：転置・逆行列・微分の性質の統合】**
以下の行列微分の公式を用いて、目的関数 $L(\boldsymbol{\theta}) = \frac{1}{2}(\Phi\boldsymbol{\theta} - \mathbf{y})^\top (\Phi\boldsymbol{\theta} - \mathbf{y})$ の勾配 $\nabla_{\boldsymbol{\theta}} L(\boldsymbol{\theta})$ を求め、一階の条件 $\nabla_{\boldsymbol{\theta}} L(\boldsymbol{\theta}) = \mathbf{0}$ から正規方程式 $\Phi^\top \Phi \boldsymbol{\theta} = \Phi^\top \mathbf{y}$ を導出せよ。
* 【公式1】 $\nabla_{\boldsymbol{\theta}} (\mathbf{a}^\top \boldsymbol{\theta}) = \mathbf{a}$
* 【公式2】 $\nabla_{\boldsymbol{\theta}} (\boldsymbol{\theta}^\top \mathbf{A} \boldsymbol{\theta}) = 2\mathbf{A}\boldsymbol{\theta}$ （ただし $\mathbf{A}$ は対称行列）

---

### 【解答・解説】
#### [問1]
$\Phi = \begin{pmatrix} 1 & 2 \\ 1 & 5 \end{pmatrix}$, $\mathbf{y} = \begin{pmatrix} 4 \\ 7 \end{pmatrix}$ である。パラメータを $\boldsymbol{\theta} = \begin{pmatrix} \theta_0 \\ \theta_1 \end{pmatrix}$ とすると、
$$\Phi\boldsymbol{\theta} - \mathbf{y} = \begin{pmatrix} 1 \cdot \theta_0 + 2 \cdot \theta_1 - 4 \\ 1 \cdot \theta_0 + 5 \cdot \theta_1 - 7 \end{pmatrix}$$
ベクトルのL2ノルムの2乗は各成分の2乗和なので、
$$\frac{1}{2}\|\Phi\boldsymbol{\theta} - \mathbf{y}\|^2 = \frac{1}{2} \left[ (\theta_0 + 2\theta_1 - 4)^2 + (\theta_0 + 5\theta_1 - 7)^2 \right]$$
これは $\frac{1}{2} \sum_{i=1}^2 (\boldsymbol{\theta}^\top \boldsymbol{\phi}(x_i) - y_i)^2$ と等しい（証明終）。

#### [問2]
まず $L(\boldsymbol{\theta})$ の括弧を展開する。内積はスカラーなので転置しても不変であるから、$\mathbf{y}^	op \Phi \boldsymbol{\theta} = (\mathbf{y}^	op \Phi \boldsymbol{\theta})^	op = \boldsymbol{\theta}^	op \Phi^	op \mathbf{y}$ となり、中央の項がまとめられる。
$$L(\boldsymbol{\theta}) = \frac{1}{2} \left[ \boldsymbol{\theta}^\top \Phi^\top \Phi \boldsymbol{\theta} - 2 (\Phi^\top \mathbf{y})^\top \boldsymbol{\theta} + \mathbf{y}^\top \mathbf{y} \right]$$
ここで、$\boldsymbol{\theta}$ で微分（勾配を計算）する。公式1および公式2（$\Phi^	op \Phi$ は対称行列）を適用すると、
$$\nabla_{\boldsymbol{\theta}} L(\boldsymbol{\theta}) = \frac{1}{2} \left[ 2 \Phi^\top \Phi \boldsymbol{\theta} - 2 \Phi^\top \mathbf{y} \right] = \Phi^\top \Phi \boldsymbol{\theta} - \Phi^\top \mathbf{y}$$
一階の条件 $\nabla_{\boldsymbol{\theta}} L(\boldsymbol{\theta}) = \mathbf{0}$ より、$\Phi^\top \Phi \boldsymbol{\theta} - \Phi^\top \mathbf{y} = \mathbf{0} \Rightarrow \Phi^\top \Phi \boldsymbol{\theta} = \Phi^\top \mathbf{y}$ （正規方程式が導出された）。

---

## 3-4. 正則化（Regularization）
**【該当内容】第3回スライド45〜50「過適合の対策＞正則化、L2正則化」**
**【狙い】** 過学習を防ぐL2正則化（Ridge）の目的関数について、代数表現と行列表現の一致を確かめ、単位行列 $I$ が出現する理由を数式変形で完全に理解する。

### [問1] L2ノルムの性質（難易度：★0）
ベクトル $\mathbf{w} = \begin{pmatrix} 3 \\ -4 \end{pmatrix}$ のL2ノルム $\|\mathbf{w}\|$ を計算し、それが自身との内積の平方根 $\sqrt{\mathbf{w}^\top \mathbf{w}}$ と等しいことを示せ。

### [問2] L2正則化付き目的関数の書き下し（難易度：★1）
損失関数を二乗誤差、正則化項をL2ノルムの2乗とし、正則化係数を $\lambda = 0.01$ とする。 $n$ 個のデータに対するL2正則化付き経験リスク最小化の目的関数 $L_{\text{reg}}(\boldsymbol{\theta})$ の式をシグマ表記で書き下せ。

### [問3] 行列による書き直しと一階の条件（難易度：★2）
問2の目的関数は、デザイン行列を用いると以下のように表現できる。
$$L_{\text{reg}}(\boldsymbol{\theta}) = \frac{1}{2}\|\Phi\boldsymbol{\theta} - \mathbf{y}\|^2 + \frac{\lambda}{2}\|\boldsymbol{\theta}\|^2$$
(1) 正則化項 $\frac{\lambda}{2}\|\boldsymbol{\theta}\|^2$ を $\boldsymbol{\theta}$ で微分（勾配）した式を求めよ。
(2) 全体の勾配を $\mathbf{0}$ と置く一階の条件から、最適解 $\hat{\boldsymbol{\theta}} = (\Phi^\top \Phi + \lambda \mathbf{I})^{-1}\Phi^\top \mathbf{y}$ を導出せよ（なぜ単位行列 $\mathbf{I}$ が必要なのか説明せよ）。

---

### 【解答・解説】
#### [問1]
$\|\mathbf{w}\| = \sqrt{3^2 + (-4)^2} = \sqrt{9 + 16} = 5$
$\mathbf{w}^\top \mathbf{w} = 3 \times 3 + (-4) \times (-4) = 9 + 16 = 25$。よって $\sqrt{\mathbf{w}^\top \mathbf{w}} = \sqrt{25} = 5$ となり一致する。

#### [問2]
$$L_{\text{reg}}(\boldsymbol{\theta}) = \frac{1}{n} \sum_{i=1}^n (y_i - \boldsymbol{\theta}^\top \boldsymbol{\phi}(x_i))^2 + 0.01 \|\boldsymbol{\theta}\|^2$$

#### [問3]
(1) $\|\boldsymbol{\theta}\|^2 = \boldsymbol{\theta}^	op \boldsymbol{\theta}$ である。公式2において $\mathbf{A}=\mathbf{I}$ （単位行列）とした場合と同じなので、$\nabla_{\boldsymbol{\theta}} \left(\frac{\lambda}{2} \boldsymbol{\theta}^	op \boldsymbol{\theta}\right) = \frac{\lambda}{2} (2 \mathbf{I} \boldsymbol{\theta}) = \lambda \boldsymbol{\theta}$。
(2) 全体の勾配は、$\nabla_{\boldsymbol{\theta}} L_{\text{reg}}(\boldsymbol{\theta}) = \Phi^\top \Phi \boldsymbol{\theta} - \Phi^\top \mathbf{y} + \lambda \boldsymbol{\theta} = \mathbf{0}$。
$\boldsymbol{\theta}$ の項をまとめる： $(\Phi^\top \Phi + \lambda \mathbf{I})\boldsymbol{\theta} = \Phi^\top \mathbf{y}$。
**【単位行列が必要な理由】** 行列 $\Phi^	op \Phi$ に対し、スカラー値である $\lambda$ をそのまま足すことは数学的に定義できない（サイズが違う）。そのため、$\lambda \boldsymbol{\theta} = \lambda \mathbf{I} \boldsymbol{\theta}$ と変換し、行列同士の足し算の形にするために単位行列 $\mathbf{I}$ が必須となる。
両辺に左から逆行列を掛けると、$\hat{\boldsymbol{\theta}} = (\Phi^\top \Phi + \lambda \mathbf{I})^{-1}\Phi^\top \mathbf{y}$ となる。

---

## 3-5. モデル選択（交差検証）
**【該当内容】第3回スライド51〜70「モデル選択、交差検証」**
**【狙い】** ハイパーパラメータ選択の具体的な手続きを、手計算可能なインデックス（データの添え字）操作を通じて厳密に理解する。

### [問1] K-fold交差検証のインデックス割当（難易度：★0）
$n=6$ 個のデータ $\{D_1, D_2, D_3, D_4, D_5, D_6\}$ がある。これを $K=3$ 個のフォルダ（グループ）に、上から順番に2個ずつ分割する（$F_1 = \{D_1, D_2\}$, $F_2 = \{D_3, D_4\}$, $F_3 = \{D_5, D_6\}$）。
このとき、**「第2イテレーション（$F_2$ を検証用データとする段階）」**において、訓練（学習）に使用されるデータのインデックス（番号）をすべて答えよ。

### [問2] LOOCV（一個抜き交差検証）の回数（難易度：★0）
サンプルサイズが $n=100$ であるデータセットに対し、LOOCV（Leave-One-Out Cross Validation）を行う場合、モデルの学習（訓練）プロセスは合計で何回実行されるか答えよ。

---

### 【解答・解説】
#### [問1]
第2イテレーションでは $F_2$ が検証用（評価用）に回るため、残りの $F_1$ と $F_3$ が訓練データとなる。
よって訓練に使用されるインデックスは **$\{1, 2, 5, 6\}$** である。

#### [問2]
LOOCVは、1つのデータを検証用に抜き出す操作を全てのデータ（$n$ 個）に対して巡回させる手法（$K=n$ 個の交差検証）である。
よって、学習は合計で **$100$ 回** 実行される。

---
---

# 【第4回】確率モデルと分位点回帰

## 4-1. 同時分布・条件付き分布・条件付き期待値
**【該当内容】第4回スライド5〜18「基本知識＞同時確率分布、条件付き確率」**
**【狙い】** 機械学習における「入力 $X$ からラベル $Y$ を予測する」という行為の数学的実態である条件付き確率・条件付き期待値を、具体的なクロス集計表（離散型）の計算から完全に理解する。

### [問1] 同時確率表からの条件付き分布（難易度：★1）
離散確率変数 $X$（予測特徴量：0または1）と $Y$（ターゲット：1桁の評価値）の同時確率分布 $P(X=x, Y=y)$ が以下の表で与えられている。

| | $Y=1$ | $Y=2$ | $Y=3$ |
| :---: | :---: | :---: | :---: |
| **$X=0$** | $0.1$ | $0.2$ | $0.1$ |
| **$X=1$** | $0.3$ | $0.2$ | $0.1$ |

(1) $X=0$ となる周辺確率 $P(X=0)$ を求めよ（正規化定数の算出に相当）。
(2) $X=0$ という条件が与えられたときの $Y$ の条件付き確率分布 $P(Y=y \mid X=0)$ を $y=1,2,3$ それぞれについて求めよ。

### [問2] 条件付き期待値の計算（難易度：★1）
上記の確率分布において、条件付き期待値 $\mathbb{E}[Y \mid X=0]$ を計算せよ。

---

### 【解答・解説】
#### [問1]
(1) $X=0$ の行の確率を足し合わせる。
$P(X=0) = 0.1 + 0.2 + 0.1 = 0.4$
(2) 条件付き確率の定義 $P(Y=y \mid X=0) = \frac{P(X=0, Y=y)}{P(X=0)}$ より、分母を $0.4$ として計算する。
* $P(Y=1 \mid X=0) = \frac{0.1}{0.4} = 0.25$
* $P(Y=2 \mid X=0) = \frac{0.2}{0.4} = 0.50$
* $P(Y=3 \mid X=0) = \frac{0.1}{0.4} = 0.25$

#### [問2]
問1(2)で求めた「$X=0$ の世界における $Y$ の確率分布」を用いて期待値を計算する。
$$\mathbb{E}[Y \mid X=0] = 1 \times 0.25 + 2 \times 0.50 + 3 \times 0.25 = 0.25 + 1.0 + 0.75 = 2.0$$

---

## 4-2. 分位点（Quantile）と外れ値の影響
**【該当内容】第4回スライド19〜35「分位点回帰、ピンボール損失」**
**【狙い】** 期待値（平均値）が外れ値（極端な値）に引っ張られやすいのに対し、分位点（中央値など）が頑健（ロバスト）である理由を、実際のデータ操作を通じて数式ベースで理解する。

### [問1] 飛びのある分布の分位点（難易度：★1）
あるデータセット（サンプルの集まり）が $\{2, 3, 5, 7, 100\}$ の5つの値で構成されている（$100$ は外れ値）。
(1) このデータセットの平均値（二乗誤差の総和を最小化する値）を求めよ。
(2) このデータセットの $\alpha = 0.5$ 分位点（中央値、すなわち累積確率が $0.5$ 以上になる左側の点）を求めよ。
(3) 外れ値であった $100$ が、さらに大きな値 $1000$ に化けたとする。このとき平均値と中央値はそれぞれどのように変化するか計算・記述し、ピンボール損失（中央値の場合は絶対値損失）が外れ値に対して持つ優位性を説明せよ。

### [問2] ピンボール損失のグラフ描写の理解（難易度：★1）
ピンボール損失関数の定義は以下で与えられる。
$$l_\alpha(y, y') = \begin{cases} (\alpha - 1)(y - y') & (y - y' < 0) \\ \alpha(y - y') & (y - y' \ge 0) \end{cases}$$
$\alpha = 0.3$ とする。誤差 $e = y - y'$ とおき、 $e = -2$ のときの損失の値と、 $e = 4$ のときの損失の値をそれぞれ計算し、この損失のグラフが $e=0$ を境にどのように傾きが変わるか説明せよ。

---

### 【解答・解説】
#### [問1]
(1) 平均値 $= \frac{2 + 3 + 5 + 7 + 100}{5} = \frac{117}{5} = 23.4$
(2) データを小さい順に並べたときの中央の数字なので、中央値 $= 5$。
(3) データが $\{2, 3, 5, 7, 1000\}$ になった場合：
* 新平均値 $= \frac{2 + 3 + 5 + 7 + 1000}{5} = \frac{1017}{5} = 203.4$ （激しく右に引っ張られた）
* 新中央値 $= 5$ （全く変化しない）
**【優位性の説明】** 二乗誤差に基づく平均値は、差の2乗をペナルティとするため、極端な外れ値に引っ張られてモデル全体が歪んでしまう。一方、絶対誤差（$\alpha=0.5$のピンボール損失）に基づく中央値は、外れ値の「大きさ」そのものではなく「自分より右側にあるか左側にあるか（符号）」しか見ないため、外れ値に対して非常に頑健（ロバスト）である。

#### [問2]
$e = y-y'$ とおく。
* $e = -2 < 0$ のとき： $l_{0.3} = (0.3 - 1) \times (-2) = (-0.7) \times (-2) = 1.4$
* $e = 4 \ge 0$ のとき： $l_{0.3} = 0.3 \times 4 = 1.2$
**【グラフの形状】** 誤差 $e < 0$ （過大評価側）では傾き $-0.7$ の右下がりの直線であり、 $e \ge 0$ （過小評価側）では傾き $0.3$ の右上がりの直線となる。 $\alpha$ の値によって、過小評価と過大評価に対するペナルティの重み（傾き）を非対称にコントロールできるのがピンボール損失の特徴である。

---
---

# 【第5回】確率論的二値分類と非線型最適化

## 5-1. ロジスティック関数（シグマイド関数）の微分
**【該当内容】第5回スライド50〜56「確率論的二値分類＞ロジスティック関数」およびスライド89「補足＞勾配の導出」**
**【狙い】** 天下り的に与えられるシグモイド関数の微分公式 $\sigma'(z) = \sigma(z)(1-\sigma(z))$ を、商の微分公式を用いて自力で完全に導出し、ニューラルネットワークやロジスティック回帰の基礎を固める。

### [問1] シグモイド関数の微分証明（難易度：★1）
ロジスティック関数（シグモイド関数） $\sigma(z) = \frac{1}{1 + e^{-z}}$ について、以下の問いに答えよ。
(1) 商の微分公式 $\left(\frac{1}{g(z)}\right)' = -\frac{g'(z)}{(g(z))^2}$ を用いて、$\frac{d}{dz}\sigma(z)$ を計算せよ。
(2) (1)の結果を巧妙に変形し、$\sigma(z)$ そのものを用いた美しい形 $\sigma(z)(1 - \sigma(z))$ になることを証明せよ。

### [問2] 対数シグモイド関数の微分（難易度：★1）
のちの損失関数の計算で多用される式 $f(z) = \log \sigma(z)$ について、合成関数の微分則を用いて $\frac{d}{dz} \log \sigma(z) = 1 - \sigma(z)$ が成り立つことを示せ。

---

### 【解答・解説】
#### [問1]
(1) $g(z) = 1 + e^{-z}$ とおくと、$g'(z) = -e^{-z}$ である。公式を適用すると、
$$\frac{d}{dz}\sigma(z) = - \frac{-e^{-z}}{(1 + e^{-z})^2} = \frac{e^{-z}}{(1 + e^{-z})^2}$$
(2) 分母をバラして、$\sigma(z) = \frac{1}{1+e^{-z}}$ の形を無理やり作り出す。
$$\frac{e^{-z}}{(1 + e^{-z})^2} = \left( \frac{1}{1 + e^{-z}} \right) \cdot \left( \frac{e^{-z}}{1 + e^{-z}} \right)$$
ここで、2つ目の括弧の分子に $1 - 1$ を補うと、
$$\frac{e^{-z}}{1 + e^{-z}} = \frac{1 + e^{-z} - 1}{1 + e^{-z}} = \frac{1 + e^{-z}}{1 + e^{-z}} - \frac{1}{1 + e^{-z}} = 1 - \sigma(z)$$
よって、原式は $= \sigma(z)(1 - \sigma(z))$ となる（証明終）。

#### [問2]
合成関数の微分則より、$(\log u)' = \frac{1}{u} \cdot u'$ である。 $u = \sigma(z)$ を代入する。
$$\frac{d}{dz} \log \sigma(z) = \frac{1}{\sigma(z)} \cdot \frac{d}{dz}\sigma(z)$$
問1(2)の結果（$\sigma'(z) = \sigma(z)(1-\sigma(z))$）を代入すると、
$$= \frac{1}{\sigma(z)} \cdot \sigma(z)(1 - \sigma(z)) = 1 - \sigma(z)$$
（証明終）。

---

## 5-2. 交差エントロピー損失と勾配の連鎖則（チェインルール）
**【該当内容】第5回スライド57〜89「交差エントロピー、勾配の導出」**
**【狙い】** 機械学習における最大のブラックボックスになりがちな「損失関数のパラメータ微分」について、合成関数の偏微分（チェインルール）を愚直に実行することで、アルゴリズムの動作を完全に数式で裏付ける。

### [問1] 尤度から対数尤度への変換理由（難易度：★0）
二値分類において、全てのデータが独立に予測通りになる確率（尤度関数）は、各データの確率の「掛け算」 $L = \prod_{i=1}^n p_i$ で表される。
(1) なぜ機械学習では、このまま最小化（最大化）をせず、$\log$ を取って「足し算」の形式に変形するのか、計算機（コンピュータ）の特性の観点から理由を説明せよ。

### [問2] チェインルールによる勾配の導出（難易度：★2）
ある1つのデータ $(x, y)$ （ただし $y \in \{0, 1\}$）に対する二値交差エントロピー損失が以下で与えられている。
$$l = -y \log \sigma(z) - (1-y) \log(1 - \sigma(z))$$
ここで、$z = \boldsymbol{\theta}^\top \boldsymbol{\phi}(x)$ である（よって $\nabla_{\boldsymbol{\theta}} z = \boldsymbol{\phi}(x)$）。
チェインルール（多変数の合成関数偏微分則） $\nabla_{\boldsymbol{\theta}} l = \frac{\partial l}{\partial z} \cdot \nabla_{\boldsymbol{\theta}} z$ を用いて、勾配ベクトルがスライド89にある以下の綺麗な形になることを一歩一歩導出せよ。
$$\nabla_{\boldsymbol{\theta}} l = (\sigma(z) - y)\boldsymbol{\phi}(x)$$

---

### 【解答・解説】
#### [問1]
確率 $p_i$ は $0 \sim 1$ の間の値をとる。データ数 $n$ が大量（数千〜数万）ある場合、それらを何回も掛け合わせると、尤度 $L$ の値は極めてゼロに近くなり、計算機内で扱える数値の下限を下回って不正確になる（**アンダーフロー・情報落ち**）。
$\log$ を取れば、積が和（$\sum \log p_i$）に変換されるため、数値が極端に小さくなるのを防ぎ、さらに微分の計算も劇的に容易になるためである。

#### [問2]
まず、$\frac{\partial l}{\partial z}$ を丁寧に計算する（5-1問2の結果も利用できる）。
$$\frac{\partial l}{\partial z} = -y \frac{\partial}{\partial z}(\log \sigma(z)) - (1-y) \frac{\partial}{\partial z}(\log(1 - \sigma(z)))$$
第1項の微分は $1 - \sigma(z)$ であった。第2項の微分は：
$$\frac{\partial}{\partial z}(\log(1 - \sigma(z))) = \frac{1}{1 - \sigma(z)} \cdot (-\sigma(z)(1 - \sigma(z))) = -\sigma(z)$$
これらを元の式に戻して整理する。
$$\frac{\partial l}{\partial z} = -y(1 - \sigma(z)) - (1-y)(-\sigma(z)) = -y + y\sigma(z) + \sigma(z) - y\sigma(z) = \sigma(z) - y$$
これに、チェインルールを適用して $\nabla_{\boldsymbol{\theta}} z = \boldsymbol{\phi}(x)$ を掛け合わせると、
$$\nabla_{\boldsymbol{\theta}} l = \frac{\partial l}{\partial z} \cdot \nabla_{\boldsymbol{\theta}} z = (\sigma(z) - y)\boldsymbol{\phi}(x)$$
が導出される（証明終）。
**【解説】** この結果は非常に直感的である。モデルの予測確率 $\sigma(z)$ と、実際の正解 $y$ の「ズレ（誤差）」に、特徴量 $\boldsymbol{\phi}(x)$ を掛け合わせたものが、パラメータを更新すべき方向（勾配）になっていることを示している。
