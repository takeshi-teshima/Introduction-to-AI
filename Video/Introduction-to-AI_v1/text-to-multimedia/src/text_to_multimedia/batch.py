"""Batch processing — discover .smd files in a tree and process them all."""

from __future__ import annotations

from pathlib import Path

import click

from text_to_multimedia.engine import process_file


def discover_smd_files(source_dir: Path) -> list[Path]:
    """Recursively find all ``.smd`` files under *source_dir*.

    Files are returned in sorted order for deterministic processing.
    """
    return sorted(source_dir.rglob("*.smd"))


def batch_process(
    source_dir: Path,
    output_dir: Path,
    *,
    cache_dir: Path | None = None,
    gap: float = 1.0,
    para_gap: float = 0.5,
    threads: int = 10,
    voice: str = "jf_alpha",
    speed: float = 1.1,
) -> None:
    """Process every ``.smd`` file under *source_dir*.

    For each file, we mirror the directory structure from *source_dir* into
    *output_dir* and create a sub-directory named after the file stem inside
    which cache and output artefacts are placed.

    Example
    -------
    Given::

        source_dir/
          section_00/
            00-01_講義の全体像.smd
          section_01/
            01-01_予測系タスク.smd

    Running ``batch_process(source_dir, output_dir)`` produces::

        output_dir/
          section_00/
            00-01_講義の全体像/
              cache/
              00-01_講義の全体像_full.wav
              manifest.json
          section_01/
            01-01_予測系タスク/
              cache/
              01-01_予測系タスク_full.wav
              manifest.json
    """
    smd_files = discover_smd_files(source_dir)
    if not smd_files:
        click.secho(f"No .smd files found under {source_dir}", fg="red")
        return

    click.secho(
        f"\n📂 Batch: found {len(smd_files)} .smd file(s) in {source_dir}\n",
        fg="cyan",
        bold=True,
    )

    for i, smd_path in enumerate(smd_files, 1):
        # Mirror the relative directory structure
        rel = smd_path.relative_to(source_dir)
        file_output_dir = output_dir / rel.parent / smd_path.stem
        file_output_dir.mkdir(parents=True, exist_ok=True)

        click.secho(
            f"━━━ [{i}/{len(smd_files)}] {rel} ━━━",
            fg="bright_white",
            bold=True,
        )

        try:
            process_file(
                smd_path,
                file_output_dir,
                cache_dir=cache_dir,
                gap=gap,
                para_gap=para_gap,
                threads=threads,
                voice=voice,
                speed=speed,
            )
        except Exception as exc:
            click.secho(f"  ❌ Error: {exc}", fg="red")

    click.secho("\n🎉 Batch complete!", fg="green", bold=True)
