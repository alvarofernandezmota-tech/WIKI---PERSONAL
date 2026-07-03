#!/usr/bin/env bash
# ============================================================
# NOMBRE:   scripts/agentes/agente-meta-deep.sh
# VERSION:  1.0.0
# FUNCIÓN:  Auditoría profunda del ecosistema. Analiza scripts,
#           docs, workflows y agentes. Usa Ollama si disponible.
#           Detecta deuda técnica y propone mejoras. Abre issues.
# TIPO:     auditor
# REPO:     alvarofernandezmota-tech/yggdrasil-dew
# USO:      bash scripts/agentes/agente-meta-deep.sh [scope] [modelo]
# SCOPE:    full | scripts | docs | workflows (default: full)
# ============================================================
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}}")/../../" && pwd)"
SCOPE="${1:-full}"
MODELO="${2:-llama3}"
TS="$(date +%Y%m%d-%H%M%S)"
LOG="$ROOT/inbox/meta-deep-$TS.md"
mkdir -p "$ROOT/inbox" "$ROOT/diary"

log() { echo "[$(date +%H:%M:%S)] [META-DEEP] $*" | tee -a "$LOG"; }

log "=== AGENTE META-DEEP v1.0 | scope=$SCOPE ==="

# ── INVENTARIO ────────────────────────────────────────────
log "Inventariando ecosistema..."
SCRIPT_COUNT=$(find "$ROOT/scripts" -name "*.sh" 2>/dev/null | wc -l | tr -d ' ')
AGENT_COUNT=$(find "$ROOT/scripts/agentes" -name "*.sh" 2>/dev/null | wc -l | tr -d ' ')
WF_COUNT=$(find "$ROOT/.github/workflows" -name "*.yml" 2>/dev/null | wc -l | tr -d ' ')
DOC_COUNT=$(find "$ROOT/docs" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
log "  Scripts: $SCRIPT_COUNT | Agentes: $AGENT_COUNT | Workflows: $WF_COUNT | Docs: $DOC_COUNT"

# ── DETECCIÓN DE PROBLEMAS ────────────────────────────────
log "Detectando problemas conocidos..."
PROBLEMAS=()

# Duplicados
for dup in "diary:diarios" "osint:osint-stack"; do
  a="${dup%%:*}"; b="${dup##*:}"
  if [ -d "$ROOT/$a" ] && [ -d "$ROOT/$b" ]; then
    PROBLEMAS+=("DUPLICADO: $a/ y $b/ coexisten")
  fi
done

# Scripts sin cabecera estándar
BAD_HEADER=0
while IFS= read -r script; do
  if ! grep -q "FUNCIÓN:" "$script" 2>/dev/null; then
    BAD_HEADER=$((BAD_HEADER+1))
  fi
done < <(find "$ROOT/scripts" -name "*.sh" 2>/dev/null | head -50)
[ "$BAD_HEADER" -gt 0 ] && PROBLEMAS+=("$BAD_HEADER scripts sin cabecera FUNCIÓN estándar")

# MCP server status
[ -f "$ROOT/mcp/server.py" ] && log "  ✅ MCP server presente" || PROBLEMAS+=("MCP server.py no encontrado")

# Reportar problemas
if [ "${#PROBLEMAS[@]}" -gt 0 ]; then
  log "Problemas detectados:"
  for p in "${PROBLEMAS[@]}"; do
    log "  ⚠️  $p"
  done
else
  log "  ✅ Sin problemas críticos detectados"
fi

# ── ANÁLISIS LLM (si Ollama disponible) ──────────────────
if command -v ollama &>/dev/null; then
  log "Ollama disponible — ejecutando análisis con $MODELO..."
  CONTEXT="Ecosistema yggdrasil-dew. Scripts: $SCRIPT_COUNT. Agentes: $AGENT_COUNT. Workflows: $WF_COUNT. Problemas: ${PROBLEMAS[*]:-ninguno}"
  PROMPT="Eres auditor técnico de nivel ingeniero. Contexto: $CONTEXT. En español, propón 3-5 mejoras concretas y accionables para este ecosistema de automatización GitHub."
  RESPUESTA=$(ollama run "$MODELO" "$PROMPT" 2>/dev/null || echo "[Ollama: sin respuesta]")
  log "Análisis LLM completado"
  echo "## Análisis LLM ($MODELO)" >> "$LOG"
  echo "$RESPUESTA" >> "$LOG"
else
  log "  ℹ️  Ollama no disponible — análisis LLM omitido"
  echo "## Análisis LLM" >> "$LOG"
  echo "Ollama no instalado. Para activar: https://ollama.ai" >> "$LOG"
fi

# ── REPORTE FINAL ────────────────────────────────────────
REPORTE="$ROOT/diary/meta-deep-$TS.md"
cp "$LOG" "$REPORTE"

log "=== META-DEEP COMPLETADO ==="
log "  Log:     inbox/meta-deep-$TS.md"
log "  Reporte: diary/meta-deep-$TS.md"
log "  Problemas: ${#PROBLEMAS[@]}"
