# 🖥️ Instalación en Madre (varpc) — Guía Completa

> Instrucciones para desplegar el ecosistema autónomo en Arch Linux.
> Actualizado: 2026-07-03 [AUTO]

## 1. inbox-watcher (Systemd Daemon)

```bash
# Dependencias
sudo pacman -S --needed inotify-tools

# Desplegar script
sudo cp scripts/inbox-watcher.sh /usr/local/bin/inbox-watcher.sh
sudo chmod +x /usr/local/bin/inbox-watcher.sh

# Logs
sudo touch /var/log/inbox-watcher.log
sudo chown varopc:varopc /var/log/inbox-watcher.log

# Systemd
sudo cp scripts/inbox-watcher.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable inbox-watcher.service
sudo systemctl start inbox-watcher.service
sudo systemctl status inbox-watcher.service

# Verificar en tiempo real
tail -f /var/log/inbox-watcher.log

# Test: simular nuevo archivo en inbox
echo '# Test [AUTO]' > /srv/yggdrasil-dew/inbox/test-$(date +%Y%m%d).md
```

## 2. MCP Server (Docker)

```bash
# Crear red compartida del ecosistema (si no existe)
docker network create yggdrasil_ecosystem_network 2>/dev/null || true

# Logs
sudo touch /var/log/mcp-server.log
sudo chown varopc:varopc /var/log/mcp-server.log

# Levantar
cd /srv/yggdrasil-dew/agentes/mcp-server
docker compose up -d

# Verificar health
curl -s http://localhost:8002/health | python3 -m json.tool

# Ver tools disponibles
curl -s http://localhost:8002/tools/list_scripts | python3 -m json.tool

# Leer roadmap via MCP
curl -s http://localhost:8002/tools/read_roadmap | python3 -m json.tool
```

## 3. Scripts lib/common.sh — Integrar en scripts existentes

Añadir al inicio de cualquier script del ecosistema:

```bash
#!/usr/bin/env bash
set -euo pipefail
# shellcheck source=scripts/lib/common.sh
source "$(git rev-parse --show-toplevel)/scripts/lib/common.sh"
```

## 4. Variables de entorno

```bash
# Añadir a /etc/environment o ~/.bashrc de varopc
export YGG_REPO_DIR=/srv/yggdrasil-dew
export YGG_LOG_FILE=/var/log/yggdrasil-dew-maintenance.log
export YGG_DRY_RUN=false  # true para test sin efectos
```

## 5. Verificación del bucle completo

```bash
# Modo test end-to-end:
export YGG_DRY_RUN=true
echo '# Test bucle' > /srv/yggdrasil-dew/inbox/test-bucle.md
# → inbox-watcher detecta → commit [AUTO] → push → GitHub Actions
# → logs en /var/log/inbox-watcher.log
tail -20 /var/log/yggdrasil-dew-maintenance.log
```
