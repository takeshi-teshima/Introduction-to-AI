# text-to-multimedia

Speech Markdown (`.smd`) ファイルを [Kokoro TTS](https://github.com/hexgrad/kokoro) で音声に変換し、さらに PDF スライド＋音声から講義動画を生成する CLI ツール。

## セットアップ

```bash
cd Video/Introduction-to-AI_v1/text-to-multimedia
mise run setup
```

`setup` タスクで以下が自動インストールされます：
- `espeak-ng` / `cmake` / `poppler` / `ffmpeg`（Homebrew 経由）
- Python 仮想環境（`.venv`）
- パッケージ（editable インストール）

## 使い方

### 単一ファイルの音声生成

```bash
mise run speech path/to/script.smd
mise run speech path/to/script.smd --output-dir ./output --gap 1.5 --speed 1.0
```

### ディレクトリ一括音声生成

```bash
mise run batch ../3_Audio_Scripts/section_00 ../4_Audio/section_00
```

`3_Audio_Scripts/` 内の `.smd` ファイルを再帰的に探し出し、
同じディレクトリ構造を `4_Audio/` にミラーして処理します。

### PDF スライド動画の生成

```bash
mise run video \
  ../0_Lecture_slides/split_slides_orig/00-01.pdf \
  ../4_Audio/section_00/00-01_講義の全体像/00-01_講義の全体像_full.wav \
  ../4_Audio/section_00/00-01_講義の全体像/manifest.json
```

出力先を指定する場合：

```bash
mise run video \
  ../0_Lecture_slides/split_slides_orig/00-01.pdf \
  ../4_Audio/section_00/00-01_講義の全体像/00-01_講義の全体像_full.wav \
  ../4_Audio/section_00/00-01_講義の全体像/manifest.json \
  -- -o ../5_Video/section_00/00-01_講義の全体像.mp4
```

オプション：

| オプション | デフォルト | 説明 |
|------------|-----------|------|
| `--output`, `-o` | `<audio_dir>/<pdf_stem>.mp4` | 出力MP4パス |
| `--fps` | 30 | フレームレート |
| `--width` | 1920 | 出力幅 px |
| `--height` | 1080 | 出力高さ px |

> **Note**: manifest.json の i 番目のエントリが PDF の i ページ目に対応します。

### パース結果の確認 (音声生成なし)

```bash
text-to-multimedia parse path/to/script.smd
```

---

## SMD 記法リファレンス

### ファイル全体構造

```markdown
---
01-01 予測系タスク
想定所要時間：約15分
スライド枚数：10枚
---

# [01-01: Slide 1/10] タイトル
本文テキスト…

# [01-01: Slide 2/10] 次のスライド
…
```

### フロントマター

ファイル **先頭** の `---` で囲まれたブロックはメタデータとして扱われ、音声生成の対象外になります。

### セクション見出し（`#`）

`#` で始まる行がセクションの区切りです。各セクションは個別の音声ファイルとしてキャッシュされ、最終的に結合されます。

- `[…]` 内はスライド参照情報（`slide_info`）として抽出されます。
- `]` 以降の文字列がセクションの **タイトル**（`heading_title`）になります。

### エイリアス読み（`[表示テキスト](読み)`）

```markdown
[AI](エーアイ)              → 「エーアイ」と読み上げ
[GPU](ジーピーユー)          → 「ジーピーユー」と読み上げ
```

### ブレイク（`[break: 時間]`）

```markdown
文の途中に [break: 500ms] 少し間を空ける。
長めの間。[break: 2s] 次の文。
```

### 注釈（`[note: …]`）

音声生成から除外されるコメント：

```markdown
[note: ここでスライドを切り替え]
通常の読み上げテキスト。
```

### 空行によるポーズ

本文中の **空行** は **0.5秒** の無音として扱われます。

### セクション間ギャップ

セクション（`#` 見出し）間には、`--gap` オプションで指定した長さ（デフォルト **1.0秒**）の無音が挿入されます。
