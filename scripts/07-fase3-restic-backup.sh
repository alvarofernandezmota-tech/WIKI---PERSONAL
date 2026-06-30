#!/bin/bash
# Fase 3 — Backup Restic offsite

set -euo pipefail

REPO_DIR="$HOME/yggdrasil-dew"
RESTIC_ENV_FILE="$REPO_DIR/.env.restic"
EXCLUDES_FILE="$REPO_DIR/infra/restic-excludes.txt"

echo "🔄 [07] Fase 3 — Backup Restic"

# Comprobaciones básicas
if ! command -v restic >/dev/null 2>&1; then
  echo "❌ restic no está instalado. Instálalo antes de ejecutar esta fase."
  exit 1
fi

if [ ! -f "$RESTIC_ENV_FILE" ]; then
  echo "❌ Falta $RESTIC_ENV_FILE con configuración Restic (RESTIC_REPOSITORY, RESTIC_PASSWORD_FILE, RESTIC_BACKUP_PATHS)."
  echo "   Crea este archivo siguiendo docs/infra/backup-restic.md."
  exit 1
fi

# Cargar variables de entorno de Restic
# Esperado: RESTIC_REPOSITORY, RESTIC_PASSWORD_FILE, RESTIC_BACKUP_PATHS
# Ejemplo de .env.restic:
#   export RESTIC_REPOSITORY="rclone:remote:bucket/path"
#   export RESTIC_PASSWORD_FILE="$HOME/.config/restic/password.txt"
#   export RESTIC_BACKUP_PATHS="$HOME $HOME/docker"
source "$RESTIC_ENV_FILE"

if [ -z "${RESTIC_REPOSITORY:-}" ] || [ -z "${RESTIC_PASSWORD_FILE:-}" ] || [ -z "${RESTIC_BACKUP_PATHS:-}" ]; then
  echo "❌ Variables RESTIC_REPOSITORY / RESTIC_PASSWORD_FILE / RESTIC_BACKUP_PATHS incompletas en $RESTIC_ENV_FILE"
  exit 1
fi

if [ ! -f "$RESTIC_PASSWORD_FILE" ]; then
  echo "❌ RESTIC_PASSWORD_FILE no existe: $RESTIC_PASSWORD_FILE"
  exit 1
fi

RESTIC_CMD=(restic backup $RESTIC_BACKUP_PATHS)
if [ -f "$EXCLUDES_FILE" ]; then
  echo "→ Usando archivo de exclusiones: $EXCLUDES_FILE"
  RESTIC_CMD+=(--exclude-file "$EXCLUDES_FILE")
fi

echo "→ Lanzando backup Restic al repositorio: $RESTIC_REPOSITORY"
"${RESTIC_CMD[@]}"

echo ""
echo "→ Snapshots recientes:"
restic snapshots | tail -n 10 || true

echo ""
echo "✅ Fase 3 — backup Restic ejecutado: $(date '+%d-%m-%Y %H:%M CEST')"
echo "📝 Recuerda documentar en ESTADO-SISTEMA.md que Fase 3 está ejecutándose correctamente."
