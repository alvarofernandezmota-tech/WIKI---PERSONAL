#!/usr/bin/env bash
# ================================================================
# ecosystem-reality-check.sh
# Auditoría completa: estado real vs lo que creemos que tenemos
# Detecta discordancias en scripts, Actions, servicios, docs
# Output: inbox/YYYY-MM-DD-reality-check.md
# Uso: bash scripts/maintenance/ecosystem-reality-check.sh
# ================================================================
set -euo pipefail

REPO_DIR="${REPO_DIR:-$(git -C "$(dirname "$0")" rev-parse --show-toplevel 2>/dev/null || pwd)}"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M)
OUTPUT="$REPO_DIR/inbox/${DATE}-reality-check.md"
WARNINGS=0
OK=0

# Colores para terminal
RED='\033[0;31m'; GRN='\033[0;32m'; YLW='\033[1;33m'; BLU='\033[0;34m'; NC='\033[0m'

log_ok()   { echo -e "${GRN}[✓]${NC} $1"; ((OK++)) || true; }
log_warn() { echo -e "${YLW}[⚠]${NC} $1"; ((WARNINGS++)) || true; }
log_err()  { echo -e "${RED}[✗]${NC} $1"; ((WARNINGS++)) || true; }
log_info() { echo -e "${BLU}[→]${NC} $1"; }

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║   ECOSYSTEM REALITY CHECK                        ║"
echo "║   $(date '+%Y-%m-%d %H:%M')                              ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""

# ── Inicializar informe ──────────────────────────────────────
cat > "$OUTPUT" << HEADER
---
type: audit
date: ${DATE}
hora: ${TIME}
source: ecosystem-reality-check.sh
priority: high
status: pending
processed_by: pending
title: Reality Check ${DATE} ${TIME}
---

# 🔍 Ecosystem Reality Check — ${DATE} ${TIME}

> Auditoría automática del estado real vs documentado.
> Generado por `ecosystem-reality-check.sh [AUTO]`

HEADER

# ================================================================
# SECCIÓN 1 — INVENTARIO DE SCRIPTS
# ================================================================
log_info "Auditando scripts/..."
echo -e "\n## 1. Scripts — Inventario y estado\n" >> "$OUTPUT"

TOTAL_SCRIPTS=$(find "$REPO_DIR/scripts" -name '*.sh' -o -name '*.py' 2>/dev/null | wc -l | tr -d ' ')
EJECUTABLES=$(find "$REPO_DIR/scripts" \( -name '*.sh' -o -name '*.py' \) -perm /111 2>/dev/null | wc -l | tr -d ' ')
NO_EXEC=$(find "$REPO_DIR/scripts" \( -name '*.sh' -o -name '*.py' \) ! -perm /111 2>/dev/null | wc -l | tr -d ' ')
EN_RAIZ=$(find "$REPO_DIR/scripts" -maxdepth 1 \( -name '*.sh' -o -name '*.py' \) 2>/dev/null | wc -l | tr -d ' ')
EN_SUBDIRS=$(find "$REPO_DIR/scripts" -mindepth 2 \( -name '*.sh' -o -name '*.py' \) 2>/dev/null | wc -l | tr -d ' ')

echo "| Métrica | Valor |" >> "$OUTPUT"
echo "|---------|-------|" >> "$OUTPUT"
echo "| Total scripts | $TOTAL_SCRIPTS |" >> "$OUTPUT"
echo "| Ejecutables (chmod +x) | $EJECUTABLES |" >> "$OUTPUT"
echo "| Sin permisos ejecución | $NO_EXEC |" >> "$OUTPUT"
echo "| En raíz scripts/ (sin organizar) | $EN_RAIZ |" >> "$OUTPUT"
echo "| En subdirectorios | $EN_SUBDIRS |" >> "$OUTPUT"
echo "" >> "$OUTPUT"

