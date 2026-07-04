# Script Descarga Global — Segunda Terminal

**Fecha:** 2026-06-24  
**Propósito:** Lanzar en segunda terminal para descarga robusta con reintentos

---

## Script completo

```bash
#!/bin/bash
# Guardar como: ~/run-descarga-ollama.sh
# Lanzar en segunda terminal mientras duermes

MODELOS=(
  "qwen2.5:3b"
  "qwen2.5:7b"
  "bge-m3"
  "nomic-embed-text"
)

echo "🚀 Iniciando descarga de modelos Ollama"
echo "Inicio: $(date)"

for modelo in "${MODELOS[@]}"; do
  echo "\n===== Descargando: $modelo ====="
  intentos=0
  while true; do
    intentos=$((intentos + 1))
    echo "Intento $intentos..."
    ollama pull "$modelo" && break
    echo "❌ Falló — reintentando en 15s..."
    sleep 15
  done
  echo "✅ $modelo descargado OK"
done

echo "\n🎉 TODOS LOS MODELOS DESCARGADOS"
echo "Fin: $(date)"
echo "\nVerificando:"
ollama list
```

## Lanzar

```bash
chmod +x ~/run-descarga-ollama.sh
~/run-descarga-ollama.sh
```

## Si quieres añadir qwen2.5:14b también

Añadir `"qwen2.5:14b"` al array MODELOS. Pesa ~9GB, asegúrate de tener espacio con `df -h`.
