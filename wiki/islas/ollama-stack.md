# 🧠 Ollama Stack

> Motor de inferencia IA local del ecosistema. Corre en Madre sobre GTX 1060 6GB.

| Campo | Valor |
|---|---|
| **Repo principal** | [`ollama-stack`](https://github.com/alvarofernandezmota-tech/ollama-stack) |
| **Máquina** | Madre · GPU GTX 1060 6GB |
| **Estado operativo** | ✅ Activo |
| **Última auditoría** | 2026-07-16 |

---

## 📌 Qué es

Ollama es el servidor de modelos de lenguaje locales del ecosistema. Corre en Docker en Madre, usando la GPU GTX 1060 6GB para inferencia. Open WebUI proporciona la interfaz de chat local. Es la base sobre la que se construirá el sistema de agentes autónomos (Fase 7).

---

## 🛠️ Stack y modelos

| Componente | Estado | Notas |
|---|---|---|
| Ollama server | ✅ Activo | Docker en Madre |
| Open WebUI | ✅ Activo | Interfaz chat local |
| GPU GTX 1060 6GB | ✅ Activo | Aceleración CUDA |

```
Modelos cargados:
  Llama 3       — activo
  Mistral       — activo
  Phi-3         — activo
```

---

## 📊 Estado actual

| Servicio | Estado | Última verificación |
|---|---|---|
| Ollama server | ✅ Activo | 2026-07-16 |
| Open WebUI | ✅ Activo | 2026-07-16 |
| Inferencia GPU | ✅ Activo | 2026-07-16 |
| Agentes IA locales | 🔴 No iniciado | Fase 7 |

---

## 🗺️ Relaciones con el ecosistema

```
Ollama Stack
  ├── corre en → Madre
  ├── alimenta → local-brain (RAG)
  ├── futuro → thea-ia (agentes)
  └── futuro → TOKI (bot Telegram con LLM local)
```

---

## 🔗 DEW — Issues y decisiones

### Issues activas

| Issue | Título | Prioridad |
|---|---|---|
| [#49](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/49) | Decisión arquitectural `thea-ia` — afecta integración agentes | 🟡 Pendiente |

### ADRs relevantes

| ADR | Decisión | Estado |
|---|---|---|
| — | Ollama como motor de inferencia local (vs cloud) | ✅ Vigente |
| — | GTX 1060 6GB suficiente para modelos 7B | ✅ Vigente |

---

## 📝 Decisiones pendientes

- [ ] Definir arquitectura de agentes locales (depende de decisión `thea-ia` — DEW #49)
- [ ] Integrar Ollama con local-brain (RAG pipeline)
- [ ] Evaluar modelos para tareas específicas del ecosistema

---

_Actualizado: 2026-07-16 · Perplexity-MCP_
