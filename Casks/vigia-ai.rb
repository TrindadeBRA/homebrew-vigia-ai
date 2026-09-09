cask "vigia-ai" do
  arch arm: "-arm64"

  version "2.11.2"
  sha256 arm:   "a34ba29e64847feff3312c68a84114b30f7466cea3ad9646014029b9290e74c7",
         intel: "8c8d947d7d6059079a8fd62c3049a087eb5fdcd9efb006750a7f7194dca9b1bf"

  url "https://github.com/TrindadeBRA/vigia-ai/releases/download/v#{version}/Vigia-AI-#{version}#{arch}.dmg"
  name "Vigia AI"
  desc "Painel local de cotas de assinaturas de IA (Claude, GPT, Cursor e outros)"
  homepage "https://github.com/TrindadeBRA/vigia-ai"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on :macos

  app "Vigia AI.app"

  # Sem certificado pago da Apple Developer ID, o build sai só ad-hoc
  # assinado — a Apple marca todo download direto do navegador como
  # "danificado" mesmo íntegro. O download do `brew` TAMBÉM grava
  # com.apple.quarantine (confirmado com xattr no .dmg em cache) — sem
  # este passo o app instalado herdaria a mesma flag e cairia no mesmo
  # aviso. Ver .agents/RELEASE.md no repo principal.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/Vigia AI.app"]
  end

  zap trash: [
    "~/Library/Application Support/vigia-ai-desktop",
    "~/Library/Preferences/com.trindadebra.vigia-ai.plist",
    "~/Library/Saved Application State/com.trindadebra.vigia-ai.savedState",
  ]
end
