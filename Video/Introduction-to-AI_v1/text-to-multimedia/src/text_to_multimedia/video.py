"""Video generation engine — PDF + WAV + manifest.json → MP4."""

from __future__ import annotations

import json
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

import click


def _check_dependencies() -> None:
    """FFmpegとpopplerが利用可能かチェックする。"""
    if shutil.which("ffmpeg") is None:
        click.secho(
            "❌ ffmpeg が見つかりません。'brew install ffmpeg' でインストールしてください。",
            fg="red",
        )
        sys.exit(1)
    if shutil.which("pdftoppm") is None:
        click.secho(
            "❌ pdftoppm が見つかりません。'brew install poppler' でインストールしてください。",
            fg="red",
        )
        sys.exit(1)


def make_video(
    pdf_path: Path,
    audio_path: Path,
    manifest_path: Path,
    output_path: Path,
    *,
    fps: int = 30,
    width: int = 1920,
    height: int = 1080,
) -> Path:
    """PDF スライド ＋ WAV 音声 ＋ manifest.json から MP4 動画を生成する。

    Parameters
    ----------
    pdf_path:
        スライドPDFファイルのパス（全ページを含む1ファイル）。
    audio_path:
        音声WAVファイルのパス（full WAV）。
    manifest_path:
        manifest.json ファイルのパス。
        ``[{"slide": "...", "start": 0.0, "duration": 10.0}, ...]`` 形式。
    output_path:
        出力MP4ファイルのパス。
    fps:
        出力動画のフレームレート（デフォルト: 30）。
    width:
        出力動画の横幅 px（デフォルト: 1920）。
    height:
        出力動画の縦幅 px（デフォルト: 1080）。

    Returns
    -------
    Path
        生成されたMP4ファイルのパス。
    """
    _check_dependencies()

    # manifest 読み込み
    manifest: list[dict] = json.loads(manifest_path.read_text(encoding="utf-8"))
    n_slides = len(manifest)
    click.secho(f"\n🎬 make-video: {n_slides} スライド検出", fg="cyan", bold=True)

    with tempfile.TemporaryDirectory(prefix="ttm_video_") as tmpdir:
        tmp = Path(tmpdir)

        # ------------------------------------------------------------------
        # Step 1: PDF → PNG (各ページ 1 枚)
        # ------------------------------------------------------------------
        click.echo("  [1/3] PDF → PNG 変換中...")

        # pdftoppm で全ページを PNG に変換
        # 出力ファイル: {tmp}/slide-{n}.png  (pdftoppm のデフォルト)
        pdftoppm_cmd = [
            "pdftoppm",
            "-png",
            "-r", "150",          # 解像度 150dpi (十分な品質)
            str(pdf_path),
            str(tmp / "slide"),
        ]
        result = subprocess.run(pdftoppm_cmd, capture_output=True, text=True)
        if result.returncode != 0:
            click.secho(f"❌ PDF変換エラー: {result.stderr}", fg="red")
            sys.exit(1)

        # 生成されたスライドPNGをソート順に取得
        slide_pngs = sorted(tmp.glob("slide-*.png"))
        n_pngs = len(slide_pngs)

        click.echo(f"     → {n_pngs} ページ生成")

        if n_pngs != n_slides:
            click.secho(
                f"⚠️  警告: PDFのページ数({n_pngs})と"
                f"manifestのエントリ数({n_slides})が一致しません。\n"
                f"     小さい方に合わせて処理を続行します。",
                fg="yellow",
            )
            n_slides = min(n_pngs, n_slides)
            slide_pngs = slide_pngs[:n_slides]
            manifest = manifest[:n_slides]

        # ------------------------------------------------------------------
        # Step 2: FFmpeg concat リスト生成
        # ------------------------------------------------------------------
        click.echo("  [2/3] タイミングリスト生成中...")

        concat_list = tmp / "filelist.txt"
        lines: list[str] = []

        # gap（スライド間の無音）を含めた実際の duration を算出する
        # manifest の gap は次のスライドの start - (current start + current duration) で求まる
        # ただし最後のスライドは音声の末尾までとする
        for i, (entry, png) in enumerate(zip(manifest, slide_pngs)):
            lines.append(f"file '{png}'")
            if i < n_slides - 1:
                next_start = manifest[i + 1]["start"]
                actual_dur = next_start - entry["start"]
            else:
                # 最後のスライドは duration のみ（gap なし）
                actual_dur = entry["duration"]
            lines.append(f"duration {actual_dur:.3f}")

        # concat demuxer では最後のファイルを重複指定する必要がある
        lines.append(f"file '{slide_pngs[-1]}'")

        concat_list.write_text("\n".join(lines), encoding="utf-8")

        # ------------------------------------------------------------------
        # Step 3: FFmpeg で動画合成
        # ------------------------------------------------------------------
        click.echo("  [3/3] 動画を合成中... (しばらくかかります)")

        output_path.parent.mkdir(parents=True, exist_ok=True)

        # vf: スケール＋レターボックス（アスペクト比を保ってパディング）
        vf = (
            f"scale={width}:{height}:force_original_aspect_ratio=decrease,"
            f"pad={width}:{height}:(ow-iw)/2:(oh-ih)/2:black"
        )

        # 音声の実際の長さを取得して動画長を明示指定（concat demuxer の映像が
        # 過長になる問題を回避するため -shortest の代わりに -t を使用）
        import soundfile as sf
        audio_info = sf.info(str(audio_path))
        audio_duration = audio_info.duration

        ffmpeg_cmd = [
            "ffmpeg",
            "-y",                         # 上書き確認なし
            "-f", "concat",
            "-safe", "0",
            "-i", str(concat_list),       # 映像: concat demuxer
            "-i", str(audio_path),        # 音声: WAV
            "-vf", vf,
            "-c:v", "libx264",
            "-preset", "fast",
            "-crf", "18",
            "-r", str(fps),
            "-c:a", "aac",
            "-b:a", "192k",
            "-t", f"{audio_duration:.3f}",  # 音声の長さに合わせてトリム
            "-movflags", "+faststart",    # ストリーミング向け最適化
            str(output_path),
        ]

        result = subprocess.run(ffmpeg_cmd, capture_output=True, text=True)
        if result.returncode != 0:
            click.secho(f"❌ FFmpegエラー:\n{result.stderr[-2000:]}", fg="red")
            sys.exit(1)

    click.secho(f"\n✅ 動画生成完了: {output_path}", fg="green", bold=True)
    return output_path
