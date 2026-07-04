#!/usr/bin/env bash
# =============================================================================
# inbox-commit.sh — UN solo comando para commitear todo lo que haya en
#                   inbox/drop/ directamente desde terminal.
#
# USO:
#   bash scripts/inbox-commit.sh "descripción de lo que entra"
#
# FLUJO:
#   1. Verifica que inbox/drop/ tenga archivos
#   2. git add inbox/drop/
#   3. git commit con mensaje estándar
#   4. git push origin main
#   → GitHub Actions detecta el push y clasifica automáticamente
# =============================================================================
set -euo pipefail

DESCRIPCION="${1:-entrada sin descripción}"
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo "$HOME/yggdrasil-dew")"
DROP_DIR="$REPO_ROOT/inbox/drop"
TIMESTAMP="$(date +%Y%m%dT%H%M%S)"

cd "$REPO_ROOT"

# 1. Verificar que hay archivos nuevos
if [[ -z "$(find "$DROP_DIR" -not -name '.gitkeep' -not -type d 2>/dev/null)" ]]; then
  echo "[inbox-commit] inbox/drop/ está vacío. Nada que commitear."
  exit 0
fi

echo "[inbox-commit] Archivos en drop/:"
ls -1 "$DROP_DIR"

# 2. Sincronizar primero
echo "[inbox-commit] Sincronizando con origin..."
git pull --rebase origin main 2>/dev/null || true

# 3. Add
git add "$DROP_DIR/"

# 4. Commit
COMMIT_MSG="inbox(drop): ${TIMESTAMP} — ${DESCRIPCION}"
git commit -m "$COMMIT_MSG"

# 5. Push
git push origin main

echo "[inbox-commit] ✓ Push completado. GitHub Actions clasificará los archivos."
echo "[inbox-commit] Commit: $COMMIT_MSG"
