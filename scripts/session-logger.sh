#!/usr/bin/env bash
# session-logger.sh
# Doc: docs/  <- COMPLETAR ruta al doc relacionado
# Fase: <- COMPLETAR fase
# Descripción: <- COMPLETAR
# ============================================================
# ARCHIVO      : session-logger.sh
# VERSIÓN      : 1.0.0
# FUNCIÓN ÚNICA: Capturar todo lo que ocurre en terminal
#                durante una sesión y guardarlo en inbox/
#                para que quede trazado y vaya a diarios/
# AUTOR        : alvarofernandezmota-tech
# USO          : source scripts/session-logger.sh
#                (añadir al final de .bashrc o ejecutar al
#                 inicio de cada sesión de trabajo)
# SALIDA       : inbox/sesiones/log-YYYYMMDD-HHMMSS.md
# ============================================================

set -euo pipefail

REPO_ROOT="$(git -C "$(dirname "${BASH_SOURCE[0]}")" rev-parse --show-toplevel 2>/dev/null || echo "$HOME/yggdrasil-dew")"
DATE_NOW=$(date "+%Y-%m-%d")
TIME_NOW=$(date "+%H:%M:%S")
STAMP=$(date "+%Y%m%dT%H%M%S")
LOG_DIR="$REPO_ROOT/inbox/sesiones"
LOG_FILE="$LOG_DIR/log-${STAMP}.md"

mkdir -p "$LOG_DIR"

# Cabecera del log
cat > "$LOG_FILE" << EOF
# Log de sesión — ${DATE_NOW} ${TIME_NOW}

| Campo | Valor |
|---|---|
| Fecha | ${DATE_NOW} |
| Hora inicio | ${TIME_NOW} |
| Usuario | $(whoami) |
| Host | $(hostname) |
| Directorio | $(pwd) |
| Branch | $(git -C "$REPO_ROOT" branch --show-current 2>/dev/null || echo 'N/A') |

## Comandos ejecutados

\`\`\`
EOF

echo "[session-logger] Log iniciado: $LOG_FILE"
echo "[session-logger] Todo lo que ejecutes quedará en inbox/sesiones/"
echo "[session-logger] Al terminar: bash scripts/session-logger.sh --close"

# Modo cierre
if [[ "${1:-}" == "--close" ]]; then
  TIME_CLOSE=$(date "+%H:%M:%S")
  echo '```' >> "$LOG_FILE"
  cat >> "$LOG_FILE" << EOF

## Cierre de sesión

| Campo | Valor |
|---|---|
| Hora cierre | ${TIME_CLOSE} |
| Último commit | $(git -C "$REPO_ROOT" log --oneline -1 2>/dev/null || echo 'N/A') |
| Estado repo | $(git -C "$REPO_ROOT" status --short | wc -l) archivos pendientes |

> Log cerrado automáticamente por session-logger.sh
EOF
  echo "[session-logger] Sesión cerrada. Log: $LOG_FILE"
  echo "[session-logger] Haz git add + commit para que session-close.yml lo recoja."
fi