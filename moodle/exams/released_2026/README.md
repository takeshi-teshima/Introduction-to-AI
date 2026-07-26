# released_2026

`release.yaml` を `moodle-convert` で Moodle 用の XML（`release.xml`）に変換する．

## 前提

`moodle-convert` は pipx でインストールしている（ローカルパスからのインストール）．

```bash
brew install pipx
pipx install /Users/teshima/2025/moodle-convert
```

## 実施コマンド

```bash
cd moodle/exams/released_2026
moodle-convert release.yaml --output release.xml
```

`~/.local/bin` が PATH に通っていない場合は `~/.local/bin/moodle-convert` を直接指定する．
