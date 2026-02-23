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
