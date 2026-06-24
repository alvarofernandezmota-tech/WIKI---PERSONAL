# 🤖 Agentes e IAs — Directorio Maestro
**Última actualización:** 2026-06-24  
**Propósito:** Mapa completo de todas las IAs y agentes del ecosistema yggdrasil-dew

---

## Estructura de esta carpeta

```
agentes/
├── README.md                    ← este fichero — mapa maestro
│
├── 🌐 IAs EXTERNAS (APIs / web)
│   ├── perplexity.md            ← Perplexity — investigación + GitHub MCP
│   ├── claude-sonnet-4.6.md     ← Claude — código complejo, razonamiento
│   ├── gemini-2.5-pro.md        ← Gemini Pro — contextos largos, PDFs
│   ├── gemini.md                ← Gemini general
│   ├── grok-3.md                ← Grok 3 — noticias X, tiempo real
│   ├── grok.md                  ← Grok general
│   ├── chatgpt-o3.md            ← ChatGPT o3 — razonamiento avanzado
│   ├── mistral-large-2.md       ← Mistral Large — alternativa europea
│   └── 2026-06-23-actualizacion-claude-gemini.md
│
├── 🏠 MODELOS LOCALES (Ollama en Madre)
│   ├── ollama-qwen2.5-72b.md    ← mejor modelo local potente
│   ├── ollama-llama3.3-70b.md   ← llama local grande
│   ├── ollama-llama3.2-3b.md    ← rápido, 3B para tareas simples
│   ├── ollama-mistral-7b.md     ← equilibrado
│   ├── ollama-deepseek-r1.md    ← razonamiento local
│   ├── ollama-gemma3.md         ← Google local
│   ├── ollama-phi4.md           ← Microsoft local, eficiente
│   ├── ollama-codegemma-starcoder2.md ← código local
│   ├── ollama-qwen2.5-72b.md
│   └── ollama/                  ← Modelfiles (erika, toki, etc.)
│
├── 👤 AGENTES PROPIOS
│   ├── toki-bot.md              ← TOKI — bot Telegram maestro
│   └── (Erika → ver ollama/)
│
├── 🛠️ TOOLS & ESPECIALIZADOS
│   ├── AI_TOOLKIT.md            ← toolkit completo de herramientas IA
│   ├── AGENT-SCRIPT.md          ← scripts de agentes
│   ├── especializados-audio.md  ← Whisper, TTS, audio
│   ├── especializados-embeddings.md ← bge-m3, RAG, vectores
│   ├── especializados-ocr-vision.md ← OCR, visión, imágenes
│   ├── opencode.md              ← OpenCode IDE IA
│   └── auditoria-ai-toolkit.md
│
└── 📝 PROMPTS
    ├── prompts.md               ← prompts maestros
    └── prompts/                 ← librería de prompts
```

---

## Cuándo usar cada IA — referencia rápida

| IA | Mejor para | Velocidad | Coste |
|---|---|---|---|
| **Perplexity** | Investigar + fuentes + GitHub MCP + documentar repo | ⚡⚡⚡ | Suscripción |
| **Claude Sonnet** | Código complejo, refactoring, análisis largo | ⚡⚡ | Suscripción |
| **Gemini 2.5 Pro** | PDFs largos, contexto 1M tokens, documentos | ⚡⚡ | Gratis/Pro |
| **Gemini Flash** | Tareas rápidas con Gemini, API barata | ⚡⚡⚡ | Muy barato |
| **Grok 3** | Noticias X, tiempo real, investigación actual | ⚡⚡ | Suscripción |
| **ChatGPT o3** | Razonamiento avanzado, matemáticas, lógica | ⚡ | Suscripción |
| **Mistral Large** | Alternativa europea, privacidad, código | ⚡⚡ | API |
| **qwen2.5:7b local** | Uso diario offline, Erika, privacidad total | ⚡⚡ | 0€ |
| **qwen2.5:3b local** | Rápido en CPU, respuestas cortas | ⚡⚡⚡ | 0€ |
| **deepseek-r1 local** | Razonamiento offline, cadenas de pensamiento | ⚡ | 0€ |

---

## Flujo de investigación con IAs

```
¿Qué quiero?
│
├── Buscar info + documentar en repo
│     └── Perplexity (esta sesión) ← SIEMPRE PRIMERO
│
├── Escribir/refactorizar código largo
│     └── Claude Sonnet
│
├── Analizar PDF / documento enorme
│     └── Gemini 2.5 Pro (1M context)
│
├── Qué pasa en Twitter / noticias hoy
│     └── Grok 3
│
├── Razonamiento matemático/lógico profundo
│     └── ChatGPT o3
│
├── Consulta privada / offline / sin internet
│     └── Ollama local (qwen2.5:7b → Erika)
│
└── Contrastar resultado importante
      └── 2ª IA diferente a la primera
```

---

## LiteLLM — acceso unificado (Fase 4)

Con LiteLLM activo, todos los modelos se usan desde 1 endpoint:

```bash
# Local (Ollama)
curl http://litellm:4000/v1/chat/completions \
  -d '{"model": "erika", "messages": [...]}'

# Claude via LiteLLM
curl http://litellm:4000/v1/chat/completions \
  -d '{"model": "claude-sonnet", "messages": [...]}'

# Gemini via LiteLLM  
curl http://litellm:4000/v1/chat/completions \
  -d '{"model": "gemini-flash", "messages": [...]}'
```

Ver configuración completa: `inbox/2026-06-24-fase4-litellm-sops-plan.md`

---

## Estado de integración

| IA | En n8n | En LiteLLM | Modelfile | Documentada |
|---|---|---|---|---|
| Erika (qwen2.5:7b) | ✅ | ✅ fase4 | ✅ | ✅ |
| qwen2.5:3b | ✅ | ✅ fase4 | — | ✅ |
| TOKI bot | ✅ | — | — | ✅ |
| Claude Sonnet | — | ✅ fase4 | — | ✅ |
| Gemini Flash | — | ✅ fase4 | — | ✅ |
| Grok 3 | — | pendiente | — | ✅ |
| deepseek-r1 | — | pendiente | — | ✅ |
