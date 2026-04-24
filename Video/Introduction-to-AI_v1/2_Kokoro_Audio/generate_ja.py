from kokoro import KPipeline
import soundfile as sf

# 日本語パイプラインの初期化
# 初回実行時にモデル（300MB程度）をHuggingFaceからダウンロードします
pipeline = KPipeline(lang_code='j')

text = "手嶋さん、こんにちは。miseでシステムライブラリまで管理すると、環境構築がとても楽になりますね。"

# 音声生成 (voice='jf_alpha' は日本語向け女性ボイスの例)
generator = pipeline(
    text, 
    voice='jf_alpha', 
    speed=1.1
)

for i, (gs, ps, audio) in enumerate(generator):
    sf.write(f"output_{i}.wav", audio, 24000)
    print(f"Generated: output_{i}.wav")