[ "$NO_EXEC" -gt 0 ] && log_warn "$NO_EXEC scripts sin permisos de ejecución" || log_ok "Todos los scripts son ejecutables"
[ "$EN_RAIZ" -gt 10 ] && log_warn "$EN_RAIZ scripts en raíz de scripts/ — organizar en subdirs" || log_ok "Scripts bien organizados"

# Scripts sin README referencia
echo "### Scripts en raíz (candidatos a migrar a subdirs)" >> "$OUTPUT"
find "$REPO_DIR/scripts" -maxdepth 1 \( -name '*.sh' -o -name '*.py' \) | sort | while read f; do
  FNAME=$(basename "$f")
  echo "- \`$FNAME\`" >> "$OUTPUT"
done

# Scripts duplicados (mismo nombre en distintos dirs)
echo "" >> "$OUTPUT"
echo "### Scripts potencialmente duplicados" >> "$OUTPUT"
DUPS=$(find "$REPO_DIR/scripts" \( -name '*.sh' -o -name '*.py' \) -printf '%f\n' 2>/dev/null | sort | uniq -d)
if [ -n "$DUPS" ]; then
  log_warn "Scripts con nombre duplicado: $DUPS"
  echo "$DUPS" | while read d; do echo "- ⚠ \`$d\`"; done >> "$OUTPUT"
else
  log_ok "Sin scripts duplicados"
  echo "_Ninguno detectado_" >> "$OUTPUT"
fi

# ================================================================
# SECCIÓN 2 — GITHUB ACTIONS
# ================================================================
log_info "Auditando .github/workflows/..."
echo -e "\n## 2. GitHub Actions — Inventario\n" >> "$OUTPUT"

ACTIONS_DIR="$REPO_DIR/.github/workflows"
if [ -d "$ACTIONS_DIR" ]; then
  TOTAL_ACTIONS=$(find "$ACTIONS_DIR" -name '*.yml' -o -name '*.yaml' | wc -l | tr -d ' ')
  echo "| Workflow | Trigger | Estado |" >> "$OUTPUT"
  echo "|----------|---------|--------|" >> "$OUTPUT"
  find "$ACTIONS_DIR" \( -name '*.yml' -o -name '*.yaml' \) | sort | while read wf; do
    WNAME=$(basename "$wf")
    TRIGGER=$(grep -E '^  (push|pull_request|schedule|workflow_dispatch):' "$wf" 2>/dev/null | head -3 | tr '\n' ' ' | sed 's/://g' | xargs || echo "manual")
    DISABLED=$(grep -q 'if: false' "$wf" 2>/dev/null && echo "🔴 DISABLED" || echo "🟢 ACTIVO")
    echo "| \`$WNAME\` | $TRIGGER | $DISABLED |" >> "$OUTPUT"
  done
  log_ok "$TOTAL_ACTIONS workflows encontrados"
else
  log_err ".github/workflows/ no existe"
  echo "❌ Directorio no encontrado" >> "$OUTPUT"
fi

# ================================================================
# SECCIÓN 3 — SERVICIOS DOCKER (si Madre accesible)
# ================================================================
log_info "Comprobando servicios Docker..."
echo -e "\n## 3. Servicios Docker (Madre)\n" >> "$OUTPUT"

if command -v docker &>/dev/null; then
  RUNNING=$(docker ps --format '{{.Names}}\t{{.Status}}\t{{.Image}}' 2>/dev/null | wc -l | tr -d ' ')
  STOPPED=$(docker ps -a --filter 'status=exited' --format '{{.Names}}' 2>/dev/null | wc -l | tr -d ' ')
  echo "| Contenedores corriendo | $RUNNING |" >> "$OUTPUT"
  echo "| Contenedores parados | $STOPPED |" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
  echo "### Contenedores activos" >> "$OUTPUT"
  echo '```' >> "$OUTPUT"
  docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Image}}' 2>/dev/null >> "$OUTPUT" || echo "Sin acceso a Docker" >> "$OUTPUT"
  echo '```' >> "$OUTPUT"
  if [ "$STOPPED" -gt 0 ]; then
    log_warn "$STOPPED contenedores parados"
    echo "### ⚠ Contenedores parados" >> "$OUTPUT"
    echo '```' >> "$OUTPUT"
    docker ps -a --filter 'status=exited' --format '{{.Names}}\t{{.Status}}' 2>/dev/null >> "$OUTPUT"
    echo '```' >> "$OUTPUT"
  fi
  log_ok "Docker accesible — $RUNNING corriendo"
