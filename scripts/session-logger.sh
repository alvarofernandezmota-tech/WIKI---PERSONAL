#!/usr/bin/env bash
# =============================================================================
# session-logger.sh — Captura todo lo que ocurre en la terminal durante una
#                     sesión de trabajo y guarda un log estructurado en
#                     inbox/sesiones/log-YYYYMMDDTHHMMSS.md
#
# USO:
#   source scripts/session-logger.sh          # iniciar logging
#   bash scripts/session-logger.sh --close    # cerrar y guardar log
# =============================================================================
set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo "$HOME/yggdrasil-dew")"
SESIONES_DIR="$REPO_ROOT/inbox/sesiones"
mkdir -p "$SESIONES_DIR"

TIMESTAMP="$(date +%Y%m%dT%H%M%S)"
LOG_FILE="$SESIONES_DIR/log-${TIMESTAMP}.md"
SCRIPT_LOG="/tmp/yggdrasil-session-${TIMESTAMP}.log"

_session_header() {
  cat > "$LOG_FILE" <<EOF
# Log de sesión — ${TIMESTAMP}

| Campo     | Valor                          |
|-----------|--------------------------------|
| Fecha     | $(date '+%Y-%m-%d %H:%M:%S')   |
| Usuario   | $(whoami)                      |
| Host      | $(hostname)                    |
| Branch    | $(git -C "$REPO_ROOT" branch --show-current 2>/dev/null || echo 'N/A') |
| Directorio| $(pwd)                         |

## Comandos ejecutados

\`\`\`bash
EOF
  echo "[session-logger] Log iniciado: $LOG_FILE"
}

_session_close() {
  local log_file
  log_file="$(ls -t "$SESIONES_DIR"/log-*.md 2>/dev/null | head -1)"
  if [[ -z "$log_file" ]]; then
    echo "[session-logger] ERROR: no se encontró log activo."
    exit 1
  fi

  # Cerrar bloque de código
  echo '```' >> "$log_file"
  echo "" >> "$log_file"
  echo "## Cierre" >> "$log_file"
  echo "" >> "$log_file"
  echo "- Hora de cierre: $(date '+%Y-%m-%d %H:%M:%S')" >> "$log_file"
  echo "- Branch final: $(git -C "$REPO_ROOT" branch --show-current 2>/dev/null || echo 'N/A')" >> "$log_file"
  echo "- Archivos modificados:" >> "$log_file"
  git -C "$REPO_ROOT" status --short 2>/dev/null | sed 's/^/  - /' >> "$log_file" || true

  echo "[session-logger] Log cerrado: $log_file"
}

# ---- Main ----
if [[ "${1:-}" == "--close" ]]; then
  _session_close
else
  _session_header
  # Activar logging de comandos en la shell actual (solo si se usa source)
  if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
    export PROMPT_COMMAND="history 1 | sed 's/^[ ]*[0-9]*[ ]*//' >> \"$LOG_FILE\""
    echo "[session-logger] PROMPT_COMMAND activado. Todo lo que escribas se registrará."
  else
    echo "[session-logger] AVISO: usa 'source scripts/session-logger.sh' para capturar comandos en tiempo real."
  fi
fi
