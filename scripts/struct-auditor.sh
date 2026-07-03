#!/usr/bin/env bash
# =============================================================
# FUNCIÓN:   Auditoría milimétrica de estructura del repo.
#            Detecta carpetas duplicadas, archivos mal ubicados,
#            carpetas vacías, naming roto. Abre issues automáticos.
#            NO modifica nada — solo detecta y reporta.
# TRIGGER:   cron semanal / workflow_dispatch / post-push estructura
# AGENTE:    struct-auditor-agent, struct-auditor-agent.yml
# ETIQUETAS: estructura, duplicado, deuda-tecnica
# RUTAS:     Lee: todo el repo
#            Escribe: diarios/struct-audit-YYYY-MM-DD.md
# =============================================================

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo '.')"
FECHA=$(date +%Y-%m-%d)
LOG="$REPO_ROOT/diarios/struct-audit-$FECHA.md"
ISSUES_ABIERTOS=0

mkdir -p "$REPO_ROOT/diarios"

log() { echo "$*" | tee -a "$LOG"; }

crear_issue() {
  local titulo="$1"
  local body="$2"
  local labels="$3"
  if command -v gh &>/dev/null; then
    # Verificar si ya existe issue con mismo título
    EXISTE=$(gh issue list --label "$labels" --state open \
      --json title --jq ".[].title" 2>/dev/null | grep -F "$titulo" || true)
    if [[ -z "$EXISTE" ]]; then
      gh issue create \
        --title "$titulo" \
        --body "$body" \
        --label "$labels" \
        --repo "alvarofernandezmota-tech/yggdrasil-dew" 2>/dev/null && \
        ISSUES_ABIERTOS=$((ISSUES_ABIERTOS + 1)) || true
      log "  🚨 Issue creado: $titulo"
    else
      log "  ⚠️  Issue ya existe: $titulo"
    fi
  fi
}

# --- INICIO LOG ---
cat > "$LOG" << EOF
# 🏗️ STRUCT AUDIT — $FECHA

Generado por: struct-auditor.sh
Fecha: $(date '+%Y-%m-%d %H:%M:%S')

---

EOF

log "## 1. CARPETAS DUPLICADAS"

# diarios/ vs diary/
if [[ -d "$REPO_ROOT/diarios" && -d "$REPO_ROOT/diary" ]]; then
  DIARIOS=$(find "$REPO_ROOT/diarios" -name '*.md' | wc -l | tr -d ' ')
  DIARY=$(find "$REPO_ROOT/diary" -name '*.md' | wc -l | tr -d ' ')
  log "  🔴 DUPLICADO: diarios/ ($DIARIOS archivos) + diary/ ($DIARY archivos)"
  crear_issue \
    "[DEUDA] Carpetas duplicadas: diarios/ y diary/ deben mergearse" \
    "Las carpetas \`diarios/\` ($DIARIOS archivos) y \`diary/\` ($DIARY archivos) son duplicadas.\n\n**Acción**: Mover todo a \`diarios/\`, deprecar \`diary/\`, actualizar referencias." \
    "deuda-tecnica,duplicado,estructura"
else
  log "  ✅ No hay duplicado diarios/diary/"
fi

# osint/ vs osint-stack/
if [[ -d "$REPO_ROOT/osint" && -d "$REPO_ROOT/osint-stack" ]]; then
  OSINT=$(find "$REPO_ROOT/osint" -name '*.md' | wc -l | tr -d ' ')
  STACK=$(find "$REPO_ROOT/osint-stack" -name '*.md' | wc -l | tr -d ' ')
  log "  🔴 DUPLICADO: osint/ ($OSINT archivos) + osint-stack/ ($STACK archivos)"
  crear_issue \
    "[DEUDA] Carpetas duplicadas: osint/ y osint-stack/ deben mergearse" \
    "Las carpetas \`osint/\` ($OSINT archivos) y \`osint-stack/\` ($STACK archivos) son duplicadas.\n\n**Acción**: Mover todo a \`osint/\`, deprecar \`osint-stack/\`." \
    "deuda-tecnica,duplicado,estructura"
else
  log "  ✅ No hay duplicado osint/"
fi

log ""
log "## 2. CARPETAS VACÍAS"

while IFS= read -r -d '' dir; do
  NOMBRE=$(basename "$dir")
  # Ignorar .git y node_modules
  [[ "$dir" == *".git"* ]] && continue
  [[ "$dir" == *"node_modules"* ]] && continue
  # Ignorar si solo tiene .gitkeep
  CONTENIDO=$(find "$dir" -not -name '.gitkeep' -not -type d 2>/dev/null | wc -l | tr -d ' ')
  if [[ "$CONTENIDO" -eq 0 ]]; then
    log "  🟡 VACÍA: $dir"
  fi
done < <(find "$REPO_ROOT" -type d -not -path '*/.git/*' -print0 2>/dev/null)

log ""
log "## 3. SCRIPTS SIN CABECERA ESTÁNDAR"

SIN_CABECERA=0
while IFS= read -r -d '' script; do
  if ! grep -q 'FUNCIÓN:' "$script" 2>/dev/null; then
    log "  🟡 SIN CABECERA: $script"
    SIN_CABECERA=$((SIN_CABECERA + 1))
  fi
done < <(find "$REPO_ROOT/scripts" -name '*.sh' -print0 2>/dev/null)

if [[ "$SIN_CABECERA" -gt 3 ]]; then
  crear_issue \
    "[DEUDA] $SIN_CABECERA scripts sin cabecera estándar" \
    "$SIN_CABECERA scripts en \`scripts/\` no tienen cabecera con FUNCIÓN/TRIGGER/ETIQUETAS/RUTAS.\n\nVer: \`diarios/struct-audit-$FECHA.md\`" \
    "deuda-tecnica,estructura"
fi

log ""
log "## 4. ARCHIVOS VACÍOS"

while IFS= read -r -d '' archivo; do
  [[ "$(basename $archivo)" == '.gitkeep' ]] && continue
  log "  🟡 VACÍO: $archivo"
done < <(find "$REPO_ROOT" -name '*.md' -size 0 -not -path '*/.git/*' -print0 2>/dev/null)

log ""
log "## RESUMEN"
log "  Issues abiertos esta ejecución: $ISSUES_ABIERTOS"
log "  Fecha: $(date '+%Y-%m-%d %H:%M:%S')"
log ""
log "---"
log "*Generado por struct-auditor.sh [AUTO]*"
