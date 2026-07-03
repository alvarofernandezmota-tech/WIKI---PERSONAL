#!/usr/bin/env bash
# ==============================================================================
# Yggdrasil-DEW - Deploy Completo en Madre (varpc)
# Lanza: inbox-watcher + MCP server + health-agent
# Uso: bash scripts/deploy-madre.sh
# IMPORTANTE: Ejecutar como varopc, no como root
# ==============================================================================

set -euo pipefail

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(git -C "$SOURCE_DIR" rev-parse --show-toplevel)"

# Colores para terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

step() { printf "\n${BLUE}[DEPLOY]${NC} %s\n" "$1"; }
ok()   { printf "${GREEN}  ✅ %s${NC}\n" "$1"; }
warn() { printf "${YELLOW}  ⚠️  %s${NC}\n" "$1"; }
fail() { printf "${RED}  ❌ %s${NC}\n" "$1"; exit 1; }

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║   Yggdrasil-DEW — Deploy Madre (varpc)          ║"
echo "║   $(date '+%Y-%m-%d %H:%M:%S') CEST               ║"
echo "╚══════════════════════════════════════════════════╝"

# ── Verificaciones previas ────────────────────────────────────────────────────
step "Verificando dependencias..."
for dep in docker git inotify-tools curl; do
    if command -v "${dep%%-*}" &>/dev/null || pacman -Qi "$dep" &>/dev/null 2>&1; then
        ok "$dep"
    else
        warn "$dep no instalado — instalando..."
        sudo pacman -S --needed --noconfirm "$dep" || fail "No se pudo instalar $dep"
    fi
done

# ── Red Docker del ecosistema ─────────────────────────────────────────────────
step "Red Docker yggdrasil_ecosystem_network..."
if docker network ls | grep -q "yggdrasil_ecosystem_network"; then
    ok "Red ya existe"
else
    docker network create yggdrasil_ecosystem_network
    ok "Red creada"
fi

# ── Logs ──────────────────────────────────────────────────────────────────────
step "Preparando archivos de log..."
for logfile in \
    /var/log/yggdrasil-dew-maintenance.log \
    /var/log/inbox-watcher.log \
    /var/log/mcp-server.log \
    /var/log/health-agent.log; do
    sudo touch "$logfile"
    sudo chown varopc:varopc "$logfile"
    ok "$logfile"
done

# ── inbox-watcher (systemd) ───────────────────────────────────────────────────
step "Instalando inbox-watcher daemon..."
sudo cp "${REPO_DIR}/scripts/inbox-watcher.sh" /usr/local/bin/inbox-watcher.sh
sudo chmod +x /usr/local/bin/inbox-watcher.sh
sudo cp "${REPO_DIR}/scripts/inbox-watcher.service" /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable inbox-watcher.service
sudo systemctl restart inbox-watcher.service

if systemctl is-active --quiet inbox-watcher.service; then
    ok "inbox-watcher activo"
else
    warn "inbox-watcher no arrancó — ver: journalctl -u inbox-watcher.service"
fi

# ── MCP Server (Docker) ───────────────────────────────────────────────────────
step "Levantando MCP Server (puerto 8002)..."
cd "${REPO_DIR}/agentes/mcp-server"
docker compose up -d
sleep 5

if curl -sf http://localhost:8002/health > /dev/null 2>&1; then
    ok "MCP Server online en :8002"
else
    warn "MCP Server arrancando... espera 30s y prueba: curl http://localhost:8002/health"
fi

# ── Health Agent (Docker) ─────────────────────────────────────────────────────
step "Levantando Health Agent (puerto 8001)..."
cd "${REPO_DIR}/agentes/health-agent"
docker compose up -d
sleep 5

if curl -sf http://localhost:8001/health > /dev/null 2>&1; then
    ok "Health Agent online en :8001"
else
    warn "Health Agent arrancando... espera 30s y prueba: curl http://localhost:8001/health"
fi

# ── ecosystem-snapshot.sh ─────────────────────────────────────────────────────
step "Probando ecosystem-snapshot.sh en DRY_RUN..."
YGG_DRY_RUN=true bash "${REPO_DIR}/scripts/ecosystem-snapshot.sh" && ok "Snapshot OK" || warn "Revisar snapshot"

# ── Resumen final ─────────────────────────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║   DEPLOY COMPLETADO — Estado del ecosistema     ║"
echo "╚══════════════════════════════════════════════════╝"
printf "  inbox-watcher:  %s\n" "$(systemctl is-active inbox-watcher.service 2>/dev/null || echo 'unknown')"
printf "  MCP server:     %s\n" "$(curl -sf http://localhost:8002/health 2>/dev/null | python3 -c "import sys,json; print(json.load(sys.stdin)['status'])" 2>/dev/null || echo 'iniciando')"
printf "  Health agent:   %s\n" "$(curl -sf http://localhost:8001/health 2>/dev/null | python3 -c "import sys,json; print(json.load(sys.stdin)['status'])" 2>/dev/null || echo 'iniciando')"
echo ""
echo "  Logs en tiempo real:"
echo "    tail -f /var/log/inbox-watcher.log"
echo "    tail -f /var/log/mcp-server.log"
echo "    tail -f /var/log/health-agent.log"
echo ""
echo "  Test inbox-watcher:"
echo "    echo '# Test [AUTO]' > ${REPO_DIR}/inbox/test-$(date +%Y%m%d).md"
echo ""
