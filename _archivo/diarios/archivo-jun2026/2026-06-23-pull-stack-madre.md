# Pull stack Madre — script descarga robusta

fecha: 2026-06-23
tags: [docker, ollama, open-webui, qdrant, madre, tmux, homelab]
estado: pendiente-ejecutar

---

## Objetivo

Descargar las 3 imágenes Docker de la Capa 2 (IA local) y Capa 4 (memoria vectorial) en Madre sin cortes de red.

## Imágenes a descargar

| # | Imagen | Puerto | Capa |
|---|--------|--------|------|
| 1 | `ollama/ollama:latest` | 11434 | IA local |
| 2 | `ghcr.io/open-webui/open-webui:main` | 3001 | IA local |
| 3 | `qdrant/qdrant:latest` | 6333 | Memoria vectorial |

## Procedimiento

```bash
# 1. Conectar a Madre
ssh varopc@<ip-madre-tailscale>

# 2. Abrir tmux sesión descargas
tmux new -s descargas

# 3. Crear script
nano pull-stack.sh
```

### Contenido pull-stack.sh

```bash
#!/bin/bash
echo "=== [1/3] Ollama ==="
docker pull ollama/ollama:latest

echo "=== [2/3] Open WebUI ==="
docker pull ghcr.io/open-webui/open-webui:main

echo "=== [3/3] Qdrant ==="
docker pull qdrant/qdrant:latest

echo "=== DONE — 3 imágenes listas ==="
```

```bash
# 4. Ejecutar
chmod +x pull-stack.sh
./pull-stack.sh

# 5. Dejar en background
Ctrl+B → D
```

## Trabajo paralelo

Abrir segunda sesión tmux mientras descarga:

```bash
ssh varopc@<ip-madre-tailscale>
tmux new -s trabajo
```

## Siguiente paso tras descarga

- Levantar docker-compose con Ollama + Open WebUI + Qdrant
- Verificar puertos: 11434, 3001, 6333
- Conectar Open WebUI a Ollama
- Pull modelos: `ollama pull qwen2.5:3b` + `ollama pull bge-m3`
