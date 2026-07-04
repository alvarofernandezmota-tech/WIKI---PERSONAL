# Ecosistema Yggdrasil — Mapa completo

> Este documento es el índice de todo. Si existe algo en el ecosistema, está referenciado aquí.

---

## La idea central

El ecosistema es una infraestructura personal que combina:
- Un servidor casero (**Madre**) que corre servicios 24/7
- Herramientas de IA que se usan desde el **Acer** (portátil) y el **iPhone**
- Repos de GitHub que organizan cada capa del sistema
- Agentes IA (web + local) que asisten en todo el trabajo

**Este repo (`yggdrasil-dew`) es el índice.** No contiene código de producción. Contiene el mapa de dónde está todo y cómo se conecta.

---

## Mapa de repos

### Núcleo del ecosistema

| Repo | Visibilidad | Propósito | Estado |
|---|---|---|---|
| [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) | Público | **CEREBRO TÉCNICO** — índice, docs, diarios, wiki | ✅ Activo |
| [yggdrasil-secops](https://github.com/alvarofernandezmota-tech/yggdrasil-secops) | Privado | Seguridad activa: OSINT propio, canary tokens, tripwires | 🟡 En construcción |

### Agentes e IA

| Repo | Visibilidad | Propósito | Estado |
|---|---|---|---|
| [THDORA-PERSONAL](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL) | Público | Bot Telegram personal + FastAPI + Ollama. Asistente + citas | 🟡 En construcción |
| [thea-ia](https://github.com/alvarofernandezmota-tech/thea-ia) | Público | Origen del proyecto IA. Python. | 🟤 Pausado / revisar |
| [local-brain](https://github.com/alvarofernandezmota-tech/local-brain) | Privado | Cerebro cognitivo local: Ollama, pgvector, RAG, embeddings | 🟡 En construcción |
| [ollama-stack](https://github.com/alvarofernandezmota-tech/ollama-stack) | Privado | Stack Ollama: modelos LLM, Open WebUI, LiteLLM, Qdrant | 🟡 En construcción |

### Herramientas y stacks

| Repo | Visibilidad | Propósito | Estado |
|---|---|---|---|
| [ai-toolkit](https://github.com/alvarofernandezmota-tech/ai-toolkit) | Público | Stack IA open source: Claude Code + OpenRouter + Ollama + n8n | 🟡 Activo |
| [osint-stack](https://github.com/alvarofernandezmota-tech/osint-stack) | Privado | Stack OSINT: Spiderfoot, pipelines de investigación | 🟡 En construcción |

### Proyectos personales / laboratorio

| Repo | Visibilidad | Propósito | Estado |
|---|---|---|---|
| [personal](https://github.com/alvarofernandezmota-tech/personal) | Público⚠️ | Vida personal: finanzas, gym, salud, diario — **debería ser privado** | ⚠️ Revisar privacidad |
| [impresion-3d](https://github.com/alvarofernandezmota-tech/impresion-3d) | Público | Anycubic Photon V1: configs, diarios, resinas | ✅ Activo |
| [image-calculator](https://github.com/alvarofernandezmota-tech/image-calculator) | Público | App Python: OCR + operaciones sobre imágenes | ✅ Completo |

### Perfil

| Repo | Visibilidad | Propósito |
|---|---|---|
| [alvarofernandezmota-tech](https://github.com/alvarofernandezmota-tech/alvarofernandezmota-tech) | Público | README de perfil GitHub |

---

## Cómo se conecta todo

```
[Acer / iPhone]
      │
      ├─── SSH / Web ───► [Madre - Servidor]
      │                        │
      │              ┌────────┼──────────┐
      │              │ Ollama  │ Docker  │
      │              │ local   │ stacks  │
      │              │ LLMs    │ OSINT   │
      │              │ RAG     │ Thdora  │
      │              └────────┴──────────┘
      │
      └─── IAs web ──► Claude / Perplexity / Copilot / ChatGPT
                       (asistentes de trabajo diario)
```

---

## Flujo de trabajo típico

1. **Idea / tarea** → entra en `inbox/` de este repo
2. **Trabajo** → se hace desde Acer con IAs web (Claude, Perplexity)
3. **Despliegue** → va a Madre vía SSH o GitHub Actions (cuando existan)
4. **Documentación** → vuelve a `yggdrasil-dew` como diario o doc
5. **Consulta local** → Ollama en Madre responde desde contexto vectorizado

---

*Última actualización: 2026-07-05*
