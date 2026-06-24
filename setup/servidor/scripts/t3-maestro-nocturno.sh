#!/bin/bash
# =============================================================================
# t3-maestro-nocturno.sh
# Script maestro para Terminal 3 — ejecutar mientras duermes.
#
# T1 ya cubre: Docker Fase 3 + Fase 4 (descargando)
# T2 ya cubre: Ollama modelos (descargando)
# T3 cubre TODO lo demás:
#   1. Ollama modelos (con skip automático si T2 ya los descargó)
#   2. Seguridad Madre: deshabilitar suspensión + UFW + sysctl
#   3. Levantar Fase 3 cuando Docker termine
#   4. Levantar Fase 4 cuando Docker termine
#   5. Monitoreo en vivo en pantalla hasta que todo acabe
#
# USO (en terminal SSH normal, SIN nohup — ves todo en pantalla):
#   bash ~/Projects/yggdrasil-dew/setup/servidor/scripts/t3-maestro-nocturno.sh
#
# Si se corta SSH, relánzalo — todo tiene skip de lo ya hecho.
# =============================================================================

set -uo pipefail

LOG="/tmp/t3-maestro.log"
MAX=5
WAIT=20
REPO="$HOME/Projects/yggdrasil-dew"

# Salida en pantalla Y en log
exec > >(tee -a "$LOG") 2>&1

log()  { echo "[$(date +%H:%M:%S)] $*"; }
ok()   { echo "[$(date +%H:%M:%S)] ✅ $*"; }
err()  { echo "[$(date +%H:%M:%S)] ❌ $*"; }
info() { echo "[$(date +%H:%M:%S)] ➤ $*"; }
warn() { echo "[$(date +%H:%M:%S)] ⚠️ $*"; }
sep()  { echo ""; echo "================================================================"; echo "  $*"; echo "================================================================"; echo ""; }

pull_ollama() {
  local m="$1" i=1
  local ya
  ya=$(ollama list 2>/dev/null | awk 'NR>1{print $1}')
  if echo "$ya" | grep -q "^${m}"; then
    info "SKIP (ya instalado): $m"
    return 0
  fi
  while [ $i -le $MAX ]; do
    info "[$i/$MAX] ollama pull $m"
    ollama pull "$m" && { ok "$m"; return 0; }
    warn "Fallo $i. Esperando ${WAIT}s..."
    sleep $WAIT; i=$((i+1))
  done
  err "FALLIDO tras $MAX intentos: $m"
}

esperar_imagen_docker() {
  local img="$1"
  local intentos=0
  while ! docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "${img%:*}"; do
    if [ $intentos -ge 60 ]; then
      warn "Timeout esperando imagen Docker: $img"
      return 1
    fi
    info "Esperando descarga Docker de ${img}... (${intentos}m)"
    sleep 60
    intentos=$((intentos+1))
  done
  ok "Imagen disponible: $img"
}

# =============================================================================
sep "T3 MAESTRO NOCTURNO — $(date)"
log "Repo: $REPO"
log "Log: $LOG"
log ""

# =============================================================================
# BLOQUE 1 — OLLAMA MODELOS
# T2 puede estar descargándolos en paralelo. Skip automático si ya están.
# =============================================================================
sep "BLOQUE 1 — OLLAMA MODELOS"
info "Orden: embeddings (RAG) → LLMs pequeños → LLMs grandes"
info "qwen2.5:3b ya instalado — se salta automáticamente"

pull_ollama "nomic-embed-text"   # 274 MB  — embeddings ligeros
pull_ollama "bge-m3"             # 1.2 GB  — embeddings RAG multilingüe
pull_ollama "qwen2.5:7b"         # 4.7 GB  — LLM general
pull_ollama "qwen2.5:14b"        # 9.0 GB  — LLM razonamiento
pull_ollama "llama3.1:8b"        # 4.7 GB  — fallback
pull_ollama "mistral:7b"         # 4.1 GB  — alternativa ligera

log ""
log "Modelos instalados ahora:"
ollama list

# =============================================================================
# BLOQUE 2 — SEGURIDAD MADRE
# =============================================================================
sep "BLOQUE 2 — SEGURIDAD MADRE"

# 2a. Deshabilitar suspensión (Madre no puede dormirse)
info "Deshabilitando suspensión/hibernación..."
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target 2>/dev/null && ok "Suspensión deshabilitada" || warn "Ya estaba deshabilitada o requiere sudo"

# 2b. UFW — activar si no está activo
info "Verificando UFW..."
if sudo ufw status | grep -q "Status: active"; then
  info "UFW ya activo"
else
  info "Activando UFW con reglas básicas..."
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  sudo ufw allow ssh
  sudo ufw allow 11434/tcp   # Ollama
  sudo ufw allow 9000/tcp    # Portainer
  sudo ufw allow 3001/tcp    # Open WebUI / Uptime Kuma
  sudo ufw allow 6333/tcp    # Qdrant
  sudo ufw allow 41641/udp   # Tailscale
  sudo ufw --force enable
  ok "UFW activado"
fi

# 2c. Sysctl hardening básico
info "Aplicando sysctl hardening..."
SYSCTL_CONF="/etc/sysctl.d/99-madre-hardening.conf"
if [ ! -f "$SYSCTL_CONF" ]; then
  sudo tee "$SYSCTL_CONF" > /dev/null << 'EOF'
# Madre hardening — generado por t3-maestro-nocturno.sh
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
# BLOQUE 3 — ESPERAR DOCKER Y LEVANTAR FASES
# =============================================================================
sep "BLOQUE 3 — LEVANTAR FASE 3 (esperar Docker)"

# Esperar a que n8n esté descargada (indicador de que Fase 3 está lista)
info "Esperando que T1 termine de descargar Fase 3..."
esperar_imagen_docker "n8nio/n8n"

if docker ps | grep -q "n8n"; then
  info "Fase 3 ya está corriendo"
else
  info "Levantando Fase 3..."
  cd "$REPO"
  docker compose -f setup/servidor/batcueva-fase3.yml up -d && ok "Fase 3 levantada" || err "Error levantando Fase 3"
fi

sep "BLOQUE 4 — LEVANTAR FASE 4 (esperar Docker)"

esperar_imagen_docker "jc21/nginx-proxy-manager"

if docker ps | grep -q "nginx-proxy-manager"; then
  info "Fase 4 ya está corriendo"
else
  info "Levantando Fase 4..."
  cd "$REPO"
  docker compose -f setup/servidor/batcueva-fase4.yml up -d && ok "Fase 4 levantada" || err "Error levantando Fase 4 — revisar batcueva-fase4.yml"
fi

# =============================================================================
# RESUMEN FINAL
# =============================================================================
sep "RESUMEN FINAL — $(date)"

log "--- Contenedores Docker activos ---"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

log ""
log "--- Modelos Ollama ---"
ollama list

log ""
log "--- UFW status ---"
sudo ufw status numbered 2>/dev/null

log ""
ok "T3 MAESTRO COMPLETADO — $(date)"
log "Log completo: $LOG"
