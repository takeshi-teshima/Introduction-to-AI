"""YAML project file schema and auto-discovery logic for video batch generation."""

from __future__ import annotations

import re
from dataclasses import dataclass, field
from pathlib import Path
from typing import Optional

import yaml


# ---------------------------------------------------------------------------
# Data model
# ---------------------------------------------------------------------------

@dataclass
class VideoEntry:
    """単一の動画生成タスクを表す。"""

    id: str
    """動画の識別子（例: '00-01', '01-11'）。"""

    pdf: str
    """スライドPDFのパス（base_dir 相対 or 絶対）。"""

    audio: str
    """音声WAVファイルのパス。"""

    manifest: str
    """manifest.json のパス。"""

    output: str
    """出力MP4のパス。"""

    def resolve(self, base_dir: Path) -> "ResolvedVideoEntry":
        """パスを絶対パスに解決した ResolvedVideoEntry を返す。"""
        def _abs(p: str) -> Path:
            path = Path(p)
            return path if path.is_absolute() else (base_dir / path).resolve()

        return ResolvedVideoEntry(
            id=self.id,
            pdf=_abs(self.pdf),
            audio=_abs(self.audio),
            manifest=_abs(self.manifest),
            output=_abs(self.output),
        )


@dataclass
class ResolvedVideoEntry:
    """パスを解決済みの VideoEntry。"""
    id: str
    pdf: Path
    audio: Path
    manifest: Path
    output: Path


@dataclass
class VideoProject:
    """YAML プロジェクトファイル全体を表す。"""

    base_dir: Path
    """相対パスの解決に使うベースディレクトリ。"""

    videos: list[VideoEntry]

    @classmethod
    def from_yaml(cls, yaml_path: Path) -> "VideoProject":
        """YAMLファイルから VideoProject をロードする。"""
        data = yaml.safe_load(yaml_path.read_text(encoding="utf-8"))

        # base_dir: 指定なければ YAML ファイルが置かれているディレクトリ
        raw_base = data.get("base_dir")
        if raw_base:
            base_dir = Path(raw_base)
            if not base_dir.is_absolute():
                base_dir = (yaml_path.parent / base_dir).resolve()
        else:
            base_dir = yaml_path.parent.resolve()

        videos = [
            VideoEntry(
                id=v["id"],
                pdf=v["pdf"],
                audio=v["audio"],
                manifest=v["manifest"],
                output=v["output"],
            )
            for v in data.get("videos", [])
        ]
        return cls(base_dir=base_dir, videos=videos)

    def to_yaml_str(self) -> str:
        """YAMLテキストを生成する。"""
        data: dict = {
            "base_dir": str(self.base_dir),
            "videos": [
                {
                    "id": v.id,
                    "pdf": v.pdf,
                    "audio": v.audio,
                    "manifest": v.manifest,
                    "output": v.output,
                }
                for v in self.videos
            ],
        }
        return yaml.dump(data, allow_unicode=True, sort_keys=False, default_flow_style=False)


# ---------------------------------------------------------------------------
# Auto-discovery
# ---------------------------------------------------------------------------

_ID_RE = re.compile(r"^(\d{2}-\d{2})")
"""スライドIDパターン: 'XX-YY' （例 '00-01', '01-11'）"""


def _extract_id(name: str) -> str | None:
    """ファイル名またはディレクトリ名の先頭から 'XX-YY' を抽出する。"""
    m = _ID_RE.match(name)
    return m.group(1) if m else None


def discover_project(
    audio_dir: Path,
    pdf_dir: Path,
    output_dir: Path,
    base_dir: Path | None = None,
) -> VideoProject:
    """audio_dir と pdf_dir を走査して VideoProject を自動生成する。

    Parameters
    ----------
    audio_dir:
        ``mise run batch`` の出力ルートディレクトリ（例: ``4_Audio/``）。
        子ディレクトリを再帰的に走査して ``manifest.json`` を持つものを列挙する。
    pdf_dir:
        スライドPDFが置かれたディレクトリ。
    output_dir:
        動画の出力先ルートディレクトリ（例: ``5_Video/``）。
        audio_dir からのディレクトリ構造をミラーする。
    base_dir:
        YAML の ``base_dir`` に書き込む値。None なら audio_dir の親ディレクトリ。

    Returns
    -------
    VideoProject
        自動生成されたプロジェクト。PDF が見つからなかったエントリは
        ``pdf`` フィールドが ``"???"`` になる。
    """
    if base_dir is None:
        base_dir = audio_dir.parent.resolve()

    # PDF 一覧を ID → Path にマッピング
    pdf_map: dict[str, Path] = {}
    for pdf_path in sorted(pdf_dir.glob("*.pdf")):
        vid = _extract_id(pdf_path.stem)
        if vid:
            # 同一IDが複数ある場合は短い名前（サフィックスなし）を優先
            if vid not in pdf_map or len(pdf_path.stem) < len(pdf_map[vid].stem):
                pdf_map[vid] = pdf_path

    # audio_dir 以下の manifest.json を走査
    entries: list[VideoEntry] = []
    for manifest_path in sorted(audio_dir.rglob("manifest.json")):
        audio_subdir = manifest_path.parent

        # full WAV を探す
        wavs = list(audio_subdir.glob("*_full.wav"))
        if not wavs:
            continue
        wav_path = wavs[0]

        # ID を抽出
        vid = _extract_id(audio_subdir.name)
        if not vid:
            continue

        # PDF を特定
        matched_pdf = pdf_map.get(vid)
        pdf_str = str(_relpath(matched_pdf, base_dir)) if matched_pdf else "???"

        # 出力パスを決定（audio_dir からの相対構造を output_dir にミラー）
        rel = audio_subdir.relative_to(audio_dir)
        # rel は section_XX/XX-YY_タイトル → section_XX/XX-YY.mp4 に
        section_part = rel.parts[0] if len(rel.parts) >= 1 else ""
        out_path = output_dir / section_part / f"{vid}.mp4"

        entries.append(VideoEntry(
            id=vid,
            pdf=pdf_str,
            audio=str(_relpath(wav_path, base_dir)),
            manifest=str(_relpath(manifest_path, base_dir)),
            output=str(_relpath(out_path, base_dir)),
        ))

    return VideoProject(base_dir=base_dir, videos=entries)


def _relpath(path: Path, base: Path) -> Path:
    """path を base からの相対パスに変換する。不可能な場合は絶対パスを返す。"""
    try:
        return path.resolve().relative_to(base.resolve())
    except ValueError:
        return path.resolve()
