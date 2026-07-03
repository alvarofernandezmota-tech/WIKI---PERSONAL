#!/usr/bin/env bash
# galatea-create-pr.sh — Crea branch + commit + PR automático para Galatea
# Uso: bash scripts/agentes/galatea-create-pr.sh <titulo> <cuerpo_archivo> [base_branch]
# Requiere: GITHUB_TOKEN, gh CLI instalado
# Ejemplo:
#   bash scripts/agentes/galatea-create-pr.sh \
#     "feat(galatea): nueva propuesta de refactor" \
#     /tmp/galatea-propuesta.md

set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(git rev-parse --show-toplevel)}"
cd "$ROOT"

# ── Args ───────────────────────────────────────────────────────────────
if [[ $# -lt 2 ]]; then
  echo "Uso: $0 <titulo> <archivo_cuerpo> [base_branch]"
  echo "Ejemplo: $0 \"feat: nueva propuesta\" /tmp/desc.md main"
  exit 1
fi

TITULO="$1"
CUERPO_FILE="$2"
BASE="${3:-main}"

if [[ ! -f "$CUERPO_FILE" ]]; then
  echo "ERROR: archivo de cuerpo no encontrado: $CUERPO_FILE"
  exit 2
fi

if ! command -v gh &>/dev/null; then
  echo "ERROR: gh CLI no instalado. Ver: https://cli.github.com/"
  exit 3
fi

if [[ -z "${GITHUB_TOKEN:-}" ]]; then
  echo "ERROR: GITHUB_TOKEN no definido"
  exit 4
fi

# ── Branch ─────────────────────────────────────────────────────────────
TS="$(date +%Y%m%dT%H%M%S)"
BRANCH="galatea/auto-pr-${TS}"

git checkout -b "$BRANCH"

# ── Preparar archivos del PR ─────────────────────────────────────────
# Si hay archivos en inbox/drop/, incluirlos en el commit
if ls "$ROOT/inbox/drop/"* &>/dev/null 2>&1; then
  git add "$ROOT/inbox/drop/"
  echo "[galatea-create-pr] Archivos en inbox/drop/ añadidos al commit"
fi

# Añadir el archivo de cuerpo si está dentro del repo
if [[ "$CUERPO_FILE" == "$ROOT"* ]]; then
  git add "$CUERPO_FILE"
fi

# Commit (sólo si hay cambios staged)
if git diff --cached --quiet; then
  # Crear un archivo de marca para que el commit no esté vacío
  MARCA="$ROOT/inbox/_meta/galatea-pr-${TS}.md"
  mkdir -p "$(dirname "$MARCA")"
  cat > "$MARCA" <<EOF
# Galatea Auto-PR $TS

$TITULO

$(cat "$CUERPO_FILE")
EOF
  git add "$MARCA"
fi

git commit -m "bot(galatea): $TITULO [auto-pr $TS]"

# ── Push y PR ───────────────────────────────────────────────────────────
git push origin "$BRANCH"

PR_URL=$(gh pr create \
  --title  "$TITULO" \
  --body-file "$CUERPO_FILE" \
  --base   "$BASE" \
  --head   "$BRANCH" \
  --label  "galatea,auto" \
  2>&1 | grep 'https://github.com' | head -1 || true)

if [[ -z "$PR_URL" ]]; then
  # Intentar sin label si falla (labels pueden no existir)
  PR_URL=$(gh pr create \
    --title  "$TITULO" \
    --body-file "$CUERPO_FILE" \
    --base   "$BASE" \
    --head   "$BRANCH" \
    2>&1 | grep 'https://github.com' | head -1 || true)
fi

echo "✅ PR creado: ${PR_URL:-'(ver en GitHub)'}"
echo "   Branch: $BRANCH"
echo "   Base:   $BASE"

# Volver a main
git checkout "$BASE"
