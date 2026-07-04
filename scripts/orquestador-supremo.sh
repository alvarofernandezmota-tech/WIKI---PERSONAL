#!/usr/bin/env bash
# FUNCIÓN:   Orquestador supremo — coordina todos los agentes en orden
# TRIGGER:   Cron diario, manual, llamada desde MCP
# AGENTE:    orquestador-supremo
# ETIQUETAS: automatizacion, orquestador
# RUTAS:     reports/orquestador/, scripts/
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-/srv/yggdrasil-dew}"
REPORT_DIR="$ROOT/reports/orquestador"
TIMESTAMP=$(date +"%Y%m%d-%H%M")
REPORT="$REPORT_DIR/orquestador-$TIMESTAMP.md"

mkdir -p "$REPORT_DIR"

log() { echo "[$(date +"%H:%M:%S")] $*"; }
ok()  { echo "- ✅ $*" >> "$REPORT"; log "OK: $*"; }
fail(){ echo "- ❌ $*" >> "$REPORT"; log "FAIL: $*"; }

echo "# ORQUESTADOR SUPREMO — $TIMESTAMP" > "$REPORT"
echo "" >> "$REPORT"

run_agent() {
  local script="$1"
  local name="$2"
  if [ -f "$ROOT/scripts/$script" ]; then
    if bash "$ROOT/scripts/$script" >> "$REPORT" 2>&1; then
      ok "$name completado"
    else
      fail "$name falló"
      command -v gh &>/dev/null && gh issue create \
        --title "[ORQUESTADOR] $name falló" \
        --label "automatizacion,urgente" \
        --body "El agente \`$name\` falló durante la ejecución del orquestador el $TIMESTAMP." 2>/dev/null || true
    fi
  else
    fail "$name — script no encontrado: scripts/$script"
  fi
}

log "Iniciando orquestador supremo"

run_agent "clasificador-maestro.sh"       "clasificador-maestro"
run_agent "gestor-estados-inbox.sh"       "gestor-estados-inbox"
run_agent "struct-auditor.sh"             "struct-auditor"
run_agent "ghost-file-detector.sh"        "ghost-file-detector"
run_agent "agent-docs-sync.sh"            "agent-docs"
run_agent "agent-islas-orquestador.sh"    "agent-islas"
run_agent "agent-tareas-manager.sh"       "agent-tareas"
run_agent "agent-investigacion-sync.sh"   "agent-investigacion"
run_agent "agent-ecosistema-audit.sh"     "agent-ecosistema"
run_agent "cross-ref-checker.sh"          "cross-ref-checker"
run_agent "isla-sync-validator.sh"        "isla-sync-validator"
run_agent "tool-inventory-auditor.sh"     "tool-inventory-auditor"

echo "" >> "$REPORT"
echo "## Resultado" >> "$REPORT"
echo "- Orquestador completado: $(date)" >> "$REPORT"

log "Orquestador completado: $REPORT"
