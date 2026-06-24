#!/bin/bash
# =============================================================================
# arranque-madre.sh — Script maestro: ejecutar UNA VEZ al llegar a Madre
# Hace todo solo y notifica por Telegram cuando termina
# Uso: cd ~/yggdrasil-dew && git pull && bash setup/servidor/scripts/arranque-madre.sh
# Log: /tmp/arranque-madre.log
# =============================================================================

LOG="/tmp/arranque-madre.log"
echo "" > $LOG
START=$(date +%s)

log()  { echo "[$(date '+%H:%M:%S')] $1" | tee -a $LOG; }
ok()   { log "✅ $1"; }
warn() { log "⚠️  $1"; }
fail() { log "❌ $1"; }

# --- Telegram (opcional — rellena si tienes thdora activo) ---
TG_TOKEN=""
TG_CHAT=""
tg() {
  [[ -z "$TG_TOKEN" ]] && return
  curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
    -d chat_id="$TG_CHAT" -d text="$1" > /dev/null
}

log "================================================"
log " ARRANQUE MADRE — $(date '+%d/%m/%Y %H:%M')"
log "================================================"
tg "🟡 Arranque Madre iniciado — $(date '+%H:%M')"

# =============================================================================
# PASO 1 — Deshabilitar suspensión permanentemente
# =============================================================================
log ""
log "--- PASO 1: Deshabilitar suspensión ---"
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target >> $LOG 2>&1
ok "Suspensión deshabilitada permanentemente"

# =============================================================================
# PASO 2 — Actualizar repo
# =============================================================================
log ""
log "--- PASO 2: Git pull ---"
git pull >> $LOG 2>&1 && ok "Repo actualizado" || warn "Git pull falló — continuando"

# =============================================================================
# PASO 3 — ZRAM (swap rápido en RAM para Ollama)
# =============================================================================
log ""
log "--- PASO 3: Configurar ZRAM ---"
if ! command -v zramctl &> /dev/null; then
  sudo apt-get install -y zram-tools >> $LOG 2>&1
fi
if ! swapon --show | grep -q zram; then
  sudo modprobe zram
  echo lz4 | sudo tee /sys/block/zram0/comp_algorithm > /dev/null
  echo 4G  | sudo tee /sys/block/zram0/disksize > /dev/null
  sudo mkswap /dev/zram0 >> $LOG 2>&1
  sudo swapon -p 100 /dev/zram0 >> $LOG 2>&1
  ok "ZRAM 4GB activado"
else
  ok "ZRAM ya activo"
fi

# =============================================================================
# PASO 4 — Sysctl optimización para IA + seguridad
# =============================================================================
log ""
log "--- PASO 4: Sysctl hardening + IA ---"
cat << 'EOF' | sudo tee /etc/sysctl.d/99-batcueva.conf > /dev/null
# Red
net.core.somaxconn = 65535
net.ipv4.tcp_max_syn_backlog = 65535
net.ipv4.ip_forward = 1
# Seguridad
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
# Memoria para Ollama
vm.swappiness = 10
vm.dirty_ratio = 15
vm.dirty_background_ratio = 5
EOF
sudo sysctl -p /etc/sysctl.d/99-batcueva.conf >> $LOG 2>&1
ok "Sysctl aplicado"

# =============================================================================
# PASO 5 — UFW firewall
# =============================================================================
log ""
log "--- PASO 5: UFW firewall ---"
sudo ufw --force reset >> $LOG 2>&1
sudo ufw default deny incoming >> $LOG 2>&1
sudo ufw default allow outgoing >> $LOG 2>&1
sudo ufw allow ssh >> $LOG 2>&1
sudo ufw allow 3000  >> $LOG 2>&1  # Open WebUI
sudo ufw allow 11434 >> $LOG 2>&1  # Ollama API
sudo ufw allow 6333  >> $LOG 2>&1  # Qdrant
sudo ufw allow 9000  >> $LOG 2>&1  # Portainer
sudo ufw allow 3001  >> $LOG 2>&1  # Uptime Kuma
sudo ufw allow 5001  >> $LOG 2>&1  # SpiderFoot
sudo ufw allow 8080  >> $LOG 2>&1  # LiteLLM / n8n
sudo ufw allow 4000  >> $LOG 2>&1  # Nginx Proxy Manager
sudo ufw --force enable >> $LOG 2>&1
ok "UFW activo con reglas del stack"

# =============================================================================
# PASO 6 — Tailscale permanente
# =============================================================================
log ""
log "--- PASO 6: Tailscale ---"
if command -v tailscale &> /dev/null; then
  sudo systemctl enable --now tailscaled >> $LOG 2>&1
  ok "Tailscale habilitado en arranque"
  # Si tienes authkey, descomenta:
  # sudo tailscale up --authkey=tskey-XXXXXXXXXX
