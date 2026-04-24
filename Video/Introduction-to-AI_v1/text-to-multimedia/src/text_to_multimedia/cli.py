"""CLI entry-point for text-to-multimedia."""

from __future__ import annotations

import os
import sys
import logging

# Suppress noisy libraries before they are imported
os.environ.setdefault("HF_HUB_OFFLINE", "1")
os.environ.setdefault("TOKENIZERS_PARALLELISM", "false")
logging.getLogger("huggingface_hub").setLevel(logging.ERROR)
logging.getLogger("torch").setLevel(logging.ERROR)

import warnings
warnings.filterwarnings("ignore")

from pathlib import Path

import click


@click.group()
def main():
    """text-to-multimedia — SMD→音声変換 & スライド動画生成ツール。"""


# ---------------------------------------------------------------------------
# process  (single file)
# ---------------------------------------------------------------------------


@main.command()
@click.argument("input_file", type=click.Path(exists=True, path_type=Path))
@click.option(
    "--output-dir", "-o",
    type=click.Path(path_type=Path),
    default=None,
    help="出力先ディレクトリ (デフォルト: 入力ファイル名のディレクトリ)",
)
@click.option(
    "--cache-dir",
    type=click.Path(path_type=Path),
    default=None,
    help="共通キャッシュディレクトリ (デフォルト: 各出力ディレクトリ内の cache/)",
)
@click.option("--gap", default=1.0, type=float, help="スライド間の無音 (秒)")
@click.option("--para-gap", default=0.5, type=float, help="段落間の無音 (秒)")
@click.option("--threads", default=10, type=int, help="同時実行スレッド数")
@click.option("--voice", default="jf_alpha", help="Kokoro voice name")
@click.option("--speed", default=1.1, type=float, help="読み上げ速度")
def process(
    input_file: Path,
    output_dir: Path | None,
    cache_dir: Path | None,
    gap: float,
    para_gap: float,
    threads: int,
    voice: str,
    speed: float,
):
    """単一の .smd ファイルを音声に変換する。"""
    from text_to_multimedia.engine import process_file

    process_file(
        input_file,
        output_dir,
        cache_dir=cache_dir,
        gap=gap,
        para_gap=para_gap,
        threads=threads,
        voice=voice,
        speed=speed,
    )


# ---------------------------------------------------------------------------
# batch  (directory)
# ---------------------------------------------------------------------------


@main.command()
@click.argument("source_dir", type=click.Path(exists=True, path_type=Path))
@click.argument("output_dir", type=click.Path(path_type=Path))
@click.option(
    "--cache-dir",
    type=click.Path(path_type=Path),
    default=None,
    help="共通キャッシュディレクトリ (デフォルト: 各出力ディレクトリ内の cache/)",
)
@click.option("--gap", default=1.0, type=float, help="スライド間の無音 (秒)")
@click.option("--para-gap", default=0.5, type=float, help="段落間の無音 (秒)")
@click.option("--threads", default=10, type=int, help="同時実行スレッド数")
@click.option("--voice", default="jf_alpha", help="Kokoro voice name")
@click.option("--speed", default=1.1, type=float, help="読み上げ速度")
def batch(
    source_dir: Path,
    output_dir: Path,
    cache_dir: Path | None,
    gap: float,
    para_gap: float,
    threads: int,
    voice: str,
    speed: float,
):
    """ディレクトリ内の .smd ファイルを一括で音声に変換する。

    SOURCE_DIR 内の .smd ファイルを再帰的に探し出し、ディレクトリ構造を
    OUTPUT_DIR にミラーして、各ファイルの音声とキャッシュを展開する。
    """
    from text_to_multimedia.batch import batch_process

    batch_process(
        source_dir,
        output_dir,
        cache_dir=cache_dir,
        gap=gap,
        para_gap=para_gap,
        threads=threads,
        voice=voice,
        speed=speed,
    )


# ---------------------------------------------------------------------------
# make-video  (PDF + WAV + manifest.json → MP4)
# ---------------------------------------------------------------------------


