# homebrew-vigia-ai

Tap Homebrew do [Vigia AI](https://github.com/TrindadeBRA/vigia-ai) — painel
local de cotas de assinaturas de IA (Claude, GPT, Cursor e outros).

## Instalar

```bash
brew tap TrindadeBRA/vigia-ai
brew install --cask vigia-ai
```

Sem certificado pago da Apple Developer ID, o `.dmg` baixado direto do
navegador sai marcado como "danificado" pelo Gatekeeper (aviso enganoso —
o app não está corrompido). Instalando por aqui isso não acontece: o
Homebrew baixa e o `postflight_steps` do cask já tira a flag de
quarentena sozinho. Detalhes técnicos em
[`.agents/RELEASE.md`](https://github.com/TrindadeBRA/vigia-ai/blob/main/.agents/RELEASE.md)
do repositório principal.

## Atualizar

```bash
brew upgrade --cask vigia-ai
```

## Versão

A fórmula em `Casks/vigia-ai.rb` é atualizada a cada release do
[repositório principal](https://github.com/TrindadeBRA/vigia-ai) pelo
workflow `release-desktop.yml`.
