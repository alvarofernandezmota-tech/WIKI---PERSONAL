#!/bin/bash
# pull-stack.sh — descarga robusta con retries y sin HTTP/2 reset
# Generado por Perplexity 2026-06-23
# Uso: bash pull-stack-robusto.sh

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

echo ""
echo "=== DONE — 3 imágenes listas ==="
docker images | grep -E 'ollama|open-webui|qdrant'
