#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# terminal-logger.sh
# Role: Logger (captura y documenta lo que se escribe/ejecuta en terminal → inbox)
# Version: 1.0
# Author: thdora-guardian[bot]
# Función única: capturar sesiones de terminal y guardarlas como artefactos en inbox/terminal-log/
#
# MODOS DE USO:
#   1. Wrappear un comando:
#        bash terminal-logger.sh -- bash scripts/agentes/agente-mejorador.sh --verbose
#   2. Grabar sesión interactiva completa:
#        bash terminal-logger.sh --session
#   3. Loggear texto/pipe desde stdin:
#        echo "output aquí" | bash terminal-logger.sh --stdin --label "mi-tarea"
#   4. Añadir nota manual al log:
#        bash terminal-logger.sh --note "Ejecuté X manualmente porque Y"

OUT_DIR="${OUT_DIR:-inbox/terminal-log}"
LABEL="${LABEL:-}"
DRY_RUN=false
VERBOSE=false
MODE="command"  # command | session | stdin | note

log(){ printf '%s %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$*"; }
on_err(){ log "ERROR at line $1"; exit 2; }
trap 'on_err $LINENO' ERR

usage(){
  cat <<EOF
Usage:
  $0 [--label NOMBRE] [--out DIR] -- COMANDO [ARGS...]
  $0 --session [--label NOMBRE]
  $0 --stdin   [--label NOMBRE]
  $0 --note "texto de nota manual"

Opciones:
  --label NAME    Etiqueta para el archivo de log (ej: "mejorador-run")
  --out DIR       Directorio de salida (default: $OUT_DIR)
  --dry-run       No escribir nada, solo mostrar qué haría
  --verbose       Log detallado
EOF
  exit 0
}

CMD_ARGS=()
NOTE_TEXT=""

while [[ "${1:-}" != "" ]]; do
  case "$1" in
    --session)  MODE="session"; shift ;;
    --stdin)    MODE="stdin"; shift ;;
    --note)     MODE="note"; NOTE_TEXT="${2:-}"; shift 2 ;;
    --label)    LABEL="$2"; shift 2 ;;
    --out)      OUT_DIR="$2"; shift 2 ;;
    --dry-run)  DRY_RUN=true; shift ;;
    --verbose)  VERBOSE=true; shift ;;
    -h|--help)  usage ;;
    --)         shift; CMD_ARGS=("$@"); break ;;
    *)          shift ;;
  esac
done

mkdir -p "$OUT_DIR"

ts(){ date -u +'%Y%m%dT%H%M%SZ'; }
label_slug(){ echo "${LABEL:-unnamed}" | tr ' /' '__' | tr -cd 'a-zA-Z0-9_-'; }

write_log(){
  local content="$1"
  local filename="$OUT_DIR/$(ts)-$(label_slug).md"
  if $DRY_RUN; then
    log "[DRY-RUN] Escribiría en $filename"
    return
  fi
  cat > "$filename" <<EOF
# Terminal Log — $(label_slug)
**Timestamp:** $(date -u +'%Y-%m-%dT%H:%M:%SZ')
**Label:** ${LABEL:-sin etiqueta}
**Host:** $(hostname)
**User:** $(whoami)
**PWD:** $(pwd)

\`\`\`
$content
\`\`\`
EOF
  log "Log guardado → $filename"
  echo "$filename"
}

# ─── MODO: wrappear un comando ────────────────────────────────────────────────
run_command(){
  if [[ ${#CMD_ARGS[@]} -eq 0 ]]; then
    log "ERROR: no se especificó comando. Usa: $0 -- COMANDO"
    exit 1
  fi
  [[ -z "$LABEL" ]] && LABEL="${CMD_ARGS[0]##*/}"
  log "Ejecutando: ${CMD_ARGS[*]}"
  local tmp
  tmp="$(mktemp)"
  # Captura stdout+stderr, muestra en tiempo real Y guarda
  { "${CMD_ARGS[@]}" 2>&1 | tee "$tmp"; } || true
  local output
  output="$(cat "$tmp")"
  rm -f "$tmp"
  write_log "$ ${CMD_ARGS[*]}"$'\n'"$output"
}

# ─── MODO: sesión interactiva completa con script(1) ─────────────────────────
run_session(){
  if ! command -v script >/dev/null 2>&1; then
    log "ERROR: 'script' no disponible. Instala util-linux."
    exit 1
  fi
  [[ -z "$LABEL" ]] && LABEL="session"
  local raw="$OUT_DIR/$(ts)-$(label_slug).typescript"
  log "Iniciando sesión grabada → $raw"
  log "Escribe 'exit' para finalizar la sesión."
  script -q "$raw" || true
  # Convertir typescript a texto legible
  local clean
  clean="$(col -bx < "$raw" 2>/dev/null || cat "$raw")"
  write_log "$clean"
  $DRY_RUN || rm -f "$raw"
}

# ─── MODO: stdin pipe ────────────────────────────────────────────────────────
run_stdin(){
  [[ -z "$LABEL" ]] && LABEL="stdin"
  local content
  content="$(cat)"
  write_log "$content"
}

# ─── MODO: nota manual ───────────────────────────────────────────────────────
run_note(){
  [[ -z "$NOTE_TEXT" ]] && { log "ERROR: --note requiere texto"; exit 1; }
  [[ -z "$LABEL" ]] && LABEL="nota-manual"
  write_log "NOTA MANUAL: $NOTE_TEXT"
}

# ─── DISPATCHER ──────────────────────────────────────────────────────────────
main(){
  case "$MODE" in
    command) run_command ;;
    session) run_session ;;
    stdin)   run_stdin ;;
    note)    run_note ;;
  esac
}

main "$@"
