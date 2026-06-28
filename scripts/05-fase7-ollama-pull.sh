#!/bin/bash
# FASE 7 — Pull modelos Ollama: llama3.1:8b · bge-m3 · nomic-embed-text

set -euo pipefail

MODELOS=("llama3.1:8b" "bge-m3" "nomic-embed-text")

echo "🟢 [05] FASE 7 — Pull modelos Ollama"

curl -s http://localhost:11434/api/tags > /dev/null 2>&1 \
  && echo "✅ Ollama API accesible" \
  || { echo "❌ Ollama no responde. Verifica: docker compose ps | grep ollama"; exit 1; }

echo ""
echo "→ Modelos actualmente instalados:"
ollama list

echo ""
for modelo in "${MODELOS[@]}"; do
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "⬇️  Descargando: $modelo"
  ollama pull "$modelo" && echo "✅ $modelo OK" || echo "❌ Error con $modelo"
  echo ""
done

echo "→ Modelos tras pull:"
ollama list

echo ""
echo "✅ COMPLETADO — $(date '+%d-%m-%Y %H:%M CEST')"
echo "📝 Marca en PLAN:"
for modelo in "${MODELOS[@]}"; do
  echo "   [x] ollama pull $modelo"
done
echo ""
echo "🔗 Verifica en Open WebUI: http://100.91.112.32:3000"
