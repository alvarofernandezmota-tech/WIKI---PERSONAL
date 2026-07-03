#!/usr/bin/env bash
# =============================================================================
# SCRIPT: copilot-2fases.sh
# VERSIÓN: 2.0.0
# FUNCIÓN ÚNICA: Entrega a Copilot el contexto del repo en 2 fases compactas
#                para que pueda trabajar de forma autónoma en GitHub sin
#                necesitar contexto previo de conversación
# AUTOR: alvaro@yggdrasil-dew
# REPO: alvarofernandezmota-tech/yggdrasil-dew
# CREADO: 2026-07-03
# ACTUALIZADO: 2026-07-03
# USO: ./copilot-2fases.sh [fase1|fase2|todo]
# DEPENDENCIAS: git, gh, find, jq
# DOCUMENTA EN: inbox/sesiones/YYYY-MM-DD-copilot-brief.md
# ABRE ISSUE SI: contexto incompleto o scripts sin plantilla detectados
# =============================================================================
set -euo pipefail

FECHA=$(date +%Y-%m-%d)
HORA=$(date +%H-%M)
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo "/srv/yggdrasil-dew")
OUTPUT_DIR="${REPO_ROOT}/inbox/sesiones"
mkdir -p "${OUTPUT_DIR}"

# ─────────────────────────────────────────────
# FASE 1 — CONTEXTO ESTRUCTURAL (lo que Copilot NECESITA saber)
# ─────────────────────────────────────────────
fase1() {
  echo ""
  echo "================================================================"
  echo " COPILOT BRIEF — FASE 1: CONTEXTO ESTRUCTURAL"
  echo " Repo: alvarofernandezmota-tech/yggdrasil-dew"
  echo " Fecha: ${FECHA} ${HORA}"
  echo "================================================================"
  echo ""
  echo "## MISIÓN DEL REPO"
  echo "Cerebro central de la infraestructura personal (Madre + Islas)."
  echo "Gestiona automatización, auditoría, agentes y documentación."
  echo ""
  echo "## ESTRUCTURA PRINCIPAL"
  echo "scripts/         → todos los scripts organizados por función"
  echo "scripts/agentes/ → agentes especializados con función única"
  echo "inbox/           → documentación activa + estados (EN PROCESO/COMPLETADO/PENDIENTE)"
  echo "diary/           → log histórico de sesiones"
  echo ".github/workflows/ → GitHub Actions automáticas"
  echo ""
  echo "## ISLAS DEL ECOSISTEMA"
  find "${REPO_ROOT}" -maxdepth 1 -type d -name 'isla-*' 2>/dev/null | sed 's|.*/||' || echo "  (sin islas separadas — todo en repo único)"
  echo ""
  echo "## SCRIPTS CRÍTICOS (core del sistema)"
  echo "  cierre-sesion.sh       → cierre + documentación automática"
  echo "  apertura-sesion.sh     → apertura + contexto"
  echo "  orquestador-supremo.sh → orquesta todos los agentes"
  echo "  issue-creator.sh       → crea issues en GitHub vía gh CLI"
  echo "  struct-auditor.sh      → detecta duplicados y fantasmas"
  echo "  ghost-file-detector.sh → archivos vacíos/huérfanos"
  echo "  gestor-estados-inbox.sh → gestiona etiquetas de estado"
  echo "  setup-labels.sh        → configura labels del repo"
  echo ""
  echo "## REGLA DE ORO — PLANTILLA ÚNICA"
  echo "Todo script debe tener cabecera con:"
  echo "  # SCRIPT, VERSIÓN, FUNCIÓN ÚNICA, AUTOR, REPO, CREADO,"
  echo "  # USO, DEPENDENCIAS, DOCUMENTA EN, ABRE ISSUE SI"
  echo ""
  echo "## LABELS SISTEMA (semáforo de estado)"
  echo "  completado / en-proceso / pendiente / bloqueado / revisar / aplazado"
  echo "  auto:script / auto:action / auto:agente"
  echo "  bug:ghost-file / bug:duplicado / bug:struct"
  echo "  prioridad:alta / prioridad:media / prioridad:baja"
  echo ""
  echo "================================================================"
  echo " FIN FASE 1 — Continúa con fase2 para estado actual"
  echo "================================================================"
}

