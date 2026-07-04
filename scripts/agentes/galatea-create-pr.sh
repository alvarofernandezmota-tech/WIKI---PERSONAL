#!/usr/bin/env bash
# scripts/agentes/galatea-create-pr.sh
# Crea una rama y PR draft con los cambios actuales no commiteados o un mensaje dado
# Uso: bash galatea-create-pr.sh "título del PR" ["cuerpo"]
set -euo pipefail

TITLE="${1:-chore: cambios automáticos por Galatea}"
BODY="${2:-PR generado automáticamente. Revisar antes de mergear.}"
BRANCH="galatea/auto-$(date +%Y%m%d-%H%M%S)"

if ! command -v gh &>/dev/null; then
  echo "ERROR: gh CLI no disponible. Instala: https://cli.github.com" >&2
  exit 1
fi

echo "Creando rama: $BRANCH"
git checkout -b "$BRANCH"

# Stage de cambios si hay
if ! git diff --cached --quiet || ! git diff --quiet; then
  git add -A
  git commit -m "$TITLE"
fi

git push origin "$BRANCH"

PR_URL=$(gh pr create \
  --title "$TITLE" \
  --body "$BODY" \
  --base main \
  --head "$BRANCH" \
  --draft)

echo "PR draft creado: $PR_URL"
