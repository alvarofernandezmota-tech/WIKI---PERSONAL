#!/usr/bin/env bash
# ============================================================
# META-ORQUESTADOR.SH
# Función  : Coordina el ciclo completo del ecosistema:
#            guardian → observadores → investigadores → mejoradores
# Isla     : islas/guardian-maestro/
# Galatea  : v1.0 — 2026-07-04
# Uso      : bash scripts/meta-orquestador.sh [fase]
#            fases: all | audit | investigate | improve
# ============================================================
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && git rev-parse --show-toplevel 2>/dev/null || pwd)"
FASE="${1:-all}"
TS=$(date +%Y%m%dT%H%M%S)
LOG_DIR="${REPO_ROOT}/inbox/_meta"
mkdir -p "${LOG_DIR}"
LOG="${LOG_DIR}/meta-orquestador-${TS}.md"

log()  { echo "[META] $*" | tee -a "${LOG}"; }
ok()   { echo "  ✅ $*" | tee -a "${LOG}"; }
warn() { echo "  ⚠️  $*" | tee -a "${LOG}"; }

echo "# 🧵 Meta-Orquestador — ${FASE} — ${TS}" >> "${LOG}"
echo "" >> "${LOG}"

run_if_exists() {
  local script="${REPO_ROOT}/$1"
  if [[ -f "${script}" ]]; then
    log "→ $1"
    if bash "${script}" >> "${LOG}" 2>&1; then
      ok "$1 completado."
    else
      warn "$1 terminó con advertencias."
    fi
  else
    warn "$1 no existe todavía — pendiente."
  fi
}

case "${FASE}" in
  all|audit)
    log "== FASE: AUDITORÍA =="
    run_if_exists "scripts/guardian-maestro.sh"
    ;;
esac

case "${FASE}" in
  all|investigate)
    log "== FASE: INVESTIGACIÓN =="
    run_if_exists "scripts/investigador-estructura.sh"
    run_if_exists "scripts/investigador-deuda-tecnica.sh"
    ;;
esac

case "${FASE}" in
  all|improve)
    log "== FASE: MEJORA =="
    run_if_exists "scripts/mejorador-scripts.sh"
    run_if_exists "scripts/mejorador-documentacion.sh"
    ;;
esac

log "Meta-orquestador completado. Log: ${LOG}"
