#!/bin/bash
# cierre-sesion.sh — Commit diario automático de fin de sesión
# Uso: bash setup/servidor/scripts/cierre-sesion.sh "descripción opcional"
# Ejecutar desde Acer o Madre al terminar el día.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
FECHA=$(date '+%Y-%m-%d')
HORA=$(date '+%H:%M')
DESC="${1:-sesión de trabajo}"

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log()  { echo -e "${GREEN}[CIERRE]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

cd "$REPO_DIR"

log "Repo: $REPO_DIR"
log "Fecha: $FECHA $HORA"

# Verificar si hay cambios
if git diff --quiet && git diff --staged --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
  warn "No hay cambios pendientes. Repo ya sincronizado."
  exit 0
fi

# Mostrar qué se va a commitear
log "Cambios detectados:"
git status --short

# Añadir todo
git add -A

# Commit con fecha
COMMIT_MSG="cierre $FECHA $HORA — $DESC"
git commit -m "$COMMIT_MSG"

# Push
git push origin main

log "✅ Commit y push completados: $COMMIT_MSG"
log "Repo sincronizado con GitHub."
