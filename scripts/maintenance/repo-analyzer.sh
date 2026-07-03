#!/usr/bin/env bash
# ================================================================
# repo-analyzer.sh — Análisis automático del ecosistema Yggdrasil
# Analiza la repo + "islas" (repos relacionados) y detecta qué falta
# Genera un informe en inbox/ con hallazgos y acciones sugeridas
# Uso: bash scripts/maintenance/repo-analyzer.sh
# ================================================================
set -euo pipefail

REPO_DIR="${REPO_DIR:-$(git -C "$(dirname "$0")" rev-parse --show-toplevel 2>/dev/null || pwd)}"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M)
INFORME="$REPO_DIR/inbox/${DATE}-repo-analysis.md"

RED='\033[0;31m'; GRN='\033[0;32m'; YLW='\033[1;33m'; BLU='\033[0;34m'; NC='\033[0m'

echo -e "${BLU}[→]${NC} Iniciando análisis del ecosistema Yggdrasil..."

# ---- Funciones de análisis ----------------------------------------

check_dir() {
  local path="$1"; local label="$2"
  if [ -d "$REPO_DIR/$path" ]; then
    echo "[✅] $label ($path)"
    return 0
  else
    echo "[❌] $label FALTA: $path"
    return 1
  fi
}

check_file() {
  local path="$1"; local label="$2"
  if [ -f "$REPO_DIR/$path" ]; then
    echo "[✅] $label"
    return 0
  else
    echo "[❌] $label FALTA: $path"
    return 1
  fi
}

check_action() {
  local workflow="$1"
  if [ -f "$REPO_DIR/.github/workflows/$workflow" ]; then
    echo "[✅] Action: $workflow"
    return 0
  else
    echo "[❌] Action FALTA: $workflow"
    return 1
  fi
}

check_service() {
  local name="$1"; local port="$2"
  if curl -sf --max-time 2 "http://localhost:$port" > /dev/null 2>&1; then
    echo "[✅] Servicio UP: $name (port $port)"
    return 0
  else
    echo "[⚠] Servicio DOWN: $name (port $port)"
    return 1
  fi
}

# ---- Colección de hallazgos en arrays ----------------------------
FALLOS=()
ADVERTENCIAS=()
OK_LIST=()

analyze() {
  local label="$1"; local result="$2"
  if [[ "$result" == OK ]]; then
    OK_LIST+=("$label")
  elif [[ "$result" == WARN ]]; then
    ADVERTENCIAS+=("$label")
  else
    FALLOS+=("$label")
  fi
}

# ---- Análisis: estructura obligatoria ----------------------------
echo -e "\n${BLU}--- Estructura básica ---${NC}"
for REQUIRED_DIR in agentes diary docs scripts inbox; do
  if [ -d "$REPO_DIR/$REQUIRED_DIR" ]; then
    OK_LIST+=("dir:$REQUIRED_DIR")
    echo -e "  ${GRN}✓${NC} $REQUIRED_DIR/"
  else
    FALLOS+=("dir_falta:$REQUIRED_DIR")
    echo -e "  ${RED}✗${NC} $REQUIRED_DIR/ FALTA"
  fi
done

# ---- Análisis: ficheros clave ------------------------------------
echo -e "\n${BLU}--- Ficheros clave ---${NC}"
KEY_FILES=(
  "ROADMAP-MASTER.md"
  "agentes/REGLAS-AGENTES.md"
  "agentes/MACRO-SPEC-ECOSISTEMA.md"
  "agentes/mcp-server/mcp_server.py"
  "agentes/mcp-server/DISEÑO.md"
  "scripts/cierre-sesion.sh"
  "scripts/apertura-sesion.sh"
  "scripts/maintenance/inbox-audit-cleanup.sh"
  "scripts/maintenance/ecosystem-reality-check.sh"
  "scripts/maintenance/repo-analyzer.sh"
)
for F in "${KEY_FILES[@]}"; do
  if [ -f "$REPO_DIR/$F" ]; then
    OK_LIST+=("file:$F")
    echo -e "  ${GRN}✓${NC} $F"
  else
    FALLOS+=("file_falta:$F")
    echo -e "  ${RED}✗${NC} $F FALTA"
  fi
done

# ---- Análisis: GitHub Actions ------------------------------------
echo -e "\n${BLU}--- GitHub Actions ---${NC}"
REQUIRED_ACTIONS=(
  "inbox-cleanup.yml"
  "reality-check.yml"
  "autonomous-cron.yml"
)
for WF in "${REQUIRED_ACTIONS[@]}"; do
  if [ -f "$REPO_DIR/.github/workflows/$WF" ]; then
    OK_LIST+=("action:$WF")
    echo -e "  ${GRN}✓${NC} $WF"
  else
    FALLOS+=("action_falta:$WF")
    echo -e "  ${RED}✗${NC} $WF FALTA"
  fi
done

TOTAL_ACTIONS=$(find "$REPO_DIR/.github/workflows/" -name '*.yml' 2>/dev/null | wc -l | tr -d ' ')
echo -e "  ${BLU}[→]${NC} Total Actions en repo: $TOTAL_ACTIONS"

