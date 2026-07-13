---
tipo: isla
repo: ollama-stack
creado: 2026-07-13
actualizado: 2026-07-13
tags: [ia, ollama, llm, litellm, qdrant, rag]
status: auditado-parcial
---

# Isla: Ollama Stack

> Stack de IA local del ecosistema Yggdrasil. Modelos LLM corriendo en Madre sin depender de APIs externas.

---

## Qué es

Repo [`ollama-stack`](https://github.com/alvarofernandezmota-tech/ollama-stack) — stack Docker completo para inferencia local:
- **Ollama** — servidor de modelos LLM (llama3, mistral, codellama...)
- **Open WebUI** — interfaz web para chat con modelos
- **LiteLLM** — gateway proxy unificado (expone OpenAI API compatible)
- **Qdrant** — base de datos vectorial para RAG

---

## Estado actual

| Componente | Estado | Puerto |
|-----------|--------|--------|
| Ollama | 🟡 Sin verificar | 11434 |
| Open WebUI | 🟡 Sin verificar | 3000 |
| LiteLLM | 🟡 Sin verificar | 4000 |
| Qdrant | 🟡 Sin verificar | 6333 |

> ⚠️ Pendiente: auditoría terminal (#55 en DEW). No hay confirmación de que todos los servicios estén healthy.

---

## Conexiones en el ecosistema

- **Madre** → corre todos los servicios Docker
- **THDORA** → puede invocar modelos Ollama vía LiteLLM
- **local-brain** → RAG usa Qdrant como vector store
- **n8n** → puede llamar a LiteLLM para flujos con IA
- **investigacion-ia** → PoCs usan Ollama como backend

---

## Seguridad

- [ ] Verificar que Ollama NO está expuesto en interfaz pública
- [ ] Verificar que LiteLLM tiene autenticación (LITELLM_MASTER_KEY)
- [ ] Verificar que Qdrant no tiene acceso sin auth desde exterior
- [ ] LITELLM_MASTER_KEY fue expuesta (HAL-008 #45) — confirmar rotación

---

## Pendientes

- `AUDIT-012` (#55 DEW) — auditoría terminal de todo el stack
- Verificar modelos activos vs zombi (`ollama list`)
- Documentar endpoint LiteLLM en `madre.md`

---

_Creado: 2026-07-13 · Perplexity-MCP · Pendiente auditoría terminal_
