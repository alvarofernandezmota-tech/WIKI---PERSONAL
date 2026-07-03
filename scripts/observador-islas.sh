#!/usr/bin/env bash
# ============================================================
# OBSERVADOR-ISLAS.SH
# Función  : Compara islas/ con MAPA-ISLAS.md y detecta desfases
# Isla     : islas/guardian-maestro/
# Galatea  : v1.0 — 2026-07-04
# Relación : Llamado por guardian-maestro.sh
# ============================================================
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && git rev-parse --show-toplevel 2>/dev/null || pwd)"
ISLAS_DIR="${REPO_ROOT}/islas"
MAPA="${REPO_ROOT}/MAPA-ISLAS.md"

echo "## 🔍 Observador: islas/"
echo ""

if [[ ! -d "${ISLAS_DIR}" ]]; then
  echo "  ⚠️  Directorio islas/ no encontrado."
  exit 0
fi

# Islas reales en disco
DISCO_ISLAS=()
while IFS= read -r -d '' d; do
  DISCO_ISLAS+=("$(basename "$d")")
done < <(find "${ISLAS_DIR}" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)

echo "  Islas en disco (${#DISCO_ISLAS[@]}):"
for isla in "${DISCO_ISLAS[@]}"; do
  if [[ -f "${MAPA}" ]] && grep -q "${isla}" "${MAPA}"; then
    echo "    ✅ ${isla} — en MAPA-ISLAS.md"
  else
    echo "    ⚠️  ${isla} — NO está en MAPA-ISLAS.md"
  fi
done

if [[ ! -f "${MAPA}" ]]; then
  echo "  ❌ MAPA-ISLAS.md no existe — crear urgente."
fi

exit 0
