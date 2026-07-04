#!/usr/bin/env bash
# scripts/orquestador-total.sh v2.0
# Uso: bash scripts/orquestador-total.sh [all|audit|inbox|health]
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
PHASE="${1:-all}"
TS=$(date +"%Y%m%d-%H%M%S")
META="$ROOT/inbox/_meta"
REPORTS="$ROOT/reports"
mkdir -p "$META" "$REPORTS"
OUT="$META/orquestador-$TS.md"

log()  { echo "[$(date +%H:%M:%S)] $*" | tee -a "$OUT"; }
ok()   { echo "  ✓ $*" | tee -a "$OUT"; }
warn() { echo "  ⚠ $*" | tee -a "$OUT"; }
fail() { echo "  ✗ $*" | tee -a "$OUT"; }

run_script() {
  local script="$1"
  local label="$2"
  if [ ! -f "$script" ]; then
    warn "$label — no encontrado: $script"
    return 0
  fi
  if bash "$script" >> "$OUT" 2>&1; then
    ok "$label"
  else
    fail "$label (exit $?)"
  fi
}

echo "# Orquestador Total — $TS" > "$OUT"
echo "Fase: $PHASE" >> "$OUT"
echo "" >> "$OUT"

# ── AUDIT ────────────────────────────────────────────────────────────────────
run_audit() {
  log "=== AUDIT ==="
  run_script "$ROOT/scripts/file-arrival-guardian.sh" "file-arrival-guardian"
  run_script "$ROOT/scripts/inbox-clasificador.sh"    "inbox-clasificador"
}

# ── INBOX ────────────────────────────────────────────────────────────────────
run_inbox() {
  log "=== INBOX ==="
  if [ -d "$ROOT/inbox/drop" ] && [ -n "$(ls -A "$ROOT/inbox/drop" 2>/dev/null)" ]; then
    ok "inbox/drop tiene archivos — ejecutar inbox-commit.sh manualmente o via MCP"
  else
    ok "inbox/drop vacío — nada que procesar"
  fi
}

# ── HEALTH ───────────────────────────────────────────────────────────────────
run_health() {
  log "=== HEALTH ==="
  for agent in agent-docs agent-islas agent-tareas; do
    t="$ROOT/agentes/$agent/test.sh"
    if [ -f "$t" ]; then
      if bash "$t" >> "$OUT" 2>&1; then
        ok "$agent test OK"
      else
        fail "$agent test FAILED"
      fi
    else
      warn "$agent — test.sh no encontrado"
    fi
  done

  # Diary report
  DIARY="$ROOT/diarios/health-$TS.md"
  mkdir -p "$ROOT/diarios"
  echo "# Health Report $TS" > "$DIARY"
  echo "Generado por orquestador-total.sh" >> "$DIARY"
  grep -E '(✓|✗|⚠)' "$OUT" >> "$DIARY" || true
  ok "Diary report: $DIARY"
}

# ── Dispatch ─────────────────────────────────────────────────────────────────
case "$PHASE" in
  audit)  run_audit  ;;
  inbox)  run_inbox  ;;
  health) run_health ;;
  all)
    run_audit
    run_inbox
    run_health
    ;;
  *)
    fail "Fase desconocida: $PHASE. Usa: all|audit|inbox|health"
    exit 1
    ;;
esac

log "=== FIN === Reporte: $OUT"
echo "$OUT"
