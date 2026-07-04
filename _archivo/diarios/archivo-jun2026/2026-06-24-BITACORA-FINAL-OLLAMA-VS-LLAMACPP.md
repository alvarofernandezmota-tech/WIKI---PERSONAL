---
tipo: bitacora-debate
fecha: 2026-06-24
hora: "06:43"
fuente: grok-3
status: VEREDICTO-FINAL
tags: [ollama, llama.cpp, arquitectura, docker, thdora, veredicto, config]
priority: CRITICA
decision: ollama-domado-fase1 → llamacpp-fase2
---

# ✅ BITÁCORA FINAL CONSOLIDADA
**Yggdrasil-Dew — Homelab Madre**  
**Fecha:** 24 junio 2026  
**Tema:** Auditoría completa stack inferencia (Ollama vs llama.cpp) para i5-8400 + 16GB RAM

---

## 1. Validación del Hardware

- **CPU:** Intel Core i5-8400 — 6 núcleos físicos / 6 hilos (sin HT)
- **RAM:** 16 GB (crítico)
- **Límites reales:**
  - Máximo 3-4 hilos seguros para inferencia
  - Techo práctico: modelos **7B-8B**
  - 14B+ → swap constante → degradación grave → THDORA muere

---

## 2. Comparativa Técnica Final

| Aspecto | Ollama Domado | llama.cpp Puro | Recomendación |
|---------|--------------|----------------|---------------|
| RAM (Qwen 7B) | 6.5–8 GB | 5.5–6.5 GB | llama.cpp |
| Velocidad CPU-only | Más lento | Más rápido | llama.cpp |
| Facilidad de uso | ✅ Muy alta | ⚠️ Media | **Ollama** |
| Estabilidad 16GB | Aceptable con límites | Mejor | llama.cpp |
| Control recursos | Bueno | Excelente | llama.cpp |
| **Recomendado ahora** | ✅ **Sí (fase inicial)** | Sí (largo plazo) | **Ollama primero** |

---

## 3. Veredicto Final

> **FASE 1 (ahora):** Ollama Domado + Qwen2.5-7B  
> **FASE 2 (2-4 semanas):** Migrar a llama.cpp server puro  
> **HÍBRIDO simultáneo:** ❌ NO — OOM Killer garantizado

**Por qué Ollama primero:**
- `ollama pull` → probar modelos en segundos
- THDORA ya conectado → cero fricción
- Aprendes sin complicaciones de infraestructura

**Por qué migrar a llama.cpp después:**
- Ahorra 1-2 GB RAM
- Mayor velocidad tokens/s
- Control absoluto de cada parámetro
- Filosofía purista open-source

---

## 4. Config Lista para Aplicar AHORA

### docker-compose.yml (Ollama domado)

```yaml
version: '3.8'

services:
  qdrant:
    image: qdrant/qdrant:latest
    restart: unless-stopped
    ports: ["6333:6333"]
    volumes: ["./qdrant_data:/qdrant/storage"]
    deploy:
      resources:
        limits: { cpus: '1.5', memory: 2g }

  ollama:
    image: ollama/ollama:latest
    restart: unless-stopped
    ports: ["11434:11434"]
    volumes: ["./ollama_data:/root/.ollama"]
    environment:
      - OLLAMA_NUM_PARALLEL=1       # prohibido procesar 2 cosas a la vez
      - OLLAMA_MAX_LOADED_MODELS=1  # solo 1 modelo en RAM
      - OLLAMA_FLASH_ATTENTION=1    # optimización para CPU
    deploy:
      resources:
        limits: { cpus: '3.5', memory: 7g }
    command: serve

  thdora:
    build: ./thdora_bot
    restart: unless-stopped
    environment:
      - TELEGRAM_TOKEN=${THDORA_TOKEN}
      - OLLAMA_HOST=http://ollama:11434
    deploy:
      resources:
        limits: { cpus: '1.0', memory: 1g }
    depends_on: [ollama]
```

### Modelfile — Qwen2.5-7B para THDORA

```dockerfile
FROM qwen2.5:7b-instruct-q5_K_M

PARAMETER num_ctx 4096
PARAMETER num_thread 3
PARAMETER temperature 0.0
PARAMETER top_p 0.1
PARAMETER top_k 20
PARAMETER repeat_penalty 1.15

SYSTEM """
Eres un asistente técnico directo para homelab Arch Linux.
Responde de forma clara y técnica. No inventes datos.
"""
```

### Aplicar sin reiniciar THDORA

```bash
# Solo recargar Ollama con nueva config
docker compose up -d --no-deps ollama

# Crear el modelo con el Modelfile
ollama create thdora-qwen -f ./ollama/Modelfile-qwen2.5-7b

# Verificar
ollama list
curl http://localhost:11434/api/tags
```

---

## 5. Separación válida con dos contenedores

> La separación en 2 containers SÍ tiene sentido si los roles no solapan en RAM:

```yaml
ollama-chat:        # THDORA / conversación
  modelo: qwen2.5:7b  → ~6.5 GB RAM
  OLLAMA_MAX_LOADED_MODELS=1

ollama-embeddings:  # RAG / Qdrant
  modelo: bge-m3      → ~600 MB RAM
  OLLAMA_MAX_LOADED_MODELS=1
```

**Total:** ~7.1 GB + ~4 GB stack Docker = ~11 GB ✅ viable en 16 GB

> ❌ Lo que NO se puede: dos containers con modelo 7B+ cada uno simultáneamente

---

## 6. Hoja de Ruta

| Fase | Cuándo | Qué hacer |
|------|--------|-----------|
| **Fase 1** | Ahora | Aplicar docker-compose domado + Modelfile Qwen2.5-7B |
| **Fase 1b** | Esta semana | Separar ollama-chat y ollama-embeddings (bge-m3) |
| **Fase 2** | 2-4 semanas | Migrar a llama.cpp server puro en Arch |
| **Fase 2b** | Después | Compilar llama.cpp con optimizaciones AVX2 para i5-8400 |

---

## 7. Próximos artefactos a generar

- [ ] Código base THDORA para conectar con Ollama domado
- [ ] Comandos para compilar llama.cpp en Arch Linux (Fase 2)
- [ ] Script migración Ollama → llama.cpp sin downtime de THDORA
- [ ] Modelfile para Llama3.1-8B (alternativa a Qwen)
- [ ] docker-compose con separación ollama-chat + ollama-embeddings
