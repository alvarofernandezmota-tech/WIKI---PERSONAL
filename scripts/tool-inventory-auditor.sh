#!/usr/bin/env bash
# FUNCIÓN:   Verificar que todos los scripts tienen cabecera estándar (FUNCIÓN, TRIGGER, AGENTE)
# TRIGGER:   Semanal
# AGENTE:    tool-inventory-auditor
# ETIQUETAS: estructura, automatizacion
# RUTAS:     scripts/
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || echo '.')}"
DATE=$(date +%Y-%m-%d)
REPORT="$ROOT/diarios/tool-inventory-$DATE.md"
MISSING=0

mkdir -p "$ROOT/diarios"
echo "# Tool Inventory Audit — $DATE" > "$REPORT"
echo "" >> "$REPORT"

while IFS= read -r script; do
  name=$(basename "$script")
  has_funcion=$(grep -c '# FUNCIÓN:' "$script" 2>/dev/null || echo 0)
  has_trigger=$(grep -c '# TRIGGER:' "$script" 2>/dev/null || echo 0)
  has_agente=$(grep -c '# AGENTE:'  "$script" 2>/dev/null || echo 0)
  if [ "$has_funcion" -eq 0 ] || [ "$has_trigger" -eq 0 ] || [ "$has_agente" -eq 0 ]; then
    echo "- ⚠️ $name — falta cabecera estándar" >> "$REPORT"
    MISSING=$((MISSING+1))
  else
    echo "- ✅ $name" >> "$REPORT"
  fi
done < <(find "$ROOT/scripts" -name '*.sh' ! -path '*/thdora/*' 2>/dev/null)

[ "$MISSING" -eq 0 ] && echo "" && echo "- ✅ Todos los scripts tienen cabecera" >> "$REPORT"

if [ "$MISSING" -gt 0 ] && command -v gh &>/dev/null; then
  gh issue create \
    --title "[TOOL-INVENTORY] $MISSING scripts sin cabecera estándar" \
    --label "estructura,automatizacion" \
    --body "tool-inventory-auditor encontró $MISSING scripts sin cabecera el $DATE.\nVer \`diarios/tool-inventory-$DATE.md\`" 2>/dev/null || true
fi

echo "[tool-inventory-auditor] Scripts sin cabecera: $MISSING"
