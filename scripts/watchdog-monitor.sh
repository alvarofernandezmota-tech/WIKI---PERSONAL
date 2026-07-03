#!/usr/bin/env bash
# FUNCIÓN:   Watchdog — vigila que todos los agentes hayan generado reportes
# TRIGGER:   Cron cada 6h, post-orquestador
# AGENTE:    watchdog-monitor
# ETIQUETAS: automatizacion, urgente, agentes
# RUTAS:     reports/watchdog/, reports/orquestador/
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-/srv/yggdrasil-dew}"
REPORT_DIR="$ROOT/reports/watchdog"
TIMESTAMP=$(date +"%Y%m%d-%H%M")
REPORT="$REPORT_DIR/watchdog-$TIMESTAMP.md"

mkdir -p "$REPORT_DIR"

log() { echo "[$(date +"%H:%M:%S")] $*"; }

echo "# WATCHDOG — $TIMESTAMP" > "$REPORT"
echo "" >> "$REPORT"

# 1. Verificar que el orquestador se ejecutó
ORQ_REPORT=$(ls -t "$ROOT/reports/orquestador" 2>/dev/null | head -n1 || echo "")
if [ -z "$ORQ_REPORT" ]; then
  echo "- ❌ Orquestador no ha generado ningún reporte" >> "$REPORT"
  log "Orquestador ausente → ISSUE"
  command -v gh &>/dev/null && gh issue create \
    --title "[WATCHDOG] Orquestador no ejecutado" \
    --label "urgente,orquestador,automatizacion" \
    --body "Watchdog detectó ausencia de reportes del orquestador en $TIMESTAMP." 2>/dev/null || true
else
  echo "- ✅ Orquestador: último reporte → $ORQ_REPORT" >> "$REPORT"
fi

# 2. Verificar que cada agente generó reportes
check_agent() {
  local dir="$ROOT/reports/$1"
  local name="$2"
  local last
  last=$(ls -t "$dir" 2>/dev/null | head -n1 || echo "")
  if [ -z "$last" ]; then
    echo "- ❌ $name — sin reportes en $dir" >> "$REPORT"
    log "$name sin reportes → ISSUE"
    command -v gh &>/dev/null && gh issue create \
      --title "[WATCHDOG] $name sin reportes" \
      --label "urgente,agentes" \
      --body "Watchdog detectó ausencia de reportes del agente \`$name\` en \`$dir\` — $TIMESTAMP." 2>/dev/null || true
  else
    echo "- ✅ $name → $last" >> "$REPORT"
  fi
}

check_agent "docs"         "agent-docs"
check_agent "islas"        "agent-islas"
check_agent "tareas"       "agent-tareas"
check_agent "investigacion" "agent-investigacion"
check_agent "eco"          "agent-ecosistema"
check_agent "struct"       "struct-auditor"

# 3. Detectar bloqueos en todos los reportes
echo "" >> "$REPORT"
echo "## Bloqueos" >> "$REPORT"
BLOCKS=$(grep -R "BLOQUEADA" "$ROOT/reports" 2>/dev/null || echo "")
if [ -n "$BLOCKS" ]; then
  echo "$BLOCKS" >> "$REPORT"
  log "Bloqueos detectados → ISSUE"
  command -v gh &>/dev/null && gh issue create \
    --title "[WATCHDOG] Bloqueos detectados en reportes" \
    --label "urgente,automatizacion" \
    --body "Watchdog detectó bloqueos:\n\n$BLOCKS\n\nTimestamp: $TIMESTAMP" 2>/dev/null || true
else
  echo "- Sin bloqueos detectados" >> "$REPORT"
fi

# 4. Verificar MCP socket
if [ ! -S "/tmp/mcp.sock" ]; then
  echo "" >> "$REPORT"
  echo "## MCP Socket" >> "$REPORT"
  echo "- ❌ /tmp/mcp.sock no encontrado — MCP no operativo" >> "$REPORT"
  command -v gh &>/dev/null && gh issue list --label "mcp" --search "MCP socket caído" --state open --json number --jq length | grep -q "^0$" && \
  gh issue create \
    --title "[WATCHDOG] MCP socket /tmp/mcp.sock caído" \
    --label "urgente,agentes,mcp" \
    --body "El socket MCP no está activo. Los agentes no tienen autonomía en GitHub API.\nTimestamp: $TIMESTAMP\n\nAcción: verificar \`docker compose up mcp-server\` en Madre." 2>/dev/null || true
fi

echo "" >> "$REPORT"
echo "## Resultado" >> "$REPORT"
echo "- Watchdog completado: $(date)" >> "$REPORT"

log "Watchdog completado: $REPORT"
