---
tipo: estado
fuente: perplexity
estado: en-progreso
tema: pull-stack-dockers
tags:
  - docker
  - pull
  - ollama
  - open-webui
  - qdrant
  - madre
  - tls
  - error
  - setup
---

# Estado descarga pull-stack — 2026-06-23 21:23 CEST

## Estado en tiempo real

| # | Imagen | Estado | Notas |
|---|---|---|---|
| 1 | `ollama/ollama:latest` | ❌ FALLIDO | `tls: bad record MAC` — fallo de red, reintentar |
| 2 | `ghcr.io/open-webui/open-webui:main` | ⏳ Descargando | fs layers en progreso |
| 3 | `qdrant/qdrant:latest` | ⏳ Pendiente | aún no iniciado |

## Error detectado: `tls: bad record MAC`

### Qué es
Error de integridad TLS durante la descarga de la capa de Ollama. No es un fallo del sistema ni de Docker, es corrupción de paquetes de red (conexión inestable, MTU, HTTP/2 reset).

### Fix rápido — reintentar solo Ollama

```bash
# Opción 1: retry directo
docker pull ollama/ollama:latest

# Opción 2: forzar HTTP/1.1 si sigue fallando
# Añadir al daemon.json:
# { "features": { "containerd-snapshotter": false } }
# y reiniciar: sudo systemctl restart docker

# Opción 3: pull con retries automáticos
for i in 1 2 3; do
  docker pull ollama/ollama:latest && break || echo "Retry $i fallido, esperando..."
  sleep 5
done
```

### Fix definitivo para pull-stack.sh — robusto con retries

```bash
#!/bin/bash
# pull-stack.sh — descarga robusta con retries y sin HTTP/2 reset
set -e

pull_with_retry() {
  local image=$1
  local max_retries=5
  local attempt=1
  while [ $attempt -le $max_retries ]; do
    echo "[Intento $attempt/$max_retries] Descargando $image..."
    docker pull "$image" && return 0
    echo "Fallo en intento $attempt. Esperando 10s..."
    sleep 10
    attempt=$((attempt + 1))
  done
  echo "ERROR: No se pudo descargar $image tras $max_retries intentos"
  return 1
}

echo "=== [1/3] Ollama ==="
pull_with_retry ollama/ollama:latest

echo "=== [2/3] Open WebUI ==="
pull_with_retry ghcr.io/open-webui/open-webui:main

echo "=== [3/3] Qdrant ==="
pull_with_retry qdrant/qdrant:latest

echo "=== DONE — 3 imágenes listas ==="
docker images | grep -E 'ollama|open-webui|qdrant'
```

## Script de verificación post-descarga

```bash
# Verificar que las 3 imágenes están descargadas
docker images | grep -E 'ollama|open-webui|qdrant'

# Resultado esperado:
# ollama/ollama          latest   ...
# ghcr.io/open-webui/open-webui   main   ...
# qdrant/qdrant          latest   ...
```

## Orden de arranque una vez descargadas

```bash
cd ~/stacks/llm
docker compose up -d
docker compose ps

# Descargar modelos
docker exec -it ollama ollama pull qwen2.5:3b
docker exec -it ollama ollama pull qwen2.5:7b
docker exec -it ollama ollama pull bge-m3
```

## Nota sobre Qdrant

El `docker-compose.yml` actual usa Open WebUI + Ollama + LiteLLM.
Si quieres Qdrant como vector store para RAG, añadir al compose:

```yaml
  qdrant:
    image: qdrant/qdrant:latest
    container_name: qdrant
    restart: unless-stopped
    ports:
      - "6333:6333"
      - "6334:6334"
    volumes:
      - qdrant_data:/qdrant/storage

volumes:
  qdrant_data:
```

## Acceso SSH activo
- Trabajo en remoto vía SSH confirmado.
- Actualizaciones en local al llegar a casa con `git pull`.
- Todo documentado en GitHub — cero pérdida de información.

## Links relacionados
- [[setup/2026-06-23-instalacion-3-dockers-llm]]
- [[agentes/ollama/2026-06-23-ollama-ecosistema-prep]]
- [[inbox/MASTER-PENDIENTES]]
