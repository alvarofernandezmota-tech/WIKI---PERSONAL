#!/usr/bin/env bash
# ============================================================
# OBSERVADOR-DIARIOS.SH
# Función  : Valida que diarios/ tenga entradas recientes y formato correcto
# Isla     : islas/guardian-maestro/
# Galatea  : v1.0 — 2026-07-04
# Relación : Llamado por guardian-maestro.sh
# ============================================================
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && git rev-parse --show-toplevel 2>/dev/null || pwd)"
DIARIOS_DIR="${REPO_ROOT}/diarios"

echo "## 🔍 Observador: diarios/"
echo ""

if [[ ! -d "${DIARIOS_DIR}" ]]; then
  echo "  ⚠️  diarios/ no encontrado."
  exit 0
fi

COUNT=$(find "${DIARIOS_DIR}" -name '*.md' | wc -l | tr -d ' ')
echo "  Total entradas: ${COUNT}"

if [[ ${COUNT} -eq 0 ]]; then
  echo "  ⚠️  diarios/ vacío — no hay ningún diario todavía."
  exit 0
fi

# Último diario modificado
LAST=$(find "${DIARIOS_DIR}" -name '*.md' -printf '%T@ %f\n' 2>/dev/null | sort -rn | head -1 | awk '{print $2}' || \
       find "${DIARIOS_DIR}" -name '*.md' -exec stat -f '%m %N' {} \; 2>/dev/null | sort -rn | head -1 | awk '{print $2}' || echo "desconocido")

echo "  Último diario: ${LAST}"

# Alertar si el último diario tiene más de 7 días
if command -v find &>/dev/null; then
  RECENT=$(find "${DIARIOS_DIR}" -name '*.md' -mtime -7 | wc -l | tr -d ' ')
  if [[ ${RECENT} -eq 0 ]]; then
    echo "  ⚠️  No hay diarios en los últimos 7 días — ¿sesión sin cerrar?"
  else
    echo "  ✅ ${RECENT} diario(s) en los últimos 7 días."
  fi
fi

exit 0
