from huggingface_hub import hf_hub_download
import os
import shutil

def download():
    # ONNX 版を専門に扱っているリポジトリに変更
    repo_id = "onnx-community/Kokoro-82M-v1.0-ONNX"
    # ファイル名もリポジトリの構成に合わせて修正
    files = ["model.onnx", "voices.json"]
    
    print(f"Hugging Face ({repo_id}) からモデルをダウンロード中...")
    
    for filename in files:
        try:
            path = hf_hub_download(repo_id=repo_id, filename=filename)
            # 現在のディレクトリに別名で保存（スクリプトとの整合性のため）
            target_name = "kokoro-v1.0.onnx" if filename == "model.onnx" else "voices.json"
            shutil.copy(path, target_name)
            size_mb = os.path.getsize(target_name) / (1024 * 1024)
            print(f"  ✓ {target_name} ({size_mb:.1f} MB) を取得しました")
        except Exception as e:
            print(f"  × {filename} のダウンロードに失敗しました: {e}")

if __name__ == "__main__":
    download()