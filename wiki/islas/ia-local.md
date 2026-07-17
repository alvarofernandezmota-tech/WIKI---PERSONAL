---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-13
actualizado: 2026-07-18
ruta: wiki/islas/ia-local.md
tags: [ia, ollama, rag, investigacion, agentes, poc, modelos, local]
status: auditado
repos: [local-brain, ollama-stack, investigacion-ia, thea-ia]
---

# 🤖 IA Local — Motor, RAG e Investigación

> Capa completa de inteligencia artificial local del ecosistema.
> Incluye motor de inferencia (Ollama), pipeline RAG (local-brain) y laboratorio de investigación (investigacion-ia).

| Campo | Valor |
|---|---|
| **Repos** | [`ollama-stack`](https://github.com/alvarofernandezmota-tech/ollama-stack) · [`local-brain`](https://github.com/alvarofernandezmota-tech/local-brain) · [`investigacion-ia`](https://github.com/alvarofernandezmota-tech/investigacion-ia) · [`thea-ia`](https://github.com/alvarofernandezmota-tech/thea-ia) |
| **Máquina** | Madre · GTX 1060 6GB (CUDA) |
| **Estado operativo** | 🟡 Parcial — Qdrant #71 + thea-ia #49 pendientes |
| **Última auditoría** | 2026-07-18 |

---

## 📌 Qué es

Todo el stack de IA local unificado en tres capas:

- **Motor de inferencia** — Ollama corriendo en Docker en Madre con GPU GTX 1060 6GB. Modelos: Llama 3, Mistral, Phi-3. Open WebUI como interfaz de chat local.
- **RAG pipeline** — `local-brain` con Qdrant como vector DB. Capa de memoria y recuperación de conocimiento del ecosistema.
- **Laboratorio de investigación** — `investigacion-ia`: PoCs de agentes (LangChain, AutoGen, CrewAI), benchmarks de modelos, prototipos antes de pasar a producción.

---

## 🛠️ Stack completo

| Componente | Repo | Estado | Notas |
|---|---|---|---|
| Ollama server | `ollama-stack` | ✅ Activo | Docker + CUDA GTX 1060 |
| Open WebUI | `ollama-stack` | ✅ Activo | Interfaz chat local |
| RAG pipeline | `local-brain` | ✅ Activo | LangChain + Qdrant |
| Vector DB (Qdrant) | `local-brain` | ✅ Activo | Issue #71 falso positivo |
| PoCs e investigación | `investigacion-ia` | 🟡 Sin auditar | Ver pendientes |
| Core agentes Python | `thea-ia` | 🔴 Decisión pendiente | DEW #49 |
| Orquestador agentes | — | 🔴 No iniciado | Fase 7 |

### Modelos cargados en Ollama

```
  Llama 3       — activo
  Mistral       — activo
  Phi-3         — activo
```

---

## 🔬 Pipeline de investigación → producción

```
investigacion-ia (PoC)
  → THDORA-PERSONAL  (bot Telegram — producción)
  → n8n              (flujos automatización — producción)
  → local-brain      (si necesita RAG)
```

---

## 📊 Estado actual

| Servicio | Estado | Última verificación |
|---|---|---|
| Ollama server | ✅ Activo | 2026-07-16 |
| Open WebUI | ✅ Activo | 2026-07-16 |
| Inferencia GPU | ✅ Activo | 2026-07-16 |
| local-brain RAG | ✅ Activo | 2026-07-16 |
| Qdrant | ✅ Activo | 2026-07-16 (issue #71 falso positivo) |
| thea-ia | 🔴 Bloqueado | Pendiente ADR — DEW #49 |
| investigacion-ia | 🟡 Sin auditar | Pendiente sesión terminal |

---

## 🗺️ Relaciones con el ecosistema

```
IA Local
  ├── corre en         → Madre (Docker + GPU)
  ├── alimenta         → THDORA (bot Telegram via LiteLLM)
  ├── alimenta         → TOKI (memoria + RAG)
  ├── investiga en     → investigacion-ia (PoCs → producción)
  └── futuro           → orquestador agentes (Fase 7)
```

---

## 🔗 DEW — Issues y decisiones

| Issue | Título | Prioridad |
|---|---|---|
| [#49](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/49) | Decisión arquitectural `thea-ia`: archivar / fusionar / librería | 🟡 Pendiente |
| [#71](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/71) | Qdrant unhealthy (falso positivo) | 🟡 Verificar terminal |

### ADRs relevantes

| ADR | Decisión | Estado |
|---|---|---|
| — | Ollama como motor de inferencia local (vs cloud) | ✅ Vigente |
| — | Qdrant como vector DB local | ✅ Vigente |
| — | GTX 1060 6GB suficiente para modelos 7B | ✅ Vigente |
| — | LangGraph para orquestación de agentes | ⏳ En evaluación |

---

## 📝 Decisiones pendientes

- [ ] Resolver decisión arquitectural `thea-ia` — DEW #49 (A: archivar / B: fusionar local-brain / C: librería)
- [ ] Verificar Qdrant healthcheck real — DEW #71 (terminal)
- [ ] Auditar PoCs en `investigacion-ia` — qué pasa a producción, qué se archiva
- [ ] Integrar Ollama ↔ local-brain (RAG pipeline completo)
- [ ] Conectar RAG pipeline con Open WebUI
- [ ] Diseñar orquestador de agentes locales (Fase 7)
- [ ] Evaluar LiteLLM como proxy unificado (THDORA + scripts → mismo endpoint)

---

> ⚠️ **Fusionada 2026-07-18** — originalmente tres islas separadas: `ia-local.md` + `ollama-stack.md` + `investigacion-ia.md`. Contenido unificado sin pérdida.

_Actualizado: 2026-07-18 · Perplexity-MCP · F21 fusión_
