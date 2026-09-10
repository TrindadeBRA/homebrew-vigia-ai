cask "vigia-ai" do
  arch arm: "-arm64"

  version "2.13.7"
  sha256 arm:   "5382d753bff64b2e6acac1f18a5effbb9095ea61dedd56a2b43001d2e49e9ce3",
         intel: "50fcc268628f229998fae90d4af64ba3dda2bf4456f68ab485ab4a32fd517d36"

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
