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

from text_to_multimedia import __version__
from text_to_multimedia.parser import SmdDocument, Section, parse_smd
from text_to_multimedia.text import clean_smd_text

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

_BREAK_ONLY_RE = re.compile(r"^\s*\[break:\s*[\d\.]+(?:ms|s)\]\s*$")
_BREAK_RE = re.compile(r"\[break:\s*([\d\.]+)(ms|s)\]")


def _parse_break_duration(text: str) -> float | None:
    """Return break duration in seconds if *text* is a standalone break tag."""
    m = _BREAK_RE.search(text)
    if m is None:
        return None
    val, unit = float(m.group(1)), m.group(2)
    return val / 1000 if unit == "ms" else val


def _segment_lines(lines: list[str]) -> list[dict]:
    """Split *lines* into segments: text paragraphs and separator gaps.

    Returns a list of dicts, each with:
    - ``{"type": "text", "lines": [...]}``  — non-blank text lines
    - ``{"type": "sep", "duration": float | None}``
      — a gap; *duration* is set if a ``[break]`` tag was found,
      otherwise *None* (use default para_gap).
    """
    segments: list[dict] = []
    current_text: list[str] = []
    in_sep = False
    sep_break: float | None = None

    for line in lines:
        stripped = line.strip()

        # Blank line or standalone [break] line → separator
        if not stripped or _BREAK_ONLY_RE.match(stripped):
            # Flush any accumulated text paragraph
            if current_text:
                segments.append({"type": "text", "lines": current_text})
                current_text = []

            if not in_sep:
                in_sep = True
                sep_break = None

            # If this line has a [break], capture its duration
            if stripped:
                dur = _parse_break_duration(stripped)
                if dur is not None:
                    sep_break = dur
        else:
            # Non-blank text line
            if in_sep:
                # Flush separator
                segments.append({"type": "sep", "duration": sep_break})
                in_sep = False
                sep_break = None
            current_text.append(stripped)

    # Flush remaining
    if current_text:
        segments.append({"type": "text", "lines": current_text})
    if in_sep:
        segments.append({"type": "sep", "duration": sep_break})

    return segments


def _generate_section_audio(
    idx: int,
    raw_text: str,
    output_path: str,
    voice: str,
    speed: float,
    label: str,
    para_gap: float = 0.5,
) -> tuple[int, bool, str, float | str]:
    """Synthesise audio for one section and write to *output_path*.

    Returns ``(idx, success, label, rtf_or_error)``.
    """
    start = time.time()
    try:
        pipeline = _get_pipeline()
        lines = raw_text.strip().split("\n")
        segments = _segment_lines(lines)
        slide_audio: list[np.ndarray] = []

        for seg in segments:
            if seg["type"] == "sep":
                dur = seg["duration"] if seg["duration"] is not None else para_gap
                slide_audio.append(np.zeros(int(SAMPLE_RATE * dur)))
            else:
                # Text paragraph — process each line, joining without pause
                for text_line in seg["lines"]:
                    # Handle inline [break: …] within a text line
                    parts = re.split(r"(\[break:\s*[\d\.]+(?:ms|s)\])", text_line)
                    for part in parts:
                        part = part.strip()
                        if not part:
                            continue

                        bm = _BREAK_RE.match(part)
                        if bm:
                            val, unit = float(bm.group(1)), bm.group(2)
                            dur = val / 1000 if unit == "ms" else val
                            slide_audio.append(np.zeros(int(SAMPLE_RATE * dur)))
                        else:
                            clean = clean_smd_text(part)
                            if not clean:
                                continue
                            for _, _, audio in pipeline(
                                clean, voice=voice, speed=speed
                            ):
                                slide_audio.append(audio)

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
    cache_dir: Path | None = None,
    gap: float = 1.0,
    para_gap: float = 0.5,
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
    cache_dir:
        Shared cache directory for synthesised section WAVs.  When *None*
        (the default), a ``cache/`` subdirectory is created inside
        *output_dir*.
    gap:
        Silence between sections in seconds.
    para_gap:
        Silence between paragraphs (empty-line gaps) within a section,
        in seconds.  Overridden by explicit ``[break: …]`` tags.
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
    if cache_dir is None:
        cache_dir = output_dir / "cache"
    output_dir.mkdir(parents=True, exist_ok=True)
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
        params_str = json.dumps(
            {"v": __version__, "voice": voice, "speed": speed, "para_gap": para_gap},
            sort_keys=True,
        )
        h = hashlib.sha256(
            (safe_label + clean_smd_text(sec.body) + params_str).encode("utf-8")
        ).hexdigest()[:12]
        filename = f"{safe_label}_{h}.wav"
        out = cache_dir / filename

        section_meta.append({"label": label, "filename": filename})
        output_paths.append(out)

        if out.exists():
            click.secho(f"  [Cache Hit]  {label}", fg="green")
        else:
            click.secho(f"  [New Task ]  {label}", fg="yellow")
            tasks.append((i, sec.body, str(out), voice, speed, label, para_gap))

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
