#!/usr/bin/env bash
## FUNCIÓN: Detecta archivos fantasma: vacíos, huérfanos sin referencia,
##          y documentos que referencian rutas inexistentes en el repo.
## TRIGGER:  GitHub Action repo-audit, MCP tool ghost_file_detector
## OUTPUT:   Lista de fantasmas + issue si hay críticos

set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || echo .)}"
DATE=$(date +"%Y-%m-%d %H:%M")
GHOSTS=0
REPORT=""

log() { REPORT+="$1\n"; echo "$1"; }

log "# 👻 GHOST FILE DETECTOR — $DATE"
log ""

# ── 1. ARCHIVOS COMPLETAMENTE VACÍOS ─────────────────────────────────────────
log "## Archivos vacíos (0 bytes)"
while IFS= read -r f; do
  rel="${f#$ROOT/}"
  # Ignorar .gitkeep y carpetas .git
  if [[ "$rel" == *".gitkeep"* ]] || [[ "$rel" == *".git/"* ]]; then
    continue
  fi
  log "  👻 VACÍO: $rel"
  GHOSTS=$((GHOSTS+1))
done < <(find "$ROOT" -type f -empty 2>/dev/null | grep -v '.git' || true)
log ""

# ── 2. LINKS INTERNOS ROTOS EN MARKDOWN ──────────────────────────────────────
log "## Links internos rotos en .md"
while IFS= read -r mdfile; do
  rel="${mdfile#$ROOT/}"
  # Extraer links tipo [texto](ruta) que no sean http/https
  grep -oP '\((?!https?://)[^)]+\.md[^)]*\)' "$mdfile" 2>/dev/null | \
  sed 's/[()]//g' | \
  while IFS= read -r link; do
    # Resolver ruta relativa al directorio del .md
    dir=$(dirname "$mdfile")
    target="$dir/$link"
    if [ ! -f "$target" ] && [ ! -f "$ROOT/$link" ]; then
      log "  🔗 ROTO: $rel → $link"
      GHOSTS=$((GHOSTS+1))
    fi
  done
done < <(find "$ROOT" -name '*.md' | grep -v '.git' || true)
log ""

# ── 3. SCRIPTS REFERENCIADOS EN DOCS PERO INEXISTENTES ───────────────────────
log "## Scripts referenciados pero no existentes"
SCRIPTS_DIR="$ROOT/scripts"
while IFS= read -r mdfile; do
  grep -oP 'scripts/[a-zA-Z0-9_-]+\.sh' "$mdfile" 2>/dev/null | \
  while IFS= read -r script_ref; do
    if [ ! -f "$ROOT/$script_ref" ]; then
      rel="${mdfile#$ROOT/}"
      log "  📄 REFERENCIADO PERO FALTA: $script_ref (mencionado en $rel)"
      GHOSTS=$((GHOSTS+1))
    fi
  done
done < <(find "$ROOT" -name '*.md' | grep -v '.git' || true)
log ""

# ── RESUMEN ───────────────────────────────────────────────────────────────────
log "## Resumen"
if [ "$GHOSTS" -eq 0 ]; then
  log "✅ GHOST OK — Sin archivos fantasma detectados."
else
  log "⚠️  GHOSTS: $GHOSTS elementos problemáticos. Revisar arriba."
  if command -v gh &>/dev/null && [ -n "${GITHUB_REPOSITORY:-}" ]; then
    gh issue create \
      --title "[GHOST-DETECTOR] $GHOSTS archivos fantasma — $DATE" \
      --body "$(printf '%b' "$REPORT")" \
      --label "audit,fantasma,automatico" 2>/dev/null || true
    echo "📋 Issue automático creado."
  fi
  exit 1
fi
