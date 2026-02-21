# kokoro-smd

Speech Markdown (`.smd`) ファイルを [Kokoro TTS](https://github.com/hexgrad/kokoro) で音声に変換する CLI ツール。

## セットアップ

```bash
cd Video/Introduction-to-AI_v1/kokoro-smd
mise run setup
```

## 使い方

### 単一ファイルの処理

```bash
kokoro-smd process path/to/script.smd
kokoro-smd process path/to/script.smd --output-dir ./output --gap 1.5 --speed 1.0
```

### ディレクトリ一括処理

```bash
kokoro-smd batch ./3_Audio_Scripts ./4_Audio_Output
```

`3_Audio_Scripts/` 内の `.smd` ファイルを再帰的に探し出し、
同じディレクトリ構造を `4_Audio_Output/` にミラーして処理します。

### パース結果の確認 (音声生成なし)

```bash
kokoro-smd parse path/to/script.smd
```

## SMD ファイル形式

```markdown
---
01-01 予測系タスク
想定所要時間：約15分
スライド枚数：10枚
---

# [01-01: Slide 1/10] タイトル
本文テキスト…
[AI](エーアイ) のように読み仮名を付与できます。

# [01-01: Slide 2/10] 次のスライド
…
```

- `---` で囲まれた部分はフロントマター（メタデータ）として扱われます
- `# [slide info] タイトル` がセクション区切りです
- `[表示テキスト](読み)` で読み上げ時のテキストを指定できます
