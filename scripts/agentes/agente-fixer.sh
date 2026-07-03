#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# agente-fixer.sh
# Role: Fixer (applies fixes suggested by mejorador)
# Version: 1.0
# Author: thdora-guardian[bot]
# FUNCIÓN ÚNICA: Aplica fixes de reports JSON generados por agente-mejorador

OUT_DIR="${OUT_DIR:-inbox/mejorador}"
DRY_RUN=true
VERBOSE=false

log(){ printf '%s %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$*"; }
on_err(){ log "ERROR at line $1"; exit 2; }
trap 'on_err $LINENO' ERR

usage(){ echo "Usage: $0 [--apply] [--verbose]"; exit 1; }

while [[ "${1:-}" != "" ]]; do
  case "$1" in
    --apply) DRY_RUN=false; shift ;;
    --verbose) VERBOSE=true; shift ;;
    -h|--help) usage ;;
    *) shift ;;
  esac
done

apply_patch_for_file(){
  local file="$1"
  local tmp
  tmp="$(mktemp)"
  cp "$file" "$tmp"
  local changed=false
  if [[ "${file##*.}" == "sh" ]]; then
    if ! head -n1 "$file" | grep -q '^#!/usr/bin/env bash'; then
      sed -i '1i#!/usr/bin/env bash' "$tmp"
      changed=true
    fi
    if ! grep -q "set -euo pipefail" "$tmp"; then
      sed -i "2iset -euo pipefail\nIFS=\$'\\\\n\\\\t'\n" "$tmp" || true
      changed=true
    fi
  fi
  if $changed; then
    if $DRY_RUN; then
      log "[DRY-RUN] Would update $file"
    else
      mv "$tmp" "$file"
      git add "$file"
      git commit -m "fix: apply agent-fixer changes to $file" || true
      log "Applied fixes to $file"
    fi
  else
    rm -f "$tmp"
    log "No changes for $file"
  fi
}

main(){
  log "Fixer started"
  mkdir -p "$OUT_DIR"
  for report in "$OUT_DIR"/*.json; do
    [[ -f "$report" ]] || continue
    file=$(jq -r '.file' "$report")
    apply_patch_for_file "$file"
  done
  log "Fixer finished"
}

main "$@"
