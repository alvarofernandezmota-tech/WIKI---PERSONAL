#!/usr/bin/env bash
# ============================================================
# GUARDIAN-MAESTRO.SH
# Función  : Punto de entrada de toda la auditoría del ecosistema
# Triggers : Manual / cron / GitHub Actions
# Isla     : islas/guardian-maestro/
# Galatea  : v1.0 — 2026-07-04
# Relación : Llama a todos los observadores y genera reporte final
# ============================================================
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && git rev-parse --show-toplevel 2>/dev/null || pwd)"
REPORT_DIR="${REPO_ROOT}/inbox/_meta"
mkdir -p "${REPORT_DIR}"
TS=$(date +%Y%m%dT%H%M%S)
REPORT="${REPORT_DIR}/guardian-report-${TS}.md"

log()  { echo "[GUARDIAN] $*" | tee -a "${REPORT}"; }
ok()   { echo "  ✅ $*" | tee -a "${REPORT}"; }
warn() { echo "  ⚠️  $*" | tee -a "${REPORT}"; }
err()  { echo "  ❌ $*" | tee -a "${REPORT}"; }

echo "# 🛡️ Guardian Maestro — Reporte de Auditoría" >> "${REPORT}"
echo "Fecha: $(date '+%Y-%m-%d %H:%M:%S')" >> "${REPORT}"
echo "" >> "${REPORT}"

OBSERVADORES=(
  "scripts/observador-scripts.sh"
  "scripts/observador-workflows.sh"
  "scripts/observador-islas.sh"
  "scripts/observador-inbox.sh"
  "scripts/observador-diarios.sh"
  "scripts/observador-mcp.sh"
)

FAILED=0

for obs in "${OBSERVADORES[@]}"; do
  OBS_PATH="${REPO_ROOT}/${obs}"
  if [[ -f "${OBS_PATH}" ]]; then
    log "Ejecutando ${obs}..."
    if bash "${OBS_PATH}" >> "${REPORT}" 2>&1; then
      ok "${obs} — OK"
    else
      err "${obs} — FALLÓ (exit $?)"
      FAILED=$((FAILED + 1))
    fi
  else
    warn "${obs} no encontrado — pendiente de crear"
  fi
done

echo "" >> "${REPORT}"
echo "---" >> "${REPORT}"
if [[ ${FAILED} -eq 0 ]]; then
  echo "**Estado final: ✅ TODOS LOS OBSERVADORES OK**" >> "${REPORT}"
else
  echo "**Estado final: ❌ ${FAILED} observador(es) con errores**" >> "${REPORT}"
fi

log "Reporte guardado en: ${REPORT}"
exit ${FAILED}
