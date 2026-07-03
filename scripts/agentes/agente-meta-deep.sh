#!/usr/bin/env bash
# scripts/agentes/agente-meta-deep.sh
# Auditor LLM: analiza el repo y genera propuestas en formato PR/diff (dry-run por defecto)
# Uso: bash scripts/agentes/agente-meta-deep.sh [--apply]
set -euo pipefail

ROOT="${YGGDRASIL_ROOT:-$(cd "$(dirname "$0")/../.." && pwd)}"
MODE="dry-run"
[ "${1:-}" = "--apply" ] && MODE="apply"
TS=$(date +"%Y%m%d-%H%M%S")
OUT="$ROOT/reports/agente-meta-deep"
mkdir -p "$OUT"
REPORT="$OUT/meta-deep-$TS.md"

echo "# Agente Meta-Deep — $TS" > "$REPORT"
echo "Modo: $MODE" >> "$REPORT"
echo "" >> "$REPORT"

# ── Recopilar contexto ───────────────────────────────────────────────────────
CONTEXT=""
for f in README.md ECOSISTEMA.md MASTER-PENDIENTES.md ESTADO-SISTEMA.md; do
  fp="$ROOT/$f"
  if [ -f "$fp" ]; then
    CONTEXT+="\n\n### $f\n"
    CONTEXT+=$(head -60 "$fp")
  fi
done

# Listar agentes y su estado
CONTEXT+="\n\n### Agentes detectados\n"
for d in "$ROOT/agentes"/*/; do
  name=$(basename "$d")
  has_test="NO"
  [ -f "$d/test.sh" ] && has_test="SÍ"
  has_diseno="NO"
  [ -f "$d/DISEÑO.md" ] || [ -f "$d/DISENO.md" ] && has_diseno="SÍ"
  CONTEXT+="- $name | test.sh: $has_test | DISEÑO: $has_diseno\n"
done

# Últimos 10 commits
CONTEXT+="\n\n### Últimos commits\n"
CONTEXT+=$(cd "$ROOT" && git log --oneline -10 2>/dev/null || echo "(no git)")

PROMPT="Eres un auditor técnico senior del ecosistema Yggdrasil-Dew. "
PROMPT+="Analiza el siguiente contexto y devuelve EXACTAMENTE 3 propuestas de mejora "
PROMPT+="en formato: PROPUESTA N: <título> | DESCRIPCIÓN: <qué hacer> | IMPACTO: alto|medio|bajo. "
PROMPT+="Contexto:\n$CONTEXT"

echo "## Prompt enviado al LLM" >> "$REPORT"
echo '```' >> "$REPORT"
echo "${PROMPT:0:500}..." >> "$REPORT"
echo '```' >> "$REPORT"
echo "" >> "$REPORT"

# ── Llamar al router LLM ─────────────────────────────────────────────────────
ROUTER="$ROOT/scripts/agentes/llm-router.sh"
if [ -f "$ROUTER" ]; then
  echo "## Respuesta LLM" >> "$REPORT"
  bash "$ROUTER" "$PROMPT" auto >> "$REPORT" 2>&1 || echo "(LLM no disponible)" >> "$REPORT"
else
  echo "## LLM router no encontrado — propuestas manuales" >> "$REPORT"
  echo "- PROPUESTA 1: Añadir PROFILE.md a todos los agentes" >> "$REPORT"
  echo "- PROPUESTA 2: Centralizar logs en logs/agentes/" >> "$REPORT"
  echo "- PROPUESTA 3: Añadir metric tracking por agente" >> "$REPORT"
fi

echo "" >> "$REPORT"
echo "## Modo: $MODE" >> "$REPORT"
if [ "$MODE" = "apply" ]; then
  echo "TODO: implementar apply automático vía Galatea" >> "$REPORT"
else
  echo "Dry-run: no se aplicó ningún cambio. Revisar reporte y ejecutar con --apply si procede." >> "$REPORT"
fi

echo "$REPORT"
