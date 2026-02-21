"""SMD file parser — handles frontmatter, headings, and speech-markdown text."""

from __future__ import annotations

import re
from dataclasses import dataclass, field
from typing import Any


# ---------------------------------------------------------------------------
# Data classes
# ---------------------------------------------------------------------------

@dataclass
class Frontmatter:
    """YAML-like frontmatter extracted from the top of an SMD file."""

    raw: str
    """The raw text between the --- delimiters (excluding the delimiters)."""

    fields: dict[str, str] = field(default_factory=dict)
    """Key–value pairs parsed from simple ``key: value`` lines."""

    def __str__(self) -> str:
        return self.raw


@dataclass
class Section:
    """A single section of the SMD document, delimited by ``# …`` headings."""

    heading_raw: str
    """The raw heading line, e.g. ``# [01-01: Slide 1/10] タイトル …``."""

    heading_title: str
    """Extracted human-readable title from the heading."""

    slide_info: str
    """Slide reference extracted from ``[…]``, e.g. ``01-01: Slide 1/10``."""

    body: str
    """Content text belonging to this section (may be multi-line)."""


@dataclass
class SmdDocument:
    """Parsed representation of a complete ``.smd`` file."""

    frontmatter: Frontmatter | None
    """Frontmatter block, or *None* if the file has no frontmatter."""

    sections: list[Section]
    """Ordered list of sections within the document."""

    preamble: str
    """Any text before the first heading (after frontmatter), if present."""


# ---------------------------------------------------------------------------
# Internal helpers
# ---------------------------------------------------------------------------

_FRONTMATTER_RE = re.compile(r"\A---\n(.*?)\n---\n?", re.DOTALL)
_HEADING_RE = re.compile(r"^#\s+(.*)$", re.MULTILINE)
# Matches  [01-01: Slide 1/10]  at the start of a heading body
_SLIDE_INFO_RE = re.compile(r"^\[(.+?)\]\s*(.*)")


def _parse_frontmatter(text: str) -> tuple[Frontmatter | None, str]:
    """Extract frontmatter from the top of *text*.

    Returns ``(frontmatter_or_none, remaining_text)``.
    """
    m = _FRONTMATTER_RE.match(text)
    if m is None:
        return None, text

    raw = m.group(1)
    fields: dict[str, str] = {}
    for line in raw.splitlines():
        line = line.strip()
        if not line:
            continue
        # Try simple "key: value" or "key：value"
        kv = re.match(r"^(.+?)[：:]\s*(.+)$", line)
        if kv:
            fields[kv.group(1).strip()] = kv.group(2).strip()
        else:
            # First non-kv line is typically the title
            if "title" not in fields:
                fields["title"] = line

    return Frontmatter(raw=raw, fields=fields), text[m.end():]


def _parse_heading(raw_heading: str) -> tuple[str, str]:
    """Parse a heading such as ``[01-01: Slide 1/10] タイトル…``.

    Returns ``(slide_info, title)``.  If the heading does not contain a
    ``[…]`` prefix, *slide_info* is ``""`` and *title* is the full heading.
    """
    m = _SLIDE_INFO_RE.match(raw_heading)
    if m:
        return m.group(1).strip(), m.group(2).strip()
    return "", raw_heading.strip()


# ---------------------------------------------------------------------------
# Public API
# ---------------------------------------------------------------------------

def parse_smd(text: str) -> SmdDocument:
    """Parse a full ``.smd`` file into an :class:`SmdDocument`.

    Parameters
    ----------
    text:
        The raw file contents.

    Returns
    -------
    SmdDocument
        A structured representation of the SMD file.
    """
    frontmatter, rest = _parse_frontmatter(text)

    # Split on heading lines (``# …``) while keeping the headings
    parts = _HEADING_RE.split(rest)

    # parts[0] is preamble (before the first heading),
    # then alternating heading / body.
    preamble = parts[0].strip()
    sections: list[Section] = []

    for i in range(1, len(parts), 2):
        heading_text = parts[i]  # the text after ``# ``
        body = parts[i + 1].strip() if i + 1 < len(parts) else ""
        slide_info, title = _parse_heading(heading_text)
        sections.append(
            Section(
                heading_raw=f"# {heading_text}",
                heading_title=title,
                slide_info=slide_info,
                body=body,
            )
        )

    return SmdDocument(frontmatter=frontmatter, sections=sections, preamble=preamble)
