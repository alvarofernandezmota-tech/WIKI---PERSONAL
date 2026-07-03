#!/usr/bin/env bash
# scripts/agentes/galatea-create-pr.sh — Crea PR draft via GitHub CLI
set -euo pipefail

BRANCH="${1:-galatea/auto-$(date +%Y%m%d%H%M%S)}"
TITLE="${2:-[Galatea] Propuesta automática}"
MODE="${3:-draft}"  # draft | ready

ROOT="${YGGDRASIL_ROOT:-$(pwd)}"

# Verificar gh CLI
command -v gh >/dev/null 2>&1 || { echo "ERROR: gh CLI no instalado"; exit 1; }

# Crear rama y commit vacío de marcador si no hay cambios
git -C "$ROOT" checkout -b "$BRANCH" 2>/dev/null || git -C "$ROOT" checkout "$BRANCH"

# Si hay cambios pendientes, commitearlos
if ! git -C "$ROOT" diff --quiet || ! git -C "$ROOT" diff --cached --quiet; then
  git -C "$ROOT" add -A
  git -C "$ROOT" commit -m "$TITLE"
fi

git -C "$ROOT" push origin "$BRANCH" 2>/dev/null

# Crear PR
DRAFT_FLAG=""
[ "$MODE" = "draft" ] && DRAFT_FLAG="--draft"

PR_URL=$(gh pr create \
  --repo "alvarofernandezmota-tech/yggdrasil-dew" \
  --base main \
  --head "$BRANCH" \
  --title "$TITLE" \
  --body "## PR automático generado por Galatea\n\n- Rama: $BRANCH\n- Modo: $MODE\n- Timestamp: $(date -Iseconds)\n\n> ⚠️ Revisar antes de mergear. Generado automáticamente por agente-meta-deep." \
  $DRAFT_FLAG 2>&1)

echo "PR creado: $PR_URL"