# ---- Análisis: servicios (solo si en Madre) ----------------------
echo -e "\n${BLU}--- Servicios (Madre) ---${NC}"
SERVICIOS=(
  "Ollama:11434"
  "n8n:5678"
  "Portainer:9000"
  "Qdrant:6333"
  "Grafana:3000"
  "Uptime-Kuma:3001"
  "health-agent:8000"
  "mcp-server:8001"
)
for SVC_PORT in "${SERVICIOS[@]}"; do
  SVC=$(echo $SVC_PORT | cut -d: -f1)
  PORT=$(echo $SVC_PORT | cut -d: -f2)
  if curl -sf --max-time 2 "http://localhost:$PORT" > /dev/null 2>&1; then
    OK_LIST+=("svc:$SVC")
    echo -e "  ${GRN}✓${NC} $SVC UP"
  else
    ADVERTENCIAS+=("svc_down:$SVC")
    echo -e "  ${YLW}●${NC} $SVC DOWN (port $PORT)"
  fi
done

# ---- Análisis: inbox state ---------------------------------------
echo -e "\n${BLU}--- Inbox state ---${NC}"
INBOX_COUNT=$(find "$REPO_DIR/inbox/" -maxdepth 1 -name '*.md' \
  ! -name 'README.md' ! -name 'PLANTILLA*.md' ! -name 'APLAZADO*.md' \
  ! -name 'SIGUIENTE*.md' ! -name 'PENDIENTES*.md' ! -name 'PLAN-*.md' \
  | wc -l | tr -d ' ')
if [ "$INBOX_COUNT" -gt 20 ]; then
  ADVERTENCIAS+=("inbox_overflow:$INBOX_COUNT ficheros")
  echo -e "  ${RED}⚠${NC} Inbox overflow: $INBOX_COUNT ficheros (>20)"
elif [ "$INBOX_COUNT" -gt 10 ]; then
  ADVERTENCIAS+=("inbox_alto:$INBOX_COUNT ficheros")
  echo -e "  ${YLW}⚠${NC} Inbox alto: $INBOX_COUNT ficheros"
else
  OK_LIST+=("inbox:$INBOX_COUNT ficheros")
  echo -e "  ${GRN}✓${NC} Inbox: $INBOX_COUNT ficheros (OK)"
fi

# ---- Análisis: diary reciente ------------------------------------
echo -e "\n${BLU}--- Diary ---${NC}"
LAST_DIARY=$(find "$REPO_DIR/diary" -name '*.md' ! -name 'README*' 2>/dev/null | sort | tail -1 || echo "")
if [ -n "$LAST_DIARY" ]; then
  LAST_DATE=$(basename "$LAST_DIARY" | cut -c1-10)
  DAYS_AGO=$(( ($(date +%s) - $(date -d "$LAST_DATE" +%s 2>/dev/null || echo $(date +%s))) / 86400 ))
  if [ "$DAYS_AGO" -gt 7 ]; then
    ADVERTENCIAS+=("diary_antiguo:${DAYS_AGO}d sin entrada")
    echo -e "  ${YLW}⚠${NC} Último diary hace ${DAYS_AGO} días"
  else
    OK_LIST+=("diary:activo")
    echo -e "  ${GRN}✓${NC} Diary activo (${LAST_DATE})"
  fi
else
  FALLOS+=("diary:vacío")
  echo -e "  ${RED}✗${NC} Diary vacío"
fi

# ---- Generar informe ---------------------------------------------
mkdir -p "$(dirname "$INFORME")"
cat > "$INFORME" << EOF
---
date: ${DATE}
hora: ${TIME}
tipo: repo-analysis
global_status: $([ ${#FALLOS[@]} -gt 0 ] && echo WARN || echo OK)
---

# Repo Analysis — ${DATE} ${TIME}

## Resumen

- ✅ OK: ${#OK_LIST[@]} items
- ⚠ Advertencias: ${#ADVERTENCIAS[@]}
- ❌ Fallos: ${#FALLOS[@]}
- Actions en repo: $TOTAL_ACTIONS
- Inbox: $INBOX_COUNT ficheros

## Fallos (requieren atención)

$(for F in "${FALLOS[@]:-}"; do echo "- [ ] $F"; done || echo "Ninguno")

## Advertencias

$(for W in "${ADVERTENCIAS[@]:-}"; do echo "- $W"; done || echo "Ninguna")

## OK

$(for O in "${OK_LIST[@]:-}"; do echo "- $O"; done)

## Acciones sugeridas [AUTO]

$([ ${#FALLOS[@]} -gt 0 ] && echo '- Crear issues para ficheros/dirs faltantes' || echo '- Sin acciones críticas')
$([ $INBOX_COUNT -gt 10 ] && echo '- Limpiar inbox (supera umbral)' || true)
$([ ${#ADVERTENCIAS[@]} -gt 0 ] && echo '- Revisar servicios DOWN' || true)

---
*Generado por repo-analyzer.sh [AUTO]*
EOF

echo -e "\n${GRN}[✓]${NC} Informe generado: $(basename $INFORME)"

# ---- Commit informe en repo -------------------------------------
cd "$REPO_DIR"
git add -A 2>/dev/null || true
if ! git diff --staged --quiet; then
  git commit -m "chore(analysis): repo-analysis ${DATE} — ${#FALLOS[@]} fallos, ${#ADVERTENCIAS[@]} warnings [AUTO]"
  git push && echo -e "${GRN}[✓]${NC} Informe pusheado" || echo -e "${YLW}[⚠]${NC} Push fallido"
fi

echo -e "\n╔═════════════════════════════════════════════╗"
echo "║   ANÁLISIS COMPLETADO                         ║"
echo "║   Fallos: ${#FALLOS[@]}  Warnings: ${#ADVERTENCIAS[@]}  OK: ${#OK_LIST[@]}     ║"
echo "╚═════════════════════════════════════════════╝"
