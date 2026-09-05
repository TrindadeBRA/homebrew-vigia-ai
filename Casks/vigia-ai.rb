cask "vigia-ai" do
  arch arm: "-arm64"

  version "2.2.3"
  sha256 arm:   "ec54bcbdbfa66f0a8dff99add3a7b136d796c044b91b2c7eb13ee27490cc16ab",
         intel: "0c299adec7a48c8fe1445c7c3e67f266c1cbe526935bdeff87adf34da44f774d"

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
  # "danificado" mesmo íntegro. O `brew install --cask` não passa pelo
  # Finder/LaunchServices pra copiar o app, então a flag de quarentena
  # nunca chega a ser um bloqueio: este postflight só garante que ela não
  # fique presa em nenhum caso. Ver .agents/RELEASE.md no repo principal.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/Vigia AI.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/vigia-ai-desktop",
    "~/Library/Preferences/com.trindadebra.vigia-ai.plist",
    "~/Library/Saved Application State/com.trindadebra.vigia-ai.savedState",
  ]
end
