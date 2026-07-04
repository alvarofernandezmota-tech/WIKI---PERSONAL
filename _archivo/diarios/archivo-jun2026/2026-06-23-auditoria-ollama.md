---
tags: [auditoria, ollama, modelos, estructura, refactor]
fecha: 2026-06-23
estado: pendiente-ejecutar
ruta-obsidian: inbox/2026-06-23-auditoria-ollama.md
---

# Auditoría `ollama/` — plan de mejora

> Generado en sesión 2026-06-23 · objetivo: escalar al nivel de `agentes/`

## Estado actual

### ✅ Lo que está bien
- `README.md` — existe
- Ficha individual por modelo — 10 modelos documentados
- Naming consistente `nombre-modelo.md`

### 🔴 Problemas
- Fichas muy cortas (400-900 bytes) vs nivel `agentes/` (2-3KB)
- Faltan modelos nuevos decididos hoy: `qwen2.5:3b` y `bge-m3`
- No hay subcarpetas por categoría
- Falta `GUIA-SELECCION.md` consolidada (está en inbox pero no en carpeta)
- Fichas sin frontmatter YAML estandarizado

## Modelos actuales

| Modelo | Tamaño ficha | Categoría |
|---|---|---|
| `qwen2.5-72b.md` | 614b | chat |
| `deepseek-r1.md` | 897b | razonamiento |
| `codegemma-starcoder2.md` | 841b | código |
| `llama3.3-70b.md` | 507b | chat |
| `llama3.2-3b.md` | 505b | chat-ligero |
| `mistral-7b.md` | 523b | chat |
| `phi4.md` | 525b | chat |
| `gemma3.md` | 489b | chat |
| `nomic-embed-text.md` | 459b | embeddings |
| `deepseek-r1.md` | 897b | razonamiento |

## Modelos a añadir (decididos hoy)

- [ ] `qwen2.5-3b.md` — modelo principal Madre (rápido, 3B)
- [ ] `bge-m3.md` — embeddings multilingue para RAG
- [ ] `open-webui.md` — interfaz web Ollama

## Estructura objetivo

```
ollama/
  README.md                    ← índice + guía rápida
  GUIA-SELECCION.md            ← cuándo usar cada modelo
  chat/
    qwen2.5-72b.md
    qwen2.5-3b.md
    llama3.3-70b.md
    llama3.2-3b.md
    mistral-7b.md
    phi4.md
    gemma3.md
  razonamiento/
    deepseek-r1.md
  codigo/
    codegemma-starcoder2.md
  embeddings/
    bge-m3.md
    nomic-embed-text.md
  interfaces/
    open-webui.md
```

## Frontmatter YAML estándar por ficha

```yaml
---
tags: [ollama, modelo, chat|embeddings|codigo|razonamiento]
nombre: qwen2.5:3b
tipo: chat-ligero
parametros: 3B
vram-minima: 4GB
caso-uso-principal: "Tareas rápidas en Madre"
estado: activo|pendiente|descartado
fecha: YYYY-MM-DD
---
```

## Pasos a ejecutar

- [ ] Crear subcarpetas: `chat/`, `razonamiento/`, `codigo/`, `embeddings/`, `interfaces/`
- [ ] Mover fichas existentes a su categoría
- [ ] Ampliar fichas a nivel `agentes/` (2-3KB con casos de uso reales)
- [ ] Crear `qwen2.5-3b.md`, `bge-m3.md`, `open-webui.md`
- [ ] Mover `inbox/2026-06-23-ollama-guia-seleccion.md` → `ollama/GUIA-SELECCION.md`
- [ ] Mover `inbox/2026-06-23-ollama-rag-investigacion.md` → `ollama/RAG-INVESTIGACION.md`
- [ ] Añadir frontmatter YAML a todos
- [ ] Actualizar `ollama/README.md` con wikilinks por categoría

## Wikilinks Obsidian desde HOME.md

```
[[ollama/README]] — Modelos Ollama locales
[[ollama/GUIA-SELECCION]] — Cuándo usar cada modelo
```
