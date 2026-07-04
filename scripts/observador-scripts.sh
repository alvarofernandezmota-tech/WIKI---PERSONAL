#!/usr/bin/env bash
# ============================================================
# OBSERVADOR-SCRIPTS.SH
# Función  : Audita que todos los .sh en scripts/ tengan cabecera Galatea
# Isla     : islas/guardian-maestro/
# Galatea  : v1.0 — 2026-07-04
# Relación : Llamado por guardian-maestro.sh
# ============================================================
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && git rev-parse --show-toplevel 2>/dev/null || pwd)"
SCRIPTS_DIR="${REPO_ROOT}/scripts"

echo "## 🔍 Observador: scripts/"
echo ""

MISSING=0
for f in "${SCRIPTS_DIR}"/*.sh; do
  [[ -f "$f" ]] || continue
  name=$(basename "$f")
  if ! grep -q 'Galatea' "$f" 2>/dev/null; then
    echo "  ⚠️  Sin cabecera Galatea: ${name}"
    MISSING=$((MISSING + 1))
  else
    echo "  ✅ ${name}"
  fi
done

if [[ ${MISSING} -eq 0 ]]; then
  echo ""
  echo "  → Todos los scripts tienen cabecera Galatea."
else
  echo ""
  echo "  → ${MISSING} script(s) sin cabecera Galatea."
fi

exit 0
