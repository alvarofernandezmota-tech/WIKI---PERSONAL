---
tags: [inbox, docker-compose, completo, todas-fases, madre]
fecha: 2026-06-24
destino: setup/servidor/docker-compose-completo.yml
estado: referencia-futura
---

# Docker Compose Final — Todas las Fases

> Referencia del compose completo cuando todo este instalado.
> NO ejecutar todo a la vez. Ir por fases.

```yaml
version: '3.8'

services:

  # === FASE 1 — IA LOCAL ===
  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    restart: always
    ports:
      - "11434:11434"
    environment:
      - OLLAMA_NUM_THREADS=6
      - OLLAMA_NUM_PARALLEL=1
      - OLLAMA_MAX_LOADED_MODELS=2
      - OLLAMA_KEEP_ALIVE=24h
    volumes:
      - ollama:/root/.ollama
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:11434/api/tags"]
      interval: 30s
      timeout: 10s
      retries: 3

  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: open-webui
    restart: always
    ports:
      - "3001:8080"
    environment:
      - OLLAMA_BASE_URL=http://ollama:11434
      - VECTOR_DB=qdrant
      - QDRANT_URI=http://qdrant:6333
      - ENABLE_RAG=true
    volumes:
      - open-webui:/app/backend/data
    depends_on:
      ollama:
        condition: service_healthy
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
      interval: 30s
      timeout: 10s
      retries: 3

  qdrant:
    image: qdrant/qdrant:latest
    container_name: qdrant
    restart: always
    ports:
      - "6333:6333"
    volumes:
      - qdrant_storage:/qdrant/storage
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:6333/healthz"]
      interval: 30s
      timeout: 5s
      retries: 3

  # === FASE 2 — GESTION Y OSINT ===
  portainer:
    image: portainer/portainer-ce:latest
    container_name: portainer
    restart: always
    ports:
      - "9000:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data

  uptime-kuma:
    image: louislam/uptime-kuma:latest
    container_name: uptime-kuma
    restart: always
    ports:
      - "3002:3001"
    volumes:
      - uptime_kuma:/app/data

  spiderfoot:
    image: smicallef/spiderfoot:latest
    container_name: spiderfoot
    restart: always
    ports:
      - "5001:5001"
    volumes:
      - spiderfoot_data:/home/spiderfoot/.spiderfoot

  # === FASE 3 — INFRAESTRUCTURA ===
  nginx-proxy-manager:
    image: jc21/nginx-proxy-manager:latest
    container_name: nginx-proxy-manager
    restart: always
    ports:
      - "80:80"
      - "443:443"
      - "81:81"
    volumes:
      - npm_data:/data
      - npm_letsencrypt:/etc/letsencrypt

  vaultwarden:
    image: vaultwarden/server:latest
    container_name: vaultwarden
    restart: always
    ports:
      - "8200:80"
    environment:
      - WEBSOCKET_ENABLED=true
      - SIGNUPS_ALLOWED=false
    volumes:
      - vaultwarden_data:/data

  watchtower:
    image: containrrr/watchtower:latest
    container_name: watchtower
    restart: always
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - WATCHTOWER_CLEANUP=true
      - WATCHTOWER_SCHEDULE=0 0 4 * * *

  n8n:
    image: n8nio/n8n:latest
    container_name: n8n
    restart: always
    ports:
      - "5678:5678"
    volumes:
      - n8n_data:/home/node/.n8n

  gitea:
    image: gitea/gitea:latest
    container_name: gitea
    restart: always
    ports:
      - "3003:3000"
      - "2222:22"
    volumes:
      - gitea_data:/data

  code-server:
    image: lscr.io/linuxserver/code-server:latest
    container_name: code-server
    restart: always
    ports:
      - "8443:8443"
    environment:
      - TZ=Europe/Madrid
      - PASSWORD=cambiar_esto
    volumes:
      - code_server_config:/config

volumes:
  ollama:
  open-webui:
  qdrant_storage:
  portainer_data:
  uptime_kuma:
  spiderfoot_data:
  npm_data:
  npm_letsencrypt:
  vaultwarden_data:
  n8n_data:
  headscale_config:
  headscale_data:
  gitea_data:
  code_server_config:
```

---
_Referencia completa. Ejecutar por fases. Ver inbox/2026-06-24-script-batcueva-fase*.md_
