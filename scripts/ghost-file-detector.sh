#!/usr/bin/env bash
# =============================================================
# FUNCIÓN:   Detectar archivos fantasma: vacíos, huérfanos,
#            sin referencias en docs, o referenciados pero
#            inexistentes. Nivel ingeniero: cero tolerancia
#            a archivos que no deberían estar.
# TRIGGER:   cron semanal / tras inbox-cleanup / manual
# AGENTE:    ghost-detector-agent, ghost-detector.yml
# ETIQUETAS: estructura, deuda-tecnica
# RUTAS:     Lee: todo el repo
#            Escribe: diarios/ghost-detector-YYYY-MM-DD.md
# =============================================================

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo '.')"
FECHA=$(date +%Y-%m-%d)
LOG="$REPO_ROOT/diarios/ghost-detector-$FECHA.md"
FANTASMAS=0

mkdir -p "$REPO_ROOT/diarios"

log() { echo "$*" | tee -a "$LOG"; }

cat > "$LOG" << EOF
# 👻 GHOST FILE DETECTOR — $FECHA

Generado por: ghost-file-detector.sh
Fecha: $(date '+%Y-%m-%d %H:%M:%S')

---

EOF

log "## 1. ARCHIVOS .MD VACÍOS"
while IFS= read -r -d '' archivo; do
  [[ "$(basename $archivo)" == '.gitkeep' ]] && continue
  FANTASMAS=$((FANTASMAS + 1))
  log "  👻 VACÍO: ${archivo#$REPO_ROOT/}"
done < <(find "$REPO_ROOT" -name '*.md' -size 0 \
  -not -path '*/.git/*' -not -name '.gitkeep' -print0 2>/dev/null)

log ""
log "## 2. SCRIPTS .SH VACÍOS O SIN PERMISOS DE EJECUCIÓN"
while IFS= read -r -d '' script; do
  NOMBRE="${script#$REPO_ROOT/}"
  if [[ ! -s "$script" ]]; then
    FANTASMAS=$((FANTASMAS + 1))
    log "  👻 VACÍO: $NOMBRE"
  elif [[ ! -x "$script" ]]; then
    log "  ⚠️  SIN +x: $NOMBRE"
  fi
done < <(find "$REPO_ROOT/scripts" -name '*.sh' -print0 2>/dev/null)

log ""
log "## 3. REFERENCIAS ROTAS EN DOCS"
# Buscar menciones de scripts/ en docs/ y verificar que existen
while IFS= read -r linea; do
  archivo_ref=$(echo "$linea" | grep -oE 'scripts/[a-zA-Z0-9._-]+\.sh' | head -1)
  if [[ -n "$archivo_ref" && ! -f "$REPO_ROOT/$archivo_ref" ]]; then
    FANTASMAS=$((FANTASMAS + 1))
    log "  👻 REF ROTA: '$archivo_ref' mencionado pero no existe"
  fi
done < <(grep -r 'scripts/.*\.sh' "$REPO_ROOT/docs" 2>/dev/null || true)

log ""
log "## 4. ARCHIVOS EN INBOX SIN FECHA EN NOMBRE"
while IFS= read -r -d '' archivo; do
  NOMBRE=$(basename "$archivo")
  # Los archivos de inbox deben tener formato YYYY-MM-DD-nombre.md
  if ! echo "$NOMBRE" | grep -qE '^[0-9]{4}-[0-9]{2}-[0-9]{2}-.*\.md$'; then
    # Excepciones conocidas
    case "$NOMBRE" in
      README.md|PLANTILLA-INBOX.md|APLAZADO-template.md|PENDIENTES-*.md|\
      PLAN-*.md|SIGUIENTE-PASO.md|.gitkeep) continue ;;
    esac
    log "  ⚠️  NAMING INCORRECTO en inbox: $NOMBRE"
  fi
done < <(find "$REPO_ROOT/inbox" -maxdepth 1 -name '*.md' -print0 2>/dev/null)

log ""
log "## 5. WORKFLOWS SIN DESCRIPCIÓN EN CABECERA"
SIN_DESC=0
while IFS= read -r -d '' wf; do
  if ! grep -q 'FUNCIÓN:' "$wf" 2>/dev/null; then
    SIN_DESC=$((SIN_DESC + 1))
    log "  ⚠️  SIN CABECERA: ${wf#$REPO_ROOT/}"
  fi
done < <(find "$REPO_ROOT/.github/workflows" -name '*.yml' -print0 2>/dev/null)

log ""
log "## RESUMEN"
log "  Fantasmas detectados: $FANTASMAS"
log "  Workflows sin cabecera: $SIN_DESC"
log ""

if [[ "$FANTASMAS" -gt 0 ]] && command -v gh &>/dev/null; then
  gh issue create \
    --title "[GHOST] $FANTASMAS archivos fantasma detectados ($FECHA)" \
    --body "Ghost-file-detector encontró $FANTASMAS archivos fantasma.\n\nVer log completo: \`diarios/ghost-detector-$FECHA.md\`\n\n**Acción requerida**: revisar y limpiar manualmente." \
    --label "estructura,deuda-tecnica" \
    --repo "alvarofernandezmota-tech/yggdrasil-dew" 2>/dev/null || true
fi

log "---"
log "*Generado por ghost-file-detector.sh [AUTO]*"
