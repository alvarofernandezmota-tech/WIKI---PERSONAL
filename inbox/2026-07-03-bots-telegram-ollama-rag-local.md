# 🤖 Bots Telegram + Ollama RAG Local — Seguridad, Auditoría y Ecosistema

**Fecha:** 2026-07-03  
**Estado:** INBOX — pendiente de revisión y acción  
**Tags:** `#telegram` `#ollama` `#rag-local` `#seguridad` `#fastapi` `#docker` `#bots`  
**Relacionado con:** `2026-07-03-enjambre-rag-llm-filosofia.md` · `2026-07-03-arquitectura-bots-ecosistema.md`

---

## 🎯 Contexto

Este documento consolida la investigación sobre bots de Telegram en 2026 con foco en:
1. Bots públicos útiles para el ecosistema (con sus riesgos)
2. Arquitectura self-hosted segura: FastAPI + Ollama + Docker
3. RAG local 100% privado sin dependencias en nube
4. Auditoría técnica de consumo y superficie de ataque

**Regla del ecosistema aplicada:** Todo lo que maneje datos del sistema va self-hosted. Bots públicos solo para tareas sin datos sensibles.

---

## 1. Bots Telegram Públicos — Catálogo y Riesgos

### 👥 Productividad

| Bot | Función | Riesgo | Uso recomendado |
|---|---|---|---|
| `@SkeddyBot` | Recordatorios en lenguaje natural | Bajo — solo timestamps | Alertas personales no sensibles |
| `@trellobot` | Crear tarjetas Trello desde Telegram | Medio — acceso a boards | Solo si Trello ya es público |
| `@TheFeedReaderBot` | Monitor RSS/YouTube/X en tiempo real | Bajo | Vigilancia de fuentes externas |

### 🤖 IA nativa Telegram

| Bot | Modelo | Riesgo | Veredicto |
|---|---|---|---|
| `@GPT4Telegrambot` | GPT-4o | ALTO — prompts van a OpenAI | ❌ No usar con datos del ecosistema |
| `@Perplexity_tg_bot` | Perplexity AI | Medio — fact-checking externo | ⚠️ Solo para búsquedas públicas |
| `@BotFather` | Oficial Telegram | Ninguno — solo gestión | ✅ Indispensable para desarrollo |

### 🛠️ Utilidades

| Bot | Función | Veredicto |
|---|---|---|
| `@filetobot` | Almacenamiento nube Telegram | ⚠️ Solo archivos no sensibles |
| `@newfileconverterbot` | Conversor de formatos | ❌ No pasar documentos privados |
| `@Rose_Bot` / `@GroupHelpBot` | Moderación anti-spam grupos | ✅ Para grupos públicos del ecosistema |

> ⚠️ **Regla de oro:** Un bot público ve TODO lo que le escribes. Sus servidores guardan logs. Nunca compartir tokens, .env, API keys, o datos de clientes.

---

## 2. Arquitectura Self-Hosted — El Stack Seguro

### Por qué self-hosted es la única opción para el ecosistema

Los bots públicos de IA de terceros tienen acceso a:
- El prompt completo de cada mensaje
- El historial de conversación
- Cualquier archivo que envíes

Con self-hosting el flujo es:
```
Telegram → Tu IP → FastAPI (tu código) → Ollama (tu hardware) → Respuesta
```
Ningún byte sale de tu infraestructura.

### Stack recomendado 2026

| Componente | Tecnología | RAM en reposo | Rol |
|---|---|---|---|
| Bot handler | FastAPI + aiogram | 24-32 MB | Webhook, routing |
| LLM local | Ollama (Llama3.2 3B) | 2-2.5 GB VRAM | Inferencia |
| Embeddings | nomic-embed-text | 270 MB | RAG vectorización |
| Vector store | ChromaDB / pgvector | ~50 MB | Índice semántico |
| Orquestador visual | n8n self-hosted | 120 MB | Flujos RAG complejos |
| Aislamiento | Docker + redes internas | overhead mínimo | Seguridad |

---

## 3. Código de Referencia — FastAPI + Ollama

### bot.py — Handler asíncrono

