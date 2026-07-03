#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# agente-vigilante.sh
# Role: Vigilante (SLA monitor and reporter)
# Version: 1.2
# Author: thdora-guardian[bot]
# FUNCIÓN ÚNICA: Vigila inbox/diary por staleness, genera reportes y abre issues

BASE="${BASE:-.}"
INBOX="${INBOX:-$BASE/inbox}"
DIARY="${DIARY:-$BASE/diary}"
THRESHOLD_HOURS="${THRESHOLD_HOURS:-24}"
BOT_NAME="${BOT_NAME:-thdora-guardian[bot]}"
OUT_DIR="${OUT_DIR:-$BASE/diary}"
VERBOSE=false

log(){ printf '%s %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$*"; }
on_err(){ log "ERROR at line $1"; exit 2; }
trap 'on_err $LINENO' ERR

usage(){ echo "Usage: $0 [--threshold HOURS] [--verbose]"; exit 1; }

while [[ "${1:-}" != "" ]]; do
  case "$1" in
    --threshold) THRESHOLD_HOURS="$2"; shift 2 ;;
    --verbose) VERBOSE=true; shift ;;
    -h|--help) usage ;;
    *) shift ;;
  esac
done

mkdir -p "$INBOX" "$DIARY" "$OUT_DIR"

check_staleness(){
  local dir="$1"
  local threshold="$2"
  local last
  last=$(find "$dir" -type f -printf '%T@ %p\n' 2>/dev/null | sort -n | tail -n1 | awk '{print $1}')
  if [[ -z "$last" ]]; then
    echo "stale"
    return
  fi
  local now
  now=$(date +%s)
  local diff hours
  diff=$(awk "BEGIN{print $now - $last}")
  hours=$(awk "BEGIN{print $diff/3600}")
  if (( $(echo "$hours > $threshold" | bc -l) )); then
    echo "stale"
  else
    echo "ok"
  fi
}

main(){
  log "Vigilante started"
  local inbox_status diary_status
  inbox_status=$(check_staleness "$INBOX" "$THRESHOLD_HOURS")
  diary_status=$(check_staleness "$DIARY" "$THRESHOLD_HOURS")
  local report_file="$OUT_DIR/sla-violation-$(date -u +%Y%m%dT%H%M%SZ).json"
  if [[ "$inbox_status" == "stale" || "$diary_status" == "stale" ]]; then
    jq -n --arg bot "$BOT_NAME" \
       --arg inbox "$inbox_status" \
       --arg diary "$diary_status" \
       --arg ts "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
      '{bot:$bot, inbox:$inbox, diary:$diary, ts:$ts}' > "$report_file"
    log "SLA violation: report written to $report_file"
    if command -v gh >/dev/null 2>&1 && [[ -n "${GITHUB_TOKEN:-}" ]]; then
      gh issue create --title "SLA violation detected" \
        --body "$(cat "$report_file")" || true
    fi
  else
    log "All systems nominal"
  fi
  log "Vigilante finished"
}

main "$@"
