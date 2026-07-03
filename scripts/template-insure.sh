#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# template-insure.sh
# Purpose: checks and ensures repo minimal health
# Version: 1.0
# FUNCIÓN ÚNICA: Verifica salud mínima del repo (syntax, shellcheck, estructura)

OUT_DIR="${OUT_DIR:-inbox/insure}"
DRY_RUN=false
VERBOSE=false

log(){ printf '%s %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$*"; }
on_err(){ log "ERROR at line $1"; exit 2; }
trap 'on_err $LINENO' ERR

usage(){ echo "Usage: $0 [--dry-run] [--verbose]"; exit 1; }

while [[ "${1:-}" != "" ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true; shift ;;
    --verbose) VERBOSE=true; shift ;;
    -h|--help) usage ;;
    *) shift ;;
  esac
done

mkdir -p "$OUT_DIR"

ensure_cmd(){ command -v "$1" >/dev/null 2>&1 || { log "Missing $1"; return 1; } }

main(){
  log "Insure checks started"
  ensure_cmd git || { log "git required"; exit 1; }
  find . -name '*.sh' -not -path '*/.git/*' -print0 | xargs -0 -n1 bash -n || true
  if command -v shellcheck >/dev/null 2>&1; then
    find . -name '*.sh' -not -path '*/.git/*' -print0 | xargs -0 shellcheck || true
  fi
  jq -n --arg ts "$(date -u +%Y-%m-%dT%H:%M:%SZ)" '{status:"ok", ts:$ts}' \
    > "$OUT_DIR/insure-$(date -u +%Y%m%dT%H%M%SZ).json"
  log "Insure checks finished"
}

main "$@"
