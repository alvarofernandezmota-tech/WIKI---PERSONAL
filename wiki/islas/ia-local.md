---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-10
actualizado: 2026-07-13T10:17:00+02:00
ruta: wiki/islas/ia-local.md
tags: [isla, ia, ollama, llm, qdrant, rag, local, litellm, gpu]
status: vigente
repos: [ollama-stack, local-brain, ai-toolkit]
---

# Isla: IA Local

> Stack de inteligencia artificial local corriendo en Madre.
> GPU GTX 1060 — Ollama, LiteLLM, Qdrant, RAG, Open WebUI.
> *Absorbe el contenido de cerebro.md (archivado 2026-07-13).*

---

## Arquitectura del stack IA

```
┌─────────────────────────────────────────────────┐
│               CAPA DE INTERFAZ                       │
│  Open WebUI (chat UI)   THDORA / n8n (bots/flujos)   │
└──────────────────┬───────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────┐
│              CAPA DE ROUTING                        │
│   LiteLLM (puerto 4000) — OpenAI API compatible      │
│   Expone todos los modelos bajo una API unificada     │
└──────────────────┬───────────────────────────┘
                  │
          ┌──────┤
          │       │
          ▼       ▼
┌─────────┐ ┌───────────────────────────────────────┐
│  Ollama  │ │        CAPA RAG (local-brain)         │
│:11434   │ │  Qdrant:6333 + pgvector (PostgreSQL)   │
│GTX 1060 │ │  Embeddings → contexto → prompt final  │
└─────────┘ └───────────────────────────────────────┘
```

---

## Repos del stack IA

| Repo | Qué contiene | Coge de | Da a |
|------|-------------|---------|------|
| [ollama-stack](https://github.com/alvarofernandezmota-tech/ollama-stack) | Docker compose Ollama+LiteLLM+Qdrant+WebUI | Madre (GPU+Docker) | THDORA, n8n, local-brain |
| [local-brain](https://github.com/alvarofernandezmota-tech/local-brain) | RAG, embeddings, pgvector | ollama-stack (Qdrant) | THDORA (contexto RAG) |
| [ai-toolkit](https://github.com/alvarofernandezmota-tech/ai-toolkit) | Stack IA open source público | — | Referencia / showcase |
| [investigacion-ia](https://github.com/alvarofernandezmota-tech/investigacion-ia) | PoCs agentes, benchmarks | ollama-stack (LLM) | THDORA (si madura) |

---

## Modelos activos (pendiente verificar con `ollama list`)

| Modelo | Uso | RAM aprox. |
|--------|-----|------------|
| llama3:8b | Chat general | 4.5 GB |
| mistral:7b | Código + razonamiento | 4.1 GB |
| nomic-embed-text | Embeddings RAG | 0.3 GB |

⚠️ Pendiente: `ollama list` en Madre para verificar qué modelos hay realmente.

---

## 🔗 Conexiones con otras islas

| Isla | Relación |
|------|----------|
| [madre.md](madre.md) | Madre provee hardware (GPU GTX 1060 + Docker) para todo el stack |
| [ollama-stack.md](ollama-stack.md) | Detalle de configuración del stack Docker |
| [thdora.md](thdora.md) | THDORA consume LiteLLM para respuestas IA |
| [orquestador.md](orquestador.md) | n8n llama a LiteLLM en flujos automatizados |
| [investigacion-ia.md](investigacion-ia.md) | PoCs usan Ollama como backend de experimentación |

---

## Estado — 2026-07-13

| Componente | Estado | Bloqueado por |
|-----------|--------|---------------|
| Ollama | 🟡 No verificado | Acceso SSH Madre |
| LiteLLM | 🟡 No verificado | #45 (KEY expuesta) |
| Qdrant | 🟡 No verificado | Acceso SSH |
| local-brain RAG | 🟡 No auditado | [local-brain #1](https://github.com/alvarofernandezmota-tech/local-brain/issues/1) |

---

_Actualizado: 2026-07-13 10:17 CEST · Perplexity-MCP · Absorbe cerebro.md (archivado)_
