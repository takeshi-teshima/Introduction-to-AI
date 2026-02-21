"""CLI entry-point for kokoro-smd."""

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
    """kokoro-smd — Speech Markdown to audio converter (Kokoro TTS)."""


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
@click.option("--gap", default=1.0, type=float, help="スライド間の無音 (秒)")
@click.option("--threads", default=10, type=int, help="同時実行スレッド数")
@click.option("--voice", default="jf_alpha", help="Kokoro voice name")
@click.option("--speed", default=1.1, type=float, help="読み上げ速度")
def process(
    input_file: Path,
    output_dir: Path | None,
    gap: float,
    threads: int,
    voice: str,
    speed: float,
):
    """単一の .smd ファイルを音声に変換する。"""
    from kokoro_smd.engine import process_file

    process_file(
        input_file,
        output_dir,
        gap=gap,
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
@click.option("--gap", default=1.0, type=float, help="スライド間の無音 (秒)")
@click.option("--threads", default=10, type=int, help="同時実行スレッド数")
@click.option("--voice", default="jf_alpha", help="Kokoro voice name")
@click.option("--speed", default=1.1, type=float, help="読み上げ速度")
def batch(
    source_dir: Path,
    output_dir: Path,
    gap: float,
    threads: int,
    voice: str,
    speed: float,
):
    """ディレクトリ内の .smd ファイルを一括で音声に変換する。

    SOURCE_DIR 内の .smd ファイルを再帰的に探し出し、ディレクトリ構造を
    OUTPUT_DIR にミラーして、各ファイルの音声とキャッシュを展開する。
    """
    from kokoro_smd.batch import batch_process

    batch_process(
        source_dir,
        output_dir,
        gap=gap,
        threads=threads,
        voice=voice,
        speed=speed,
    )


# ---------------------------------------------------------------------------
# parse  (debug / inspection)
# ---------------------------------------------------------------------------


@main.command()
@click.argument("input_file", type=click.Path(exists=True, path_type=Path))
def parse(input_file: Path):
    """Parse an .smd file and print its structure (音声生成なし)."""
    from kokoro_smd.parser import parse_smd

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