else
  echo "_Docker no accesible desde este contexto (ejecutar en Madre)_" >> "$OUTPUT"
  log_info "Docker no disponible — ejecutar en Madre para datos reales"
fi

# ================================================================
# SECCIÓN 4 — SERVICIOS HTTP (ping básico)
# ================================================================
log_info "Pinging servicios HTTP conocidos..."
echo -e "\n## 4. Servicios HTTP — Estado\n" >> "$OUTPUT"
echo "| Servicio | URL | Estado |" >> "$OUTPUT"
echo "|----------|-----|--------|" >> "$OUTPUT"

declare -A SERVICES
SERVICES=(
  ["Portainer"]="http://localhost:9000"
  ["n8n"]="http://localhost:5678"
  ["Uptime-Kuma"]="http://localhost:3001"
  ["Grafana"]="http://localhost:3000"
  ["Ollama"]="http://localhost:11434"
  ["Open-WebUI"]="http://localhost:8080"
  ["Gitea"]="http://localhost:3002"
  ["Qdrant"]="http://localhost:6333"
  ["health-agent"]="http://localhost:8000"
)

for SERVICE in "${!SERVICES[@]}"; do
  URL="${SERVICES[$SERVICE]}"
  if curl -sf --max-time 2 "$URL" > /dev/null 2>&1; then
    echo "| $SERVICE | \`$URL\` | ✅ UP |" >> "$OUTPUT"
    log_ok "$SERVICE UP"
  else
    echo "| $SERVICE | \`$URL\` | ❌ DOWN |" >> "$OUTPUT"
    log_warn "$SERVICE DOWN ($URL)"
  fi
done

# ================================================================
# SECCIÓN 5 — DISCORDANCIAS DOCS vs REALIDAD
# ================================================================
log_info "Buscando discordancias docs/realidad..."
echo -e "\n## 5. Discordancias detectadas\n" >> "$OUTPUT"

# Scripts referenciados en README que no existen
if [ -f "$REPO_DIR/scripts/README.md" ]; then
  echo "### Scripts referenciados en README pero no encontrados" >> "$OUTPUT"
  FOUND_MISSING=0
  grep -oP '`[^`]+\.sh`' "$REPO_DIR/scripts/README.md" 2>/dev/null | tr -d '`' | sort -u | while read SCRIPTREF; do
    if ! find "$REPO_DIR/scripts" -name "$SCRIPTREF" | grep -q .; then
      echo "- ❌ \`$SCRIPTREF\` referenciado pero no existe" >> "$OUTPUT"
      log_warn "Script fantasma: $SCRIPTREF"
      FOUND_MISSING=$((FOUND_MISSING+1))
    fi
  done
  echo "" >> "$OUTPUT"
fi

# TODOs y FIXMEs en scripts
echo "### TODOs/FIXMEs pendientes en scripts" >> "$OUTPUT"
TODOS=$(grep -rn 'TODO\|FIXME\|HACK\|XXX' "$REPO_DIR/scripts" --include='*.sh' --include='*.py' 2>/dev/null | wc -l | tr -d ' ')
if [ "$TODOS" -gt 0 ]; then
  log_warn "$TODOS TODOs/FIXMEs en scripts"
  echo "_$TODOS items encontrados:_" >> "$OUTPUT"
  echo '```' >> "$OUTPUT"
  grep -rn 'TODO\|FIXME' "$REPO_DIR/scripts" --include='*.sh' --include='*.py' 2>/dev/null | head -20 >> "$OUTPUT" || true
  echo '```' >> "$OUTPUT"
