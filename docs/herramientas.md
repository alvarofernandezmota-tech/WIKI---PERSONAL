# Herramientas del ecosistema

> Qué herramienta existe, para qué sirve y dónde se usa.
> Inventario completo. Una entrada por herramienta.

---

## Agentes IA web

Se usan desde el navegador del Acer o el iPhone. No requieren infraestructura propia.

| Herramienta | Uso principal | Notas |
|---|---|---|
| **Claude** (Anthropic) | Desarrollo, arquitectura, código complejo | Agente principal |
| **Perplexity** | Búsqueda, organización, wiki, research | Este agente |
| **GitHub Copilot** | Autocompletado de código en VSCode | En el Acer |
| **ChatGPT** | Consultas rápidas, DALL-E, voz | iOS + web |
| **Gemini** | Consultas alternativas, documentos largos | Web |
| **Grok** | Twitter/X context, consultas informales | Web |

---

## IA local (en Madre)

| Herramienta | Repo | Uso | Estado |
|---|---|---|---|
| **Ollama** | [ollama-stack](https://github.com/alvarofernandezmota-tech/ollama-stack) | Correr LLMs locales sin coste | 🟡 |
| **Open WebUI** | ollama-stack | Interfaz web para Ollama | 🟡 |
| **LiteLLM** | ollama-stack | Gateway unificado de modelos | 🟡 |
| **Qdrant** | local-brain | Base de datos vectorial (RAG) | 🟡 |
| **pgvector** | local-brain | PostgreSQL con embeddings | 🟡 |

---

## Automatización

| Herramienta | Uso | Estado |
|---|---|---|
| **n8n** | Automatización de flujos (cuando corra en Madre) | 🔴 Por instalar |
| **GitHub Actions** | CI/CD, scripts del repo | ⚠️ Pausado (sin infra real) |

---

## Desarrollo

| Herramienta | Uso | Dónde |
|---|---|---|
| **VSCode** | Editor principal | Acer |
| **Claude Code** | Agente de código en terminal | Acer |
| **Git / GitHub** | Control de versiones + repos | Acer |
| **Docker** | Contenedores en Madre | Madre |
| **SSH** | Acceso a Madre | Acer + iPhone |

---

## Conocimiento y notas

| Herramienta | Uso | Notas |
|---|---|---|
| **Obsidian** | Notas personales, PKM local | En Acer. Vault local, no sincronizado con este repo |
| **Este repo (yggdrasil-dew)** | Wiki técnica del ecosistema | GitHub |

> **Obsidian y este repo son cosas distintas.** Obsidian es para notas personales y pensamiento en bruto. `yggdrasil-dew` es documentación técnica estática y revisada.

---

## Seguridad y monitorización

| Herramienta | Repo | Uso | Estado |
|---|---|---|---|
| **Spiderfoot** | [osint-stack](https://github.com/alvarofernandezmota-tech/osint-stack) | OSINT propio + externo | 🟡 |
| **Canary Tokens** | yggdrasil-secops | Tripwires de intrusión | 🟡 |
| **Scripts de salud** | yggdrasil-secops | Monitorizar Madre y servicios | 🟡 |

> Las mismas herramientas de monitorización que sirven para vigilar lo externo (OSINT) sirven para vigilar lo interno (salud del servidor). Esa es la lógica del ecosistema.

---

## Bot personal

| Herramienta | Repo | Uso | Estado |
|---|---|---|---|
| **THDORA** | [THDORA-PERSONAL](https://github.com/alvarofernandezmota-tech/THDORA-PERSONAL) | Bot Telegram: pendientes, citas, consultas al sistema | 🟡 |

> THDORA es la interfaz conversacional del ecosistema. Corre en Madre, se usa desde el iPhone. Conecta con Ollama local para respuestas sin coste.

---

*Última actualización: 2026-07-05*