@main.command("make-video")
@click.argument("pdf", type=click.Path(exists=True, path_type=Path))
@click.argument("audio", type=click.Path(exists=True, path_type=Path))
@click.argument("manifest", type=click.Path(exists=True, path_type=Path))
@click.option(
    "--output", "-o",
    type=click.Path(path_type=Path),
    default=None,
    help="出力MP4ファイルパス (デフォルト: audio と同ディレクトリ/<pdf名>.mp4)",
)
@click.option("--fps", default=30, type=int, help="フレームレート (デフォルト: 30)")
@click.option("--width", default=1920, type=int, help="出力幅 px (デフォルト: 1920)")
@click.option("--height", default=1080, type=int, help="出力高さ px (デフォルト: 1080)")
def make_video_cmd(
    pdf: Path,
    audio: Path,
    manifest: Path,
    output: Path | None,
    fps: int,
    width: int,
    height: int,
):
    """PDFスライド ＋ WAV音声 ＋ manifest.json からMP4動画を生成する。

    \b
    PDF      スライドPDFファイル (全ページ含む)
    AUDIO    音声WAVファイル (full WAV)
    MANIFEST manifest.json ファイル

    \b
    例:
      text-to-multimedia make-video slides.pdf lecture.wav manifest.json
      text-to-multimedia make-video slides.pdf lecture.wav manifest.json -o output.mp4
    """
    from text_to_multimedia.video import make_video

    if output is None:
        output = audio.parent / f"{pdf.stem}.mp4"

    make_video(
        pdf_path=pdf,
        audio_path=audio,
        manifest_path=manifest,
        output_path=output,
        fps=fps,
        width=width,
        height=height,
    )


# ---------------------------------------------------------------------------
# parse  (debug / inspection)
# ---------------------------------------------------------------------------


@main.command()
@click.argument("input_file", type=click.Path(exists=True, path_type=Path))
def parse(input_file: Path):
    """Parse an .smd file and print its structure (音声生成なし)."""
    from text_to_multimedia.parser import parse_smd

    content = input_file.read_text(encoding="utf-8")
    doc = parse_smd(content)

    if doc.frontmatter:
        click.secho("── Frontmatter ──", fg="cyan", bold=True)
        for k, v in doc.frontmatter.fields.items():
            click.echo(f"  {k}: {v}")
        click.echo()

    if doc.preamble:
        click.secho("── Preamble ──", fg="yellow")
        click.echo(f"  {doc.preamble[:200]}")
        click.echo()

    click.secho(f"── Sections ({len(doc.sections)}) ──", fg="green", bold=True)
    for i, sec in enumerate(doc.sections):
        click.echo(f"  [{i}] slide={sec.slide_info!r}  title={sec.heading_title!r}")
        body_preview = sec.body.replace("\n", " ")[:100]
        click.echo(f"      body: {body_preview}…")


# ---------------------------------------------------------------------------
# init-project  (audio_dir + pdf_dir → YAML project file)
# ---------------------------------------------------------------------------


@main.command("init-project")
@click.argument("audio_dir", type=click.Path(exists=True, path_type=Path))
@click.argument("pdf_dir", type=click.Path(exists=True, path_type=Path))
@click.option(
    "--output-dir", "-o",
    type=click.Path(path_type=Path),
    default=None,
    help="動画の出力先ルートディレクトリ (デフォルト: audio_dir の兄弟ディレクトリ '5_Video')",
)
@click.option(
    "--project-file", "-p",
    type=click.Path(path_type=Path),
    default=None,
    help="出力YAMLファイルパス (デフォルト: audio_dir の親に video_project.yaml)",
)
@click.option(
    "--base-dir",
    type=click.Path(path_type=Path),
    default=None,
    help="相対パスのベースディレクトリ (デフォルト: audio_dir の親)",
)
def init_project_cmd(
    audio_dir: Path,
    pdf_dir: Path,
    output_dir: Path | None,
    project_file: Path | None,
    base_dir: Path | None,
):
    """音声出力ディレクトリとPDFディレクトリからYAMLプロジェクトファイルを自動生成する。

    \b
    AUDIO_DIR   mise run batch の出力ルートディレクトリ (例: 4_Audio/)
    PDF_DIR     スライドPDFが置かれたディレクトリ (例: 0_Lecture_slides/split_slides_orig/)

    \b
    例:
      text-to-multimedia init-project 4_Audio/ 0_Lecture_slides/split_slides_orig/
      text-to-multimedia init-project 4_Audio/ 0_Lecture_slides/split_slides_orig/ -o 5_Video/ -p project.yaml
    """
    from text_to_multimedia.project import discover_project

    resolved_audio = audio_dir.resolve()
    resolved_pdf = pdf_dir.resolve()

    if base_dir is None:
        _base = resolved_audio.parent
    else:
        _base = base_dir.resolve()

    if output_dir is None:
        _output = _base / "5_Video"
    else:
        _output = output_dir.resolve()

    if project_file is None:
        _project_file = _base / "video_project.yaml"
    else:
        _project_file = project_file.resolve()

    click.secho(
        f"\n🔍 init-project: {resolved_audio} ↔ {resolved_pdf}", fg="cyan", bold=True
    )

    project = discover_project(
        audio_dir=resolved_audio,
        pdf_dir=resolved_pdf,
        output_dir=_output,
        base_dir=_base,
    )

    n_total = len(project.videos)
    n_unmatched = sum(1 for v in project.videos if v.pdf == "???")

    _project_file.parent.mkdir(parents=True, exist_ok=True)
    _project_file.write_text(project.to_yaml_str(), encoding="utf-8")

    click.secho(f"\n✅ {n_total} エントリを検出 → {_project_file}", fg="green", bold=True)

    if n_unmatched:
        click.secho(
            f"⚠️  {n_unmatched} エントリで PDF が見つかりませんでした。"
            f"\n   YAMLの '???' を手動で修正してください。",
            fg="yellow",
        )
    else:
        click.secho("   全エントリの PDF が自動マッチしました ✨", fg="green")

    # 未マッチ一覧を表示
    for v in project.videos:
        if v.pdf == "???":
            click.secho(f"   ❌ {v.id}: PDF 未マッチ  audio={v.audio}", fg="yellow")


