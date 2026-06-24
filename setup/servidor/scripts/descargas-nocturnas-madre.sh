#!/bin/bash
# =============================================================================
# descargas-nocturnas-madre.sh
# Descarga en background todos los modelos Ollama + imágenes Docker pendientes.
# Seguro para ejecutar con Acer apagado — usa nohup, todo queda en Madre.
#
# USO:
#   bash descargas-nocturnas-madre.sh
#   tail -f /tmp/descargas-madre.log   ← para seguir el progreso
# =============================================================================

LOG="/tmp/descargas-madre.log"

echo "" > "$LOG"
echo "======================================" >> "$LOG"
echo " DESCARGAS NOCTURNAS MADRE" >> "$LOG"
echo " $(date)" >> "$LOG"
echo "======================================" >> "$LOG"

# -----------------------------------------------------------------------------
# 1. MODELOS OLLAMA — CPU only (Madre sin GPU)
#    Orden: embeddings primero (pequeños, críticos para RAG), luego LLMs
# -----------------------------------------------------------------------------
OLLAMA_MODELS=(
  "nomic-embed-text"   # 274 MB — embeddings ligeros (crítico local-brain)
  "bge-m3"             # 1.2 GB — embeddings multilingüe (crítico RAG)
  "qwen2.5:7b"         # 4.7 GB — LLM general Madre (ya tiene 3b)
  "qwen2.5:14b"        # 9.0 GB — LLM razonamiento Madre
  "llama3.1:8b"        # 4.7 GB — fallback open source
  "mistral:7b"         # 4.1 GB — alternativa ligera
)

echo "" >> "$LOG"
echo "--- OLLAMA MODELS ---" >> "$LOG"

for MODEL in "${OLLAMA_MODELS[@]}"; do
  echo "[$(date +%H:%M:%S)] Iniciando descarga: $MODEL" >> "$LOG"
  ollama pull "$MODEL" >> "$LOG" 2>&1
  if [ $? -eq 0 ]; then
    echo "[$(date +%H:%M:%S)] ✅ OK: $MODEL" >> "$LOG"
  else
    echo "[$(date +%H:%M:%S)] ❌ ERROR: $MODEL" >> "$LOG"
  fi
done

# -----------------------------------------------------------------------------
# 2. DOCKER IMAGES — pre-pull de Fase 3 y 4
#    Así el docker-compose up es instantáneo cuando toque levantarlas
# -----------------------------------------------------------------------------
DOCKER_IMAGES=(
  "n8nio/n8n:latest"                        # Fase 3 — workflows
  "ghcr.io/paperless-ngx/paperless-ngx"     # Fase 3 — documentos
  "vaultwarden/server:latest"               # Fase 3 — passwords
  "jc21/nginx-proxy-manager:latest"         # Fase 4 — proxy inverso
  "containrrr/watchtower:latest"            # Fase 4 — auto-update
  "spiderfoot/spiderfoot:latest"            # osint-stack — OSINT
  "ghcr.io/theharvester/theharvester"       # osint-stack — emails/subdomains
)

echo "" >> "$LOG"
echo "--- DOCKER IMAGES ---" >> "$LOG"

for IMAGE in "${DOCKER_IMAGES[@]}"; do
  echo "[$(date +%H:%M:%S)] docker pull: $IMAGE" >> "$LOG"
  docker pull "$IMAGE" >> "$LOG" 2>&1
  if [ $? -eq 0 ]; then
    echo "[$(date +%H:%M:%S)] ✅ OK: $IMAGE" >> "$LOG"
  else
    echo "[$(date +%H:%M:%S)] ❌ ERROR: $IMAGE" >> "$LOG"
  fi
done

# -----------------------------------------------------------------------------
# 3. RESUMEN FINAL
# -----------------------------------------------------------------------------
echo "" >> "$LOG"
echo "======================================" >> "$LOG"
echo " RESUMEN FINAL" >> "$LOG"
echo " $(date)" >> "$LOG"
echo "======================================" >> "$LOG"
echo "" >> "$LOG"
echo "Modelos Ollama instalados:" >> "$LOG"
ollama list >> "$LOG" 2>&1
echo "" >> "$LOG"
echo "Imágenes Docker descargadas:" >> "$LOG"
docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" >> "$LOG" 2>&1
echo "" >> "$LOG"
echo "✅ Script completado: $(date)" >> "$LOG"

echo "Script finalizado. Ver resultados:"
echo "  tail -50 $LOG"
