---
tags: [setup, servidor, docker, homelab, batcueva, madre]
fecha: 2026-06-23
estado: en-curso
ruta-obsidian: setup/servidor/docker-stack.md
---

# 🐳 Docker Stack — Batcueva (Madre)

> Servicios Docker corriendo en Madre.
> Repo con docker-compose: [[alvarofernandezmota-tech/ollama-stack]] (pendiente crear)

## Ley: Infraestructura != Producto

Este doc = conocimiento y estado del homelab.
El docker-compose real vive en repos GitHub propios.

## Servicios — Fase 1 (instalando ahora)

| Servicio | Imagen | Puerto | Repo | Estado |
|---|---|---|---|---|
| Ollama | `ollama/ollama:latest` | 11434 | ollama-stack | ⏳ descargando |
| Open WebUI | `ghcr.io/open-webui/open-webui:main` | 3000 | ollama-stack | ⏳ descargando |
| Qdrant | `qdrant/qdrant:latest` | 6333/6334 | ollama-stack | ⏳ descargando |

## Servicios — Fase 2 (esta semana)

| Servicio | Puerto | Propósito |
|---|---|---|
| SpiderFoot | 5001 | OSINT |
| Portainer | 9000 | UI Docker |
| Uptime Kuma | 3002 | Monitor servicios |

## Servicios — Fase 3 (futuro)

| Servicio | Propósito |
|---|---|
| n8n | Automatización workflows |
| Pi-hole | DNS + bloqueo anuncios |
| Headscale | VPN self-hosted |
| Gitea | GitHub propio |
| Code Server | VSCode en browser |

## Comandos útiles

```bash
docker ps                          # ver servicios corriendo
docker compose up -d               # levantar stack
docker compose logs -f             # ver logs
curl http://localhost:11434/api/tags  # verificar Ollama
curl http://localhost:6333/healthz    # verificar Qdrant
```

## Ver también
- [[ollama/README]]
- [[inbox/2026-06-23-estado-descargas-madre]]
- [[inbox/2026-06-23-prompt-claude-ecosistema-docker]]
