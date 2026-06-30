#!/bin/bash
# ==============================================================================
# SCRIPT: 05-fase7-ollama-pull.sh
# OBJETIVO: Descargar y verificar modelos en las instancias de Ollama.
# ==============================================================================

set -e

echo "[+] Iniciando Fase 7: Descarga de modelos de Inteligencia Artificial..."

# 1. Función para verificar si un contenedor está corriendo
verificar_contenedor() {
    local nombre=$1
    if [ "$(docker inspect -f '{{.State.Running}}' "$nombre" 2>/dev/null)" != "true" ]; then
        echo "[!] Error: El contenedor '$nombre' no está en ejecución."
        echo "[*] Por favor, ejecuta primero: bash scripts/04-fase2-start-batcueva.sh"
        exit 1
    fi
}

# Validar estado operativo de las instancias
verificar_contenedor "ollama"
verificar_contenedor "ollama-embeddings"

# 2. Descarga de LLM principal
echo "----------------------------------------------------------------------"
echo "[+] Descargando LLM principal en contenedor: ollama"
echo "[+] Modelo: llama3.1:8b"
echo "----------------------------------------------------------------------"
docker exec -i ollama ollama pull llama3.1:8b

# 3. Descarga de modelos de embeddings para RAG
echo "----------------------------------------------------------------------"
echo "[+] Descargando modelos de embeddings en contenedor: ollama-embeddings"
echo "----------------------------------------------------------------------"

echo "[+] Modelo 1/2: bge-m3..."
docker exec -i ollama-embeddings ollama pull bge-m3

echo "[+] Modelo 2/2: nomic-embed-text..."
docker exec -i ollama-embeddings ollama pull nomic-embed-text

# 4. Verificación final
echo "----------------------------------------------------------------------"
echo "[+] Verificación de modelos instalados:"
echo "----------------------------------------------------------------------"

echo "[*] Modelos en instancia general (ollama):"
docker exec -i ollama ollama list

echo ""
echo "[*] Modelos en instancia RAG (ollama-embeddings):"
docker exec -i ollama-embeddings ollama list

echo "----------------------------------------------------------------------"
echo "[+] Fase 7 completada. Modelos listos para producción."