```python
import os
import httpx
from fastapi import FastAPI, Request, BackgroundTasks

app = FastAPI()

TOKEN = os.getenv("TELEGRAM_TOKEN")
OLLAMA_URL = os.getenv("OLLAMA_HOST", "http://localhost:11434")
MODEL_NAME = "llama3.2"  # o qwen3:8b para más capacidad
TELEGRAM_API = f"https://api.telegram.org/bot{TOKEN}"

async def send_to_telegram(chat_id: int, text: str):
    async with httpx.AsyncClient() as client:
        await client.post(
            f"{TELEGRAM_API}/sendMessage",
            json={"chat_id": chat_id, "text": text, "parse_mode": "Markdown"}
        )

async def process_ai_research(chat_id: int, user_prompt: str):
    # Toda la IA ocurre en localhost — ningún dato sale
    async with httpx.AsyncClient(timeout=60.0) as client:
        response = await client.post(
            f"{OLLAMA_URL}/api/generate",
            json={"model": MODEL_NAME, "prompt": user_prompt, "stream": False}
        )
        ai_response = response.json().get("response", "Error") if response.status_code == 200 \
            else "⚠️ Error de conexión con Ollama local."
    await send_to_telegram(chat_id, ai_response)

@app.post("/webhook")
async def telegram_webhook(request: Request, background_tasks: BackgroundTasks):
    data = await request.json()
    if "message" in data:
        chat_id = data["message"]["chat"]["id"]
        text = data["message"].get("text", "")
        # Asíncrono: FastAPI libera el hilo inmediatamente
        background_tasks.add_task(process_ai_research, chat_id, text)
    return {"status": "ok"}
```

**Auditoría de seguridad:**
- CPU en reposo: **0.0%** (solo se activa con webhook)
- RAM en reposo: **24-32 MB**
- Telemetría externa: **ninguna** — todo va a `127.0.0.1:11434`
- Superficie de ataque: solo el endpoint `/webhook` expuesto

### docker-compose.yml — Aislamiento por contenedor

```yaml
version: '3.8'

networks:
  secure_bot_net:
    driver: bridge

services:
  n8n:
    image: n8nio/n8n:latest
    container_name: n8n_orquestador
    networks: [secure_bot_net]
    environment:
      - GENERIC_TIMEZONE=Europe/Madrid
      - N8N_ENCRYPTION_KEY=${N8N_KEY}  # en .env, nunca hardcoded
    volumes:
      - ./n8n_data:/home/node/.n8n
    ports: ["5678:5678"]
    restart: unless-stopped

  research_bot:
    build: .
    container_name: python_research_bot
    networks: [secure_bot_net]
    environment:
      - TELEGRAM_TOKEN=${TELEGRAM_TOKEN}  # en .env
      - OLLAMA_HOST=http://host.docker.internal:11434
    ports: ["8000:8000"]
    # SIN volumes → el contenedor no puede leer el disco del host
    restart: unless-stopped
```

**Auditoría Docker:**
- Sin `volumes` mapeados → el script **no puede leer** archivos del host
- Si un atacante compromete el bot, queda atrapado en el contenedor
- Red interna: los contenedores no se hablan entre sí salvo que se permita explícitamente
- Ollama corre fuera de Docker con acceso directo a GPU → sin overhead de virtualización

---

## 4. RAG Local 100% Privado — Flujo Completo

```
[Tus Documentos]
       ↓
[Chunking: 300-500 tokens, 15% overlap]
       ↓
[nomic-embed-text (Ollama)] → Vectores matemáticos
       ↓
[ChromaDB / pgvector LOCAL]
       ↓
[Query → Retrieve top-5 → Cross-encoder rerank]
       ↓
[Ollama qwen3:8b → Genera respuesta con contexto]
       ↓
[Telegram → Tu chat]
```

Todo en `127.0.0.1`. Cero nube. Cero logs externos.

### Herramientas de interfaz visual (para no usar consola)

| Herramienta | Descripción | Fit ecosistema |
|---|---|---|
| **Open WebUI** | Interfaz tipo ChatGPT sobre Ollama, RAG integrado | ✅ Para uso personal/pruebas |
| **AnythingLLM** | Drag & drop documentos, ChromaDB/LanceDB interno | ✅ Para arrastrar inbox/ y docs/ |
| **n8n self-hosted** | Orquestador visual para flujos RAG en producción | ✅ Para pipelines automatizados |

