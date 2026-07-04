#!/usr/bin/env bash
# scripts/agentes/agente-meta-deep.sh
# Auditor meta: lee reports/, genera resumen y extrae PERCENT_COMPLETE
# Si cobertura < 70% crea issue en GitHub automáticamente
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
TS="$(date +%Y%m%d-%H%M%S)"
OUT="$ROOT/reports/meta-deep/meta-deep-$TS.md"
mkdir -p "$ROOT/reports/meta-deep"

log(){ echo "[$(date +%Y-%m-%dT%H:%M:%S)] $*"; }

echo "# Meta-Deep Audit — $TS" > "$OUT"
echo "" >> "$OUT"

# Contar reportes existentes
AUDIT_COUNT=$(ls "$ROOT/reports/audit"/*.md 2>/dev/null | wc -l | tr -d ' ')
SMOKE_COUNT=$(ls "$ROOT/reports/verify"/*.md 2>/dev/null | wc -l | tr -d ' ')
echo "## Reportes encontrados" >> "$OUT"
echo "- audit/: $AUDIT_COUNT" >> "$OUT"
echo "- verify/: $SMOKE_COUNT" >> "$OUT"

# Contar MISSING en el último audit
LAST_AUDIT=$(ls "$ROOT/reports/audit"/*.md 2>/dev/null | tail -n1 || echo "")
MISSING_COUNT=0
OK_COUNT=0
if [ -n "$LAST_AUDIT" ]; then
  MISSING_COUNT=$(grep -c '\[MISSING\]' "$LAST_AUDIT" || true)
  OK_COUNT=$(grep -c '\[OK\]' "$LAST_AUDIT" || true)
fi
TOTAL=$((MISSING_COUNT + OK_COUNT))
if [ "$TOTAL" -gt 0 ]; then
  PCT=$(( (OK_COUNT * 100) / TOTAL ))
else
  PCT=0
fi

echo "" >> "$OUT"
echo "## Cobertura" >> "$OUT"
echo "- OK: $OK_COUNT" >> "$OUT"
echo "- MISSING: $MISSING_COUNT" >> "$OUT"
echo "- PERCENT_COMPLETE: ${PCT}%" >> "$OUT"

log "Cobertura calculada: ${PCT}% (OK=$OK_COUNT MISSING=$MISSING_COUNT)"

# Crear issue si cobertura < 70%
if [ "$PCT" -lt 70 ] && command -v gh &>/dev/null; then
  log "WARN: cobertura ${PCT}% < 70%, creando issue"
  gh issue create \
    --title "[meta-deep] Cobertura baja: ${PCT}%" \
    --body "Auto-detectado PERCENT_COMPLETE ${PCT}% en meta-deep $TS. MISSING=$MISSING_COUNT. Ver $OUT" \
    --label "audit" 2>/dev/null || log "WARN: no se pudo crear issue (gh no autenticado)"
fi

echo "" >> "$OUT"
echo "Meta-deep guardado en: $OUT"
log "DONE: $OUT"
