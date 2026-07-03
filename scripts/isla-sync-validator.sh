#!/usr/bin/env bash
## FUNCIÓN: Valida que MAPA-ISLAS.md refleja la estructura real del repo.
##          Si hay islas en disco no documentadas, o documentadas pero inexistentes,
##          lista las discrepancias y propone el fix.
## TRIGGER:  GitHub Action en push a main, MCP tool isla_sync_validator
## OUTPUT:   Informe de sincronización MAPA-ISLAS.md ↔ disco

set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || echo .)}"
MAPA="$ROOT/MAPA-ISLAS.md"
DATE=$(date +"%Y-%m-%d %H:%M")
ISSUES=0

echo "# 🗺️  ISLA SYNC VALIDATOR — $DATE"
echo ""

if [ ! -f "$MAPA" ]; then
  echo "❌ MAPA-ISLAS.md no encontrado en $ROOT"
  exit 1
fi

# Extraer islas mencionadas en MAPA-ISLAS.md (carpetas referenciadas)
MAPPED_DIRS=$(grep -oP '^## \K[^\n]+' "$MAPA" 2>/dev/null | \
  tr '[:upper:]' '[:lower:]' | \
  sed 's/ /-/g' || true)

# Carpetas de primer nivel en el repo (islas reales)
REAL_DIRS=$(find "$ROOT" -mindepth 1 -maxdepth 1 -type d | \
  xargs -I{} basename {} | \
  grep -v '^\.' | \
  grep -v 'node_modules' | \
  sort)

echo "## Islas documentadas en MAPA-ISLAS.md vs disco"
echo ""

# Islas en disco pero NO en el mapa
echo "### Islas en disco pero NO documentadas en MAPA-ISLAS.md:"
while IFS= read -r dir; do
  if ! echo "$MAPPED_DIRS" | grep -qi "$dir"; then
    echo "  ⚠️  NO DOCUMENTADA: $dir"
    echo "     Fix: Añadir '## $dir' a MAPA-ISLAS.md"
    ISSUES=$((ISSUES+1))
  fi
done <<< "$REAL_DIRS"
echo ""

# Islas documentadas pero NO en disco
echo "### Islas documentadas en MAPA-ISLAS.md pero NO en disco:"
while IFS= read -r isla; do
  if [ -n "$isla" ] && [ ! -d "$ROOT/$isla" ]; then
    echo "  ❌  FANTASMA DOC: $isla"
    echo "     Fix: Crear carpeta '$isla/' o eliminar de MAPA-ISLAS.md"
    ISSUES=$((ISSUES+1))
  fi
done <<< "$MAPPED_DIRS"
echo ""

echo "## Resumen"
if [ "$ISSUES" -eq 0 ]; then
  echo "✅ MAPA-ISLAS.md sincronizado con la realidad del repo."
else
  echo "⚠️  $ISSUES discrepancias entre MAPA-ISLAS.md y el repo real."
  exit 1
fi
