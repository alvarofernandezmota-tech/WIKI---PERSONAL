---
tags: [docker, madre, homelab, estado, ollama, qdrant, webui]
fecha: 2026-06-23
hora: 20:38
estado: descargando
tipo: estado-instalacion
ruta-obsidian: inbox/2026-06-23-estado-descargas-madre.md
---

# Estado descargas Madre — 2026-06-23 20:38

## Imágenes descargando AHORA

| Servicio | Imagen | Puerto | Estado |
|---|---|---|---|
| Ollama | `ollama/ollama:latest` | 11434 | ⏳ Descargando |
| Open WebUI | `ghcr.io/open-webui/open-webui:main` | 3000 | ⏳ Descargando |
| Qdrant | `qdrant/qdrant:latest` | 6333 / 6334 | ⏳ Descargando |

## Siguiente paso inmediato

1. Usar prompt `[[inbox/2026-06-23-prompt-claude-ecosistema-docker]]` con Claude
2. Claude crea repo `ollama-stack` mientras descargan
3. Cuando terminen: `docker compose up -d`
4. Pull modelos: qwen2.5:7b, qwen2.5:3b, bge-m3

## Comandos de verificación post-instalación

```bash
# Verificar servicios
docker ps

# Verificar Ollama
curl http://localhost:11434/api/tags

# Verificar Qdrant
curl http://localhost:6333/healthz

# Ver logs
docker compose logs -f
```

## URLs de acceso (cuando estén levantados)

- Open WebUI: http://localhost:3000
- Ollama API: http://localhost:11434
- Qdrant Dashboard: http://localhost:6333/dashboard

## Wikilinks
- [[ollama/README]]
- [[setup/servidor/docker-stack]]
- [[inbox/2026-06-23-prompt-claude-ecosistema-docker]]
