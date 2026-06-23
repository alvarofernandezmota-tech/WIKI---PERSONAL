---
tipo: instalacion
fuente: perplexity
estado: pendiente
tema: dockers-llm
tags:
  - docker
  - llm
  - ollama
  - open-webui
  - litellm
  - setup
  - madre
  - instalacion
---

# Instalación de los 3 dockers LLM

> Generado por Perplexity el 2026-06-23 21:20 CEST.
> Objetivo: levantar el ecosistema LLM local completo en Madre con 3 contenedores Docker.

## Los 3 dockers

| # | Servicio | Imagen | Puerto | Rol |
|---|---|---|---|---|
| 1 | Ollama | `ollama/ollama` | `11434` | Motor local de inferencia |
| 2 | Open WebUI | `ghcr.io/open-webui/open-webui` | `3000` | Interfaz chat local |
| 3 | LiteLLM Proxy | `ghcr.io/berriai/litellm` | `4000` | Router de modelos (local + cloud) |

## Prerequisitos en Madre

```bash
# Docker y docker compose instalados
docker --version
docker compose version

# GPU disponible (opcional, mejora rendimiento)
nvidia-smi  # si hay GPU NVIDIA

# Espacio en disco
df -h  # mínimo 20GB libres para modelos
```

## docker-compose.yml completo

```yaml
version: '3.8'

services:

  # --- DOCKER 1: Ollama ---
  ollama:
    image: ollama/ollama
    container_name: ollama
    restart: unless-stopped
    ports:
      - "11434:11434"
    volumes:
      - ollama_data:/root/.ollama
    environment:
      - OLLAMA_HOST=0.0.0.0
    # Descomentar si hay GPU NVIDIA:
    # deploy:
    #   resources:
    #     reservations:
    #       devices:
    #         - driver: nvidia
    #           count: all
    #           capabilities: [gpu]

  # --- DOCKER 2: Open WebUI ---
  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: open-webui
    restart: unless-stopped
    ports:
      - "3000:8080"
    volumes:
      - open_webui_data:/app/backend/data
    environment:
      - OLLAMA_BASE_URL=http://ollama:11434
      - WEBUI_SECRET_KEY=cambia_esto_por_clave_segura
    depends_on:
      - ollama

  # --- DOCKER 3: LiteLLM Proxy ---
  litellm:
    image: ghcr.io/berriai/litellm:main-latest
    container_name: litellm
    restart: unless-stopped
    ports:
      - "4000:4000"
    volumes:
      - ./litellm-config.yaml:/app/config.yaml
    command: ["--config", "/app/config.yaml", "--port", "4000"]
    environment:
      - LITELLM_MASTER_KEY=sk-cambia_esto
    depends_on:
      - ollama

volumes:
  ollama_data:
  open_webui_data:
```

## litellm-config.yaml

```yaml
model_list:
  - model_name: qwen2.5-3b
    litellm_params:
      model: ollama/qwen2.5:3b
      api_base: http://ollama:11434

  - model_name: qwen2.5-7b
    litellm_params:
      model: ollama/qwen2.5:7b
      api_base: http://ollama:11434

  - model_name: bge-m3
    litellm_params:
      model: ollama/bge-m3
      api_base: http://ollama:11434

  # Modelos cloud (requieren API keys en .env)
  # - model_name: gemini-flash
  #   litellm_params:
  #     model: gemini/gemini-1.5-flash
  #     api_key: os.environ/GEMINI_API_KEY

litellm_settings:
  drop_params: true
  set_verbose: false
```

## Comandos de instalación paso a paso

```bash
# 1. Crear directorio de trabajo en Madre
mkdir -p ~/stacks/llm && cd ~/stacks/llm

# 2. Crear archivos de configuración
# (copiar docker-compose.yml y litellm-config.yaml de arriba)

# 3. Levantar los 3 dockers
docker compose up -d

# 4. Verificar que están corriendo
docker compose ps

# 5. Descargar modelos en Ollama
docker exec -it ollama ollama pull qwen2.5:3b
docker exec -it ollama ollama pull qwen2.5:7b
docker exec -it ollama ollama pull bge-m3

# 6. Verificar modelos descargados
docker exec -it ollama ollama list

# 7. Acceder a Open WebUI
# Abrir navegador en: http://madre.local:3000  (o IP de Madre)

# 8. Verificar LiteLLM
curl http://localhost:4000/health
```

## Verificación rápida post-instalación

```bash
# Test Ollama directo
curl http://localhost:11434/api/generate -d '{
  "model": "qwen2.5:3b",
  "prompt": "Hola, responde en español",
  "stream": false
}'

# Test LiteLLM proxy
curl http://localhost:4000/v1/chat/completions \
  -H "Authorization: Bearer sk-cambia_esto" \
  -H "Content-Type: application/json" \
  -d '{"model": "qwen2.5-3b", "messages": [{"role": "user", "content": "Hola"}]}'
```

## Acceso desde la red local

| Servicio | URL local |
|---|---|
| Ollama API | `http://madre.local:11434` |
| Open WebUI | `http://madre.local:3000` |
| LiteLLM Proxy | `http://madre.local:4000` |

## Mantenimiento

```bash
# Parar todo
docker compose down

# Actualizar imágenes
docker compose pull && docker compose up -d

# Ver logs
docker compose logs -f ollama
docker compose logs -f open-webui
docker compose logs -f litellm

# Limpiar modelos no usados
docker exec -it ollama ollama rm nombre-modelo
```

## Links relacionados
- [[agentes/ollama/2026-06-23-ollama-ecosistema-prep]]
- [[agentes/ollama/2026-06-23-auditoria-ollama]]
- [[setup/2026-06-23-local-brain-setup]]
- [[agentes/ollama/2026-06-23-ollama-guia-seleccion]]
- [[docs/decisiones/2026-06-23-decision-homelab-vs-proyectos]]
