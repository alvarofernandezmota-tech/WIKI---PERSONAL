---
tipo: pendiente-investigacion
fecha: 2026-06-24
hora: "07:01"
status: pendiente
tags: [thdora, comandos, docker, ollama, arquitectura, pendiente]
priority: ALTA
---

# ❓ PENDIENTES — Comandos THDORA + Docker multi-Ollama

---

## Pregunta 1: Tipos de comandos en THDORA

> Hay que explorar qué tipos de comandos existen y cómo resolver cada caso.

Tipos a investigar:

| Tipo | Ejemplo | Necesita IA | Resolución |
|------|---------|-------------|------------|
| Consulta instantánea | /status /ram /cpu | ❌ No | subprocess / psutil |
| Control Docker | /up /down /restart | ❌ No | docker SDK o subprocess |
| Consulta con LLM | /pregunta /explica | ✅ Sí | Ollama API |
| Acción de negocio | reserva / cita | ✅ Sí | function calling |
| Alerta automática | RAM > 85% container caído | ❌ No | monitor + scheduler |
| Flujo conversacional | onboarding cliente | ✅ Sí | estado + Ollama |

**Pendiente:** Mapear todos los comandos actuales de THDORA y clasificarlos.
Ver repo THDORA para inventario real.

---

## Pregunta 2: ¿Dos Ollama en dos Docker = dos modelos simultáneos?

**Respuesta corta: SÍ, pero con condición de RAM.**

### Cómo funciona

```
Container ollama-A  →  carga qwen2.5:7b  →  reserva ~6.5 GB RAM
Container ollama-B  →  carga bge-m3      →  reserva ~0.6 GB RAM
────────────────────────────────────────────
Modelos:  7.1 GB + stack Docker ~4 GB = ~11 GB ✅ VIABLE
```

### La regla es simple

```
Suma de RAM de todos los modelos cargados
+ RAM del stack Docker activo
< 14 GB (margen de 2 GB para OS)
```

### Combinaciones viables en Madre (16 GB)

| ollama-A | ollama-B | Total modelos | ¿Viable? |
|----------|----------|---------------|----------|
| qwen2.5:7b (~6.5 GB) | bge-m3 (~0.6 GB) | ~7.1 GB | ✅ Sí |
| qwen2.5:7b (~6.5 GB) | nomic-embed (~0.3 GB) | ~6.8 GB | ✅ Sí |
| qwen2.5:7b (~6.5 GB) | qwen2.5:3b (~2 GB) | ~8.5 GB | ⚠️ Justo |
| qwen2.5:7b (~6.5 GB) | llama3.1:8b (~5 GB) | ~11.5 GB | ❌ NO |
| qwen2.5:7b (~6.5 GB) | qwen2.5:7b (~6.5 GB) | ~13 GB | ❌ NO |
| qwen2.5:14b (~9 GB) | cualquier cosa | >13 GB | ❌ NO |

### Config docker-compose para dos Ollama

```yaml
services:
  ollama-chat:
    image: ollama/ollama:latest
    ports: ["11434:11434"]
    volumes: ["./ollama_data:/root/.ollama"]
    environment:
      - OLLAMA_NUM_PARALLEL=1
      - OLLAMA_MAX_LOADED_MODELS=1
    deploy:
      resources:
        limits: { cpus: '3.0', memory: 8g }

  ollama-embeddings:
    image: ollama/ollama:latest
    ports: ["11435:11434"]   # puerto diferente!
    volumes: ["./ollama_embed_data:/root/.ollama"]
    environment:
      - OLLAMA_NUM_PARALLEL=1
      - OLLAMA_MAX_LOADED_MODELS=1
    deploy:
      resources:
        limits: { cpus: '1.0', memory: 2g }
```

### Cómo lo usa THDORA

```python
# THDORA sabe a qué Ollama llamar según la tarea
OLLAMA_CHAT_URL      = "http://ollama-chat:11434"      # qwen2.5:7b
OLLAMA_EMBED_URL     = "http://ollama-embeddings:11434" # bge-m3

# Conversación con cliente
response = ollama_chat.chat(model="qwen2.5:7b", ...)

# Embeddings para RAG / Qdrant
vector = ollama_embed.embeddings(model="bge-m3", ...)
```

---

## Pendientes concretos que salen de esto

- [ ] Inventariar todos los comandos actuales de THDORA (ver su repo)
- [ ] Clasificar cada comando por tipo (tabla de arriba)
- [ ] Decidir separación ollama-chat + ollama-embeddings en Madre
- [ ] Probar config dos Ollama cuando qwen2.5:7b esté descargado
- [ ] Medir RAM real con ambos containers activos

---

## Nota

El código de todo esto va en **repo THDORA**, no aquí.
Aquí solo la documentación, decisiones y arquitectura.
