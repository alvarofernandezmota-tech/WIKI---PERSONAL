#!/usr/bin/env bash
# implement_priorities_1_to_4.sh
# Doc: docs/  <- COMPLETAR ruta al doc relacionado
# Fase: <- COMPLETAR fase
# Descripción: <- COMPLETAR
# scripts/maintenance/implement_priorities_1_to_4.sh
# Implementa PRIORIDAD 1..4 según auditoría: consolidación orquestadores,
# auto-commit cierre-sesion, migración sesiones->diarios, auditoría pre-sesión.
#
# Usage:
#   ./scripts/maintenance/implement_priorities_1_to_4.sh        # dry-run
#   ./scripts/maintenance/implement_priorities_1_to_4.sh --apply  # apply changes, commit & push
#   ./scripts/maintenance/implement_priorities_1_to_4.sh --help
set -euo pipefail

ROOT="$(pwd)"
TS="$(date +%Y%m%d-%H%M%S)"
DRY_RUN=true
APPLY=false
GITHUB_REMOTE="${GITHUB_REMOTE:-origin}"
GITHUB_TOKEN="${GITHUB_TOKEN:-}"
BRANCH_PREFIX="maintenance/priority"
REPORT_DIR="$ROOT/reports/maintenance"
BACKUP_DIR="$ROOT/maintenance/backups/$TS"
AUDIT_DOC="scripts/SCRIPTS-AUDITORIA.md"

print_help(){
  cat <<EOF
implement_priorities_1_to_4.sh

Options:
  --apply        Apply changes (create branches, commit, push, create PRs if token present)
  --remote NAME  Use remote NAME for push (default: origin)
  --help         Show this help
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --apply) DRY_RUN=false; APPLY=true; shift ;;
    --remote) GITHUB_REMOTE="$2"; shift 2 ;;
    -h|--help) print_help; exit 0 ;;
    *) echo "Unknown arg: $1"; print_help; exit 1 ;;
  esac
done

mkdir -p "$REPORT_DIR" "$BACKUP_DIR"
echo "# SCRIPTS AUDITORIA - cambios aplicados por implement_priorities_1_to_4" > "$AUDIT_DOC"
echo "Timestamp: $TS" >> "$AUDIT_DOC"
echo "" >> "$AUDIT_DOC"

# Utility: create branch and optionally push
create_branch_and_push(){
  local branch="$1"
  if $DRY_RUN; then
    echo "[DRY-RUN] would create branch: $branch"
  else
    git checkout -b "$branch"
  fi
}

commit_and_push(){
  local msg="$1"
  if $DRY_RUN; then
    echo "[DRY-RUN] would git add/commit: $msg"
  else
    git add -A
    git commit -m "$msg"
    git push "$GITHUB_REMOTE" HEAD
  fi
}

create_pr_draft(){
  local branch="$1"
  local title="$2"
  local body="$3"
  if [ -z "$GITHUB_TOKEN" ]; then
    echo "[INFO] GITHUB_TOKEN not set — skipping PR creation for $branch"
    return 0
  fi
  REPO_API=$(git remote get-url "$GITHUB_REMOTE" | sed -E 's#(git@github.com:|https://github.com/)([^/]+/[^.]+)(.git)?#https://api.github.com/repos/\2#')
  payload=$(jq -nc --arg t "$title" --arg b "$body" --arg h "$branch" --arg base "main" '{title:$t,body:$b,head:$h,base:$base,draft:true}')
  if $DRY_RUN; then
    echo "[DRY-RUN] would create draft PR: $title -> $branch"
    echo "Payload: $payload"
  else
    resp=$(curl -s -X POST "$REPO_API/pulls" -H "Authorization: token $GITHUB_TOKEN" -H "Content-Type: application/json" -d "$payload")
    url=$(echo "$resp" | jq -r '.html_url // empty')
    if [ -n "$url" ]; then
      echo "Draft PR created: $url"
    else
      echo "Failed to create PR for $branch. Response: $resp"
    fi
  fi
}

# ---------------------------------------------------------------------------
# PRIORIDAD 1: Consolidación de orquestadores
# ---------------------------------------------------------------------------
echo "## PRIORIDAD 1: Consolidación orquestadores" >> "$AUDIT_DOC"
ORQUESTADORES_TO_KEEP=("orquestador-unico.sh")
ORQUESTADORES_ALL=( "orquestador-unico.sh" "orquestador-supremo.sh" "orquestador-total.sh" "meta-orquestador.sh" "clasificador-maestro.sh" "guardian-maestro.sh" )
ARCHIVE_DIR="scripts/archive"
mkdir -p "$ARCHIVE_DIR"

branch1="$BRANCH_PREFIX-1-consolidacion-$TS"
echo "Planned: mover orquestadores redundantes a $ARCHIVE_DIR y dejar ${ORQUESTADORES_TO_KEEP[*]}" >> "$AUDIT_DOC"
if $DRY_RUN; then
  echo "[DRY-RUN] PRIORIDAD 1: would create branch $branch1"
