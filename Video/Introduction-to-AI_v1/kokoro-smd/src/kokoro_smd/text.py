"""Text-cleaning utilities for Speech Markdown content."""

from __future__ import annotations

import re


def clean_smd_text(text: str) -> str:
    """Strip speech-markdown tags and return plain reading text.

    Processing steps
    ----------------
    1. Remove ``[note: …]`` annotation tags entirely.
    2. Replace ``[display](reading)``  →  ``reading``
       (handles optional ``alias:`` prefix).
    3. Remove style tags like ``#[Normal]``.
    """
    # 1. [note: ...] annotations
    text = re.sub(r"\[note:.*?\]", "", text, flags=re.DOTALL)

    # 2. [display](alias: reading) or [display](reading)  →  reading
    text = re.sub(r"\[.*?\]\((?:alias:\s*)?(.*?)\)", r"\1", text)

    # 3. Style tags  #[Normal] etc.
    text = re.sub(r"#\[\w+\]", "", text)

    return text.strip()
