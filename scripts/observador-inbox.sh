#!/usr/bin/env bash
# ============================================================
# OBSERVADOR-INBOX.SH
# Función  : Audita el estado de inbox/ — archivos en drop/, antigüedad,
#            acumulación y estado del clasificador
# Isla     : islas/guardian-maestro/
# Galatea  : v1.0 — 2026-07-04
# Relación : Llamado por guardian-maestro.sh
# ============================================================
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && git rev-parse --show-toplevel 2>/dev/null || pwd)"
INBOX_DIR="${REPO_ROOT}/inbox"
DROP_DIR="${INBOX_DIR}/drop"

echo "## 🔍 Observador: inbox/"
echo ""

if [[ ! -d "${INBOX_DIR}" ]]; then
  echo "  ⚠️  inbox/ no encontrado."
  exit 0
fi

# Contar archivos reales en drop/ (excluye .gitkeep)
DROP_COUNT=0
if [[ -d "${DROP_DIR}" ]]; then
  DROP_COUNT=$(find "${DROP_DIR}" -type f ! -name '.gitkeep' | wc -l | tr -d ' ')
fi

if [[ ${DROP_COUNT} -eq 0 ]]; then
  echo "  ✅ inbox/drop/ vacío — todo clasificado."
else
  echo "  ⚠️  inbox/drop/ tiene ${DROP_COUNT} archivo(s) pendiente(s) de clasificar."
  find "${DROP_DIR}" -type f ! -name '.gitkeep' | while read -r f; do
    echo "      → $(basename "$f")"
  done
fi

# Verificar que existe el clasificador
CLASIFICADOR="${REPO_ROOT}/scripts/inbox-clasificador.sh"
if [[ -f "${CLASIFICADOR}" ]]; then
  echo "  ✅ inbox-clasificador.sh — presente."
else
  echo "  ⚠️  inbox-clasificador.sh — no encontrado en scripts/."
fi

exit 0
