#!/usr/bin/env bash
# FUNCIÓN:   Actividad autónoma nocturna entre sesiones del humano
# TRIGGER:   Cron 00:00-08:00 UTC cada 2h
# AGENTE:    between-sessions
# ETIQUETAS: automatizacion, agentes
# RUTAS:     diarios/, inbox/, reports/
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-/srv/yggdrasil-dew}"
DATE=$(date +%Y-%m-%d)
TIMESTAMP=$(date +"%Y%m%d-%H%M")
BRIEF="$ROOT/diarios/brief-$DATE.md"

mkdir -p "$ROOT/diarios"

echo "# Brief nocturno — $TIMESTAMP" > "$BRIEF"
echo "" >> "$BRIEF"

# 1. Clasificar inbox
if [ -f "$ROOT/scripts/clasificador-maestro.sh" ]; then
  echo "## Clasificación inbox" >> "$BRIEF"
  bash "$ROOT/scripts/clasificador-maestro.sh" >> "$BRIEF" 2>&1 || echo "- ⚠️ Clasificador falló" >> "$BRIEF"
fi

# 2. Health check servicios
echo "" >> "$BRIEF"
echo "## Estado servicios" >> "$BRIEF"
for port in 11434 5678 6333 8000; do
  if curl -sf --max-time 3 "http://localhost:$port" > /dev/null 2>&1; then
    echo "- ✅ :$port operativo" >> "$BRIEF"
  else
    echo "- ❌ :$port no responde" >> "$BRIEF"
  fi
done

# 3. MCP socket
echo "" >> "$BRIEF"
echo "## MCP Socket" >> "$BRIEF"
if [ -S "/tmp/mcp.sock" ]; then
  echo "- ✅ /tmp/mcp.sock activo" >> "$BRIEF"
else
  echo "- ❌ /tmp/mcp.sock no encontrado" >> "$BRIEF"
fi

# 4. Resumen de actividad nocturna (commits recientes)
echo "" >> "$BRIEF"
echo "## Actividad reciente" >> "$BRIEF"
cd "$ROOT" && git log --since='8 hours ago' --oneline 2>/dev/null >> "$BRIEF" || echo "- Sin commits recientes" >> "$BRIEF"

# 5. Issues urgentes abiertos
echo "" >> "$BRIEF"
echo "## Issues urgentes" >> "$BRIEF"
command -v gh &>/dev/null && gh issue list --label "urgente" --state open --limit 5 >> "$BRIEF" 2>/dev/null || echo "- gh CLI no disponible" >> "$BRIEF"

echo "[between-sessions] Brief generado: $BRIEF"
