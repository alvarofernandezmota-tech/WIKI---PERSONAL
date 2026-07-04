#!/usr/bin/env bash
# scripts/maintenance/master_run.sh — Terminal Madre
# Punto de entrada único. Orquesta todos los pasos en orden seguro.
# Dry-run por defecto. --apply para ejecutar de verdad.
set -euo pipefail

ROOT="$(pwd)"
DRY_RUN=true

while [ $# -gt 0 ]; do
  case "$1" in
    --apply) DRY_RUN=false; shift ;;
    --help) echo "Usage: $0 [--apply]"; exit 0 ;;
    *) echo "Unknown arg: $1"; exit 1 ;;
  esac
done

MODE=$( $DRY_RUN && echo "DRY-RUN" || echo "APPLY" )
echo "═══════════════════════════════════════"
echo "  TERMINAL MADRE — Yggdrasil-Dew       "
echo "  Mode: $MODE"
echo "  $(date -Iseconds)"
echo "═══════════════════════════════════════"

run_step() {
  local n="$1" desc="$2" cmd="$3"
  echo ""
  echo "── STEP $n: $desc"
  if [ "$DRY_RUN" = true ]; then
    echo "   [DRY-RUN] $cmd"
  else
    eval "$cmd" && echo "   ✓ OK" || echo "   ✗ FAILED (continuing)"
  fi
}

run_step 0 "smoke tests" \
  "bash scripts/verify/run-smoke-tests.sh"

run_step 1 "mover .md fuera de scripts/" \
  "git mv scripts/2026-07-03-23-05-struct-auditor-output.md inbox/_meta/ 2>/dev/null || true; git mv scripts/2026-07-03-inbox-audit-consolidado.md inbox/_meta/ 2>/dev/null || true; git mv scripts/2026-07-03-cierre-sesion-completo.md diarios/ 2>/dev/null || true; git mv scripts/2026-07-03-reality-check.md diarios/ 2>/dev/null || true; git mv scripts/gemini-brief.md docs/ 2>/dev/null || true"

run_step 2 "file-arrival-guardian (dry-run)" \
  "bash scripts/file-arrival-guardian.sh --dry-run"

run_step 3 "Perplexity informer" \
  "bash agentes/agent-perplexity-informer/run.sh"

run_step 4 "meta-deep auditor" \
  "bash scripts/agentes/agente-meta-deep.sh"

run_step 5 "obsidian observer" \
  "bash scripts/observador-obsidian.sh"

run_step 6 "inbox clasificador" \
  "bash scripts/inbox-clasificador.sh"

run_step 7 "struct auditor" \
  "bash scripts/struct-auditor.sh"

echo ""
echo "═══════════════════════════════════════"
echo "  TERMINAL MADRE — $MODE completado    "
echo "  $(date -Iseconds)"
echo "═══════════════════════════════════════"