# ─────────────────────────────────────────────
# FASE 2 — ESTADO ACTUAL (lo que está en proceso y pendiente)
# ─────────────────────────────────────────────
fase2() {
  echo ""
  echo "================================================================"
  echo " COPILOT BRIEF — FASE 2: ESTADO ACTUAL DEL ECOSISTEMA"
  echo " Fecha: ${FECHA} ${HORA}"
  echo "================================================================"
  echo ""
  echo "## FASE DEL PROYECTO"
  echo "  FASE 1 ✅ COMPLETADA — Estructura base + scripts core"
  echo "  FASE 2 ✅ COMPLETADA — Auditoría y detección de gaps"
  echo "  FASE 3 🔵 EN PROCESO — Estandarizar plantilla + activar scripts + labels"
  echo "  FASE 4 ⬜ PENDIENTE  — MCP server socket activo + agentes autónomos"
  echo "  FASE 5 ⬜ PENDIENTE  — Propagación a islas"
  echo ""
  echo "## ISSUES ABIERTOS EN GITHUB"
  if command -v gh &>/dev/null; then
    gh issue list --repo alvarofernandezmota-tech/yggdrasil-dew \
      --state open --limit 15 \
      --json number,title,labels \
      --jq '.[] | "  #\(.number) [\(.labels | map(.name) | join(","))] \(.title)"' 2>/dev/null \
      || echo "  (gh CLI no disponible en este contexto)"
  else
    echo "  (gh CLI no disponible — consultar GitHub Issues manualmente)"
  fi
  echo ""
  echo "## ARCHIVOS EN PROCESO (inbox/)"
  grep -rl '🔵 EN PROCESO\|estado: en-proceso\|EN PROCESO' "${REPO_ROOT}/inbox/" 2>/dev/null \
    | head -10 | sed 's|.*/||' | sed 's/^/  /' || echo "  (ninguno detectado)"
  echo ""
  echo "## SCRIPTS SIN PLANTILLA ESTÁNDAR (🔴 ACTUALIZAR)"
  CONTADOR=0
  for SCRIPT in "${REPO_ROOT}/scripts"/*.sh; do
    if ! grep -q '# FUNCIÓN ÚNICA:' "${SCRIPT}" 2>/dev/null; then
      echo "  ⚠️  $(basename ${SCRIPT})"
      CONTADOR=$((CONTADOR + 1))
    fi
  done
  [ ${CONTADOR} -eq 0 ] && echo "  ✅ Todos los scripts tienen plantilla estándar"
  echo "  Total sin plantilla: ${CONTADOR}"
  echo ""
  echo "## MCP SERVER"
  if systemctl is-active --quiet mcp-server 2>/dev/null; then
    echo "  ✅ mcp-server: ACTIVO"
  else
    echo "  ❌ mcp-server: INACTIVO — Socket no disponible"
    echo "  → Acción: activar en Madre para autonomía GitHub"
  fi
  echo ""
  echo "## PRÓXIMAS ACCIONES (prioridad alta)"
  echo "  1. Ejecutar setup-labels.sh con nuevo sistema de labels"
  echo "  2. Aplicar plantilla única a scripts sin cabecera estándar"
  echo "  3. Activar MCP server socket en Madre"
  echo "  4. Crear agente completion-tracker para gestión automática de labels"
  echo "  5. Auditar scripts/agentes/ con tool-inventory-auditor.sh"
  echo ""
  echo "================================================================"
  echo " FIN FASE 2 — Copilot puede operar de forma autónoma con este contexto"
  echo "================================================================"
  echo ""

  # Documentar en inbox
  cat >> "${OUTPUT_DIR}/${FECHA}-copilot-brief.md" << EOF
## Copilot Brief — ${FECHA} ${HORA}
- Fase actual: FASE 3 EN PROCESO
- Scripts sin plantilla: ${CONTADOR}
- MCP server: ver fase2 output
- Generado por: copilot-2fases.sh v2.0.0
EOF
  echo "  📝 Documentado en: ${OUTPUT_DIR}/${FECHA}-copilot-brief.md"
}

# ─────────────────────────────────────────────
# MAIN
# ─────────────────────────────────────────────
ARG=${1:-todo}
case "${ARG}" in
  fase1) fase1 ;;
  fase2) fase2 ;;
  todo)  fase1; fase2 ;;
  *)
    echo "Uso: $0 [fase1|fase2|todo]"
    echo "  fase1 → contexto estructural del repo"
    echo "  fase2 → estado actual + pendientes"
    echo "  todo  → ambas fases (por defecto)"
    exit 1
    ;;
esac
