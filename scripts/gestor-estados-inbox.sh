#!/usr/bin/env bash
# =============================================================
# FUNCIÓN:   Gestor de los 3 estados del inbox.
#            NUEVO → EN-PROCESO → PROCESADO
#            Cada archivo pasa por estos estados con timestamps.
#            Detecta archivos bloqueados (>24h en EN-PROCESO).
# TRIGGER:   push a main / cron cada 6h / workflow_dispatch
# AGENTE:    gestor-estados-inbox.yml
# ETIQUETAS: inbox, clasificacion
# RUTAS:     Lee/Escribe: inbox/*.md, inbox/estados/
#            Logs en: diarios/gestor-estados-YYYY-MM-DD.log
# =============================================================

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo '.')"
INBOX="$REPO_ROOT/inbox"
ESTADOS="$REPO_ROOT/inbox/.estados"
LOG="$REPO_ROOT/diarios/gestor-estados-$(date +%Y-%m-%d).log"
AHORA=$(date +%s)

mkdir -p "$ESTADOS" "$REPO_ROOT/inbox/archive" "$REPO_ROOT/diarios"

log() { echo "[$(date +%H:%M:%S)] $*" | tee -a "$LOG"; }

# Estado de un archivo: lee o devuelve NUEVO
get_estado() {
  local nombre="$1"
  local estado_file="$ESTADOS/${nombre}.estado"
  if [[ -f "$estado_file" ]]; then
    cat "$estado_file"
  else
    echo "NUEVO"
  fi
}

# Guarda el estado con timestamp
set_estado() {
  local nombre="$1"
  local estado="$2"
  local estado_file="$ESTADOS/${nombre}.estado"
  echo "$estado|$(date +%s)|$(date '+%Y-%m-%d %H:%M:%S')" > "$estado_file"
  log "🔄 [$nombre] → $estado"
}

# Tiempo en segundos desde que entró en el estado actual
tiempo_en_estado() {
  local nombre="$1"
  local estado_file="$ESTADOS/${nombre}.estado"
  if [[ -f "$estado_file" ]]; then
    local ts
    ts=$(cut -d'|' -f2 "$estado_file")
    echo $((AHORA - ts))
  else
    echo "0"
  fi
}

procesar_archivo() {
  local archivo="$1"
  local nombre
  nombre=$(basename "$archivo")

  # Ignorar especiales
  [[ "$nombre" == ".gitkeep" ]] && return
  [[ "$nombre" == "README.md" ]] && return
  [[ "$nombre" == "PLANTILLA-INBOX.md" ]] && return
  [[ "$nombre" == "APLAZADO-template.md" ]] && return
  [[ "$archivo" == *"/archive/"* ]] && return

  local estado
  estado=$(get_estado "$nombre")
  local tiempo
  tiempo=$(tiempo_en_estado "$nombre")

  case "$estado" in

    NUEVO)
      # Transición: NUEVO → EN-PROCESO
      set_estado "$nombre" "EN-PROCESO"
      log "📥→🔄 [$nombre] NUEVO → EN-PROCESO"
      ;;

    EN-PROCESO)
      # Si lleva >24h en EN-PROCESO → forzar a PROCESADO o archive
      if [[ "$tiempo" -gt 86400 ]]; then
        log "⏰ [$nombre] lleva $((tiempo/3600))h en EN-PROCESO — forzando archive"
        mv "$archivo" "$REPO_ROOT/inbox/archive/$nombre" 2>/dev/null || true
        set_estado "$nombre" "PROCESADO-ARCHIVE"

        if command -v gh &>/dev/null; then
          gh issue create \
            --title "[INBOX-BLOQUEADO] $nombre lleva >24h sin procesar" \
            --body "El archivo \`$nombre\` lleva $((tiempo/3600)) horas en estado EN-PROCESO sin avanzar. Ha sido movido a \`inbox/archive/\`." \
            --label "inbox,urgente" \
            --repo "alvarofernandezmota-tech/yggdrasil-dew" 2>/dev/null || true
        fi
      else
        log "🔄 [$nombre] EN-PROCESO hace $((tiempo/60)) min — esperando clasificador"
      fi
      ;;

    PROCESADO*)
      log "✅ [$nombre] ya está PROCESADO — sin acción"
      ;;
  esac
}

generar_informe() {
  local nuevos=0 en_proceso=0 procesados=0 bloqueados=0

  while IFS= read -r -d '' archivo; do
    local nombre
    nombre=$(basename "$archivo")
    [[ "$nombre" == ".gitkeep" ]] && continue
    [[ "$archivo" == *"/archive/"* ]] && continue

    local estado
    estado=$(get_estado "$nombre")
    local tiempo
    tiempo=$(tiempo_en_estado "$nombre")

    case "$estado" in
      NUEVO)      nuevos=$((nuevos+1)) ;;
      EN-PROCESO) en_proceso=$((en_proceso+1))
                  [[ "$tiempo" -gt 86400 ]] && bloqueados=$((bloqueados+1)) ;;
      PROCESADO*) procesados=$((procesados+1)) ;;
    esac
  done < <(find "$INBOX" -maxdepth 1 -name '*.md' -print0 2>/dev/null)

  log "=== INFORME DE ESTADOS ==="
  log "  📥 NUEVO:      $nuevos"
  log "  🔄 EN-PROCESO: $en_proceso (bloqueados >24h: $bloqueados)"
  log "  ✅ PROCESADO:  $procesados"
  log "========================="
}

main() {
  log "=== GESTOR DE ESTADOS INBOX INICIADO ==="

  while IFS= read -r -d '' archivo; do
    procesar_archivo "$archivo"
  done < <(find "$INBOX" -maxdepth 1 -name '*.md' -print0 2>/dev/null)

  generar_informe
  log "=== GESTOR DE ESTADOS FINALIZADO ==="
}

main "$@"
