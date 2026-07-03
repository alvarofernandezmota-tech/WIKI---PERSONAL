#!/usr/bin/env bash
## FUNCIÓN: Verifica que cada script en scripts/ tiene cabecera ## FUNCIÓN
##          declarada. Sin FUNCIÓN documentada = script huérfano de contexto.
## TRIGGER:  MCP tool tool_inventory_auditor, GitHub Action repo-audit
## OUTPUT:   Lista de scripts bien/mal documentados

set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || echo .)}"
SCRIPTS_DIR="$ROOT/scripts"
DATE=$(date +"%Y-%m-%d %H:%M")
MISSING=0
OK=0

echo "# 🛠️  TOOL INVENTORY AUDITOR — $DATE"
echo ""

if [ ! -d "$SCRIPTS_DIR" ]; then
  echo "❌ Directorio scripts/ no encontrado."
  exit 1
fi

echo "## Scripts sin cabecera ## FUNCIÓN:"
while IFS= read -r script; do
  name=$(basename "$script")
  if ! grep -q '## FUNCIÓN' "$script" 2>/dev/null; then
    echo "  ❌  SIN FUNCIÓN: $name"
    MISSING=$((MISSING+1))
  else
    funcion=$(grep '## FUNCIÓN' "$script" | head -1 | sed 's/## FUNCIÓN: //')
    OK=$((OK+1))
  fi
done < <(find "$SCRIPTS_DIR" -name '*.sh' -type f | sort)

echo ""
echo "## Scripts correctamente documentados: $OK"
echo "## Scripts sin ## FUNCIÓN: $MISSING"
echo ""

if [ "$MISSING" -eq 0 ]; then
  echo "✅ TOOL INVENTORY OK — Todos los scripts están documentados."
else
  echo "⚠️  $MISSING scripts sin documentar. Añadir cabecera ## FUNCIÓN a cada uno."
  exit 1
fi
