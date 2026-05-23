# 第1回: 確率の基礎とリスク関数・ERM

## リスク関数 and 経験リスク

### 分布が既知の場合の真のリスク関数 {#q:1-2-1 .questionbox tags="確認"}

あるデータ生成分布において、入力 $X$ は常に $1$ で固定されており、ラベル $Y$ は確率 $0.6$ で $y=3$、確率 $0.4$ で $y=8$ をとるとする。予測モデル $f$ を定数 $c$ を出力するモデル $f(x)=c$ とし、損失関数を二乗誤差 $l(y, y') = (y-y')^2$ とする。

1. このときの真のリスク関数 $R(f) = \mathbb{E}[l(Y, f(X))]$ の式を $c$ を用いて書き下せ。
2. $c = 5$ （すなわち $f(x) = 5$）のときの真のリスク $R(f)$ の値を求めよ。

::: {.right}
[（解答・解説へ）](#a:1-2-1)
:::

### 経験リスクの計算と予測値の代入 {#q:1-2-2 .questionbox tags="不要"}

上記のデータ生成分布から、現実世界でランダムに $n=3$ 個のサンプルを収集したところ、偶然にも全て $y_1=3, y_2=3, y_3=3$ であったとする。

1. この手元の標本に対する経験リスク $\hat{R}(f)$ の式を $c$ を用いて書き下せ。
2. $c=5$ （すなわち $f(x)=5$）のときの経験リスク $\hat{R}(f)$ の値を計算せよ。

::: {.right}
[（解答・解説へ）](#a:1-2-2)
:::

### 解答・解説

**【該当内容】** 第1回スライド78〜86「予測系タスクの学習＞リスク関数、リスクの標本近似」
**【ねらい】** 未来のあらゆるデータを考慮した「真のリスク（期待値）」と、手元にあるデータから計算する「経験リスク（標本平均）」の関係を具体的に数値で比較し、そのギャップを理解する。

### 問1-2-1 の解答・解説 {#a:1-2-1 .answerbox ref="q:1-2-1"}

1. 定数を出力する予測モデル $f(X) = c$ を代入して、真のリスク $R(f)$ を書き下します。
        $$R(f) = \mathbb{E}[l(Y, f(X))] = \mathbb{E}[(Y - f(X))^2] = 0.6 \times (3 - c)^2 + 0.4 \times (8 - c)^2$$
2. $c=5$ （すなわち $f(x)=5$）のとき、
        $$R(f) = 0.6 \times (3 - 5)^2 + 0.4 \times (8 - 5)^2 = 0.6 \times 4 + 0.4 \times 9 = 2.4 + 3.6 = 6.0$$

::: {.right}
[（問題へ戻る）](#q:1-2-1)
:::

### 問1-2-2 の解答・解説 {#a:1-2-2 .answerbox ref="q:1-2-2"}

1. 手元にある $n=3$ 個の訓練データに対する経験リスク $\hat{R}(f)$ は、予測値 $f(x_i) = c$ を用いて以下のように表されます。
        $$\hat{R}(f) = \frac{1}{3} \sum_{i=1}^3 (y_i - f(x_i))^2 = \frac{1}{3} \left[ (3-c)^2 + (3-c)^2 + (3-c)^2 \right] = (3-c)^2$$
2. $c=5$ （すなわち $f(x)=5$）のとき、
        $$\hat{R}(f) = (3-5)^2 = 4.0$$

::: {.right}
[（問題へ戻る）](#q:1-2-2)
:::

# 第2回: 最適化と最小二乗法・偏微分

## 最小二乗法の真髄：偏微分から一階の条件へ

### 一階の条件からの式変形 {#q:2-first-order-conditions-scalar .questionbox tags="確認"}

最適解において勾配ベクトルがゼロになるという一階の条件 $\nabla L(w,b) = \mathbf{0}$ のうち、$\frac{\partial L}{\partial b} = 0$ の式を変形し、最適な切片 $\hat{b}$ が、サンプルの平均値 $\bar{x} = \frac{1}{n}\sum_{i=1}^n x_i$, $\bar{y} = \frac{1}{n}\sum_{i=1}^n y_i$ を用いて
$$
\hat{b} = \bar{y} - w\bar{x}
$$
と表せることを証明せよ。

::: {.right}
[（解答・解説へ）](#a:2-first-order-conditions-scalar)
:::

### 学習済みパラメータによる新規データの予測 {#q:2-prediction-with-learned-parameters .questionbox tags="不要"}

あるデータセットに対して最小二乗法を適用したところ、学習済みパラメータが $\hat{w} = 2.5, \hat{b} = 1.0$ と求まった。このとき、新規に観測された特徴量 $x_{\text{new}} = 6$ に対する予測値 $\hat{y}_{\text{new}}$ を計算せよ。

::: {.right}
[（解答・解説へ）](#a:2-prediction-with-learned-parameters)
:::

### 解答・解説

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


# 第3回: 線型モデルの行列表現と正則化・モデル選択

## ベクトルの内積と性質

### 内積の線形性と対称性の証明 {#q:3-inner-product-properties .questionbox tags="発展"}

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
