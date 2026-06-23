---
tags: [inbox, script, configuracion, madre, systemd, ssh, tailscale, ufw]
fecha: 2026-06-24
estado: listo-para-ejecutar
destino: setup/servidor/scripts/configuracion-completa.sh
---

# Script Configuracion Completa — Madre

> Todo lo que hay que configurar una vez. Post-instalacion.
> Ejecutar despues del script de descargas.

---

## CONFIG 1 — Anti-suspension permanente

```bash
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
echo "Suspension deshabilitada OK"
```

---

## CONFIG 2 — Tailscale autoarranque

```bash
sudo systemctl enable --now tailscaled
sudo systemctl status tailscaled --no-pager
# Genera key en https://admin.tailscale.com/settings/keys (Reusable + No expiry)
# Sustituye la key:
sudo tailscale up --authkey=tskey-XXXXXXXXXXXXXXXX
tailscale status
echo "Tailscale OK"
```

---

## CONFIG 3 — UFW firewall

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22
sudo ufw allow from 192.168.1.0/24 to any port 3001
sudo ufw allow from 100.64.0.0/10 to any port 3001
sudo ufw allow from 192.168.1.0/24 to any port 11434
sudo ufw allow from 100.64.0.0/10 to any port 11434
sudo ufw allow from 192.168.1.0/24 to any port 9000
sudo ufw allow from 100.64.0.0/10 to any port 9000
sudo ufw allow from 192.168.1.0/24 to any port 3002
sudo ufw allow from 100.64.0.0/10 to any port 3002
sudo ufw --force enable
sudo ufw status
echo "UFW OK"
```

---

## CONFIG 4 — SSH sin contrasena Madre -> Acer

```bash
ssh-keygen -t ed25519 -C "madre" -f ~/.ssh/id_ed25519 -N ""
ssh-copy-id varo@100.86.119.102
# Test:
ssh varo@100.86.119.102 echo "SSH sin contrasena OK"
```

---

## CONFIG 5 — Ollama Modelfiles

```bash
# qwen2.5:3b CPU optimizado
cat > /tmp/Modelfile-cpu << 'EOF'
FROM qwen2.5:3b
PARAMETER num_thread 6
PARAMETER num_gpu 0
PARAMETER num_ctx 4096
EOF
docker cp /tmp/Modelfile-cpu ollama:/Modelfile-cpu
docker exec ollama ollama create qwen2.5:3b-cpu -f /Modelfile-cpu

# Erika — agente personal
cat > /tmp/Modelfile-erika << 'EOF'
FROM qwen2.5:3b
SYSTEM """Eres Erika, asistente tecnica de Alvaro. Arch Linux, Docker, Python, pentest. Siempre en espanol. Directa y tecnica. Sin inventar."""
PARAMETER num_thread 6
PARAMETER num_gpu 0
PARAMETER num_ctx 4096
PARAMETER temperature 0.7
EOF
docker cp /tmp/Modelfile-erika ollama:/Modelfile-erika
docker exec ollama ollama create erika -f /Modelfile-erika

docker exec ollama ollama list
echo "Modelfiles OK"
```

---

## CONFIG 6 — Docker autoarranque

```bash
sudo systemctl enable docker
sudo systemctl enable containerd
# Para que docker compose suba solo al reiniciar:
# Ya esta cubierto con restart: always en el compose
echo "Docker autoarranque OK"
```

---

## CONFIG 7 — tmux config basica

```bash
cat > ~/.tmux.conf << 'EOF'
set -g mouse on
set -g history-limit 10000
set -g default-terminal "screen-256color"
bind r source-file ~/.tmux.conf
EOF
echo "tmux config OK"
```

---

## VERIFICACION FINAL COMPLETA

```bash
echo "=== DOCKER SERVICES ==" && docker compose ps
echo "=== OLLAMA MODELS ==" && docker exec ollama ollama list
echo "=== TAILSCALE ==" && tailscale status
echo "=== UFW ==" && sudo ufw status
echo "=== SYSTEMD DOCKER ==" && systemctl is-enabled docker
echo "=== SUSPENSION ==" && systemctl is-masked sleep.target
echo "=== TODO CONFIGURADO ==" 
```

---
_Destino final: setup/servidor/scripts/configuracion-completa.sh_
