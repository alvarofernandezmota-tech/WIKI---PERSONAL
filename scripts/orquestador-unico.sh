#!/usr/bin/env bash
# =============================================================================
# orquestador-unico.sh — Punto de entrada único para ejecutar todos los
#                        agentes/scripts del ecosistema en orden correcto.
#
# FASES:
#   all     — auditoría + inbox + health (por defecto)
#   audit   — solo auditoría de estructura
#   inbox   — solo gestión de inbox
#   health  — solo salud del sistema
#
# USO:
#   bash scripts/orquestador-unico.sh [all|audit|inbox|health]
# =============================================================================
set -euo pipefail

FASE="${1:-all}"
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo "$HOME/yggdrasil-dew")"
META_DIR="$REPO_ROOT/inbox/_meta"
mkdir -p "$META_DIR"

TIMESTAMP="$(date +%Y%m%dT%H%M%S)"
INFORME="$META_DIR/orquestador-${TIMESTAMP}.md"
ERRORS=0

log() { echo "[orquestador] $*"; }
err() { echo "[orquestador] ERROR: $*" >&2; ((ERRORS++)) || true; }

run_script() {
  local script="$1"
  local desc="$2"
  local path="$REPO_ROOT/scripts/$script"
  log "→ $desc ($script)"
  if [[ -x "$path" ]]; then
    if bash "$path" >> "$INFORME" 2>&1; then
      echo "  ✓ $script" >> "$INFORME"
    else
      echo "  ✗ $script (falló)" >> "$INFORME"
      err "$script falló"
    fi
  else
    echo "  - $script (no encontrado o sin permisos)" >> "$INFORME"
    log "  SKIP: $script no encontrado o no ejecutable"
  fi
}

# ---- Cabecera del informe ----
cat > "$INFORME" <<EOF
# Informe orquestador — ${TIMESTAMP}

- Fase: ${FASE}
- Fecha: $(date '+%Y-%m-%d %H:%M:%S')
- Branch: $(git -C "$REPO_ROOT" branch --show-current 2>/dev/null || echo 'N/A')

## Ejecución

EOF

# ---- Fases ----
phase_audit() {
  log "=== FASE: AUDIT ==="
  run_script "file-arrival-guardian.sh" "Guardián de llegada de archivos"
  run_script "auditoria-maestra.sh"     "Auditoría maestra de estructura"
  run_script "audit-and-migrate.sh"    "Auditoría + migración automática"
}

phase_inbox() {
  log "=== FASE: INBOX ==="
  run_script "inbox-clasificador.sh"   "Clasificador de inbox"
  run_script "clasificador-maestro.sh" "Clasificador maestro"
}

phase_health() {
  log "=== FASE: HEALTH ==="
  run_script "ecosystem-snapshot.sh"   "Snapshot del ecosistema"
  run_script "code-drift-detector.sh"  "Detector de drift de código"
}

case "$FASE" in
  audit)  phase_audit ;;
  inbox)  phase_inbox ;;
  health) phase_health ;;
  all)
    phase_audit
    phase_inbox
    phase_health
    ;;
  *)
    err "Fase desconocida: $FASE. Usa: all | audit | inbox | health"
    exit 1
    ;;
esac

# ---- Footer del informe ----
cat >> "$INFORME" <<EOF

## Resultado final

- Errores detectados: ${ERRORS}
- Informe: ${INFORME}
EOF

log "Informe guardado en: $INFORME"

if [[ $ERRORS -gt 0 ]]; then
  log "Completado con $ERRORS error(es). Revisa el informe."
  exit 1
else
  log "Completado sin errores."
fi