else
  log_ok "Sin TODOs/FIXMEs en scripts"
  echo "_Ninguno encontrado_" >> "$OUTPUT"
fi

# ================================================================
# SECCIÓN 6 — FASE ACTUAL DEL ECOSISTEMA
# ================================================================
log_info "Calculando fase actual..."
echo -e "\n## 6. Fase actual del ecosistema\n" >> "$OUTPUT"

# Detectar fases completadas por presencia de ficheros clave
FASE1=$([ -f "$REPO_DIR/scripts/03-fase1-seguridad.sh" ] && echo "✅" || echo "❌")
FASE2=$([ -f "$REPO_DIR/scripts/04-fase2-start-batcueva.sh" ] && echo "✅" || echo "❌")
FASE3=$([ -f "$REPO_DIR/scripts/07-fase3-restic-backup.sh" ] && echo "✅" || echo "❌")
FASE4_HEALTH=$([ -d "$REPO_DIR/health-agent-core" ] || [ -d "$REPO_DIR/services/health-agent" ] && echo "✅" || echo "🔨")
FASE5_MCP=$(find "$REPO_DIR" -name 'mcp*.py' -o -name 'mcp-server*' 2>/dev/null | grep -q . && echo "✅" || echo "❌")
FASE6_RAG=$([ -f "$REPO_DIR/services/rag*" ] 2>/dev/null || find "$REPO_DIR" -name 'rag*.py' 2>/dev/null | grep -q . && echo "✅" || echo "❌")

cat >> "$OUTPUT" << FASES
| Fase | Componente | Estado |
|------|------------|--------|
| Fase 1 | Seguridad base (UFW, fail2ban, hardening) | $FASE1 |
| Fase 2 | Stack batcueva (Portainer, n8n, Ollama) | $FASE2 |
| Fase 3 | Backup Restic | $FASE3 |
| Fase 4 | health-agent-core (FastAPI + LLM) | $FASE4_HEALTH |
| Fase 5 | MCP server Madre | $FASE5_MCP |
| Fase 6 | RAG + second-brain | $FASE6_RAG |
FASES

# ================================================================
# RESUMEN FINAL
# ================================================================
TOTAL_CHECKS=$((OK + WARNINGS))

cat >> "$OUTPUT" << SUMMARY

---

## Resumen

| | |
|--|--|
| ✅ OK | $OK |
| ⚠ Warnings | $WARNINGS |
| Total checks | $TOTAL_CHECKS |
| Scripts totales | $TOTAL_SCRIPTS |
| Actions activas | ${TOTAL_ACTIONS:-?} |

*Generado por ecosystem-reality-check.sh [AUTO] · ${DATE} ${TIME}*
*Ejecutar en Madre para datos Docker/HTTP reales.*
SUMMARY

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║  RESUMEN FINAL                               ║"
echo "╠══════════════════════════════════════════════╣"
echo "║  ✅ OK      : $OK"
echo "║  ⚠  WARN    : $WARNINGS"
echo "║  Informe    : inbox/$(basename $OUTPUT)"
echo "╚══════════════════════════════════════════════╝"
echo ""

# Commit automático
if command -v git &>/dev/null && git -C "$REPO_DIR" rev-parse --git-dir &>/dev/null; then
  cd "$REPO_DIR"
  git add inbox/ 2>/dev/null || true
  git diff --staged --quiet || git commit -m "audit(ecosystem): reality-check ${DATE} — ${OK}ok/${WARNINGS}warn [AUTO]" 2>/dev/null || true
  git push 2>/dev/null && echo "[✓] Push completado" || echo "[⚠] Push manual necesario"
fi
