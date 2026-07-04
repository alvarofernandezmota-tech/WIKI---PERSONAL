# Mega-Script Descarga Nocturna

**Fecha:** 2026-06-24  
**Cuándo lanzar:** Justo antes de dormir, después de verificar Fase 1 levantada

---

## Script completo

```bash
#!/bin/bash
# scripts/descarga-nocturna.sh
# Lanzar antes de dormir. Descarga todo mientras duermes.
# Duración estimada: 4-8 horas según conexión

set -e
LOG="/tmp/descarga-nocturna-$(date +%Y%m%d-%H%M).log"
exec > >(tee -a $LOG) 2>&1

echo "========================================"
echo " DESCARGA NOCTURNA — $(date)"
echo "========================================"

# === MODELOS OLLAMA ===
echo "[1/5] Descargando modelos Ollama..."
docker exec ollama ollama pull qwen2.5:14b
docker exec ollama ollama pull qwen2.5:7b
docker exec ollama ollama pull llama3.1:8b
docker exec ollama ollama pull bge-m3
docker exec ollama ollama pull nomic-embed-text
docker exec ollama ollama pull mistral:7b
echo "✅ Modelos Ollama completados"

# === IMÁGENES DOCKER FASE 1 ===
echo "[2/5] Imágenes Fase 1 — IA Local..."
docker pull ollama/ollama:latest
docker pull ghcr.io/open-webui/open-webui:main
docker pull qdrant/qdrant:latest
echo "✅ Fase 1 completada"

# === IMÁGENES DOCKER FASE 2 ===
echo "[3/5] Imágenes Fase 2 — Gestión y OSINT..."
docker pull portainer/portainer-ce:latest
docker pull louislam/uptime-kuma:latest
docker pull smicallef/spiderfoot:latest
docker pull n8nio/n8n:latest
echo "✅ Fase 2 completada"

# === IMÁGENES DOCKER FASE 3 ===
echo "[4/5] Imágenes Fase 3 — Infraestructura..."
docker pull jc21/nginx-proxy-manager:latest
docker pull vaultwarden/server:latest
docker pull containrrr/watchtower:latest
docker pull gitea/gitea:latest
docker pull lscr.io/linuxserver/code-server:latest
echo "✅ Fase 3 completada"

# === IMÁGENES DOCKER FASE 4 ===
echo "[5/5] Imágenes Fase 4 — LiteLLM + Agentes..."
docker pull ghcr.io/berriai/litellm:main-latest
docker pull flowiseai/flowise:latest
docker pull postgres:15-alpine
docker pull redis:7-alpine
echo "✅ Fase 4 completada"

echo ""
echo "========================================"
echo " DESCARGA COMPLETADA — $(date)"
echo " Log guardado en: $LOG"
echo "========================================"
docker exec ollama ollama list
docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.Size}}'
```

---

## Cómo lanzarlo

```bash
# Darle permisos
chmod +x scripts/descarga-nocturna.sh

# Lanzar en background (sobrevive si cierras terminal)
nohup ./scripts/descarga-nocturna.sh &

# O con tmux/screen
tmux new -s descarga
./scripts/descarga-nocturna.sh
# Ctrl+B D para desconectar
```

## Verificar por la mañana

```bash
# Ver log
cat /tmp/descarga-nocturna-*.log | tail -50

# Ver modelos
docker exec ollama ollama list

# Ver imágenes
docker images
```
