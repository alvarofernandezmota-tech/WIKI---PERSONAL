---
tags: [setup, seguridad, ufw, fail2ban, sysctl, fase1b]
fecha: 2026-06-24
estado: documentado
---

# Fase 1b — Seguridad base Madre

> Ejecutar después de levantar Fase 1 (Ollama + WebUI + Qdrant).
> Automatizado en `arranque-madre.sh` pasos 4-6.

---

## UFW — Firewall

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 3000   # Open WebUI
sudo ufw allow 11434  # Ollama API
sudo ufw allow 6333   # Qdrant
sudo ufw allow 9000   # Portainer
sudo ufw allow 3001   # Uptime Kuma
sudo ufw allow 5001   # SpiderFoot
sudo ufw allow 8080   # LiteLLM / n8n
sudo ufw allow 4000   # Nginx Proxy Manager
sudo ufw enable
sudo ufw status
```

---

## Sysctl — Optimización kernel para IA

```bash
sudo nano /etc/sysctl.d/99-batcueva.conf
```

Contenido:
```ini
# Red
net.core.somaxconn = 65535
net.ipv4.tcp_max_syn_backlog = 65535
net.ipv4.ip_forward = 1

# Seguridad
net.ipv4.conf.all.rp_filter = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0

# Memoria para Ollama (reduce swap agresivo)
vm.swappiness = 10
vm.dirty_ratio = 15
vm.dirty_background_ratio = 5
```

Aplicar:
```bash
sudo sysctl -p /etc/sysctl.d/99-batcueva.conf
```

---

## ZRAM — Swap rápido en RAM

```bash
sudo apt install zram-tools -y
sudo modprobe zram
echo lz4 | sudo tee /sys/block/zram0/comp_algorithm
echo 4G  | sudo tee /sys/block/zram0/disksize
sudo mkswap /dev/zram0
sudo swapon -p 100 /dev/zram0

# Verificar:
swapon --show
```

Persistente en arranque — añadir a `/etc/rc.local`:
```bash
modprobe zram
echo lz4 > /sys/block/zram0/comp_algorithm
echo 4G  > /sys/block/zram0/disksize
mkswap /dev/zram0
swapon -p 100 /dev/zram0
```

---

## fail2ban — Protección SSH

```bash
sudo apt install fail2ban -y
sudo systemctl enable --now fail2ban

# Configurar jail SSH:
sudo nano /etc/fail2ban/jail.local
```

Contenido:
```ini
[sshd]
enabled = true
port    = ssh
filter  = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime  = 3600
findtime = 600
```

```bash
sudo systemctl restart fail2ban
sudo fail2ban-client status sshd
```

---

## Verificación final

```bash
sudo ufw status verbose
sudo fail2ban-client status
swapon --show
sysctl vm.swappiness
docker compose ps
```

Todo debería mostrar: UFW activo, fail2ban activo, ZRAM montado, swappiness=10, 3 contenedores running.

---
_Ver también: [[arranque-madre.sh]] · [[docker-compose.yml]] · [[tailscale-autoarranque.md]]_
