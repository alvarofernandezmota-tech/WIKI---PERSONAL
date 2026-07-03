#!/usr/bin/env bash
# =============================================================================
# check-backup.sh — Verificar integridad repos Restic
# Uso: ./check-backup.sh [local|sftp|b2|all]
# Cron recomendado: 0 4 * * 0  (domingos a las 4am)
# =============================================================================
set -euo pipefail

ENV_FILE="$(dirname "$0")/../../.env"
[[ -f "$ENV_FILE" ]] && source "$ENV_FILE"

REPO_LOCAL="${RESTIC_REPO_LOCAL:-/mnt/backup/restic}"
REPO_SFTP="${RESTIC_REPO_SFTP:-sftp:varopc@192.168.1.100:/backup/restic-madre}"
REPO_B2="${RESTIC_REPO_B2:-b2:batcueva-backup:/restic}"

_check() {
  local REPO="$1" NAME="$2" EXTRA="$3"
  echo "[$(date '+%H:%M:%S')] Verificando $NAME..."
  eval "$EXTRA" restic -r "$REPO" \
    --password-file /etc/restic/password \
    check --read-data-subset=5%
  echo "[$(date '+%H:%M:%S')] $NAME OK"
}

DEST="${1:-all}"
case "$DEST" in
  local) _check "$REPO_LOCAL" "LOCAL" "" ;;
  sftp)  _check "$REPO_SFTP"  "SFTP"  "" ;;
  b2)    _check "$REPO_B2"    "B2"    "B2_ACCOUNT_ID=${B2_ACCOUNT_ID:-} B2_ACCOUNT_KEY=${B2_ACCOUNT_KEY:-}" ;;
  all)
    _check "$REPO_LOCAL" "LOCAL" ""
    _check "$REPO_SFTP"  "SFTP"  ""
    _check "$REPO_B2"    "B2"    "B2_ACCOUNT_ID=${B2_ACCOUNT_ID:-} B2_ACCOUNT_KEY=${B2_ACCOUNT_KEY:-}"
    echo "=== CHECK 3-2-1 COMPLETADO ==="
    ;;
esac
