---
fecha: "2026-07-03"
tags: ["investigacion", "prompt", "bots", "agentes", "arquitectura", "ia"]
estado: "listo-para-usar"
---

# Prompt de investigación — Bots, Agentes y Clasificación de Conocimiento

Usa este prompt en Gemini, ChatGPT o cualquier LLM potente.

---

## PROMPT

```
Soy un desarrollador construyendo un ecosistema personal de automatización llamado Yggdrasil.
Tengo los siguientes componentes:

- yggdrasil-dew: second brain (docs, diarios, inbox, scripts)
- thdora: bot Telegram personal (citas, hábitos, IA con Groq/Ollama)
- yggdrasil-secops: seguridad y pentesting
- Madre: servidor Linux local (Ubuntu, Docker, Ollama)

La regla SINE define que todo lo que ocurre se documenta simultáneamente
en inbox + diario + docs permanente + GitHub Issue con label.

Necesito investigar lo siguiente:

## PREGUNTA 1 — Bot clasificador de conocimiento
Quiero un bot/agente que:
- Reciba archivos markdown del inbox
- Clasifique si la información vale (relevante, accionable) o no vale
- Si vale: sugiera el hueco correcto en docs/ y los labels/tags adecuados
- Si no vale: lo archive automáticamente
- Funcione con LLM local (Ollama llama3.1 o mistral)

¿Qué arquitectura recomiendas? ¿LangChain? ¿LlamaIndex? ¿Agente personalizado?
¿Cómo entrenar/prompt-engineer el clasificador para mi sistema de docs?

## PREGUNTA 2 — Cuántos bots son demasiados
Tengo planificados:
- thdora (bot personal Telegram — citas/hábitos) — EN PRODUCCIÓN
- thdora-guardian (monitorización Madre + alertas)
- thdora-dew (gestión repo + clasificador inbox)
- thdora-research (búsquedas + síntesis información)

¿Es razonable esta arquitectura? ¿Debería fusionar alguno?
¿Cómo gestionar la complejidad operacional de múltiples bots Docker?
¿Patrón orquestador vs bots independientes?

## PREGUNTA 3 — Clasificación automática de conocimiento
¿Qué técnicas existen para clasificación automática de notas/docs?
- RAG (Retrieval Augmented Generation)
- Embeddings + clasificación vectorial
- Few-shot prompting con ejemplos de mi propio sistema
- Reglas + LLM híbrido

¿Cuál tiene mejor ratio esfuerzo/resultado para un sistema personal?

## PREGUNTA 4 — Priorización correcta
Tengo deuda técnica en thdora (código zombie, bugs activos) Y quiero
construir bots nuevos. ¿Cómo priorizar correctamente sin caer en
dispersión? ¿Qué framework de decisión usarías?

## CONTEXTO TÉCNICO
- Stack: Python, FastAPI, python-telegram-bot, Docker, Ollama
- LLMs disponibles: llama3.1:8b, mistral:7b, codellama:7b (local)
- APIs externas: Groq (llama-3.1, llama-3.3), Telegram Bot API
- Git: GitHub, repos privadas
- SO: Ubuntu server (Madre) + uso móvil intensivo
```

---

## Qué esperar de la respuesta

- Arquitectura concreta para el clasificador
- Decisión fundamentada sobre cuántos bots
- Técnica de clasificación recomendada con código ejemplo
- Framework de priorización técnica

## Siguiente paso tras investigación

Resultados → `docs/investigacion/resultados-bots-agentes.md`
Decisiones → issues correspondientes en yggdrasil-dew
