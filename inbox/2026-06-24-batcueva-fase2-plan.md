---
tags: [inbox, batcueva, fase2, docker, portainer, uptime-kuma, pendiente]
fecha: 2026-06-24
destino: setup/servidor/batcueva-fase2.md
estado: planificado
---

# Batcueva Fase 2 — Plan Docker

> Despues de Ollama stack estable. Anadir servicios de gestion y OSINT.
> Mover a setup/servidor/batcueva-fase2.md cuando toque.

---

## Servicios a anadir al docker-compose

### Portainer — UI Docker
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
```
Acceso: http://localhost:9000

### Uptime Kuma — Monitoreo servicios
```yaml
  uptime-kuma:
    image: louislam/uptime-kuma:latest
    container_name: uptime-kuma
    restart: always
    ports:
      - "3002:3001"
    volumes:
      - uptime_kuma:/app/data
```
Acceso: http://localhost:3002
Configurar monitores: Ollama, WebUI, Qdrant, Tailscale

### SpiderFoot — OSINT
```yaml
  spiderfoot:
    image: smicallef/spiderfoot:latest
    container_name: spiderfoot
    restart: always
    ports:
      - "5001:5001"
    volumes:
      - spiderfoot_data:/home/spiderfoot/.spiderfoot
```
Acceso: http://localhost:5001

---

## Orden de instalacion
1. Portainer primero — para gestionar el resto desde UI
2. Uptime Kuma — monitorear stack actual
3. SpiderFoot — cuando OSINT sea prioridad

## Anadir volumes al compose
```yaml
volumes:
  ollama:
  open-webui:
  qdrant_storage:
  portainer_data:
  uptime_kuma:
  spiderfoot_data:
```

---
_Aplicar en: setup/servidor/docker-compose.yml (ampliar) + setup/servidor/batcueva-fase2.md_