else
  git fetch "$GITHUB_REMOTE"
fi

for f in "${ORQUESTADORES_ALL[@]}"; do
  src="scripts/$f"
  if [ -f "$src" ]; then
    if [[ " ${ORQUESTADORES_TO_KEEP[*]} " == *" $f "* ]]; then
      echo "[KEEP] $src" >> "$AUDIT_DOC"
    else
      echo "[ARCHIVE] $src -> $ARCHIVE_DIR/$f" >> "$AUDIT_DOC"
      if ! $DRY_RUN; then
        mkdir -p "$ARCHIVE_DIR"
        git mv "$src" "$ARCHIVE_DIR/$f"
      fi
    fi
  else
    echo "[MISSING] $src" >> "$AUDIT_DOC"
  fi
done

if ! $DRY_RUN; then
  commit_and_push "chore(consolidation): archive redundant orchestrators (priority 1)"
  create_pr_draft "$(git rev-parse --abbrev-ref HEAD)" "consolidation: archive redundant orchestrators" "Archiving redundant orchestrators to scripts/archive/; keeping orquestador-unico.sh as canonical orchestrator."
else
  echo "[DRY-RUN] PRIORIDAD 1 changes prepared (no commit)" >> "$AUDIT_DOC"
fi

# ---------------------------------------------------------------------------
# PRIORIDAD 2: cierre-sesion.sh auto-commit
# ---------------------------------------------------------------------------
echo "" >> "$AUDIT_DOC"
echo "## PRIORIDAD 2: cierre-sesion auto-commit" >> "$AUDIT_DOC"
CIERRE="scripts/cierre-sesion.sh"
INBOX_COMMIT="scripts/inbox-commit.sh"
append_line="
# Auto-upload session closure (added by maintenance script)
if [ -x \"$INBOX_COMMIT\" ]; then
  if [ \"${DRY_RUN}\" = \"false\" ]; then
    \"$INBOX_COMMIT\" || true
  else
    echo \"[DRY-RUN] would call $INBOX_COMMIT to commit closure\"
  fi
fi
"
echo "Planned: append call to $INBOX_COMMIT at end of $CIERRE" >> "$AUDIT_DOC"
if [ -f "$CIERRE" ]; then
  if grep -q "Auto-upload session closure (added by maintenance script)" "$CIERRE" 2>/dev/null; then
    echo "[SKIP] $CIERRE already patched" >> "$AUDIT_DOC"
  else
    echo "[PATCH] will append auto-commit snippet to $CIERRE" >> "$AUDIT_DOC"
    if ! $DRY_RUN; then
      printf "%s\n" "$append_line" >> "$CIERRE"
      chmod +x "$CIERRE"
      git add "$CIERRE"
      git commit -m "feat: auto-commit session closure in cierre-sesion.sh (priority 2)"
      git push "$GITHUB_REMOTE" HEAD
      create_pr_draft "$(git rev-parse --abbrev-ref HEAD)" "feat: auto-commit session closure" "Appended call to $INBOX_COMMIT at end of cierre-sesion.sh (auto-upload closure)."
    fi
  fi
else
  echo "[MISSING] $CIERRE" >> "$AUDIT_DOC"
fi

# ---------------------------------------------------------------------------
# PRIORIDAD 3: migrar-sesiones-diarios.sh
# ---------------------------------------------------------------------------
echo "" >> "$AUDIT_DOC"
echo "## PRIORIDAD 3: migrar sesiones a diarios" >> "$AUDIT_DOC"
MIGRAR_SCRIPT="scripts/migrar-sesiones-diarios.sh"
cat > "${MIGRAR_SCRIPT}.tmp" <<'SH'
#!/usr/bin/env bash
# scripts/migrar-sesiones-diarios.sh
# Mueve inbox/sesiones/cierre-*.md -> diarios/YYYY-MM-DD-tema.md
set -euo pipefail
ROOT="$(pwd)"
INBOX="$ROOT/inbox/sesiones"
OUTDIR="$ROOT/diarios"
mkdir -p "$OUTDIR"
for f in "$INBOX"/cierre-*.md; do
  [ -f "$f" ] || continue
  base=$(basename "$f")
  if [[ "$base" =~ ([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
    datepart="${BASH_REMATCH[1]}"
  elif [[ "$base" =~ ([0-9]{8}) ]]; then
    d="${BASH_REMATCH[1]}"
    datepart="${d:0:4}-${d:4:2}-${d:6:2}"
  else
    datepart=$(grep -Eo '[0-9]{4}-[0-9]{2}-[0-9]{2}' "$f" | head -n1 || true)
    if [ -z "$datepart" ]; then
      datepart=$(date -r "$f" +%F)
    fi
  fi
  topic=$(grep -m1 '^#' "$f" | sed 's/^#\s*//; s/[^a-zA-Z0-9_-]/-/g' | tr '[:upper:]' '[:lower:]' | cut -c1-40 || true)
  if [ -z "$topic" ]; then
    topic=$(echo "$base" | sed 's/^cierre-//; s/\.md$//; s/[^a-zA-Z0-9_-]/-/g' | cut -c1-40)
  fi
  out="$OUTDIR/${datepart}-${topic}.md"
  if [ -f "$out" ]; then
    suffix=1
    while [ -f "${out%.md}-$suffix.md" ]; do suffix=$((suffix+1)); done
    out="${out%.md}-$suffix.md"
  fi
  echo "Moving $f -> $out"
  mv "$f" "$out"
done
SH

echo "- Planned migrar script content (see ${MIGRAR_SCRIPT}.tmp)" >> "$AUDIT_DOC"

if $DRY_RUN; then
  echo "[DRY-RUN] would write $MIGRAR_SCRIPT and make executable"
  rm -f "${MIGRAR_SCRIPT}.tmp"
else
  mv "${MIGRAR_SCRIPT}.tmp" "$MIGRAR_SCRIPT"
  chmod +x "$MIGRAR_SCRIPT"
  git add "$MIGRAR_SCRIPT"
  git commit -m "feat: add migrar-sesiones-diarios.sh (priority 3)"
  git push "$GITHUB_REMOTE" HEAD
  create_pr_draft "$(git rev-parse --abbrev-ref HEAD)" "feat: migrar sesiones a diarios" "Adds script to move inbox/sesiones/cierre-*.md to diarios/YYYY-MM-DD-tema.md and handle collisions."
fi

# ---------------------------------------------------------------------------
# PRIORIDAD 4: apertura-sesion.sh -> run struct-auditor.sh --quick
# ---------------------------------------------------------------------------
echo "" >> "$AUDIT_DOC"
echo "## PRIORIDAD 4: auditoría pre-sesión en apertura-sesion.sh" >> "$AUDIT_DOC"
APERTURA="scripts/apertura-sesion.sh"
AUDITOR="scripts/struct-auditor.sh"
precheck_snippet="
# Pre-session quick audit (added by maintenance script)
if [ -x \"$AUDITOR\" ]; then
  \"$AUDITOR\" --quick || { echo \"Critical issues detected by struct-auditor.sh --quick. Aborting session start.\"; exit 1; }
else
  echo \"struct-auditor not found or not executable; skipping pre-session audit.\"
fi
"
echo "Planned: insert pre-session quick audit snippet at top of $APERTURA" >> "$AUDIT_DOC"
if [ -f "$APERTURA" ]; then
  if grep -q "Pre-session quick audit (added by maintenance script)" "$APERTURA" 2>/dev/null; then
    echo "[SKIP] $APERTURA already patched" >> "$AUDIT_DOC"
  else
    echo "[PATCH] will insert pre-session audit snippet into $APERTURA" >> "$AUDIT_DOC"
    if ! $DRY_RUN; then
      awk -v snip="$precheck_snippet" 'NR==1 && /^#!/{print; print snip; next} NR==1{print snip} {print}' "$APERTURA" > "$APERTURA.tmp" && mv "$APERTURA.tmp" "$APERTURA"
      chmod +x "$APERTURA"
      git add "$APERTURA"
      git commit -m "feat: pre-session quick audit in apertura-sesion.sh (priority 4)"
      git push "$GITHUB_REMOTE" HEAD
      create_pr_draft "$(git rev-parse --abbrev-ref HEAD)" "feat: pre-session quick audit" "Adds struct-auditor.sh --quick call to apertura-sesion.sh to abort on critical issues."
    fi
  fi
else
  echo "[MISSING] $APERTURA" >> "$AUDIT_DOC"
fi

# ---------------------------------------------------------------------------
# Finalize audit doc
# ---------------------------------------------------------------------------
echo "" >> "$AUDIT_DOC"
echo "## Summary of actions (script run)" >> "$AUDIT_DOC"
echo "- Mode: $( $DRY_RUN && echo 'DRY-RUN' || echo 'APPLY' )" >> "$AUDIT_DOC"
echo "- Backup dir: $BACKUP_DIR" >> "$AUDIT_DOC"
echo "" >> "$AUDIT_DOC"
echo "Detailed changes and notes are recorded above." >> "$AUDIT_DOC"

cp "$AUDIT_DOC" "$REPORT_DIR/$(basename "$AUDIT_DOC" .md)-$TS.md"
echo "Audit doc saved to $REPORT_DIR/$(basename "$AUDIT_DOC" .md)-$TS.md"

echo ""
if $DRY_RUN; then
  echo "Dry-run complete. Review $AUDIT_DOC and the planned changes in $REPORT_DIR."
  echo "To apply changes run with --apply"
else
  echo "Apply complete. Review commits and PRs on remote."
fi