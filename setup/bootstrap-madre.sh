#!/usr/bin/env bash
# =============================================================================
# bootstrap-madre.sh — Setup inicial completo de Madre
# Ejecutar UNA VEZ como: bash bootstrap-madre.sh
# Requisitos: git, docker, internet
# =============================================================================

set -euo pipefail

REPO_URL="https://github.com/alvarofernandezmota-tech/yggdrasil-dew.git"
REPO_DIR="/srv/yggdrasil-dew"
USER_HOME="$HOME"

log()  { echo -e "\033[1;32m[→]\033[0m $*"; }
warn() { echo -e "\033[1;33m[⚠]\033[0m $*"; }
err()  { echo -e "\033[1;31m[✗]\033[0m $*"; exit 1; }
ok()   { echo -e "\033[1;36m[✓]\033[0m $*"; }

echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║     BOOTSTRAP MADRE — Yggdrasil Dew Setup            ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""

# — PASO 1: Clonar el repo —
if [[ -d "$REPO_DIR" ]]; then
  log "Repo ya existe en $REPO_DIR — haciendo git pull..."
  cd "$REPO_DIR" && git pull --rebase
else
  log "Clonando repo en $REPO_DIR..."
  sudo mkdir -p /srv
  sudo chown "$(whoami):$(whoami)" /srv
  git clone "$REPO_URL" "$REPO_DIR"
fi
cd "$REPO_DIR"
ok "Repo listo en $REPO_DIR"

# — PASO 2: Permisos de scripts —
log "Aplicando permisos a scripts..."
find scripts/ -name "*.sh" -exec chmod +x {} \;
find setup/ -name "*.sh" -exec chmod +x {} \;
ok "Permisos aplicados"

# — PASO 3: Instalar gh CLI si no existe —
if ! command -v gh &>/dev/null; then
  log "Instalando GitHub CLI (gh)..."
  type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
  sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
    https://cli.github.com/packages stable main" \
    | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt update && sudo apt install gh -y
  ok "gh CLI instalado"
else
  ok "gh CLI ya instalado: $(gh --version | head -1)"
fi

# — PASO 4: Login gh (interactivo) —
if ! gh auth status &>/dev/null; then
  warn "No autenticado en GitHub. Iniciando login..."
  echo ""
  echo "  Cuando te pida elegir método, elige: GitHub.com → HTTPS → Token"
  echo "  Token necesario en: https://github.com/settings/tokens"
  echo "  Scopes necesarios: repo, workflow, read:org"
  echo ""
  gh auth login
else
  ok "gh CLI autenticado: $(gh auth status 2>&1 | head -1)"
fi

# — PASO 5: Crear estructura de directorios locales —
log "Creando directorios locales en Madre..."
mkdir -p /srv/yggdrasil-dew/logs/audit
mkdir -p /srv/yggdrasil-dew/logs/health-agent
mkdir -p /srv/yggdrasil-dew/logs/mcp-audit
mkdir -p /srv/yggdrasil-dew/scripts/archive
mkdir -p /srv/logs/mcp-audit
ok "Directorios creados"

# — PASO 6: Crear .env del MCP server —
MCP_ENV="$REPO_DIR/agentes/mcp-server/.env"
if [[ ! -f "$MCP_ENV" ]]; then
  if [[ -f "$REPO_DIR/agentes/mcp-server/.env.example" ]]; then
    cp "$REPO_DIR/agentes/mcp-server/.env.example" "$MCP_ENV"
    warn ".env creado desde .env.example — DEBES editar $MCP_ENV con tus tokens reales"
    warn "Tokens necesarios: MADRE_MCP_TOKEN, GITHUB_TOKEN, TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID"
  else
    warn "No existe .env.example en agentes/mcp-server/ — créalo manualmente"
  fi
else
  ok ".env del MCP server ya existe"
fi

# — PASO 7: Verificar Docker —
if ! command -v docker &>/dev/null; then
  err "Docker no instalado. Instalar en: https://docs.docker.com/engine/install/ubuntu/"
else
  ok "Docker disponible: $(docker --version)"
  if ! docker ps &>/dev/null; then
    warn "Docker no tiene permisos sin sudo. Añadiendo usuario al grupo docker..."
    sudo usermod -aG docker "$(whoami)"
    warn "NECESITAS cerrar sesión y volver a entrar para que surja efecto"
  fi
fi

# — PASO 8: Arrancar MCP server —
MCP_DIR="$REPO_DIR/agentes/mcp-server"
if [[ -f "$MCP_DIR/docker-compose.mcp.yml" ]]; then
  log "Arrancando MCP server..."
  cd "$MCP_DIR"
  docker compose -f docker-compose.mcp.yml up -d --build 2>&1 | tail -20
  sleep 3
  if curl -sf http://localhost:8765/health &>/dev/null; then
    ok "MCP server ONLINE en http://localhost:8765"
  else
    warn "MCP server no responde aún — puede estar iniciando. Espera 10s y prueba:"
    warn "curl http://localhost:8765/health"
  fi
else
  warn "docker-compose.mcp.yml no existe aún en $MCP_DIR"
  warn "Ejecuta: bash scripts/audit-and-migrate.sh cuando el repo esté completo"
fi

cd "$REPO_DIR"

# — PASO 9: Smoke test final —
echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║                   RESUMEN FINAL                       ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""
echo "  Repo:     $REPO_DIR"
echo "  gh CLI:   $(gh auth status 2>&1 | head -1 || echo 'no autenticado')"
echo "  Docker:   $(docker --version 2>/dev/null || echo 'no disponible')"
echo ""
echo "  Siguiente paso:"
echo "  1. Editar $MCP_ENV con tokens reales"
echo "  2. bash scripts/audit-and-migrate.sh --dry-run"
echo "  3. bash scripts/audit-and-migrate.sh"
echo "  4. bash scripts/create-issues.sh"
echo ""
echo "  Docs: https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/AGENT.md"
echo ""