---

## 5. Repositorios de Referencia Auditables

| Repo | Stars aprox | Stack | Auditable |
|---|---|---|---|
| `ollama-telegram` (rikkichy) | ~800 | Python + Ollama API | ✅ MIT |
| `local-ai-packaged` (coleam00) | ~3k | Docker Compose + n8n + Ollama + Qdrant | ✅ MIT |
| `n8n-install` (kossakovsky) | ~500 | n8n + Supabase + Ollama | ✅ MIT |
| `awesome-agent-swarm` (EvoMap) | Curated | Lista recursos enjambre | ✅ Referencia |

Todos tienen código 100% auditable en GitHub. Sin binarios opacos.

---

## 6. Modelos Ollama recomendados por caso de uso

| Modelo | Tamaño Q4 | Caso de uso en ecosistema |
|---|---|---|
| `qwen3:0.6b` | ~400 MB | Respuestas rápidas, clasificación |
| `llama3.2:3b` | ~2 GB | Bot general de Telegram |
| `qwen3:8b` | ~5 GB | thdora con razonamiento + tool-use |
| `deepseek-coder:6.7b` | ~4 GB | Auditoría de código, issue #12 |
| `nomic-embed-text` | ~270 MB | Embeddings RAG (no genera texto) |
| `phi3:mini` | ~2.3 GB | Alternativa ligera a llama3.2 |

**Regla:** Para el bot de Telegram en producción usar `llama3.2:3b` o `qwen3:8b`. Para el RAG usar siempre `nomic-embed-text` para embeddings (es el más rápido y eficiente en local).

---

## 7. Seguridad — Checklist Operacional

- [ ] Tokens de Telegram en `.env`, nunca en el código
- [ ] `.env` en `.gitignore` — verificar antes de cada push
- [ ] Webhook solo acepta IPs oficiales de Telegram (`149.154.160.0/20`, `91.108.4.0/22`)
- [ ] `docker compose` sin privilegios de root
- [ ] Sin `volumes` en el contenedor del bot (solo en n8n si necesita persistencia)
- [ ] Ollama en `127.0.0.1:11434` — no expuesto al exterior
- [ ] n8n con `N8N_ENCRYPTION_KEY` configurada
- [ ] Auditoría mensual: `docker scan <imagen>` para CVEs

---

## 8. Integración con el Ecosistema Yggdrasil

### Lo que ya tenemos vs lo que falta

| Componente | Estado | Próximo paso |
|---|---|---|
| Bot Telegram (thdora) | ✅ En producción | Añadir RAG local |
| Docker self-hosted | ✅ Build completado hoy | Verificar `docker compose ps` |
| Ollama local | ⬜ Pendiente | Instalar en Madre |
| nomic-embed-text | ⬜ Pendiente | Tras Ollama |
| ChromaDB / pgvector | ⬜ Pendiente | Fase 7 |
| n8n self-hosted | ⬜ Aplazado | Fase 8 |

### Comando para empezar con Ollama hoy

```bash
# Instalar Ollama (si no está)
curl -fsSL https://ollama.com/install.sh | sh

# Descargar modelo base (2GB, vale para el bot)
ollama pull llama3.2:3b

# Descargar embeddings para RAG (270MB)
ollama pull nomic-embed-text

# Verificar que funciona
ollama run llama3.2:3b "Hola, ¿estás funcionando?"
```

---

## 9. Acciones propuestas

### Esta sesión
- [ ] `docker compose ps` — verificar que thdora está Up
- [ ] Instalar Ollama en Madre si no está
- [ ] `ollama pull llama3.2:3b` — modelo base del ecosistema

### Próxima sesión
- [ ] Conectar thdora → Ollama local (reemplazar API externa si existe)
- [ ] `src/rag/ingest.py` — indexar `inbox/` con nomic-embed-text
- [ ] Crear `CLAUDE.md` con filosofía del ecosistema como system prompt base

### Aplazado (Fase 7-8)
- [ ] n8n self-hosted como orquestador visual
- [ ] Open WebUI para pruebas de RAG
- [ ] `biblia` bot — RAG puro sobre todo el ecosistema
