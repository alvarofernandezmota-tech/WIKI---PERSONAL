#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# agente-mejorador.sh
# Role: Mejorador (suggests fixes, creates branches and PRs)
# Version: 1.1
# Author: thdora-guardian[bot]
# FUNCIÓN ÚNICA: Detecta problemas en scripts/docs, genera branches agent-fix/* y PRs

REPO_ROOT="${REPO_ROOT:-.}"
OUT_DIR="${OUT_DIR:-inbox/mejorador}"
GIT_AUTHOR="${GIT_AUTHOR:-thdora-guardian[bot] <bot@example.com>}"
DRY_RUN=true
VERBOSE=false

log(){ printf '%s %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$*"; }
err(){ printf '%s ERROR %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$*" >&2; }
on_err(){ err "Unexpected error at line $1"; exit 2; }
trap 'on_err $LINENO' ERR

usage(){
  cat <<EOF
Usage: $0 [--apply] [--verbose] [--out DIR]
  --apply     Apply fixes and push branches (default: dry-run)
  --verbose   Verbose logging
  --out DIR   Output directory for reports (default: $OUT_DIR)
EOF
  exit 1
}

while [[ "${1:-}" != "" ]]; do
  case "$1" in
    --apply) DRY_RUN=false; shift ;;
    --verbose) VERBOSE=true; shift ;;
    --out) OUT_DIR="$2"; shift 2 ;;
    -h|--help) usage ;;
    *) shift ;;
  esac
done

mkdir -p "$OUT_DIR"

find_candidates(){
  find "$REPO_ROOT" -type f \( -name '*.sh' -o -name '*.py' -o -name '*.md' \) \
    -not -path '*/.git/*' -print0 \
    | xargs -0 -n1 bash -c 'f="$0"; grep -Iq . "$f" || exit 0; (head -n1 "$f" | grep -q "^#!/" || grep -q "TODO" "$f") && echo "$f"' || true
}

analyze_file(){
  local file="$1"
  local report="$OUT_DIR/$(echo "$file" | tr '/' '_' | sed 's/[^a-zA-Z0-9_.-]/_/g').json"
  local issues=()
  if [[ "${file##*.}" == "sh" ]]; then
    if ! head -n1 "$file" | grep -q '^#!/usr/bin/env bash'; then
      issues+=("missing_shebang")
    fi
    if ! grep -q "set -euo pipefail" "$file"; then
      issues+=("missing_strict_mode")
    fi
  fi
  if grep -q "TODO" "$file"; then
    issues+=("has_todo")
  fi
  jq -n --arg file "$file" --argjson issues "$(printf '%s\n' "${issues[@]:-}" | jq -R . | jq -s .)" \
    '{file:$file, issues:$issues, ts:now}' > "$report"
  $VERBOSE && log "Analyzed $file -> $report"
  echo "$report"
}

create_branch_and_patch(){
  local file="$1"
  local branch="agent-fix/$(basename "$file")-$(date -u +%s)"
  log "Preparing branch $branch for $file"
  git fetch origin main || true
  git checkout -b "$branch"
  local changed=false

  if [[ "${file##*.}" == "sh" ]]; then
    if ! head -n1 "$file" | grep -q '^#!/usr/bin/env bash'; then
      sed -i '1i#!/usr/bin/env bash' "$file"
      changed=true
    fi
    if ! grep -q "set -euo pipefail" "$file"; then
      sed -i "2iset -euo pipefail\nIFS=\$'\\\\n\\\\t'\n" "$file" || true
      changed=true
    fi
  fi

  if $changed; then
    git add "$file"
    git commit -m "chore: agent suggested fixes for $file" --author "$GIT_AUTHOR" || true
    if $DRY_RUN; then
      log "[DRY-RUN] Would push branch $branch with fixes"
      git checkout - >/dev/null 2>&1 || true
      git branch -D "$branch" >/dev/null 2>&1 || true
    else
      git push -u origin "$branch"
      if command -v gh >/dev/null 2>&1; then
        gh pr create --title "Agent fixes: $(basename "$file")" \
          --body "Automated fixes proposed by agent-mejorador" \
          --base main --head "$branch" || true
      fi
    fi
  else
    log "No simple fixes for $file"
    git checkout - >/dev/null 2>&1 || true
    git branch -D "$branch" >/dev/null 2>&1 || true
  fi
}

main(){
  log "Mejorador started"
  local candidates
  mapfile -t candidates < <(find_candidates)
  if [[ ${#candidates[@]} -eq 0 ]]; then
    log "No candidates found"
    exit 0
  fi
  for f in "${candidates[@]}"; do
    analyze_file "$f"
  done
  for report in "$OUT_DIR"/*.json; do
    [[ -f "$report" ]] || continue
    file=$(jq -r '.file' "$report")
    issues_count=$(jq '.issues | length' "$report")
    if [[ "$issues_count" -gt 0 ]]; then
      create_branch_and_patch "$file"
    fi
  done
  log "Mejorador finished"
}

main "$@"
