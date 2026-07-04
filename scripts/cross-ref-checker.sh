#!/usr/bin/env bash
# FUNCIÓN:   Verificar que links internos entre docs/ no están rotos
# TRIGGER:   Semanal, manual
# AGENTE:    cross-ref-checker
# ETIQUETAS: documentacion, estructura
# RUTAS:     docs/
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || echo '.')}"
DATE=$(date +%Y-%m-%d)
REPORT="$ROOT/diarios/cross-ref-$DATE.md"
BROKEN=0

mkdir -p "$ROOT/diarios"
echo "# Cross-Ref Checker — $DATE" > "$REPORT"
echo "" >> "$REPORT"

while IFS= read -r mdfile; do
  while IFS= read -r link; do
    abs="$ROOT/$link"
    rel="$(dirname "$mdfile")/$link"
    if [ ! -e "$abs" ] && [ ! -e "$rel" ]; then
      echo "- ❌ \`$mdfile\` → \`$link\` (no existe)" >> "$REPORT"
      BROKEN=$((BROKEN+1))
    fi
  done < <(grep -oP '\(\K[^)]+(?=\))' "$mdfile" | grep -v '^http' | grep -v '^#' || true)
done < <(find "$ROOT" -name '*.md' ! -path "$ROOT/.git/*" 2>/dev/null)

[ "$BROKEN" -eq 0 ] && echo "- ✅ Sin links rotos" >> "$REPORT"

if [ "$BROKEN" -gt 0 ] && command -v gh &>/dev/null; then
  gh issue create \
    --title "[CROSS-REF] $BROKEN links internos rotos" \
    --label "documentacion,estructura" \
    --body "Cross-ref-checker encontró $BROKEN links rotos el $DATE. Ver \`diarios/cross-ref-$DATE.md\`" 2>/dev/null || true
fi

echo "[cross-ref-checker] Links rotos: $BROKEN"
