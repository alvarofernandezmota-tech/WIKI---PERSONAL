#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# =============================================================================
# Nombre:       agente-estado-tracker.sh
# Función única: Gestiona estados y etiquetas de artefactos en inbox/ y en GitHub issues
# Rol:          tracker
# Versión:      1.0
# Autor:        Perplexity-MCP <alvarofernandezmota@gmail.com>
# Creado:       2026-07-03 23:55 CEST
# Actualizado:  2026-07-03 23:55 CEST
# Ruta:         scripts/agentes/agente-estado-tracker.sh
# Tags:         [tracker, estado, labels, inbox]
# Flags:
#   --mark ESTADO ARCHIVO    Marca un archivo con estado
#   --report                 Genera reporte de todos los estados en inbox/
#   --sync-issues            Sincroniza estados con labels de GitHub issues
#   --verbose                Log detallado
#   --dry-run                Simula sin escribir
#
# ESTADOS: por-hacer | en-proceso | completado | archivado | bloqueado
# =============================================================================

INBOX="${INBOX:-inbox}"
DRY_RUN=false
VERBOSE=false
MODE="report"
TARGET_FILE=""
TARGET_ESTADO=""

log(){ printf '%s %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$*"; }
on_err(){ log "ERROR at line $1"; exit 2; }
trap 'on_err $LINENO' ERR

usage(){
  cat <<EOF
Usage:
  $0 --mark <estado> <archivo>   Marca archivo con estado
  $0 --report                    Genera reporte de estados en inbox/
  $0 --sync-issues               Sincroniza con labels de GitHub

Estados válidos: por-hacer | en-proceso | completado | archivado | bloqueado
EOF
  exit 0
}

while [[ "${1:-}" != "" ]]; do
  case "$1" in
    --mark)
      MODE="mark"
      TARGET_ESTADO="$2"
      TARGET_FILE="$3"
      shift 3
      ;;
    --report)      MODE="report"; shift ;;
    --sync-issues) MODE="sync"; shift ;;
    --dry-run)     DRY_RUN=true; shift ;;
    --verbose)     VERBOSE=true; shift ;;
    -h|--help)     usage ;;
    *)             shift ;;
  esac
done

# Emoji por estado
estado_emoji(){
  case "$1" in
    por-hacer)   echo "🔴" ;;
    en-proceso)  echo "🟡" ;;
    completado)  echo "🟢" ;;
    archivado)   echo "⚪" ;;
    bloqueado)   echo "🔵" ;;
    *)           echo "❓" ;;
  esac
}

# Marca un archivo añadiendo/actualizando línea de estado en el archivo
do_mark(){
  local file="$1" estado="$2"
  local emoji
  emoji=$(estado_emoji "$estado")
  local ts
  ts=$(date -u +%Y-%m-%dT%H:%M:%SZ)

  if [[ ! -f "$file" ]]; then
    log "ERROR: archivo no encontrado: $file"
    exit 1
  fi

  if $DRY_RUN; then
    log "[DRY-RUN] Marcaría $file como $emoji $estado"
    return
  fi

  # Si es .md, actualizar o añadir línea de estado en frontmatter
  if [[ "${file##*.}" == "md" ]]; then
    if grep -q '^status:' "$file"; then
      sed -i "s/^status:.*/status: $estado/" "$file"
    else
      # Si tiene frontmatter añadir antes del ---
      if head -1 "$file" | grep -q '^---'; then
        sed -i "1a status: $estado" "$file" || true
      fi
    fi
  fi

  # Crear/actualizar archivo de tracking en inbox/
  local track_dir="$INBOX/.tracker"
  mkdir -p "$track_dir"
  local track_file="$track_dir/$(echo "$file" | tr '/' '_').json"
  jq -n \
    --arg file "$file" \
    --arg estado "$estado" \
    --arg emoji "$emoji" \
    --arg ts "$ts" \
    '{file:$file, estado:$estado, emoji:$emoji, ts:$ts}' > "$track_file"

  log "$emoji $estado → $file"
}

# Genera reporte de todos los estados
do_report(){
  log "Generando reporte de estados..."
  local ts
  ts=$(date -u +'%Y%m%dT%H%M%SZ')
  local report="$INBOX/.tracker/reporte-${ts}.md"
  mkdir -p "$INBOX/.tracker"

  {
    echo "# Estado del Inbox — $(date -u +%Y-%m-%dT%H:%M:%SZ)"
    echo ""
    echo "| Estado | Archivo | Última actualización |"
    echo "|---|---|---|"

    for tf in "$INBOX"/.tracker/*.json; do
      [[ -f "$tf" ]] || continue
      file=$(jq -r '.file' "$tf")
      estado=$(jq -r '.estado' "$tf")
      ts_item=$(jq -r '.ts' "$tf")
      emoji=$(estado_emoji "$estado")
      echo "| $emoji $estado | \`$file\` | $ts_item |"
    done

    echo ""
    echo "## Resumen"
    for e in por-hacer en-proceso completado archivado bloqueado; do
      count=$(find "$INBOX/.tracker" -name '*.json' -exec jq -r '.estado' {} \; 2>/dev/null | grep -c "^${e}$" || true)
      emoji=$(estado_emoji "$e")
      echo "- $emoji $e: $count"
    done
  } > "$report"

  log "Reporte guardado → $report"
  cat "$report"
}

# Sincroniza estados con labels de issues de GitHub
do_sync(){
  if ! command -v gh >/dev/null 2>&1; then
    log "WARN: gh CLI no disponible, saltando sync"
    return
  fi

  log "Sincronizando estados con GitHub issues..."
  # Para cada issue abierto con label agent-fix, verificar si hay artefacto completado
  while IFS= read -r issue_number; do
    local tracking
    tracking=$(find "$INBOX/.tracker" -name '*.json' \
      -exec jq -r 'select(.estado=="completado") | .file' {} \; 2>/dev/null | head -1 || true)
    if [[ -n "$tracking" ]]; then
      if $DRY_RUN; then
        log "[DRY-RUN] Añadiría label 'completado' a issue #$issue_number"
      else
        gh issue edit "$issue_number" --add-label "completado" --remove-label "por-hacer,en-proceso" 2>/dev/null || true
        log "Issue #$issue_number → completado"
      fi
    fi
  done < <(gh issue list --label "agent-fix" --json number --jq '.[].number' 2>/dev/null || true)

  log "Sync finalizado"
}

main(){
  log "agente-estado-tracker iniciado (mode=$MODE)"
  case "$MODE" in
    mark)   do_mark "$TARGET_FILE" "$TARGET_ESTADO" ;;
    report) do_report ;;
    sync)   do_sync ;;
  esac
  log "agente-estado-tracker finalizado"
}

main "$@"