# ---------------------------------------------------------------------------
# video-batch  (YAML project file → batch MP4 generation)
# ---------------------------------------------------------------------------


@main.command("video-batch")
@click.argument("project_file", type=click.Path(exists=True, path_type=Path))
@click.option("--fps", default=30, type=int, help="フレームレート (デフォルト: 30)")
@click.option("--width", default=1920, type=int, help="出力幅 px (デフォルト: 1920)")
@click.option("--height", default=1080, type=int, help="出力高さ px (デフォルト: 1080)")
@click.option(
    "--only",
    multiple=True,
    metavar="ID",
    help="指定IDのみ処理 (複数指定可: --only 00-01 --only 01-02)",
)
@click.option(
    "--skip-existing/--no-skip-existing",
    default=True,
    help="出力MP4が既に存在する場合スキップ (デフォルト: スキップする)",
)
def video_batch_cmd(
    project_file: Path,
    fps: int,
    width: int,
    height: int,
    only: tuple[str, ...],
    skip_existing: bool,
):
    """YAMLプロジェクトファイルを読み込んでMP4動画を一括生成する。

    \b
    PROJECT_FILE  video_project.yaml へのパス

    \b
    例:
      text-to-multimedia video-batch video_project.yaml
      text-to-multimedia video-batch video_project.yaml --only 00-01 --only 00-02
      text-to-multimedia video-batch video_project.yaml --no-skip-existing
    """
    from text_to_multimedia.project import VideoProject
    from text_to_multimedia.video import make_video

    project = VideoProject.from_yaml(project_file)
    videos = project.videos

    # フィルタ
    if only:
        videos = [v for v in videos if v.id in only]

    n_total = len(videos)
    click.secho(
        f"\n🎬 video-batch: {n_total} 本の動画を処理 ({project_file.name})",
        fg="cyan",
        bold=True,
    )

    ok_count = 0
    skip_count = 0
    err_count = 0

    for i, entry in enumerate(videos, 1):
        resolved = entry.resolve(project.base_dir)

        click.secho(
            f"\n━━━ [{i}/{n_total}] {entry.id} ━━━",
            fg="bright_white",
            bold=True,
        )

        # 未マッチ PDF チェック
        if entry.pdf == "???":
            click.secho(
                f"  ⏭️  スキップ: PDF が '???' のまま未設定 ({entry.id})", fg="yellow"
            )
            err_count += 1
            continue

        # ファイル存在チェック
        missing = []
        if not resolved.pdf.exists():
            missing.append(f"PDF: {resolved.pdf}")
        if not resolved.audio.exists():
            missing.append(f"Audio: {resolved.audio}")
        if not resolved.manifest.exists():
            missing.append(f"Manifest: {resolved.manifest}")
        if missing:
            for m in missing:
                click.secho(f"  ❌ ファイルが見つかりません: {m}", fg="red")
            err_count += 1
            continue

        # スキップ判定
        if skip_existing and resolved.output.exists():
            click.secho(
                f"  ✅ スキップ (既存): {resolved.output.name}", fg="green"
            )
            skip_count += 1
            continue

        try:
            make_video(
                pdf_path=resolved.pdf,
                audio_path=resolved.audio,
                manifest_path=resolved.manifest,
                output_path=resolved.output,
                fps=fps,
                width=width,
                height=height,
            )
            ok_count += 1
        except SystemExit:
            err_count += 1
        except Exception as exc:
            click.secho(f"  ❌ エラー: {exc}", fg="red")
            err_count += 1

    # サマリー
    click.secho(
        f"\n{'='*50}\n"
        f"🏁 完了: {ok_count} 成功 / {skip_count} スキップ / {err_count} エラー",
        fg="green" if err_count == 0 else "yellow",
        bold=True,
    )

