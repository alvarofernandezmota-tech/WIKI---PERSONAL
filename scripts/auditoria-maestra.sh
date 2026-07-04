#!/usr/bin/env bash
# =============================================================================
# auditoria-maestra.sh — Auditoría completa del ecosistema yggdrasil-dew
# Uso: bash scripts/auditoria-maestra.sh [--dry-run] [--fix]
# =============================================================================
set -euo pipefail

DRY_RUN=false
FIX=false
for arg in "$@"; do
  case $arg in
    --dry-run) DRY_RUN=true ;;
    --fix)     FIX=true ;;
  esac
done

TS=$(date +%Y-%m-%dT%H-%M-%S)
FECHA=$(date +%Y-%m-%d)
REPORTE="inbox/_meta/auditoria-${FECHA}T${TS##*T}.md"
mkdir -p inbox/_meta

ERRORS=0
WARNS=0
FIXED=0
LINES=()

log() { echo "$1"; LINES+=("$1"); }

log "# Auditoría maestra — ${FECHA} ${TS##*T}"
log ""
log "Mode: $([ $DRY_RUN = true ] && echo 'dry-run' || echo 'real') | Fix: $([ $FIX = true ] && echo 'sí' || echo 'no')"
log ""
log "## 1. Archivos fuera de lugar en scripts/"

while IFS= read -r f; do
  log "  ⚠️  $f"
  WARNS=$((WARNS+1))
  if [ $FIX = true ] && [ $DRY_RUN = false ]; then
    DEST="inbox/drop/$(basename $f)"
    mv "$f" "$DEST"
    log "    → movido a $DEST"
    FIXED=$((FIXED+1))
  fi
done < <(find scripts/ -maxdepth 1 -name '*.md' \
  ! -name 'README.md' ! -name 'SCRIPTS.md' ! -name 'SCRIPTS-AUDITORIA.md' 2>/dev/null)

if [ ${#LINES[@]} -le 4 ]; then log "  ✅ OK"; fi

log ""
log "## 2. Carpetas obligatorias"
for d in inbox/drop inbox/sesiones inbox/_meta diarios docs scripts; do
  if [ -d "$d" ]; then
    log "  ✅ $d/"
  else
    log "  ❌ FALTA: $d/"
    ERRORS=$((ERRORS+1))
    if [ $FIX = true ] && [ $DRY_RUN = false ]; then
      mkdir -p "$d"
      touch "$d/.gitkeep"
      log "    → creado"
      FIXED=$((FIXED+1))
    fi
  fi
done

log ""
log "## 3. Scripts clave presentes"
for s in scripts/cierre-maestro.sh scripts/apertura-maestra.sh scripts/auditoria-maestra.sh scripts/inbox-commit.sh; do
  if [ -f "$s" ]; then
    log "  ✅ $s"
  else
    log "  ❌ FALTA: $s"
    ERRORS=$((ERRORS+1))
  fi
done

log ""
log "## 4. GitHub Actions presentes"
for a in .github/workflows/inbox-clasificador.yml .github/workflows/auditoria-auto.yml; do
  if [ -f "$a" ]; then
    log "  ✅ $a"
  else
    log "  ⚠️  FALTA: $a"
    WARNS=$((WARNS+1))
  fi
done

log ""
log "## 5. inbox/drop/ pendientes"
DROP_COUNT=$(find inbox/drop/ -not -name '.gitkeep' -not -type d 2>/dev/null | wc -l)
if [ "$DROP_COUNT" -gt 0 ]; then
  log "  📥 $DROP_COUNT archivo(s) pendiente(s):"
  find inbox/drop/ -not -name '.gitkeep' -not -type d 2>/dev/null | while read f; do log "    $f"; done
else
  log "  ✅ inbox/drop/ vacío (limpio)"
fi

log ""
log "## 6. Últimos 5 commits"
log '```'
log "$(git log -5 --oneline 2>/dev/null || echo '(sin historial)')"
log '```'

log ""
log "## Resumen"
log "| Métrica | Valor |"
log "|---|---|"
log "| ❌ Errores | ${ERRORS} |"
log "| ⚠️  Avisos | ${WARNS} |"
log "| 🔧 Fixes aplicados | ${FIXED} |"
log "| 📥 Drop pendientes | ${DROP_COUNT} |"

if [ $DRY_RUN = false ]; then
  printf '%s\n' "${LINES[@]}" > "$REPORTE"
  echo ""
  echo "📄 Reporte guardado en: $REPORTE"
fi

if [ $ERRORS -gt 0 ]; then
  echo "❌ Auditoría completada con $ERRORS error(es). Ejecuta con --fix para corregir."
  exit 1
else
  echo "✅ Auditoría OK (avisos: $WARNS)"
fi
