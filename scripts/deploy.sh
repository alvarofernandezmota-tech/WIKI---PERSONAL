#!/usr/bin/env bash
# ============================================================
# YGGDRASIL ECOSYSTEM DEPLOY SCRIPT
# Ejecutar en Madre: bash scripts/deploy.sh
# SIEMPRE dry_run por defecto — añade --apply para ejecutar
# ============================================================

set -euo pipefail

DRY_RUN=true
REPO_DEW="/srv/yggdrasil-dew"
REPO_SECOPS="/srv/yggdrasil-secops"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'

log()  { echo -e "${GREEN}[✅ OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[⚠️  WARN]${NC} $1"; }
info() { echo -e "${BLUE}[ℹ️  INFO]${NC} $1"; }
err()  { echo -e "${RED}[❌ ERR]${NC} $1"; exit 1; }

run() {
  if $DRY_RUN; then
    echo -e "${YELLOW}[DRY_RUN]${NC} $*"
  else
    eval "$@"
  fi
}

for arg in "$@"; do
  [[ "$arg" == "--apply" ]] && DRY_RUN=false
done

$DRY_RUN && warn "Modo DRY_RUN activo. Añade --apply para ejecutar de verdad."
echo ""

# ─────────────────────────────────────────────
# 1. PREREQUISITOS
# ─────────────────────────────────────────────
info "Verificando prerequisitos..."

command -v docker    &>/dev/null && log "Docker OK"       || err "Docker no encontrado"
command -v gh        &>/dev/null && log "gh CLI OK"       || warn "gh CLI no encontrado — list_issues no funcionará"
command -v python3   &>/dev/null && log "Python3 OK"      || err "Python3 no encontrado"

if curl -s http://localhost:11434/api/tags &>/dev/null; then
  log "Ollama OK"
else
  warn "Ollama no responde en :11434 — health-agent necesitará Ollama"
fi

echo ""

# ─────────────────────────────────────────────
# 2. ESTRUCTURA DE DIRECTORIOS
# ─────────────────────────────────────────────
info "Creando estructura de directorios..."

DIRS=(
  "$REPO_DEW/agentes/mcp-server/tools"
  "$REPO_DEW/agentes/alvaro-agent"
  "$REPO_DEW/agentes/obsidian-agent/tools"
  "$REPO_DEW/agentes/docs-agent"
  "$REPO_DEW/agentes/roadmap-agent"
  "$REPO_DEW/logs/mcp-audit"
  "$REPO_DEW/logs/health-agent"
  "$REPO_DEW/inbox"
  "$REPO_DEW/diary"
  "$REPO_DEW/reports"
  "$REPO_SECOPS/health-agent"
  "$REPO_SECOPS/security-agent"
  "$REPO_SECOPS/watchdogs"
)

for d in "${DIRS[@]}"; do
  run "mkdir -p '$d'"
done
log "Directorios creados"
echo ""

# ─────────────────────────────────────────────
# 3. DESPLEGAR MCP SERVER
# ─────────────────────────────────────────────
info "Desplegando MCP Server..."

if ! $DRY_RUN; then
  cd "$REPO_DEW/agentes/mcp-server"
  docker compose build --no-cache
  docker compose up -d
  log "MCP Server desplegado en :3000"
else
  info "[DRY_RUN] docker compose build + up para MCP server"
fi

echo ""

# ─────────────────────────────────────────────
# 4. DESPLEGAR HEALTH AGENT
# ─────────────────────────────────────────────
info "Desplegando Health Agent..."

if ! $DRY_RUN; then
  cd "$REPO_DEW/agentes/health-agent"
  docker compose build --no-cache
  docker compose up -d
  log "Health Agent desplegado en :8001"
else
  info "[DRY_RUN] docker compose build + up para Health Agent"
fi

echo ""

# ─────────────────────────────────────────────
# 5. INSTALAR DEPENDENCIAS PYTHON
# ─────────────────────────────────────────────
info "Instalando dependencias Python..."
run "pip3 install --quiet mcp fastmcp fastapi uvicorn pydantic requests"
log "Dependencias OK"
echo ""

# ─────────────────────────────────────────────
# 6. VERIFICACIÓN FINAL
# ─────────────────────────────────────────────
info "Verificación final..."

if ! $DRY_RUN; then
  sleep 3
  if curl -s http://localhost:8001/health/ping | grep -q "ok"; then
    log "Health Agent responde en :8001 ✅"
  else
    warn "Health Agent no responde aún — revisa: docker logs yggdrasil-health-agent"
  fi
  docker ps --filter "name=yggdrasil" --format "{{.Names}}\t{{.Status}}"
else
  info "[DRY_RUN] Verificaciones de red omitidas"
fi

echo ""
echo "══════════════════════════════════════════════"
if $DRY_RUN; then
  warn "DRY_RUN completado. Para desplegar de verdad:"
  echo "  bash scripts/deploy.sh --apply"
else
  log "DESPLIEGUE COMPLETADO"
  echo "  MCP Server:    http://localhost:3000"
  echo "  Health Agent:  http://localhost:8001/health/ping"
fi
echo "══════════════════════════════════════════════"
