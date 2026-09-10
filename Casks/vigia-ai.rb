cask "vigia-ai" do
  arch arm: "-arm64"

  version "2.13.0"
  sha256 arm:   "41b7915497df5c6492149d63ee900cf17a84edd20aa588e762601790e299a1ea",
         intel: "3152a0844296cac02fd56da2a25f68d79189f3eb5f3401b8831c7cc43364ebd8"

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
