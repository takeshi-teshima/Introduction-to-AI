"""Audio generation engine — section-level TTS with caching."""

from __future__ import annotations

import hashlib
import json
import re
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

import click
import numpy as np
import soundfile as sf

from kokoro_smd.parser import SmdDocument, Section, parse_smd
from kokoro_smd.text import clean_smd_text

SAMPLE_RATE = 24000


# ---------------------------------------------------------------------------
# Lazy pipeline singleton
# ---------------------------------------------------------------------------

_pipeline = None


def _get_pipeline():
    """Lazily initialise the Kokoro pipeline (heavy import)."""
    global _pipeline
    if _pipeline is None:
        from kokoro import KPipeline

        _pipeline = KPipeline(lang_code="j", repo_id="hexgrad/Kokoro-82M")
    return _pipeline


# ---------------------------------------------------------------------------
# Section-level audio generation
# ---------------------------------------------------------------------------


def _generate_section_audio(
    idx: int,
    raw_text: str,
    output_path: str,
    voice: str,
    speed: float,
    label: str,
) -> tuple[int, bool, str, float | str]:
    """Synthesise audio for one section and write to *output_path*.

    Returns ``(idx, success, label, rtf_or_error)``.
    """
    start = time.time()
    try:
        pipeline = _get_pipeline()
        lines = raw_text.strip().split("\n")
        slide_audio: list[np.ndarray] = []

        for i, line in enumerate(lines):
            line = line.strip()
            if not line:
                # Blank line → 0.5 s pause
                slide_audio.append(np.zeros(int(SAMPLE_RATE * 0.5)))
                continue

            # [break: 500ms] / [break: 1.5s]
            parts = re.split(r"(\[break:\s*[\d\.]+[ms]*\])", line)
            for part in parts:
                part = part.strip()
                if not part:
                    continue

                bm = re.match(r"\[break:\s*([\d\.]+)(ms|s)\]", part)
                if bm:
                    val, unit = float(bm.group(1)), bm.group(2)
                    dur = val / 1000 if unit == "ms" else val
                    slide_audio.append(np.zeros(int(SAMPLE_RATE * dur)))
                else:
                    clean = clean_smd_text(part)
                    if not clean:
                        continue
                    for _, _, audio in pipeline(clean, voice=voice, speed=speed):
                        slide_audio.append(audio)

            # 0.5 s inter-line pause (within section)
            if i < len(lines) - 1:
                slide_audio.append(np.zeros(int(SAMPLE_RATE * 0.5)))

        if not slide_audio:
            return idx, False, label, "No audio data"

        final = np.concatenate(slide_audio)
        sf.write(output_path, final, SAMPLE_RATE)
        audio_dur = len(final) / SAMPLE_RATE
        rtf = (time.time() - start) / audio_dur
        return idx, True, label, rtf
    except Exception as exc:
        return idx, False, label, str(exc)


# ---------------------------------------------------------------------------
# Single-file processor
# ---------------------------------------------------------------------------


def process_file(
    input_path: Path,
    output_dir: Path | None = None,
    *,
    gap: float = 1.0,
    threads: int = 10,
    voice: str = "jf_alpha",
    speed: float = 1.1,
) -> Path | None:
    """Process a single ``.smd`` file and produce a combined WAV + manifest.

    Parameters
    ----------
    input_path:
        Path to the source ``.smd`` file.
    output_dir:
        Directory to write outputs into.  Defaults to ``<input_stem>/``
        next to the input file.
    gap:
        Silence between sections in seconds.
    threads:
        Max parallel threads for TTS.
    voice:
        Kokoro voice name.
    speed:
        Playback speed factor.

    Returns
    -------
    Path or None
        Path to the combined WAV file, or *None* if no audio was produced.
    """
    content = input_path.read_text(encoding="utf-8")
    doc = parse_smd(content)

    if output_dir is None:
        output_dir = input_path.parent / input_path.stem
    cache_dir = output_dir / "cache"
    cache_dir.mkdir(parents=True, exist_ok=True)

    click.secho(f"\n🚀 Processing: {input_path.name}", fg="cyan", bold=True)

    # Frontmatter info
    if doc.frontmatter:
        click.echo(f"   Frontmatter: {doc.frontmatter.fields}")

    # Build task list --------------------------------------------------------
    tasks: list[tuple[int, str, str, str, float, str]] = []
    section_meta: list[dict] = []
    output_paths: list[Path] = []

    for i, sec in enumerate(doc.sections):
        label = sec.heading_title or sec.slide_info or f"section_{i:03d}"
        # Filesystem-safe label
        safe_label = re.sub(r'[\\/:*?"<>|\s]+', "_", label)[:80]
        h = hashlib.sha256(
            (safe_label + clean_smd_text(sec.body)).encode("utf-8")
        ).hexdigest()[:12]
        filename = f"{safe_label}_{h}.wav"
        out = cache_dir / filename

        section_meta.append({"label": label, "filename": filename})
        output_paths.append(out)

        if out.exists():
            click.secho(f"  [Cache Hit]  {label}", fg="green")
        else:
            click.secho(f"  [New Task ]  {label}", fg="yellow")
            tasks.append((i, sec.body, str(out), voice, speed, label))

    # TTS -------------------------------------------------------------------
    if tasks:
        with ThreadPoolExecutor(max_workers=threads) as pool:
            futures = {pool.submit(_generate_section_audio, *t): t for t in tasks}
            for fut in as_completed(futures):
                idx, ok, lbl, info = fut.result()
                if ok:
                    click.echo(f"      -> Finished: {lbl:<25} (RTF: {info:.4f})")
                else:
                    click.secho(f"      !! Failed:  {lbl} — {info}", fg="red")

    # Combine ---------------------------------------------------------------
    combined: list[np.ndarray] = []
    manifest: list[dict] = []
    gap_samples = np.zeros(int(SAMPLE_RATE * gap))
    current_time = 0.0

    for i, out in enumerate(output_paths):
        if not out.exists():
            continue
        audio, _ = sf.read(out)
        dur = len(audio) / SAMPLE_RATE
        manifest.append(
            {
                "slide": section_meta[i]["label"],
                "start": round(current_time, 3),
                "duration": round(dur, 3),
            }
        )
        combined.append(audio)
        current_time += dur + gap
        if i < len(output_paths) - 1:
            combined.append(gap_samples)

    if not combined:
        return None

    final_file = output_dir / f"{input_path.stem}_full.wav"
    sf.write(final_file, np.concatenate(combined), SAMPLE_RATE)
    manifest_file = output_dir / "manifest.json"
    manifest_file.write_text(
        json.dumps(manifest, indent=2, ensure_ascii=False), encoding="utf-8"
    )
    click.secho(f"\n✅ Build Success: {final_file}", fg="green", bold=True)
    return final_file
