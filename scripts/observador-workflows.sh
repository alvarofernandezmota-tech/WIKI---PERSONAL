#!/usr/bin/env bash
# ============================================================
# OBSERVADOR-WORKFLOWS.SH
# Función  : Valida que los workflows de .github/workflows/ estén activos
#            y tengan comentario de función/Galatea
# Isla     : islas/guardian-maestro/
# Galatea  : v1.0 — 2026-07-04
# Relación : Llamado por guardian-maestro.sh
# ============================================================
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && git rev-parse --show-toplevel 2>/dev/null || pwd)"
WF_DIR="${REPO_ROOT}/.github/workflows"

echo "## 🔍 Observador: .github/workflows/"
echo ""

if [[ ! -d "${WF_DIR}" ]]; then
  echo "  ⚠️  Directorio .github/workflows/ no encontrado."
  exit 0
fi

MISSING_COMMENT=0
for f in "${WF_DIR}"/*.yml "${WF_DIR}"/*.yaml; do
  [[ -f "$f" ]] || continue
  name=$(basename "$f")
  if ! grep -qiE '(funcion|función|galatea|descripcion)' "$f" 2>/dev/null; then
    echo "  ⚠️  Sin comentario de función: ${name}"
    MISSING_COMMENT=$((MISSING_COMMENT + 1))
  else
    echo "  ✅ ${name}"
  fi
done

if [[ ${MISSING_COMMENT} -eq 0 ]]; then
  echo ""
  echo "  → Todos los workflows tienen comentario de función."
else
  echo ""
  echo "  → ${MISSING_COMMENT} workflow(s) sin comentario de función."
fi

exit 0
