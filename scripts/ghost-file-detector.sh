#!/usr/bin/env bash
# FUNCIÓN:   Detectar archivos vacíos y referencias rotas en docs
# TRIGGER:   Cron diario, manual, llamada desde MCP
# AGENTE:    ghost-file-detector
# ETIQUETAS: estructura, deuda-tecnica
# RUTAS:     diarios/, docs/
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || echo '.')}"
REPORT_DIR="$ROOT/diarios"
DATE=$(date +%Y-%m-%d)
REPORT="$REPORT_DIR/ghost-files-$DATE.md"
FOUND=0

mkdir -p "$REPORT_DIR"

echo "# Ghost File Detector — $DATE" > "$REPORT"
echo "" >> "$REPORT"

# 1. Archivos vacíos (0 bytes)
echo "## Archivos vacíos (0 bytes)" >> "$REPORT"
while IFS= read -r f; do
  echo "- 👻 $f" >> "$REPORT"
  FOUND=$((FOUND+1))
done < <(find "$ROOT" -type f -size 0 \
  ! -path "$ROOT/.git/*" \
  ! -path "$ROOT/node_modules/*" \
  2>/dev/null)

if [ "$FOUND" -eq 0 ]; then
  echo "- Sin archivos vacíos" >> "$REPORT"
fi

# 2. Referencias rotas en markdown (links [texto](ruta) locales)
echo "" >> "$REPORT"
echo "## Referencias rotas en docs/" >> "$REPORT"
BROKEN=0
while IFS= read -r mdfile; do
  while IFS= read -r link; do
    link_path="$(dirname "$mdfile")/$link"
    if [ ! -e "$link_path" ]; then
      echo "- 🔗 Roto: \`$mdfile\` → \`$link\`" >> "$REPORT"
      BROKEN=$((BROKEN+1))
      FOUND=$((FOUND+1))
    fi
  done < <(grep -oP '\(\K[^)]+(?=\))' "$mdfile" | grep -v '^http' | grep -v '^#' || true)
done < <(find "$ROOT/docs" -name '*.md' 2>/dev/null)

if [ "$BROKEN" -eq 0 ]; then
  echo "- Sin referencias rotas" >> "$REPORT"
fi

# 3. Abrir issue si hay fantasmas
if [ "$FOUND" -gt 0 ] && command -v gh &>/dev/null; then
  EXISTING=$(gh issue list --label "estructura" --search "[FANTASMAS]" --state open --json number --jq length 2>/dev/null || echo "0")
  if [ "$EXISTING" -eq 0 ]; then
    gh issue create \
      --title "[FANTASMAS] $FOUND archivos vacíos o referencias rotas detectados" \
      --label "estructura,deuda-tecnica" \
      --body "Ghost File Detector encontró **$FOUND** problemas el $DATE.\n\nVer reporte: \`diarios/ghost-files-$DATE.md\`" 2>/dev/null || true
  fi
fi

echo "" >> "$REPORT"
echo "## Resumen" >> "$REPORT"
echo "- Total problemas: **$FOUND**" >> "$REPORT"
echo "[ghost-file-detector] Completado. Problemas: $FOUND"
