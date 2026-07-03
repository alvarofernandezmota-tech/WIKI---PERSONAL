#!/usr/bin/env bash
# =============================================================================
# run-backup.sh — Backup Restic 3-2-1 para Batcueva
# Destinos: A) Local Madre  B) SFTP varopc  C) Backblaze B2
# Uso: ./run-backup.sh [local|sftp|b2|all]
# Cron recomendado: 0 3 * * * /home/varopc/yggdrasil-dew/scripts/backup/run-backup.sh all
# =============================================================================
set -euo pipefail

# --- Cargar variables de entorno ---
ENV_FILE="$(dirname "$0")/../../.env"
if [[ -f "$ENV_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$ENV_FILE"
fi

# --- Config ---
BACKUP_SOURCES=(
  "/home/varopc/yggdrasil-dew"
  "/home/varopc/.config"
  "/home/varopc/.ssh"
)
EXCLUDES=(
  "--exclude=/home/varopc/yggdrasil-dew/.git"
  "--exclude=*.apk"
  "--exclude=*.iso"
  "--exclude=node_modules"
  "--exclude=__pycache__"
  "--exclude=.obsidian/workspace*"
)
KEEP_DAILY=7
KEEP_WEEKLY=4
KEEP_MONTHLY=6
LOG_DIR="/var/log/restic"
LOG_FILE="$LOG_DIR/backup-$(date +%Y%m%d-%H%M%S).log"

# --- Repos ---
REPO_LOCAL="${RESTIC_REPO_LOCAL:-/mnt/backup/restic}"
REPO_SFTP="${RESTIC_REPO_SFTP:-sftp:varopc@192.168.1.100:/backup/restic-madre}"
REPO_B2="${RESTIC_REPO_B2:-b2:batcueva-backup:/restic}"

mkdir -p "$LOG_DIR"

# =============================================================================
_log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"; }

_backup_to_repo() {
  local REPO="$1"
  local DEST_NAME="$2"
  local EXTRA_ENV="$3"

  _log "=== INICIO backup -> $DEST_NAME ==="
  eval "$EXTRA_ENV" restic -r "$REPO" \
    --password-file /etc/restic/password \
    backup "${BACKUP_SOURCES[@]}" \
    "${EXCLUDES[@]}" \
    --tag batcueva \
    --tag "$(hostname)" \
    --verbose 2>&1 | tee -a "$LOG_FILE"

  _log "Aplicando politica de retención en $DEST_NAME..."
  eval "$EXTRA_ENV" restic -r "$REPO" \
    --password-file /etc/restic/password \
    forget \
    --keep-daily   "$KEEP_DAILY" \
    --keep-weekly  "$KEEP_WEEKLY" \
    --keep-monthly "$KEEP_MONTHLY" \
    --prune 2>&1 | tee -a "$LOG_FILE"

  _log "=== FIN backup -> $DEST_NAME ==="
}

_init_repo() {
  local REPO="$1"
  local EXTRA_ENV="$2"
  if ! eval "$EXTRA_ENV" restic -r "$REPO" \
      --password-file /etc/restic/password \
      snapshots &>/dev/null; then
    _log "Inicializando repo $REPO..."
    eval "$EXTRA_ENV" restic -r "$REPO" \
      --password-file /etc/restic/password \
      init 2>&1 | tee -a "$LOG_FILE"
  fi
}

# =============================================================================
DEST="${1:-all}"

case "$DEST" in
  local)
    _init_repo "$REPO_LOCAL" ""
    _backup_to_repo "$REPO_LOCAL" "LOCAL" ""
    ;;
  sftp)
    _init_repo "$REPO_SFTP" ""
    _backup_to_repo "$REPO_SFTP" "SFTP-varopc" ""
    ;;
  b2)
    B2_ENV="B2_ACCOUNT_ID=${B2_ACCOUNT_ID:-} B2_ACCOUNT_KEY=${B2_ACCOUNT_KEY:-}"
    _init_repo "$REPO_B2" "$B2_ENV"
    _backup_to_repo "$REPO_B2" "Backblaze-B2" "$B2_ENV"
    ;;
  all)
    _init_repo "$REPO_LOCAL" ""
    _backup_to_repo "$REPO_LOCAL" "LOCAL" ""
    _init_repo "$REPO_SFTP" ""
    _backup_to_repo "$REPO_SFTP" "SFTP-varopc" ""
    B2_ENV="B2_ACCOUNT_ID=${B2_ACCOUNT_ID:-} B2_ACCOUNT_KEY=${B2_ACCOUNT_KEY:-}"
    _init_repo "$REPO_B2" "$B2_ENV"
    _backup_to_repo "$REPO_B2" "Backblaze-B2" "$B2_ENV"
    _log "=== BACKUP 3-2-1 COMPLETADO ==="
    ;;
  *)
    echo "Uso: $0 [local|sftp|b2|all]"
    exit 1
    ;;
esac
