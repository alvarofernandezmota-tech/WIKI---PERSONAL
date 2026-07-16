# 🤖 IA Local

> Capa de inteligencia artificial local del ecosistema: RAG, memoria, agentes y orquestación.

| Campo | Valor |
|---|---|
| **Repos principales** | [`local-brain`](https://github.com/alvarofernandezmota-tech/local-brain) · [`investigacion-ia`](https://github.com/alvarofernandezmota-tech/investigacion-ia) · [`thea-ia`](https://github.com/alvarofernandezmota-tech/thea-ia) |
| **Máquina** | Madre · GTX 1060 6GB |
| **Estado operativo** | ✅ Activo · decisión arquitectural pendiente |
| **Última auditoría** | 2026-07-16 |

---

## 📌 Qué es

Isla que agrupa toda la capa IA local del ecosistema: el sistema RAG (Retrieval-Augmented Generation) con Qdrant en `local-brain`, los PoCs e investigación en `investigacion-ia`, y el core Python de agentes en `thea-ia` (pendiente decisión arquitectural). Depende de `ollama-stack` como motor de inferencia.

---

## 🛠️ Stack y componentes

| Componente | Repo | Estado |
|---|---|---|
| RAG pipeline | `local-brain` | ✅ Activo |
| Vector DB (Qdrant) | `local-brain` | ✅ Activo |
| PoCs e investigación | `investigacion-ia` | ✅ Activo |
| Core agentes Python | `thea-ia` | 🟡 Decisión pendiente |
| Orquestador agentes | — | 🔴 No iniciado (Fase 7) |

---

## 📊 Estado actual

| Servicio | Estado | Última verificación |
|---|---|---|
| local-brain RAG | ✅ Activo | 2026-07-16 |
| Qdrant | ✅ Activo | 2026-07-16 |
| thea-ia | 🟡 Bloqueado | Pendiente ADR — DEW #49 |

---

## 🗺️ Relaciones con el ecosistema

```
IA Local
  ├── consume → ollama-stack (inferencia)
  ├── alimenta → TOKI (memoria + RAG)
  ├── futuro → orquestador agentes
  └── investiga en → investigacion-ia
```

---

## 🔗 DEW — Issues y decisiones

### Issues activas

| Issue | Título | Prioridad |
|---|---|---|
| [#49](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/49) | Decisión arquitectural `thea-ia`: archivar / fusionar / librería | 🟡 Pendiente |

### ADRs relevantes

| ADR | Decisión | Estado |
|---|---|---|
| — | Qdrant como vector DB local | ✅ Vigente |
| — | LangGraph para orquestación de agentes | ⏳ En evaluación |

---

## 📝 Decisiones pendientes

- [ ] Resolver decisión arquitectural `thea-ia` — DEW #49 (opciones: A archivar / B fusionar local-brain / C librería)
- [ ] Diseñar orquestador de agentes locales (Fase 7)
- [ ] Conectar RAG pipeline con Open WebUI

---

_Actualizado: 2026-07-16 · Perplexity-MCP_
