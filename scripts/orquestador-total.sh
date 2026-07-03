#!/usr/bin/env bash
# ============================================================
# NOMBRE:   scripts/orquestador-total.sh
# VERSION:  2.0.0
# FUNCIÓN:  Orquestador total del ecosistema yggdrasil-dew.
#           Coordina todos los agentes, valida CORE, audita
#           estructura, sincroniza islas y genera reporte.
# AUTOR:    yggdrasil-dew ecosystem
# REPO:     alvarofernandezmota-tech/yggdrasil-dew
# USO:      bash scripts/orquestador-total.sh [completo|rapido|solo-auditoria]
# ============================================================
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}}")/.." && pwd)"
MODO="${1:-completo}"
TS="$(date +%Y-%m-%d-%H%M%S)"
LOG="$ROOT/inbox/orquestador-total-$TS.log"
mkdir -p "$ROOT/inbox" "$ROOT/diary"

log() { echo "[$(date +%H:%M:%S)] [ORQUESTADOR] $*" | tee -a "$LOG"; }

log "=== ORQUESTADOR TOTAL v2.0 | modo=$MODO ==="

# ── 1. HEALTH CHECK ──────────────────────────────────────
log "[1/7] Health check del ecosistema..."
if python3 "$ROOT/mcp/server.py" --stdio <<< '{"method":"tools/call","params":{"name":"health_check","arguments":{}}}' 2>/dev/null; then
  log "  → MCP server operativo"
else
  log "  → MCP server: verificando manualmente"
  [ -d "$ROOT/scripts" ] && log "  ✅ scripts/" || log "  ❌ scripts/ FALTA"
  [ -d "$ROOT/inbox" ]   && log "  ✅ inbox/"   || log "  ❌ inbox/ FALTA"
  [ -d "$ROOT/diary" ]   && log "  ✅ diary/"   || log "  ❌ diary/ FALTA"
  [ -f "$ROOT/docs/CORE-ECOSISTEMA.md" ] && log "  ✅ CORE-ECOSISTEMA.md" || log "  ❌ CORE-ECOSISTEMA.md FALTA"
fi

[ "$MODO" = "rapido" ] && { log "Modo rápido: solo health check"; exit 0; }

# ── 2. STRUCT AUDITOR ────────────────────────────────────
log "[2/7] Auditoría de estructura..."
if [ -f "$ROOT/scripts/struct-auditor.sh" ]; then
  bash "$ROOT/scripts/struct-auditor.sh" 2>&1 | tee -a "$LOG" || log "  ⚠️  struct-auditor con advertencias"
else
  log "  ⚠️  struct-auditor.sh no encontrado"
  # Auditoría básica inline
  for dup in "diary:diarios" "osint:osint-stack" "agentes:agents"; do
    a="${dup%%:*}"; b="${dup##*:}"
    if [ -d "$ROOT/$a" ] && [ -d "$ROOT/$b" ]; then
      log "  ⚠️  DUPLICADO: $a/ y $b/ — consolidar en $a/"
    fi
  done
fi

[ "$MODO" = "solo-auditoria" ] && { log "Modo solo-auditoria completado"; exit 0; }

# ── 3. GHOST FILE DETECTOR ───────────────────────────────
log "[3/7] Detectando archivos fantasma..."
if [ -f "$ROOT/scripts/ghost-file-detector.sh" ]; then
  bash "$ROOT/scripts/ghost-file-detector.sh" 2>&1 | tee -a "$LOG" || true
else
  log "  → Búsqueda básica de vacíos..."
  find "$ROOT" -name "*.sh" -empty -not -path "*/.git/*" | while read -r f; do
    log "  ⚠️  Script vacío: ${f#$ROOT/}"
  done
fi

# ── 4. ISLA SYNC VALIDATOR ───────────────────────────────
log "[4/7] Validando sincronía de islas..."
if [ -f "$ROOT/scripts/isla-sync-validator.sh" ]; then
  bash "$ROOT/scripts/isla-sync-validator.sh" 2>&1 | tee -a "$LOG" || true
else
  log "  → Verificando islas conocidas..."
  for isla in isla-proyectos isla-hardware isla-formacion isla-osint; do
    [ -d "$ROOT/$isla" ] && log "  ✅ $isla/" || log "  ⚠️  $isla/ no existe aún"
  done
fi

# ── 5. TOOL INVENTORY AUDITOR ────────────────────────────
log "[5/7] Auditando inventario de tools..."
SCRIPT_COUNT=$(find "$ROOT/scripts" -name "*.sh" 2>/dev/null | wc -l | tr -d ' ')
AGENT_COUNT=$(find "$ROOT/scripts/agentes" -name "*.sh" 2>/dev/null | wc -l | tr -d ' ')
WF_COUNT=$(find "$ROOT/.github/workflows" -name "*.yml" 2>/dev/null | wc -l | tr -d ' ')
log "  Scripts: $SCRIPT_COUNT | Agentes: $AGENT_COUNT | Workflows: $WF_COUNT"

# ── 6. CROSS-REF CHECK ───────────────────────────────────
log "[6/7] Verificando referencias cruzadas en docs..."
if [ -f "$ROOT/scripts/cross-ref-checker.sh" ]; then
  bash "$ROOT/scripts/cross-ref-checker.sh" 2>&1 | tee -a "$LOG" || true
else
  log "  → cross-ref-checker.sh pendiente de implementar"
fi

# ── 7. REPORTE FINAL ─────────────────────────────────────
log "[7/7] Generando reporte de sesión..."
REPORTE="$ROOT/diary/orquestador-$TS.md"
cat > "$REPORTE" << REPORT
# Reporte Orquestador Total
**Fecha:** $(date '+%Y-%m-%d %H:%M:%S')
**Modo:** $MODO

## Resumen
- Scripts: $SCRIPT_COUNT
- Agentes: $AGENT_COUNT  
- Workflows: $WF_COUNT

## Log completo
Ver: inbox/orquestador-total-$TS.log

## Estado
✅ Orquestación completada
REPORT

log "=== ORQUESTADOR COMPLETADO ==="
log "  Log:     inbox/orquestador-total-$TS.log"
log "  Reporte: diary/orquestador-$TS.md"
