#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# FUNCIÓN: Galatea scan — auditoría de la capa de diseño
# Detecta islas y bots Galatea, genera reporte y TODO
# Integrado en orquestador-total como módulo 13
# ============================================================

ROOT="/srv/yggdrasil-dew"
TIMESTAMP=$(date +"%Y%m%d-%H%M")

log() { echo "[$(date +"%H:%M:%S")] $*"; }
ensure_dir() { mkdir -p "$1"; }

REPORT_DIR="$ROOT/reports/galatea"
ensure_dir "$REPORT_DIR"
REPORT="$REPORT_DIR/galatea-$TIMESTAMP.md"

echo "# Galatea — Escaneo de diseño de agentes y bots — $TIMESTAMP" > "$REPORT"
echo "" >> "$REPORT"

echo "## Islas Galatea" >> "$REPORT"
find "$ROOT/islas" -maxdepth 1 -type f -name "ISLA-*" -print >> "$REPORT" 2>/dev/null || echo "- Sin islas ISLA-* todavía" >> "$REPORT"

echo "" >> "$REPORT"
echo "## Bots Galatea" >> "$REPORT"
find "$ROOT/agentes/bots" -maxdepth 1 -type f -print >> "$REPORT" 2>/dev/null || echo "- Sin bots todavía" >> "$REPORT"

echo "" >> "$REPORT"
echo "## Agentes registrados en REGISTRO-HERRAMIENTAS" >> "$REPORT"
if [ -f "$ROOT/docs/REGISTRO-HERRAMIENTAS.md" ]; then
  cat "$ROOT/docs/REGISTRO-HERRAMIENTAS.md" >> "$REPORT"
else
  echo "- REGISTRO-HERRAMIENTAS.md no encontrado" >> "$REPORT"
fi

echo "" >> "$REPORT"
echo "## TODO Galatea" >> "$REPORT"
echo "- Usar agent-meta-deep para detectar huecos." >> "$REPORT"
echo "- Generar nuevos agentes con galatea-fabrica-agentes.sh." >> "$REPORT"
echo "- Revisar islas EN-DISEÑO y avanzar a ACTIVA." >> "$REPORT"

log "Galatea scan completado: $REPORT"
