#!/usr/bin/env bash
# =============================================================================
# inbox-commit.sh — Commitea TODO lo que haya en inbox/drop/ de una vez
# Uso: bash scripts/inbox-commit.sh "descripción de lo que entra"
# =============================================================================
set -euo pipefail

DESC="${1:-entrada manual}"
FECHA=$(date +%Y-%m-%d)
HORA=$(date +%H:%M)
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "main")

DROP_COUNT=$(find inbox/drop/ -not -name '.gitkeep' -not -type d 2>/dev/null | wc -l)

if [ "$DROP_COUNT" -eq 0 ]; then
  echo "ℹ️  inbox/drop/ está vacío. Nada que commitear."
  echo "   Copia tu archivo primero: cp /ruta/archivo.md inbox/drop/"
  exit 0
fi

echo "📦 $DROP_COUNT archivo(s) en inbox/drop/:"
find inbox/drop/ -not -name '.gitkeep' -not -type d 2>/dev/null | while read f; do echo "  → $f"; done

git add inbox/drop/
git commit -m "inbox(drop): ${FECHA} ${HORA} — ${DESC}"
git push origin "$BRANCH"

echo ""
echo "✅ Push hecho. El Action inbox-clasificador.yml clasificará los archivos automáticamente."
echo "   Revisa: https://github.com/alvarofernandezmota-tech/yggdrasil-dew/actions"
