#!/usr/bin/env bash
# ============================================================
# OBSERVADOR-MCP.SH
# Función  : Audita la carpeta mcp/ — tools presentes, naming, docs
# Isla     : islas/guardian-maestro/
# Galatea  : v1.0 — 2026-07-04
# Relación : Llamado por guardian-maestro.sh
# ============================================================
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && git rev-parse --show-toplevel 2>/dev/null || pwd)"
MCP_DIR="${REPO_ROOT}/mcp"

echo "## 🔍 Observador: mcp/"
echo ""

if [[ ! -d "${MCP_DIR}" ]]; then
  echo "  ⚠️  mcp/ no encontrado — puede que no exista todavía."
  exit 0
fi

TOOLS=$(find "${MCP_DIR}" -type f \( -name '*.sh' -o -name '*.py' -o -name '*.js' -o -name '*.ts' \) | wc -l | tr -d ' ')
DOCS=$(find "${MCP_DIR}" -type f -name '*.md' | wc -l | tr -d ' ')

echo "  Tools encontrados : ${TOOLS}"
echo "  Docs encontrados  : ${DOCS}"

if [[ ${TOOLS} -eq 0 ]]; then
  echo "  ⚠️  No hay tools en mcp/ todavía."
else
  echo "  ✅ ${TOOLS} tool(s) presentes en mcp/."
fi

if [[ ${DOCS} -eq 0 ]]; then
  echo "  ⚠️  Sin documentación en mcp/ — crear docs/MCP.md."
else
  echo "  ✅ ${DOCS} doc(s) en mcp/."
fi

exit 0
