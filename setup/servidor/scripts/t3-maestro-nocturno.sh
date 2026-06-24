#!/bin/bash
# =============================================================================
# t3-maestro-nocturno.sh
# Script maestro para Terminal 3 — ejecutar mientras duermes.
#
# T1 cubre: Docker Fase 3 + Fase 4 (descargando images)
# T2 cubre: Ollama modelos
# T3 cubre TODO lo demás:
#   1. Ollama modelos (skip automático si T2 ya los descargó)
#   2. Seguridad: suspensión + UFW + sysctl hardening
#   3. Pre-pull Docker todas las imágenes Fase 3 + 4 (5 reintentos)
#   4. Levantar Fase 3 y Fase 4 cuando las imágenes estén listas
#   5. Monitoreo en vivo en pantalla hasta que todo acabe
#
# USO (sin nohup — ves todo en pantalla):
#   bash ~/Projects/yggdrasil-dew/setup/servidor/scripts/t3-maestro-nocturno.sh
#
# Si se corta SSH — relánzalo. Todo tiene skip de lo ya hecho.
# =============================================================================

set -uo pipefail

LOG="/tmp/t3-maestro.log"
MAX=5
WAIT=20
REPO="$HOME/Projects/yggdrasil-dew"

exec > >(tee -a "$LOG") 2>&1

log()  { echo "[$(date +%H:%M:%S)] $*"; }
ok()   { echo "[$(date +%H:%M:%S)] ✅ $*"; }
err()  { echo "[$(date +%H:%M:%S)] ❌ $*"; }
info() { echo "[$(date +%H:%M:%S)] ➤ $*"; }
warn() { echo "[$(date +%H:%M:%S)] ⚠️ $*"; }
sep()  { echo ""; echo "================================================================"; echo "  $*"; echo "================================================================"; echo ""; }

pull_con_reintentos() {
  local TIPO="$1" ITEM="$2" i=1
  while [ $i -le $MAX ]; do
    info "[$i/$MAX] $TIPO pull: $ITEM"
    if [ "$TIPO" = "ollama" ]; then
      ollama pull "$ITEM" && { ok "$ITEM"; return 0; }
    else
      docker pull "$ITEM" && { ok "$ITEM"; return 0; }
    fi
    warn "Fallo $i. Esperando ${WAIT}s..."
    sleep $WAIT; i=$((i+1))
  done
  err "FALLIDO tras $MAX intentos: $ITEM — continuando"
  return 1
}

pull_ollama() {
  local m="$1"
  local ya; ya=$(ollama list 2>/dev/null | awk 'NR>1{print $1}')
  if echo "$ya" | grep -q "^${m}"; then
    info "SKIP (ya instalado): $m"; return 0
  fi
  pull_con_reintentos "ollama" "$m"
}

pull_docker() {
  local img="$1"
  if docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "${img%:*}"; then
    info "SKIP (ya descargada): $img"; return 0
  fi
  pull_con_reintentos "docker" "$img"
}

# =============================================================================
sep "T3 MAESTRO NOCTURNO — $(date)"

# =============================================================================
# BLOQUE 1 — OLLAMA MODELOS (skip si T2 ya los tiene)
# =============================================================================
sep "BLOQUE 1 — OLLAMA MODELOS"

pull_ollama "nomic-embed-text"   # 274 MB  — embeddings RAG
pull_ollama "bge-m3"             # 1.2 GB  — embeddings multilingüe
pull_ollama "qwen2.5:7b"         # 4.7 GB  — LLM general
pull_ollama "qwen2.5:14b"        # 9.0 GB  — LLM razonamiento
pull_ollama "llama3.1:8b"        # 4.7 GB  — fallback
pull_ollama "mistral:7b"         # 4.1 GB  — alternativa

log ""
log "Modelos Ollama instalados:"
ollama list

# =============================================================================
# BLOQUE 2 — DOCKER: todas las imágenes Fase 3 + 4 (skip si T1 ya las tiene)
# =============================================================================
sep "BLOQUE 2 — DOCKER IMAGES (skip si T1 ya las descargó)"

# Fase 3
pull_docker "n8nio/n8n:latest"
pull_docker "gitea/gitea:latest"
pull_docker "lscr.io/linuxserver/code-server:latest"
pull_docker "headscale/headscale:latest"
pull_docker "vaultwarden/server:latest"

# Fase 4
pull_docker "jc21/nginx-proxy-manager:latest"
pull_docker "containrrr/watchtower:latest"
pull_docker "ghcr.io/berriai/litellm:main-latest"

# =============================================================================
# BLOQUE 3 — SEGURIDAD MADRE
# =============================================================================
sep "BLOQUE 3 — SEGURIDAD MADRE"

info "Deshabilitando suspensión..."
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target 2>/dev/null \
  && ok "Suspensión deshabilitada" || warn "Ya estaba deshabilitada"

info "Verificando UFW..."
if sudo ufw status | grep -q "Status: active"; then
  info "UFW ya activo"
else
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  sudo ufw allow ssh
  sudo ufw allow 11434/tcp  # Ollama
  sudo ufw allow 9000/tcp   # Portainer
  sudo ufw allow 3001/tcp   # Open WebUI
  sudo ufw allow 6333/tcp   # Qdrant
  sudo ufw allow 5678/tcp   # n8n
  sudo ufw allow 3003/tcp   # Gitea
  sudo ufw allow 8443/tcp   # Code Server
  sudo ufw allow 4000/tcp   # LiteLLM
  sudo ufw allow 81/tcp     # Nginx Proxy Manager
  sudo ufw allow 5001/tcp   # SpiderFoot
  sudo ufw allow 41641/udp  # Tailscale
  sudo ufw --force enable
  ok "UFW activado"
fi

info "Aplicando sysctl hardening..."
SYSCTL_CONF="/etc/sysctl.d/99-madre-hardening.conf"
if [ ! -f "$SYSCTL_CONF" ]; then
  sudo tee "$SYSCTL_CONF" > /dev/null << 'EOF'
# Madre hardening
net.ipv4.ip_forward = 1
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.all.accept_source_route = 0
kernel.dmesg_restrict = 1
EOF
  sudo sysctl -p "$SYSCTL_CONF" 2>/dev/null
  ok "sysctl hardening aplicado"
else
  info "sysctl hardening ya existe"
fi

# =============================================================================
# BLOQUE 4 — LEVANTAR FASE 3
# =============================================================================
sep "BLOQUE 4 — LEVANTAR FASE 3"

if docker ps | grep -q "n8n"; then
  info "Fase 3 ya corriendo"
else
  cd "$REPO"
  docker compose -f setup/servidor/batcueva-fase3.yml up -d \
    && ok "Fase 3 levantada" || err "Error Fase 3 — revisar batcueva-fase3.yml"
fi

# =============================================================================
# BLOQUE 5 — LEVANTAR FASE 4
# =============================================================================
sep "BLOQUE 5 — LEVANTAR FASE 4"

if docker ps | grep -q "nginx-proxy-manager"; then
  info "Fase 4 ya corriendo"
else
  cd "$REPO"
  docker compose -f setup/servidor/batcueva-fase4.yml up -d \
    && ok "Fase 4 levantada" || err "Error Fase 4 — verificar litellm-config.yaml"
fi

# =============================================================================
# RESUMEN FINAL
# =============================================================================
sep "RESUMEN FINAL — $(date)"

log "--- Contenedores activos ---"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

log ""
log "--- Modelos Ollama ---"
ollama list

log ""
ok "T3 COMPLETADO — $(date)"
log "Log: $LOG"
