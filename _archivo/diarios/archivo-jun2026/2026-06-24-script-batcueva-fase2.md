---
tags: [inbox, batcueva, fase2, portainer, uptime-kuma, spiderfoot, script]
fecha: 2026-06-24
estado: listo-cuando-toque
destino: setup/servidor/scripts/batcueva-fase2.sh
---

# Script Batcueva Fase 2 — Portainer + Uptime Kuma + SpiderFoot

> Ejecutar DESPUES de que Fase 1 (Ollama stack) este estable y verificado.
> Imagenes ya descargadas por script-descarga-completa.md

---

## Compose ampliado — anadir estos servicios

```yaml
  portainer:
    image: portainer/portainer-ce:latest
    container_name: portainer
    restart: always
    ports:
      - "9000:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:9000"]
      interval: 30s
      timeout: 10s
      retries: 3

  uptime-kuma:
    image: louislam/uptime-kuma:latest
    container_name: uptime-kuma
    restart: always
    ports:
      - "3002:3001"
    volumes:
      - uptime_kuma:/app/data
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3001"]
      interval: 30s
      timeout: 10s
      retries: 3

  spiderfoot:
    image: smicallef/spiderfoot:latest
    container_name: spiderfoot
    restart: always
    ports:
      - "5001:5001"
    volumes:
      - spiderfoot_data:/home/spiderfoot/.spiderfoot
```

## Volumes a anadir
```yaml
  portainer_data:
  uptime_kuma:
  spiderfoot_data:
```

## Comandos

```bash
# Anadir servicios al compose y levantar
docker compose up -d portainer uptime-kuma
docker compose ps

# Verificar
curl -s http://localhost:9000 && echo "Portainer OK"
curl -s http://localhost:3002 && echo "Uptime Kuma OK"
```

## Post-instalacion Uptime Kuma

Configurar monitores en http://localhost:3002:
- Ollama: http://ollama:11434/api/tags
- Open WebUI: http://open-webui:8080/health  
- Qdrant: http://qdrant:6333/healthz
- Portainer: http://portainer:9000
- Tailscale: ping 100.86.119.102 (Acer)

---
_Destino: setup/servidor/scripts/batcueva-fase2.sh + docker-compose.yml ampliado_
