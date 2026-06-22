---
tags: [agente, ia, llm, embeddings, local, especializado, semantica]
fecha-actualizacion: 2026-06-22
---

# 🔢 Especializados: Embeddings — Búsqueda Semántica y Memoria Vectorial Local

## Modelos
- **nomic-embed-text** (Nomic AI)
- **mxbai-embed-large** (MixedBread AI)

## Qué son los embeddings
Convierten texto en vectores numéricos de alta dimensión que capturan el significado semántico.
Permiten búsqueda por similitud conceptual en lugar de por palabras clave exactas.

## Casos de uso principales
- **RAG (Retrieval-Augmented Generation):** Búsqueda semántica en tu repo/docs antes de pasar contexto a un LLM
- **Base de datos vectorial local:** Indexar yggdrasil-dew para búsqueda inteligente
- **Memoria de agente:** Recuperar notas relevantes por significado, no por título
- **Deduplicación:** Detectar notas duplicadas o muy similares en el vault

## Ventajas sobre búsqueda por palabras clave
- Encuentra "SSH sin contraseña" aunque el texto diga "autenticación por clave pública"
- Agrupa conceptualmente notas relacionadas aunque usen vocabulario diferente

## Coste
- **Gratuito:** Ejecutados localmente via Ollama

## Privacidad
- **Absoluta:** Todo procesado en local — los embeddings de tus documentos no salen de tu máquina

## Hardware
- **RAM mínima:** 1-2 GB — muy ligeros, funcionan perfectamente en Acer
- **Velocidad:** Muy rápidos — diseñados para procesar documentos en batch

```bash
# nomic-embed-text
ollama pull nomic-embed-text

# mxbai-embed-large
ollama pull mxbai-embed-large

# Uso via API Ollama
curl http://localhost:11434/api/embeddings -d '{"model": "nomic-embed-text", "prompt": "SSH sin contraseña"}'
```

## Integración futura en el ecosistema
- Indexar inbox/ y agentes/ de yggdrasil-dew para búsqueda semántica local
- Base para sistema RAG local sobre el segundo cerebro

---
_Ver también: [[agentes/especializados-audio]] · [[agentes/especializados-ocr-vision]]_