else
  warn "Tailscale no instalado — instalar manualmente"
fi

# =============================================================================
# PASO 7 — Levantar Fase 1 (Ollama + Open WebUI + Qdrant)
# =============================================================================
log ""
log "--- PASO 7: Levantar Fase 1 ---"
cd ~/yggdrasil-dew
docker compose -f setup/servidor/docker-compose.yml up -d >> $LOG 2>&1
sleep 10
if docker compose -f setup/servidor/docker-compose.yml ps | grep -q "healthy\|running"; then
  ok "Fase 1 levantada (Ollama + WebUI + Qdrant)"
telse
  warn "Fase 1 puede necesitar más tiempo — ver: docker compose ps"
fi

# =============================================================================
# PASO 8 — Pre-descarga Fases 2-4 en background
# =============================================================================
log ""
log "--- PASO 8: Pre-descarga Fases 2-4 en background ---"
nohup bash setup/servidor/scripts/pre-descarga-todo.sh > /tmp/pre-descarga.log 2>&1 &
DESCARGA_PID=$!
ok "Pre-descarga lanzada en background (PID: $DESCARGA_PID)"
log "   Ver progreso: tail -f /tmp/pre-descarga.log"

# =============================================================================
# PASO 9 — Modelos Ollama (en background, espera que Ollama arranque)
# =============================================================================
log ""
log "--- PASO 9: Descarga modelos Ollama en background ---"
(
  sleep 30  # Esperar que Ollama esté listo
  for modelo in qwen2.5:3b nomic-embed-text bge-m3 llama3:8b phi4:latest deepseek-r1:7b; do
    until docker exec ollama ollama pull $modelo >> /tmp/ollama-modelos.log 2>&1; do
      sleep 10
    done
    echo "✅ Modelo descargado: $modelo" >> /tmp/ollama-modelos.log
  done
  echo "🎯 Todos los modelos Ollama descargados" >> /tmp/ollama-modelos.log
) &
ok "Descarga modelos Ollama lanzada en background"
log "   Ver progreso: tail -f /tmp/ollama-modelos.log"

# =============================================================================
# PASO 10 — Crear Modelfile Erika
# =============================================================================
log ""
log "--- PASO 10: Modelfile Erika ---"
MODELFILE_DIR=~/yggdrasil-dew/agentes/ollama
mkdir -p $MODELFILE_DIR
cat << 'EOF' > /tmp/Modelfile-Erika
FROM qwen2.5:3b
SYSTEM """Eres Erika, asistente técnica de Álvaro. Eres directa, concisa y técnica.
Especialidades: Linux, Docker, Python, IA local, pentest, homelab.
Respondes en español siempre. Sin florituras. Solo lo útil."""
PARAMETER temperature 0.3
PARAMETER num_ctx 4096
EOF
(
  sleep 60  # Esperar que qwen2.5:3b esté descargado
  docker exec ollama ollama create erika -f /tmp/Modelfile-Erika >> $LOG 2>&1
  echo "✅ Modelo Erika creado" >> $LOG
) &
ok "Modelfile Erika programado para crear cuando qwen2.5:3b esté listo"

# =============================================================================
# RESUMEN FINAL
# =============================================================================
END=$(date +%s)
DURACION=$((END - START))

log ""
log "================================================"
log " ARRANQUE COMPLETADO en ${DURACION}s"
log "================================================"
log " Fase 1:        ACTIVA"
log " Pre-descarga:  EN BACKGROUND (PID: $DESCARGA_PID)"
log " Modelos:       EN BACKGROUND"
log " Erika:         EN BACKGROUND"
log " UFW:           ACTIVO"
log " ZRAM:          ACTIVO (4GB)"
log ""
log " Logs:"
log "   Arranque:     cat /tmp/arranque-madre.log"
log "   Descargas:    tail -f /tmp/pre-descarga.log"
log "   Modelos:      tail -f /tmp/ollama-modelos.log"
log ""
log " Servicios:"
log "   Open WebUI:   http://$(hostname -I | awk '{print $1}'):3000"
log "   Ollama API:   http://$(hostname -I | awk '{print $1}'):11434"
log "   Qdrant:       http://$(hostname -I | awk '{print $1}'):6333"
log "================================================"

tg "✅ Madre lista — Fase 1 activa, descargas en background. Tiempo: ${DURACION}s"
tg "🌐 WebUI: http://$(hostname -I | awk '{print $1}'):3000"

echo ""
echo "✅ Arranque completado. Madre trabajando sola."
echo "   Cerrar terminal es seguro — todo corre en background."
