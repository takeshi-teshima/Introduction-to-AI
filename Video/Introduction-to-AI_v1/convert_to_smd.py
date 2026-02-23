#!/usr/bin/env python3
"""Convert lecture scripts from 1_Scripts format to .smd format for 3_Audio_Scripts.

Target .smd format (based on 2_Kokoro_Audio/lecture.smd):
- `# [Section-ID: Slide N]` as section headings
- `#[Normal]` prefix on first line if needed
- Plain text for lecture content
- No structural separators (--- 次のスライドへ --- etc.)
- Header metadata preserved as comments

Source format:
- Header block with ========, title, duration, slide count
- Slide sections with ■ スライド N／M：タイトル
- Content lines
- --- 次のスライドへ --- separators
"""

import re
import os
import glob
from pathlib import Path

BASE_DIR = Path("/Users/teshima/2025/Introduction-to-AI/Video/Introduction-to-AI_v1")
SCRIPTS_DIR = BASE_DIR / "1_Scripts"
OUTPUT_DIR = BASE_DIR / "3_Audio_Scripts"


def parse_script(filepath: Path) -> dict:
    """Parse a lecture script file and return structured data."""
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Normalize line endings
    content = content.replace('\r\n', '\n').replace('\r', '\n')
    lines = content.split('\n')

    # Parse header
    header_info = {}
    header_end = 0

    # Find title from header
    for i, line in enumerate(lines):
        stripped = line.strip()
        if stripped.startswith('========'):
            continue
        if re.match(r'^\d{2}-\d{2}', stripped):
            header_info['title'] = stripped
        if '想定所要時間' in stripped:
            header_info['duration'] = stripped
        if 'スライド枚数' in stripped:
            header_info['slide_count'] = stripped
        # Find first slide marker to determine header end
        if stripped.startswith('■ スライド') or stripped.startswith('----------------------------------------'):
            if '■ スライド' not in stripped:
                continue
            header_end = i
            break
        # Also check if we hit the first slide delimiter
        if stripped.startswith('----------------------------------------') and i > 0:
            # Look ahead for slide marker
            for j in range(i, min(i + 3, len(lines))):
                if '■ スライド' in lines[j]:
                    header_end = i
                    break

    # Parse slides
    slides = []
    current_slide = None
    i = 0
    while i < len(lines):
        line = lines[i].strip()

        # Detect slide delimiter pattern
        if line.startswith('----------------------------------------'):
            # Look for slide header in next lines
            for j in range(i + 1, min(i + 3, len(lines))):
                stripped_j = lines[j].strip()
                match = re.match(r'■ スライド\s*(\d+)／(\d+)(?:：(.+))?', stripped_j)
                if match:
                    # Save previous slide
                    if current_slide is not None:
                        slides.append(current_slide)

                    slide_num = match.group(1)
                    total_slides = match.group(2)
                    slide_title = match.group(3) if match.group(3) else ""
                    slide_title = slide_title.strip()

                    current_slide = {
                        'number': int(slide_num),
                        'total': int(total_slides),
                        'title': slide_title,
                        'content_lines': []
                    }

                    # Skip past the delimiter block (dashes + slide header + dashes)
                    # Find the closing dashes
                    k = j + 1
                    while k < len(lines) and lines[k].strip() != '----------------------------------------':
                        k += 1
                    i = k + 1  # Skip past closing dashes
                    break
            else:
                i += 1
            continue

        # Skip slide transition markers
        if line == '--- 次のスライドへ ---':
            i += 1
            continue

        # Skip trailing ======== blocks
        if line.startswith('========'):
            i += 1
            continue

        # Add content to current slide
        if current_slide is not None:
            current_slide['content_lines'].append(lines[i])
        i += 1

    # Don't forget last slide
    if current_slide is not None:
        slides.append(current_slide)

    return {
        'header': header_info,
        'slides': slides,
        'filename': filepath.stem
    }


def format_smd(parsed: dict, section_id: str) -> str:
    """Format parsed script data into .smd format."""
    output_lines = []

    # Add header as comments
    header = parsed['header']
    if header.get('title'):
        output_lines.append(f"# {header['title']}")
    if header.get('duration'):
        output_lines.append(f"# {header['duration']}")
    if header.get('slide_count'):
        output_lines.append(f"# {header['slide_count']}")
    output_lines.append("")

    for slide in parsed['slides']:
        # Section heading with slide info
        slide_title = slide['title']
        heading = f"# [{section_id}: Slide {slide['number']}/{slide['total']}] {slide_title}"
        output_lines.append(heading)

        # Content - trim leading/trailing blank lines
        content = slide['content_lines']

        # Strip trailing empty lines
        while content and content[-1].strip() == '':
            content = content[:-1]
        # Strip leading empty lines
        while content and content[0].strip() == '':
            content = content[1:]

        for line in content:
            output_lines.append(line.rstrip())

        output_lines.append("")

    return '\n'.join(output_lines)


def get_section_id(filename: str) -> str:
    """Extract section ID from filename, e.g., '01-02+01-03' from '01-02+01-03_教師付き学習と線形回帰'."""
    match = re.match(r'(\d{2}[-+\d]+(?:\+\d{2}-\d{2})*)', filename)
    if match:
        return match.group(1)
    return filename


def find_lecture_scripts(section_dir: Path) -> list:
    """Find actual lecture script files (exclude メモ, 改善提案, etc.)."""
    scripts = []
    for f in sorted(section_dir.glob('*.txt')):
        name = f.stem
        # Skip non-lecture files
        skip_patterns = [
            'スライド改善提案',
            'セクション構成メモ',
            'セクション構成の振り返り',
            '番号付け修正',
            'プロジェクト全体',
            '復習',
            '検証レポート',
        ]
        if any(p in name for p in skip_patterns):
            continue
        # Must start with XX-YY pattern
        if not re.match(r'^\d{2}-\d{2}', name):
            continue
        scripts.append(f)
    return scripts


def main():
    # Create output directory
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    sections = ['section_00', 'section_01', 'section_02', 'section_03']

    for section_name in sections:
        section_dir = SCRIPTS_DIR / section_name
        if not section_dir.exists():
            continue

        out_section_dir = OUTPUT_DIR / section_name
        out_section_dir.mkdir(parents=True, exist_ok=True)

        scripts = find_lecture_scripts(section_dir)
        print(f"\n=== {section_name} ===")
        for script in scripts:
            print(f"  Processing: {script.name}")
            parsed = parse_script(script)
            section_id = get_section_id(script.stem)
            smd_content = format_smd(parsed, section_id)

            out_file = out_section_dir / f"{script.stem}.smd"
            with open(out_file, 'w', encoding='utf-8') as f:
                f.write(smd_content)
            print(f"    -> {out_file.name} ({len(parsed['slides'])} slides)")


if __name__ == '__main__':
    main()
