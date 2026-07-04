#!/usr/bin/env bash
# scripts/maintenance/master_run.sh
# =============================================
# TERMINAL MADRE — Punto de entrada unico del ecosistema Yggdrasil.
# Orquesta todos los agentes y scripts en el orden correcto.
# Dry-run por defecto. Usa --apply para ejecutar realmente.
# =============================================
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(pwd)}"
DRY_RUN=true

while [ $# -gt 0 ]; do
  case "$1" in
    --apply) DRY_RUN=false; shift ;;
    --help)
      echo "Usage: $0 [--apply]"
      echo ""
      echo "Dry-run (default): muestra que haria cada paso sin ejecutar nada."
      echo "--apply:           ejecuta todos los pasos en orden."
      exit 0
      ;;
    *) echo "[ERROR] Unknown arg: $1"; exit 1 ;;
  esac
done

mode() { $DRY_RUN && echo "DRY-RUN" || echo "APPLY"; }

run_step() {
  local step="$1"; shift
  local cmd="$*"
  echo ""
  echo "━━━ STEP $step ━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  if [ "$DRY_RUN" = true ]; then
    echo "[DRY-RUN] Would run: $cmd"
  else
    echo "[RUN] $cmd"
    eval "$cmd"
  fi
}

echo "============================================"
echo " MASTER RUNNER — Yggdrasil-Dew"
echo " Mode: $(mode)"
echo " Root: $ROOT"
echo " Time: $(date -Iseconds)"
echo "============================================"

# PASO 0: Mover .md extraviados en scripts/
run_step "0: Move stray .md" \
  "bash -c 'cd \"$ROOT\"; for f in scripts/2026-*.md; do [ -f \"\$f\" ] || continue; git mv \"\$f\" inbox/_meta/ 2>/dev/null && echo moved \$f || true; done'"

# PASO 1: Perplexity informer
run_step "1: Perplexity informer" \
  "bash \"$ROOT/agentes/agent-perplexity-informer/run.sh\""

# PASO 2: Meta-deep auditor
run_step "2: Meta-deep auditor" \
  "bash \"$ROOT/scripts/agentes/agente-meta-deep.sh\""

# PASO 3: Obsidian observer
run_step "3: Obsidian observer" \
  "bash \"$ROOT/scripts/observador-obsidian.sh\""

# PASO 4: Smoke tests
run_step "4: Smoke tests" \
  "bash \"$ROOT/scripts/verify/run-smoke-tests.sh\""

echo ""
echo "============================================"
echo " MASTER RUNNER COMPLETE — Mode: $(mode)"
echo "============================================"
