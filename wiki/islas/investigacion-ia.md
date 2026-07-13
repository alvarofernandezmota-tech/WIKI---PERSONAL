---
tipo: isla
repo: investigacion-ia
creado: 2026-07-13
actualizado: 2026-07-13
tags: [ia, investigacion, agentes, poc, arquitecturas]
status: auditado-parcial
---

# Isla: Investigación IA

> Laboratorio de IA del ecosistema. PoCs de agentes, análisis de modelos, arquitecturas experimentales y flujos multi-agente.

---

## Qué es

Repo [`investigacion-ia`](https://github.com/alvarofernandezmota-tech/investigacion-ia) — espacio de investigación aplicada:
- **PoCs de agentes** — experimentos con LangChain, AutoGen, CrewAI
- **Análisis de modelos** — benchmarks Ollama, comparativas
- **Arquitecturas de agentes** — diseño de sistemas multi-agente
- **Flujos experimentales** — prototipos antes de integrar en THDORA/n8n

---

## Conexiones en el ecosistema

- **ollama-stack** → backend LLM para todos los experimentos
- **THDORA** → destino final de agentes que maduran
- **n8n** → destino final de flujos que maduran
- **local-brain** → RAG y memoria vectorial

---

## Pipeline de madurez

```
investigacion-ia (PoC) → THDORA-PERSONAL (producción bot)
                       → n8n (producción flujo)
                       → local-brain (si necesita RAG)
```

---

## Estado actual

| Aspecto | Estado |
|---------|--------|
| Contenido real | 🟡 Sin auditar |
| Issues | ⚪ Ninguno |
| Conexión DEW | ⚪ Sin issue de auditoría |

---

## Pendientes

- Auditar qué PoCs existen y cuál es su estado
- Decidir qué pasa a producción y qué se archiva
- Documentar arquitecturas de agentes probadas

---

_Creado: 2026-07-13 · Perplexity-MCP · Pendiente auditoría_
