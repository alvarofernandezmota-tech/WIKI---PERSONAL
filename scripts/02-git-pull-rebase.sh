#!/bin/bash
# Sincronizar yggdrasil-dew en Madre

set -euo pipefail

REPO_DIR="$HOME/yggdrasil-dew"

echo "🔄 [02] git pull --rebase — yggdrasil-dew"

if [ ! -d "$REPO_DIR/.git" ]; then
  echo "❌ No existe repo en $REPO_DIR"
  exit 1
fi

cd "$REPO_DIR"

echo "→ Estado antes:"
git status --short
echo "→ Último commit:"
git log --oneline -3

echo ""
echo "→ Ejecutando pull --rebase..."
git pull --rebase origin main

echo ""
echo "→ Commit tras pull:"
git log --oneline -3

echo ""
echo "✅ COMPLETADO — $(date '+%d-%m-%Y %H:%M CEST')"
echo "📝 Marca en PLAN: [x] git pull --rebase en Madre"
echo "   Commit: $(git rev-parse --short HEAD)"
