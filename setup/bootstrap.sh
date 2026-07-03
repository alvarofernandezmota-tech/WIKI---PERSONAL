#!/usr/bin/env bash
# =============================================================================
# YGGDRASIL BOOTSTRAP
# Un comando para levantar el ecosistema completo en cualquier máquina
# Uso: curl -sL https://raw.githubusercontent.com/alvarofernandezmota-tech/yggdrasil-dew/main/setup/bootstrap.sh | bash
# =============================================================================
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
info()  { echo -e "${BLUE}[→]${NC} $1"; }
ok()    { echo -e "${GREEN}[✓]${NC} $1"; }
warn()  { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[✗]${NC} $1"; exit 1; }

echo ""
echo "🌳 YGGDRASIL BOOTSTRAP"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# --- 1. DEPENDENCIAS ---
info "Verificando dependencias..."
for cmd in git docker curl ssh; do
  command -v "$cmd" &>/dev/null && ok "$cmd disponible" || error "$cmd no encontrado — instálalo primero"
done

# --- 2. CLONAR REPOS ---
info "Clonando repositorios..."
mkdir -p ~/Projects

clone_repo() {
  local repo=$1 dest=$2
  if [ -d "$dest" ]; then
    warn "$dest ya existe — haciendo git pull"
    git -C "$dest" pull --quiet
  else
    git clone "git@github.com:alvarofernandezmota-tech/${repo}.git" "$dest"
    ok "Clonado: $dest"
  fi
}

clone_repo "yggdrasil-dew"  "~/yggdrasil-dew"
clone_repo "thdora"         "~/Projects/thdora"

# --- 3. VARIABLES DE ENTORNO ---
if [ ! -f ~/yggdrasil-dew/.env ]; then
  if [ -f ~/yggdrasil-dew/.env.template ]; then
    cp ~/yggdrasil-dew/.env.template ~/yggdrasil-dew/.env
    warn ".env creado desde template — EDÍTALO antes de continuar"
    warn "nano ~/yggdrasil-dew/.env"
    echo ""
    read -p "¿Ya has editado el .env? (s/N): " confirm
    [[ "$confirm" =~ ^[sS]$ ]] || error "Edita el .env primero"
  else
    error ".env.template no encontrado"
  fi
else
  ok ".env ya existe"
fi

# --- 4. SSH AGENT (evitar passphrase en cada push) ---
info "Configurando SSH agent..."
if ! pgrep -u "$USER" ssh-agent > /dev/null 2>&1; then
  eval "$(ssh-agent -s)" > /dev/null
fi
if [ -f ~/.ssh/id_ed25519_github ]; then
  ssh-add ~/.ssh/id_ed25519_github 2>/dev/null && ok "Clave SSH añadida al agent" || warn "No se pudo añadir la clave SSH"
fi

# --- 5. DOCKER ---
info "Verificando Docker..."
if ! docker info &>/dev/null; then
  error "Docker no está corriendo — inicia Docker primero"
fi

if [ -f ~/Projects/thdora/docker-compose.yml ]; then
  info "Levantando thdora..."
  docker compose -f ~/Projects/thdora/docker-compose.yml up -d --build
  ok "thdora levantado"
else
  warn "docker-compose.yml de thdora no encontrado — saltando"
fi

# --- 6. VERIFICACIÓN FINAL ---
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ok "Bootstrap completado"
echo ""
info "Estado Docker:"
docker ps --format "  {{.Names}}\t{{.Status}}" 2>/dev/null || true
echo ""
echo "🌳 Ecosistema listo."
