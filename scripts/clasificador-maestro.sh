#!/usr/bin/env bash
# =============================================================
# FUNCIÓN:   Decisor maestro del inbox. Analiza cada archivo
#            de inbox/ y decide su destino final según nombre,
#            contenido y metadatos. Es la pieza más crítica
#            del flujo de automatización.
# TRIGGER:   push a main / workflow_dispatch / manual
# AGENTE:    thdora-guardian, clasificador-maestro.yml
# ETIQUETAS: inbox, clasificacion
# RUTAS:     Lee: inbox/*.md
#            Escribe: docs/, scripts/, agentes/, investigacion/,
#                     islas/, docs/leyes/, docs/tareas/, inbox/archive/
# =============================================================

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo '.')"
INBOX="$REPO_ROOT/inbox"
LOG="$REPO_ROOT/diarios/clasificador-$(date +%Y-%m-%d).log"

mkdir -p "$REPO_ROOT/docs/leyes" \
         "$REPO_ROOT/docs/tareas" \
         "$REPO_ROOT/agentes" \
         "$REPO_ROOT/investigacion" \
         "$REPO_ROOT/islas" \
         "$REPO_ROOT/inbox/archive"

log() { echo "[$(date +%H:%M:%S)] $*" | tee -a "$LOG"; }

clasificar_archivo() {
  local archivo="$1"
  local nombre
  nombre=$(basename "$archivo")
  local destino=""
  local motivo=""

  # Ignorar ficheros especiales
  [[ "$nombre" == ".gitkeep" ]] && return
  [[ "$nombre" == "README.md" ]] && return
  [[ "$nombre" == "PLANTILLA-INBOX.md" ]] && return
  [[ "$nombre" == "APLAZADO-template.md" ]] && return

  # Leer primeras líneas para detectar tipo por contenido
  local cabecera
  cabecera=$(head -5 "$archivo" 2>/dev/null || echo "")

  # --- REGLAS DE CLASIFICACIÓN (orden: más específico primero) ---

  # 1. Diseño de agente
  if echo "$nombre $cabecera" | grep -qiE '(agente|agent|modelfile|ollama|diseño-agent)'; then
    destino="agentes"
    motivo="diseño de agente detectado"

  # 2. Script o código
  elif echo "$nombre $cabecera" | grep -qiE '(script|bash|python|\.sh|\.py|#!/)'; then
    destino="scripts"
    motivo="script ejecutable detectado"

  # 3. Reglas / leyes del sistema
  elif echo "$nombre $cabecera" | grep -qiE '(regla|ley|leyes|SINE|escalado|orquestacion|reglas)'; then
    destino="docs/leyes"
    motivo="regla del sistema detectada"

  # 4. Plan de islas
  elif echo "$nombre $cabecera" | grep -qiE '(isla|islas|ISLA|cluster|PLAN-ESTRUCTURA)'; then
    destino="islas"
    motivo="plan de islas detectado"

  # 5. OSINT / investigación
  elif echo "$nombre $cabecera" | grep -qiE '(osint|enjambre|rag|llm|filosofia|investigacion|research|bots-telegram)'; then
    destino="investigacion"
    motivo="investigación/OSINT detectado"

  # 6. Tareas pendientes
  elif echo "$nombre $cabecera" | grep -qiE '(tarea|TAREA|PENDIENTE|pendiente|TODO|SIGUIENTE-PASO|PENDIENTES)'; then
    destino="docs/tareas"
    motivo="tarea pendiente detectada"

  # 7. Documentación general (macro-spec, arquitectura, reality-check, etc.)
  elif echo "$nombre $cabecera" | grep -qiE '(MACRO|SPEC|arquitectura|reality|audit|alerting|plan-fases|MCP-SERVER|SINTESIS|repo-research|inbox-audit|fix-madre|health-alert|ideas-bots)'; then
    destino="docs"
    motivo="documentación permanente detectada"

  # 8. Fallback: si no se clasifica → docs/tareas como zona segura
  else
    destino="docs/tareas"
    motivo="sin clasificación específica → docs/tareas"
  fi

  log "📁 [$nombre] → $destino/ ($motivo)"

  # Marcar con prefijo EN-PROCESO antes de mover
  local destino_path="$REPO_ROOT/$destino/$nombre"

  # No sobreescribir si ya existe
  if [[ -f "$destino_path" ]]; then
    log "⚠️  [$nombre] ya existe en $destino/ → moviendo a archive"
    mv "$archivo" "$REPO_ROOT/inbox/archive/$nombre"
    return
  fi

  mv "$archivo" "$destino_path"
  log "✅ [$nombre] movido a $destino/"
}

main() {
  log "=== CLASIFICADOR MAESTRO INICIADO ==="
  log "Escaneando inbox: $INBOX"

  local total=0
  local clasificados=0

  while IFS= read -r -d '' archivo; do
    total=$((total + 1))
    clasificar_archivo "$archivo"
    clasificados=$((clasificados + 1))
  done < <(find "$INBOX" -maxdepth 1 -name '*.md' -not -name '.*' -print0 2>/dev/null)

  log "=== CLASIFICACIÓN COMPLETADA: $clasificados/$total archivos procesados ==="

  # Si quedan >10 archivos sin procesar, crear issue
  local restantes
  restantes=$(find "$INBOX" -maxdepth 1 -name '*.md' -not -name '.*' | wc -l | tr -d ' ')
  if [[ "$restantes" -gt 10 ]]; then
    log "🚨 ALERTA: $restantes archivos siguen en inbox tras clasificación"
    if command -v gh &>/dev/null; then
      gh issue create \
        --title "[INBOX] $restantes archivos sin clasificar tras clasificador-maestro" \
        --body "El clasificador-maestro no pudo mover $restantes archivos. Revisar manualmente.\n\nLog: diarios/clasificador-$(date +%Y-%m-%d).log" \
        --label "inbox,urgente" \
        --repo "alvarofernandezmota-tech/yggdrasil-dew" 2>/dev/null || true
    fi
  fi
}

main "$@"
