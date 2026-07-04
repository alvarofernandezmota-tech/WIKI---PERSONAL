---
tags: [inbox, fase3, n8n, headscale, gitea, code-server, docker]
fecha: 2026-06-24
destino: setup/servidor/batcueva-fase3.md
estado: planificado
---

# Batcueva Fase 3 — Completa

> Ejecutar cuando Fase 2 este estable.
> Servicios avanzados: automatizacion + self-hosted infra.

---

## n8n — Automatizacion workflows

```yaml
  n8n:
    image: n8nio/n8n:latest
    container_name: n8n
    restart: always
    ports:
      - "5678:5678"
    environment:
      - N8N_HOST=0.0.0.0
      - N8N_PORT=5678
      - WEBHOOK_URL=http://100.91.112.32:5678
      - N8N_ENCRYPTION_KEY=cambiar_esto_32chars
    volumes:
      - n8n_data:/home/node/.n8n
```

Usos en el ecosistema:
- Cuando llega nota a inbox/ -> notificacion Telegram
- Cada domingo -> generar resumen semanal con Ollama
- Monitor servicios -> alerta si caen

---

## Headscale — Tailscale self-hosted

```yaml
  headscale:
    image: headscale/headscale:latest
    container_name: headscale
    restart: always
    ports:
      - "8085:8080"
    volumes:
      - headscale_config:/etc/headscale
      - headscale_data:/var/lib/headscale
    command: serve
```

```bash
# Config minima
mkdir -p ~/.config/headscale
cat > ~/.config/headscale/config.yaml << 'EOF'
server_url: http://100.91.112.32:8085
listen_addr: 0.0.0.0:8080
metrics_listen_addr: 0.0.0.0:9090
grpc_listen_addr: 0.0.0.0:50443
ip_prefixes:
  - 100.64.0.0/10
EOF

# Crear namespace y obtener key
docker exec headscale headscale namespaces create alvaro
docker exec headscale headscale preauthkeys create --namespace alvaro --reusable --expiration 999d
```

---

## Gitea — GitHub self-hosted

```yaml
  gitea:
    image: gitea/gitea:latest
    container_name: gitea
    restart: always
    ports:
      - "3003:3000"
      - "2222:22"
    environment:
      - USER_UID=1000
      - USER_GID=1000
      - GITEA__database__DB_TYPE=sqlite3
    volumes:
      - gitea_data:/data
```

Uso: mirror de yggdrasil-dew + repos privados sin depender de GitHub.

---

## Code Server — VSCode en browser

```yaml
  code-server:
    image: lscr.io/linuxserver/code-server:latest
    container_name: code-server
    restart: always
    ports:
      - "8443:8443"
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Madrid
      - PASSWORD=cambiar_esto
      - SUDO_PASSWORD=cambiar_esto
    volumes:
      - code_server_config:/config
      - ~/yggdrasil-dew:/config/workspace/cerebro
```

Acceso: http://localhost:8443 — VSCode completo con acceso al cerebro.

---

## Volumes Fase 3
```yaml
  n8n_data:
  headscale_config:
  headscale_data:
  gitea_data:
  code_server_config:
```

## UFW Fase 3
```bash
sudo ufw allow from 192.168.1.0/24 to any port 5678  # n8n
sudo ufw allow from 100.64.0.0/10 to any port 5678
sudo ufw allow from 192.168.1.0/24 to any port 3003  # gitea
sudo ufw allow from 100.64.0.0/10 to any port 3003
sudo ufw allow from 192.168.1.0/24 to any port 8443  # code-server
sudo ufw allow from 100.64.0.0/10 to any port 8443
sudo ufw reload
```

---
_Destino: setup/servidor/batcueva-fase3.md_
