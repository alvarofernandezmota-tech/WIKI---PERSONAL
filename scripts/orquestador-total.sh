#!/usr/bin/env bash
set -euo pipefail

ROOT="/srv/yggdrasil-dew"
TIMESTAMP=$(date +"%Y%m%d-%H%M")

log() { echo "[$(date +"%H:%M:%S")] $*"; }
ensure_dir() { mkdir -p "$1"; }

###############################################
# 1. CLASIFICADOR MAESTRO
###############################################

clasificador_maestro() {
  log "Clasificador maestro — INICIO"

  INBOX="$ROOT/inbox"
  ARCHIVE="$ROOT/inbox/archive"
  ensure_dir "$ARCHIVE"

  for f in "$INBOX"/*; do
    [ -f "$f" ] || continue
    nombre="$(basename "$f")"
    contenido="$(cat "$f" 2>/dev/null || echo "")"

    destino=""

    if [[ "$nombre" =~ dise.*agent || "$contenido" =~ dise.*agent || "$contenido" =~ modelfile || "$contenido" =~ ollama ]]; then
      destino="$ROOT/agentes"
    elif [[ "$contenido" =~ regla || "$contenido" =~ ley || "$contenido" =~ SINE || "$contenido" =~ escalado ]]; then
      destino="$ROOT/docs/leyes"
    elif [[ "$contenido" =~ isla || "$nombre" =~ PLAN-ESTRUCTURA ]]; then
      destino="$ROOT/islas"
    elif [[ "$contenido" =~ enjambre || "$contenido" =~ rag || "$contenido" =~ osint || "$contenido" =~ telegram ]]; then
      destino="$ROOT/investigacion"
    elif [[ "$contenido" =~ MACRO || "$contenido" =~ arquitectura || "$contenido" =~ reality || "$contenido" =~ audit ]]; then
      destino="$ROOT/docs"
    elif [[ "$contenido" =~ tarea || "$contenido" =~ PENDIENTE || "$contenido" =~ SIGUIENTE-PASO ]]; then
      destino="$ROOT/docs/tareas"
    elif [[ "$contenido" =~ script || "$nombre" =~ \.sh$ || "$nombre" =~ \.py$ ]]; then
      destino="$ROOT/scripts"
    fi

    if [ -n "$destino" ]; then
      ensure_dir "$destino"
      if [ -f "$destino/$nombre" ]; then
        log "Ya existe en destino, archivando: $nombre"
        mv "$f" "$ARCHIVE/$nombre"
      else
        log "Moviendo $nombre → $destino"
        mv "$f" "$destino/$nombre"
      fi
    else
      log "Sin destino claro, se queda en inbox: $nombre"
    fi
  done

  log "Clasificador maestro — FIN"
}

###############################################
# 2. GESTOR ESTADOS INBOX
###############################################

gestor_estados_inbox() {
  log "Gestor estados inbox — INICIO"

  ESTADOS_DIR="$ROOT/inbox/.estados"
  ARCHIVE="$ROOT/inbox/archive"
  ensure_dir "$ESTADOS_DIR"
  ensure_dir "$ARCHIVE"

  for f in "$ROOT/inbox"/*; do
    [ -f "$f" ] || continue
    nombre="$(basename "$f")"
    estado_file="$ESTADOS_DIR/$nombre.estado"

    if [ ! -f "$estado_file" ]; then
      echo "NUEVO $(date +"%Y-%m-%d %H:%M:%S")" > "$estado_file"
      log "Marcado NUEVO: $nombre"
    fi
  done

  for e in "$ESTADOS_DIR"/*.estado; do
    [ -f "$e" ] || continue
    nombre="$(basename "$e" .estado)"
    if grep -q "EN-PROCESO" "$e"; then
      if [ -f "$ROOT/inbox/$nombre" ]; then
        log "Archivo atascado, archivando: $nombre"
        mv "$ROOT/inbox/$nombre" "$ARCHIVE/$nombre"
        echo "PROCESADO $(date +"%Y-%m-%d %H:%M:%S")" >> "$e"
      fi
    fi
  done

  log "Gestor estados inbox — FIN"
}

###############################################
# 3. STRUCT-AUDITOR
###############################################

struct_auditor() {
  REPORT_DIR="$ROOT/reports/struct"
  ensure_dir "$REPORT_DIR"
  REPORT="$REPORT_DIR/struct-$TIMESTAMP.md"
  ERRORS=false

  echo "# Auditoría estructural — $TIMESTAMP" > "$REPORT"
  echo "" >> "$REPORT"

  echo "## Carpetas requeridas" >> "$REPORT"
  REQUIRED_DIRS=(
    "agentes"
    "docs"
    "docs/leyes"
    "docs/tareas"
    "islas"
    "investigacion"
    "scripts"
    "inbox"
    "inbox/archive"
  )

  for d in "${REQUIRED_DIRS[@]}"; do
    if [ -d "$ROOT/$d" ]; then
      echo "- OK: $d" >> "$REPORT"
    else
      echo "- ERROR: Falta carpeta $d" >> "$REPORT"
      ERRORS=true
    fi
  done
  echo "" >> "$REPORT"

  echo "## Validación de plantillas" >> "$REPORT"

  check_template() {
    local file="$1"; shift
    local required=("$@")
    for r in "${required[@]}"; do
      if ! grep -q "$r" "$file" 2>/dev/null; then
        echo "- ERROR: $file no contiene '$r'" >> "$REPORT"
        ERRORS=true
      fi
    done
  }

  AGENT_REQ=("## Rol" "## Entradas" "## Salidas" "## Límites")
  for f in "$ROOT/agentes"/*/DISEÑO.md; do
    [ -f "$f" ] || continue
    echo "- Revisando $f" >> "$REPORT"
    check_template "$f" "${AGENT_REQ[@]}"
  done

  ISLA_REQ=("## Objetivo" "## Estado" "## Siguiente-paso")
  for f in "$ROOT/islas"/*.md; do
    [ -f "$f" ] || continue
    echo "- Revisando $f" >> "$REPORT"
    check_template "$f" "${ISLA_REQ[@]}"
  done

  echo "" >> "$REPORT"
  echo "## Archivos huérfanos" >> "$REPORT"
  find "$ROOT" -maxdepth 3 -type f | while read -r f; do
    case "$f" in
      *inbox*|*archive*|*.md|*.sh|*.py) ;;
      *)
        echo "- HUÉRFANO: $f" >> "$REPORT"
        ERRORS=true
        ;;
    esac
  done

  echo "" >> "$REPORT"
  if [ "$ERRORS" = true ]; then
    echo "## Resultado: FALLA" >> "$REPORT"
  else
    echo "## Resultado: OK" >> "$REPORT"
  fi

  log "Struct-auditor completado: $REPORT"
}

###############################################
# 4. AGENT-DOCS
###############################################

agent_docs() {
  REPORT_DIR="$ROOT/reports/docs"
  ensure_dir "$REPORT_DIR"
  REPORT="$REPORT_DIR/docs-$TIMESTAMP.md"

  echo "# Agent-docs — Sync documentación — $TIMESTAMP" > "$REPORT"
  echo "" >> "$REPORT"

  echo "## Fuentes clave" >> "$REPORT"
  for f in "$ROOT/docs"/*.md "$ROOT/docs/leyes"/*.md "$ROOT/docs/tareas"/*.md; do
    [ -f "$f" ] || continue
    echo "- $f" >> "$REPORT"
  done

  echo "" >> "$REPORT"
  echo "## Cambios recientes (24h)" >> "$REPORT"
  find "$ROOT/docs" -type f -mtime -1 -print >> "$REPORT"

  echo "" >> "$REPORT"
  echo "## TODO auto-generado" >> "$REPORT"
  grep -R "PENDIENTE" -n "$ROOT/docs" 2>/dev/null || echo "- No hay PENDIENTE en docs" >> "$REPORT"

  log "Agent-docs completado: $REPORT"
}

###############################################
# 5. AGENT-ISLAS
###############################################

agent_islas() {
  REPORT_DIR="$ROOT/reports/islas"
  ensure_dir "$REPORT_DIR"
  REPORT="$REPORT_DIR/islas-$TIMESTAMP.md"

  echo "# Agent-islas — Orquestador de islas — $TIMESTAMP" > "$REPORT"
  echo "" >> "$REPORT"

  echo "## Islas detectadas" >> "$REPORT"
  for f in "$ROOT/islas"/*.md; do
    [ -f "$f" ] || continue
    ESTADO=$(grep -m1 "Estado:" "$f" 2>/dev/null || echo "Estado: DESCONOCIDO")
    OBJETIVO=$(grep -m1 "Objetivo:" "$f" 2>/dev/null || echo "Objetivo: N/A")
    echo "- $(basename "$f"): $ESTADO — $OBJETIVO" >> "$REPORT"
  done

  echo "" >> "$REPORT"
  echo "## Islas bloqueadas (sin Siguiente-paso)" >> "$REPORT"
  BLOQUEADAS=false
  for f in "$ROOT/islas"/*.md; do
    [ -f "$f" ] || continue
    if ! grep -q "Siguiente-paso" "$f" 2>/dev/null; then
      echo "- BLOQUEADA: $(basename "$f")" >> "$REPORT"
      BLOQUEADAS=true
    fi
  done

  echo "" >> "$REPORT"
  if [ "$BLOQUEADAS" = true ]; then
    echo "## Resultado: FALLA parcial" >> "$REPORT"
  else
    echo "## Resultado: OK" >> "$REPORT"
  fi

  log "Agent-islas completado: $REPORT"
}

###############################################
# 6. AGENT-TAREAS
###############################################

agent_tareas() {
  REPORT_DIR="$ROOT/reports/tareas"
  ensure_dir "$REPORT_DIR"
  REPORT="$REPORT_DIR/tareas-$TIMESTAMP.md"

  echo "# Agent-tareas — Gestor de tareas — $TIMESTAMP" > "$REPORT"
  echo "" >> "$REPORT"

  echo "## Tareas PENDIENTE" >> "$REPORT"
  grep -R "PENDIENTE" -n "$ROOT/docs/tareas" 2>/dev/null || echo "- Ninguna" >> "$REPORT"

  echo "" >> "$REPORT"
  echo "## Tareas con SIGUIENTE-PASO" >> "$REPORT"
  grep -R "SIGUIENTE-PASO" -n "$ROOT/docs/tareas" 2>/dev/null || echo "- No se detectan SIGUIENTE-PASO" >> "$REPORT"

  log "Agent-tareas completado: $REPORT"
}

###############################################
# 7. AGENT-INVESTIGACION
###############################################

agent_investigacion() {
  REPORT_DIR="$ROOT/reports/investigacion"
  ensure_dir "$REPORT_DIR"
  REPORT="$REPORT_DIR/investigacion-$TIMESTAMP.md"

  echo "# Agent-investigacion — Sync investigación — $TIMESTAMP" > "$REPORT"
  echo "" >> "$REPORT"

  echo "## Enjambres / RAG / OSINT / Telegram" >> "$REPORT"
  grep -R "enjambre\|rag\|osint\|telegram" -n "$ROOT/investigacion" 2>/dev/null || echo "- No hay coincidencias" >> "$REPORT"

  echo "" >> "$REPORT"
  echo "## Índice de archivos" >> "$REPORT"
  find "$ROOT/investigacion" -maxdepth 3 -type f -print >> "$REPORT"

  echo "" >> "$REPORT"
  echo "## TODO sugerido" >> "$REPORT"
  echo "- Revisar hilos con más de 3 menciones de 'urgente'." >> "$REPORT"

  log "Agent-investigacion completado: $REPORT"
}

###############################################
# 8. AGENT-ECOSISTEMA
###############################################

agent_ecosistema() {
  REPORT_DIR="$ROOT/reports/eco"
  ensure_dir "$REPORT_DIR"
  REPORT="$REPORT_DIR/eco-$TIMESTAMP.md"

  echo "# Agent-ecosistema — Auditoría global — $TIMESTAMP" > "$REPORT"
  echo "" >> "$REPORT"

  echo "## Resumen rápido" >> "$REPORT"
  echo "- Islas: $(ls "$ROOT/islas" 2>/dev/null | wc -l)" >> "$REPORT"
  echo "- Docs: $(ls "$ROOT/docs" 2>/dev/null | wc -l)" >> "$REPORT"
  echo "- Investigación: $(ls "$ROOT/investigacion" 2>/dev/null | wc -l)" >> "$REPORT"
  echo "- Scripts: $(ls "$ROOT/scripts" 2>/dev/null | wc -l)" >> "$REPORT"

  echo "" >> "$REPORT"
  echo "## Últimos reports (24h)" >> "$REPORT"
  find "$ROOT/reports" -type f -mtime -1 -print >> "$REPORT"

  log "Agent-ecosistema completado: $REPORT"
}

###############################################
# 9. WATCHDOG
###############################################

watchdog() {
  REPORT_DIR="$ROOT/reports/watchdog"
  ensure_dir "$REPORT_DIR"
  REPORT="$REPORT_DIR/watchdog-$TIMESTAMP.md"

  echo "# WATCHDOG — Monitor de agentes — $TIMESTAMP" > "$REPORT"
  echo "" >> "$REPORT"

  check_dir() {
    local dir="$1"
    local name="$2"
    local last
    last=$(ls -t "$dir" 2>/dev/null | head -n1 || echo "")
    if [ -z "$last" ]; then
      echo "- ERROR: $name sin reportes." >> "$REPORT"
    else
      echo "- OK: $name → $last" >> "$REPORT"
    fi
  }

  check_dir "$ROOT/reports/docs" "agent-docs"
  check_dir "$ROOT/reports/islas" "agent-islas"
  check_dir "$ROOT/reports/tareas" "agent-tareas"
  check_dir "$ROOT/reports/investigacion" "agent-investigacion"
  check_dir "$ROOT/reports/eco" "agent-ecosistema"
  check_dir "$ROOT/reports/struct" "struct-auditor"

  log "Watchdog completado: $REPORT"
}

###############################################
# 10. AGENTE META DEEP
###############################################

agent_meta_deep() {
  REPORT_DIR="$ROOT/reports/meta-deep"
  ensure_dir "$REPORT_DIR"
  REPORT="$REPORT_DIR/meta-deep-$TIMESTAMP.md"

  echo "# Agente META DEEP — Investigación profunda — $TIMESTAMP" > "$REPORT"
  echo "" >> "$REPORT"

  echo "## Scripts" >> "$REPORT"
  ls "$ROOT/scripts" >> "$REPORT" 2>/dev/null

  echo "" >> "$REPORT"
  echo "## Workflows" >> "$REPORT"
  ls "$ROOT/.github/workflows" >> "$REPORT" 2>/dev/null

  echo "" >> "$REPORT"
  echo "## Reports" >> "$REPORT"
  find "$ROOT/reports" -maxdepth 3 -type f >> "$REPORT" 2>/dev/null

  log "Agente META DEEP completado: $REPORT"
}

###############################################
# 11. ORQUESTADOR TOTAL
###############################################

orquestador_total() {
  REPORT_DIR="$ROOT/reports/orquestador-total"
  ensure_dir "$REPORT_DIR"
  MASTER="$REPORT_DIR/total-$TIMESTAMP.md"

  echo "# ORQUESTADOR TOTAL — $TIMESTAMP" > "$MASTER"
  echo "" >> "$MASTER"

  clasificador_maestro >> "$MASTER" 2>&1
  gestor_estados_inbox >> "$MASTER" 2>&1
  struct_auditor >> "$MASTER" 2>&1
  agent_docs >> "$MASTER" 2>&1
  agent_islas >> "$MASTER" 2>&1
  agent_tareas >> "$MASTER" 2>&1
  agent_investigacion >> "$MASTER" 2>&1
  agent_ecosistema >> "$MASTER" 2>&1
  watchdog >> "$MASTER" 2>&1
  agent_meta_deep >> "$MASTER" 2>&1

  log "ORQUESTADOR TOTAL COMPLETADO: $MASTER"
}

###############################################
# 12. DISPATCHER
###############################################

usage() {
  cat <<EOF
Uso: $0 <comando>

Comandos:
  clasificador
  estados-inbox
  struct
  docs
  islas
  tareas
  investigacion
  ecosistema
  watchdog
  meta-deep
  orquestador-total
EOF
}

main() {
  cmd="${1:-}"

  case "$cmd" in
    clasificador)        clasificador_maestro ;;
    estados-inbox)       gestor_estados_inbox ;;
    struct)              struct_auditor ;;
    docs)                agent_docs ;;
    islas)               agent_islas ;;
    tareas)              agent_tareas ;;
    investigacion)       agent_investigacion ;;
    ecosistema)          agent_ecosistema ;;
    watchdog)            watchdog ;;
    meta-deep)           agent_meta_deep ;;
    orquestador-total)   orquestador_total ;;
    *)                   usage; exit 1 ;;
  esac
}

main "$@"
