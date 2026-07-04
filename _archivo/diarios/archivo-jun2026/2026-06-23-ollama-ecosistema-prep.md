---
tipo: planificacion
fuente: perplexity
estado: pendiente
tema: ollama-ecosistema
tags:
  - ollama
  - ecosistema
  - obsidian
  - agentes
  - rag
  - setup
  - inbox
  - planificacion
---

# Preparación del ecosistema Ollama

## Contexto
Nota de planificación para preparar el ecosistema Ollama dentro de `yggdrasil-dew`, con Obsidian como fuente de verdad y la repo como destino final del conocimiento consolidado.

Todo lo relacionado con Ollama ya fue auditado y clasificado en la inbox el 2026-06-23.
Ver: [[inbox/2026-06-23-sesion-gemini-auditoria-inbox-perplexity]]

## Archivos ya documentados en inbox
- [[inbox/2026-06-23-auditoria-ollama]] — auditoría completa de modelos y estado.
- [[inbox/2026-06-23-ollama-rag-investigacion]] — investigación RAG con Ollama.
- [[inbox/2026-06-23-ollama-bge-m3]] — modelo de embeddings bge-m3.
- [[inbox/2026-06-23-ollama-guia-seleccion]] — guía de selección de modelos.
- [[inbox/2026-06-23-ollama-qwen2.5-3b]] — modelo qwen2.5 3b documentado.
- [[inbox/2026-06-23-ollama-qwen2.5-7b]] — modelo qwen2.5 7b documentado.
- [[inbox/2026-06-23-v4-pendiente-ollama]] — tareas pendientes para ollama v4.
- [[inbox/2026-06-23-local-brain-setup]] — setup del cerebro local con Ollama.

## Objetivo del ecosistema
Conectar Ollama como motor local de inferencia y RAG dentro del ecosistema completo:

```
Obsidian (vault)
    │
    ├── Ollama (inferencia local)
    │     ├── bge-m3 (embeddings RAG)
    │     ├── qwen2.5-3b (modelo ligero)
    │     └── qwen2.5-7b (modelo completo)
    │
    ├── Open WebUI (interfaz local)
    ├── OpenCode (coding assistant)
    ├── LiteLLM proxy (router de modelos)
    └── THDORA (agente central)
```

## Componentes del ecosistema

| componente | rol | estado |
|---|---|---|
| Ollama | motor local de inferencia | activo |
| bge-m3 | embeddings para RAG | pendiente de configurar |
| qwen2.5-3b | modelo ligero local | pendiente de validar |
| qwen2.5-7b | modelo completo local | pendiente de validar |
| Open WebUI | interfaz local | activo |
| OpenCode | coding assistant | activo |
| LiteLLM proxy | router de modelos | activo |
| THDORA | agente central | en desarrollo |
| Obsidian | fuente de verdad | activo |

## Decisiones clave pendientes
- Confirmar modelo de embeddings: `bge-m3` vs otros.
- Definir pipeline RAG completo: Obsidian → embeddings → Ollama → respuesta.
- Integrar Ollama con Open WebUI como interfaz principal.
- Documentar configuración de LiteLLM con modelos locales Ollama.
- Decidir qué modelos corren en Madre y cuáles en varopc.

## Flujo RAG objetivo
```
nota en Obsidian
    │
    ↓
embeddings con bge-m3 (Ollama)
    │
    ↓
vector store local
    │
    ↓
consulta desde Open WebUI o THDORA
    │
    ↓
respuesta con contexto real del vault
```

## Reglas del ecosistema
- Ollama es el motor local: inferencia sin coste, sin red.
- Todo lo que pueda correr local, corre en Ollama.
- Gemini, Claude y Perplexity son para escalar, documentar e investigar.
- Mistral es para ejecución y código.
- THDORA coordina el ecosistema completo.

## Próximos pasos
1. Mover archivos de Ollama de `inbox/` a `agentes/`.
2. Configurar bge-m3 como modelo de embeddings.
3. Validar pipeline RAG con una nota de prueba de Obsidian.
4. Documentar la configuración en `setup/local-brain.md`.
5. Actualizar `CONTEXT.md` al finalizar.
6. Vincular esta nota desde `MASTER-PENDIENTES.md`.

## Links relacionados
- [[inbox/2026-06-23-ollama-rag-investigacion]]
- [[inbox/2026-06-23-local-brain-setup]]
- [[inbox/2026-06-23-auditoria-ollama]]
- [[inbox/2026-06-23-sesion-gemini-auditoria-inbox-perplexity]]
