#!/usr/bin/env bash
# scripts/maintenance/pause_noisy_workflows.sh
# Usage:
#   ./scripts/maintenance/pause_noisy_workflows.sh          # dry-run, no changes
#   ./scripts/maintenance/pause_noisy_workflows.sh --apply  # apply changes and push
#   ./scripts/maintenance/pause_noisy_workflows.sh --revert # restore from last backup
set -euo pipefail

ROOT="$(pwd)"
TS="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="$ROOT/maintenance/workflows-backup/$TS"
REPORT_DIR="$ROOT/reports/maintenance"
REPORT_FILE="$REPORT_DIR/pause-workflows-$TS.md"
GIT_BRANCH="${GIT_BRANCH:-main}"
COMMIT_MSG="chore: pause noisy workflows -> workflow_dispatch (maintenance/$TS)"
DRY_RUN=true
APPLY=false
REVERT=false

NOISY_WORKFLOWS=(
  "auditoria-auto.yml"
  "audit-on-push.yml"
  "ecosystem-guardian.yml"
  "clasificador.yml"
  "clasificador-maestro.yml"
  "autonomous-cron.yml"
  "auto-investigacion.yml"
  "between-sessions.yml"
  "context-reminder.yml"
  "ghost-file-detector.yml"
  "code-drift.yml"
  "cross-ref-checker.yml"
  "diary-writer.yml"
  "isla-context-sync.yml"
  "isla-sync-validator.yml"
  "islas-health.yml"
  "deuda-tecnica.yml"
  "agent-monitor.yml"
)

print_help() {
  cat <<EOF
Pause noisy workflows maintenance script

Options:
  --apply          Apply changes (modify files, commit and push)
  --revert         Revert last backup (restore files from latest backup)
  --branch BRANCH  Use BRANCH for commit and push (default: main)
  -h|--help        Show this help
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --apply)  DRY_RUN=false; APPLY=true; shift ;;
    --revert) REVERT=true; shift ;;
    --branch) GIT_BRANCH="$2"; shift 2 ;;
    -h|--help) print_help; exit 0 ;;
    *) echo "Unknown arg: $1"; print_help; exit 1 ;;
  esac
done

mkdir -p "$REPORT_DIR"

# --- REVERT MODE ---
if [ "$REVERT" = true ]; then
  LATEST_BACKUP=$(ls -1d maintenance/workflows-backup/* 2>/dev/null | tail -n1 || true)
  if [ -z "$LATEST_BACKUP" ]; then
    echo "No backups found in maintenance/workflows-backup/"
    exit 1
  fi
  echo "Restoring from $LATEST_BACKUP ..."
  cp -a "$LATEST_BACKUP/.github/workflows/." .github/workflows/
  echo "Restored. Create a revert commit manually if desired:"
  echo "  git add .github/workflows && git commit -m 'chore: revert workflow pause' && git push"
  exit 0
fi

# --- AUDIT MODE ---
echo "# Pause noisy workflows report" > "$REPORT_FILE"
echo "Timestamp: $TS" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "## Workflows analizados" >> "$REPORT_FILE"

mkdir -p "$BACKUP_DIR/.github/workflows"
found_any=false

for wf in "${NOISY_WORKFLOWS[@]}"; do
  wfpath=".github/workflows/$wf"
  if [ -f "$wfpath" ]; then
    found_any=true
    echo "- $wf" >> "$REPORT_FILE"
    cp -p "$wfpath" "$BACKUP_DIR/.github/workflows/$wf"
  else
    echo "- $wf (no encontrado)" >> "$REPORT_FILE"
  fi
done

if [ "$found_any" = false ]; then
  echo "No matching noisy workflows found. Nothing to do."
  echo "Result: No matching files found." >> "$REPORT_FILE"
  exit 0
fi

echo "" >> "$REPORT_FILE"
echo "Backup en: $BACKUP_DIR" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "## Modificaciones propuestas" >> "$REPORT_FILE"

transform_workflow() {
  local src="$1"
  local dst="$2"
  local wfname
  wfname=$(basename "$src")
  cat > "$dst" <<WFEOF
# PAUSED BY MAINTENANCE SCRIPT — solo manual dispatch
# Backup en: $BACKUP_DIR/.github/workflows/$wfname
# Ver docs/OPERATIONAL-PLAYBOOK.md para proceso de reactivacion.
name: $(grep '^name:' "$src" | head -n1 | sed 's/name: //' || echo "$wfname") [SILENCIADO]

on:
  workflow_dispatch:

jobs:
  skip:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Workflow silenciado. Reactivar editando el trigger en .github/workflows/$wfname"
WFEOF
}

MODIFIED=()
for wf in "${NOISY_WORKFLOWS[@]}"; do
  wfpath=".github/workflows/$wf"
  if [ -f "$wfpath" ]; then
    tmp="/tmp/pause_wf_$wf.tmp"
    transform_workflow "$wfpath" "$tmp"
    if ! diff -q "$wfpath" "$tmp" >/dev/null 2>&1; then
      echo "- Modificar: $wf" >> "$REPORT_FILE"
      MODIFIED+=("$wf")
      if [ "$DRY_RUN" = true ]; then
        echo "==== DIFF: $wf ===="
        diff -u "$wfpath" "$tmp" || true
        echo ""
      else
        mv "$tmp" "$wfpath"
      fi
    else
      echo "- Sin cambios: $wf" >> "$REPORT_FILE"
      rm -f "$tmp"
    fi
  fi
done

echo "" >> "$REPORT_FILE"
echo "## Resumen" >> "$REPORT_FILE"
echo "Total modificados: ${#MODIFIED[@]}" >> "$REPORT_FILE"
for m in "${MODIFIED[@]}"; do echo "- $m" >> "$REPORT_FILE"; done

if [ "$DRY_RUN" = true ]; then
  echo ""
  echo "DRY-RUN completo. Ningun archivo fue modificado."
  echo "Para aplicar: ./scripts/maintenance/pause_noisy_workflows.sh --apply"
  echo "Informe: $REPORT_FILE"
  exit 0
fi

# --- COMMIT Y PUSH ---
if [ "${#MODIFIED[@]}" -eq 0 ]; then
  echo "Nada que aplicar."
  exit 0
fi

git checkout "$GIT_BRANCH"
git add .github/workflows
git add "$REPORT_FILE" || true
git commit -m "$COMMIT_MSG"
git push origin "$GIT_BRANCH"

echo ""
echo "Cambios aplicados y pusheados a $GIT_BRANCH."
echo "Backup: $BACKUP_DIR"
echo "Informe: $REPORT_FILE"

# --- MONITOREO PERCENT_COMPLETE ---
PCT=$(grep -Eo 'PERCENT_COMPLETE: [0-9]{1,3}%' reports/meta-deep/*.md 2>/dev/null | head -n1 | sed 's/[^0-9]//g' || echo "")
if [ -n "$PCT" ] && [ "$PCT" -lt 70 ]; then
  echo "AVISO: PERCENT_COMPLETE=$PCT% < 70%. Considera abrir un issue."
  # gh issue create --title "Low coverage: $PCT%" --body "Auto-detected PERCENT_COMPLETE $PCT% en meta-deep" || true
fi
