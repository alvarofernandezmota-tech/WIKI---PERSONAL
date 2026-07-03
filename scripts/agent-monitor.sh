#!/usr/bin/env bash
# =============================================================
# FUNCIÓN:   Vigila que todos los agentes/workflows estén vivos.
#            Si alguno lleva >24h sin run exitoso, abre issue
#            con label automatizacion y título [AGENTE-CAÍDO].
#            Es el centinela de centinelas.
# TRIGGER:   cron cada 6h / workflow_dispatch
# AGENTE:    agent-monitor.yml
# ETIQUETAS: automatizacion, urgente
# RUTAS:     Lee: GitHub Actions API
#            Escribe: diarios/agent-monitor-YYYY-MM-DD.md
# =============================================================

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo '.')"
FECHA=$(date +%Y-%m-%d)
LOG="$REPO_ROOT/diarios/agent-monitor-$FECHA.md"
CAIDOS=0
AHORA=$(date +%s)

mkdir -p "$REPO_ROOT/diarios"

log() { echo "$*" | tee -a "$LOG"; }

# Lista de workflows críticos a vigilar
WORKFLOWS_CRITICOS=(
  "audit-on-push.yml"
  "diary-writer.yml"
  "health-check.yml"
  "clasificador-maestro.yml"
  "gestor-estados-inbox.yml"
  "ecosystem-guardian.yml"
  "repo-audit.yml"
  "orquestador-maestro.yml"
)

cat > "$LOG" << EOF
# 🤖 AGENT MONITOR — $FECHA

Generado por: agent-monitor.sh
Fecha: $(date '+%Y-%m-%d %H:%M:%S')

---

EOF

log "## ESTADO DE AGENTES/WORKFLOWS"
log ""

for wf in "${WORKFLOWS_CRITICOS[@]}"; do
  if ! command -v gh &>/dev/null; then
    log "  ⚠️  gh CLI no disponible — saltando $wf"
    continue
  fi

  # Obtener último run del workflow
  ULTIMO_RUN=$(gh api \
    "/repos/alvarofernandezmota-tech/yggdrasil-dew/actions/workflows/$wf/runs?per_page=1" \
    --jq '.workflow_runs[0] | {status: .status, conclusion: .conclusion, created_at: .created_at}' \
    2>/dev/null || echo '{"status":"unknown","conclusion":"unknown","created_at":"1970-01-01T00:00:00Z"}')

  STATUS=$(echo "$ULTIMO_RUN" | grep -o '"status":"[^"]*"' | cut -d'"' -f4)
  CONCLUSION=$(echo "$ULTIMO_RUN" | grep -o '"conclusion":"[^"]*"' | cut -d'"' -f4)
  CREATED=$(echo "$ULTIMO_RUN" | grep -o '"created_at":"[^"]*"' | cut -d'"' -f4)

  # Calcular tiempo desde último run
  if [[ "$CREATED" != "1970-01-01T00:00:00Z" ]]; then
    TS_RUN=$(date -d "$CREATED" +%s 2>/dev/null || date -j -f '%Y-%m-%dT%H:%M:%SZ' "$CREATED" +%s 2>/dev/null || echo 0)
    HORAS_SIN_RUN=$(( (AHORA - TS_RUN) / 3600 ))
  else
    HORAS_SIN_RUN=999
  fi

  # Evaluar estado
  if [[ "$CONCLUSION" == "failure" ]] || [[ "$HORAS_SIN_RUN" -gt 24 ]]; then
    CAIDOS=$((CAIDOS + 1))
    log "  🔴 CAÍDO: $wf (conclusión: $CONCLUSION, hace ${HORAS_SIN_RUN}h)"

    # Abrir issue si no existe
    TITULO="[AGENTE-CAÍDO] $wf"
    EXISTE=$(gh issue list --label "automatizacion" --state open \
      --json title --jq '.[].title' 2>/dev/null | grep -F "$wf" || true)

    if [[ -z "$EXISTE" ]]; then
      gh issue create \
        --title "$TITULO" \
        --body "El workflow \`$wf\` está caído o no ha corrido en ${HORAS_SIN_RUN}h.\n\n- Último estado: $STATUS\n- Conclusión: $CONCLUSION\n- Último run: $CREATED\n\n**Acción**: revisar en [Actions]($GITHUB_SERVER_URL/$GITHUB_REPOSITORY/actions)" \
        --label "automatizacion,urgente" \
        --repo "alvarofernandezmota-tech/yggdrasil-dew" 2>/dev/null || true
      log "    → Issue abierto: $TITULO"
    fi
  elif [[ "$CONCLUSION" == "success" ]]; then
    log "  ✅ OK: $wf (hace ${HORAS_SIN_RUN}h)"
  else
    log "  ⚠️  DESCONOCIDO: $wf (status: $STATUS, conclusión: $CONCLUSION)"
  fi
done

log ""
log "## RESUMEN"
log "  Workflows vigilados: ${#WORKFLOWS_CRITICOS[@]}"
log "  Caídos: $CAIDOS"
log "  Fecha: $(date '+%Y-%m-%d %H:%M:%S')"
log ""
log "---"
log "*Generado por agent-monitor.sh [AUTO]*"
