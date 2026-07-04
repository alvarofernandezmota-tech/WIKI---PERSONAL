---
tags: [inbox, agentes, claude, gemini, investigacion, rag, pendiente-migrar]
fecha: 2026-06-23
estado: pendiente-migrar
destino-1: agentes/claude-sonnet-4.6.md
destino-2: agentes/gemini-2.5-pro.md
relacionado-anterior: [[inbox/2026-06-23-ollama-rag-investigacion]]
relacionado-siguiente:
ruta-obsidian: inbox/2026-06-23-actualizacion-claude-gemini.md
---

# Actualización Fichas Claude + Gemini — Sesión RAG 2026-06-23

> Migrar a `agentes/claude-sonnet-4.6.md` y `agentes/gemini-2.5-pro.md`
> cuando se revisen y validen los cambios.

---

## Claude Sonnet 4.6 — Cambios a incorporar

### Nuevo campo: Capacidades demostradas en investigación técnica

En la sesión de hoy Claude demostró capacidad de análisis técnico profundo para hardware específico:
- Analizó trade-offs de LLMs para GTX 1060 6GB con tabla comparativa real
- Identificó bug crítico de BM25 (no persiste entre reinicios) que Gemini no mencionó
- Dio solución con código concreto (pickle persistencia)
- Recomendó Groq API como modo potente (aprovechando key existente en thdora)
- Identificó RRF como fusión correcta vs extend() directo

### Nuevo campo: Cuadro comparativo vs Gemini (RAG)

| Aspecto | Claude | Gemini | Quién acertó |
|---|---|---|---|
| LLM recomendado | qwen2.5:3b | qwen2.5:3b | Ambos ✅ |
| Embeddings | bge-m3 | nomic (por VRAM) | Gemini más práctico ✅ |
| ChromaDB | Quedarse | Migrar a LanceDB | Claude más conservador ✅ |
| Bug BM25 | Sí lo detectó | No lo mencionó | Claude ✅ |
| Modo potente | Groq API | qwen2.5:14b offload | Claude más eficiente ✅ |

### Actualizar en ficha
- `fecha-actualizacion: 2026-06-23`
- Tags: añadir `investigacion-tecnica`, `rag`, `ollama`
- Nuevo apartado: **Úsos demostrados en investigación RAG**
- Protocolo actualizado: Claude investiga RAG + documenta → Perplexity sube

---

## Gemini 2.5 Pro — Cambios a incorporar

### Nuevo campo: Capacidades demostradas en investigación técnica

- Analizó correctamente el impacto de VRAM en la elección de embedding model
- Introdujo LanceDB como alternativa a ChromaDB (Claude no lo mencionó)
- Propuso Markdown-Aware Chunking con inyección de metadata como prefijo
- Recomendó qwen2.5:14b con layer offloading para modo potente local
- Más pragmático en hardware constraints que Claude

### Nuevo campo: Cuadro comparativo vs Claude (RAG)

| Aspecto | Gemini | Claude | Quién acertó |
|---|---|---|---|
| VRAM awareness | Alto — consideró coexistencia LLM+embed | Menos detallado | Gemini ✅ |
| ChromaDB | Propuso LanceDB | Quedarse | Gemini más visionario |
| Bug BM25 | No lo detectó | Sí | Claude ✅ |
| Chunking | Más detallado con prefijo metadata | Básico | Gemini ✅ |
| Modo potente | qwen2.5:14b offload local | Groq API | Depende del contexto |

### Actualizar en ficha
- `fecha-actualizacion: 2026-06-23`
- Tags: añadir `investigacion-tecnica`, `rag`, `hardware-aware`
- Nuevo apartado: **Úsos demostrados en investigación RAG**
- Nota: Gemini es más preciso en análisis de hardware constraints

---

## Aprendizaje del flujo de investigación paralela

Usar Claude y Gemini en paralelo para la misma pregunta técnica es muy efectivo:

```
Misma pregunta → Claude + Gemini simultáneo
        ↓
Sintetizar diferencias (Perplexity)
        ↓
Inbox con síntesis
        ↓
Codigo actualizado en repo
```

- Donde coinciden → certeza alta, implementar
- Donde difieren → analizar trade-off + decidir + documentar por qué

---

## Checklist de migración

- [ ] Actualizar `agentes/claude-sonnet-4.6.md` con apartado investigación RAG
- [ ] Actualizar `agentes/gemini-2.5-pro.md` con apartado investigación RAG
- [ ] Añadir tabla comparativa Claude vs Gemini en `agentes/README.md`
- [ ] Mover esta nota a `agentes/sesiones/2026-06-23-rag-investigacion.md`
