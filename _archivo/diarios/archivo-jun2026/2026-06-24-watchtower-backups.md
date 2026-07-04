---
tags: [inbox, watchtower, backups, restic, docker, automatizacion]
fecha: 2026-06-24
destino: setup/servidor/watchtower-backups.md
estado: listo-para-ejecutar
---

# Watchtower + Backups — Automatizacion Madre

---

## Watchtower — Auto-update Docker images

```yaml
  watchtower:
    image: containrrr/watchtower:latest
    container_name: watchtower
    restart: always
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - WATCHTOWER_CLEANUP=true
      - WATCHTOWER_SCHEDULE=0 0 4 * * *   # cada dia a las 4am
      - WATCHTOWER_NOTIFICATIONS=shoutrrr
      # Notificacion Telegram (opcional):
      # - WATCHTOWER_NOTIFICATION_URL=telegram://TOKEN@telegram?chats=CHAT_ID
    command: --interval 86400
```

---

## Backups con restic — repo yggdrasil-dew

```bash
# Instalar
sudo pacman -S --noconfirm restic

# Inicializar repo backup local
restic init --repo /backup/yggdrasil

# Backup manual
restic -r /backup/yggdrasil backup ~/yggdrasil-dew

# Automatizar con cron/systemd timer
sudo tee /etc/systemd/system/backup-cerebro.service << 'EOF'
[Unit]
Description=Backup yggdrasil-dew

[Service]
Type=oneshot
ExecStart=/usr/bin/restic -r /backup/yggdrasil backup /home/varo/yggdrasil-dew
EOF

sudo tee /etc/systemd/system/backup-cerebro.timer << 'EOF'
[Unit]
Description=Timer backup cerebro diario

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
EOF

sudo systemctl enable --now backup-cerebro.timer
sudo systemctl list-timers | grep backup
```

## Backup volumenes Docker

```bash
# Script backup volumenes criticos
cat > ~/backup-docker-volumes.sh << 'EOF'
#!/bin/bash
DATE=$(date +%Y-%m-%d)
BACKUP_DIR="/backup/docker-volumes/$DATE"
mkdir -p $BACKUP_DIR

for vol in ollama open-webui qdrant_storage; do
  docker run --rm \
    -v ${vol}:/source:ro \
    -v $BACKUP_DIR:/backup \
    alpine tar czf /backup/${vol}.tar.gz -C /source .
  echo "Backup $vol OK"
done

echo "Backups en $BACKUP_DIR"
EOF

chmod +x ~/backup-docker-volumes.sh
~/backup-docker-volumes.sh
```

---
_Destino: setup/servidor/watchtower-backups.md_
