---
tags: [inbox, yggdrasil, v4, arquitectura, rag, sqlite, chromadb, ollama, thdora, pendiente-migrar]
fecha: 2026-06-23
estado: pendiente-migrar
destino: tools/local-brain/
fuente: gemini + claude + chatgpt (debate trilateral)
relacionado-anterior: [[inbox/2026-06-23-ollama-rag-investigacion]]
relacionado-siguiente:
ruta-obsidian: inbox/2026-06-23-yggdrasil-v4-diario-maestro.md
---

# Yggdrasil v4 — Diario Maestro de Arquitectura

> Debate trilateral: Gemini (Especialista Sistemas) + Claude (Ingeniero Software) + ChatGPT (Auditor Producción)
> Hardware: GTX 1060 6GB · i5-8400 · Arch Linux Kernel Zen · uv

---

## Resumen Ejecutivo v2 → v4

| Componente | v2 (antes) | v4 (ahora) |
|---|---|---|
| Chunk IDs | posición relativa `ch_0, ch_1` | **sha256(content)** — invariante |
| Léxico | BM25 pickle monolito | **SQLite FTS5** incremental |
| Chunking | headers + caracteres | **code_aware** — bloques intactos |
| Concurrencia | Semaphore(2) ciego | **VRAMBudgetScheduler** dinámico |
| Almacenamiento | ChromaDB como BBDD principal | **SQLite como SSoT** + Chroma como acelerador |
| Memoria | Notas planas | **Grafo semántico** memory_nodes + memory_edges |
| Streaming | No | **SSE con throttling** (8 tokens/update) |
| Systemd | Requires= sin health check | **ExecStartPre curl** hasta socket ready |

---

## FASE 1 — Gemini detecta 3 fallos en v2

### A) Monolito BM25 pickle → SQLite FTS5

Pickle reconstruye todo el corpus O(N) en cada cambio.
FTS5 actualiza O(1) por nota modificada.

```python
import sqlite3
conn = sqlite3.connect("local_brain.db")
conn.execute("CREATE VIRTUAL TABLE IF NOT EXISTS notas_fts USING fts5(filename, content);")
cursor = conn.execute(
    "SELECT filename, content, bm25(notas_fts) FROM notas_fts WHERE notas_fts MATCH ? ORDER BY bm25(notas_fts) ASC LIMIT ?",
    ("Docker NOT networks", 5)
)
```

### B) VRAM mal calculada

Gemini asumía hot-swapping en PCIe → Claude lo corrigió (ver Fase 2).

### C) Chunking ciego rompe bloques de código

Si un script bash supera el límite → variables en Chunk A, lógica en Chunk B → embedding inútil.
Solución: code_aware_split (ver código abajo).

---

## FASE 2 — Claude corrige a Gemini

### Cálculo real de VRAM GTX 1060 6GB

```
LLM qwen2.5:3b Q4    = 2.00 GB
Embedding bge-m3     = 0.57 GB
OS Hyprland          = 1.50 GB
─────────────────────────────
Total                = 4.07 GB
Libre                = 1.93 GB  ✅ caben los dos sin hot-swap
```

Clave: `keep_alive=10m` en Ollama → ambos modelos co-residentes en CUDA.
El cuello de botella real es la **KV Cache** con contextos largos, no el swap.

### SQLite FTS5 — matiz importante

`bm25()` en SQLite devuelve valores **negativos** (más negativo = más relevante).
Hay que normalizar antes de fusionar con RRF o los scores son basura.
$k_1$ y $b$ no son configurables en FTS5 (fijados en código fuente).

### code_aware_split (code_aware.py)

```python
import re

def code_aware_split(content: str, max_chars: int = 600) -> list[str]:
    code_block_pattern = re.compile(r'```[\s\S]*?```', re.MULTILINE)
    chunks = []
    last_end = 0
    for match in code_block_pattern.finditer(content):
        text_before = content[last_end:match.start()]
        if text_before.strip():
            chunks.extend(_split_text(text_before, max_chars))
        chunks.append(match.group(0))  # bloque código → unidad indivisible
        last_end = match.end()
    remainder = content[last_end:]
    if remainder.strip():
        chunks.extend(_split_text(remainder, max_chars))
    return chunks

def _split_text(text: str, max_chars: int) -> list[str]:
    sections = re.split(r'\n(#{1,3} .+)\n', text)
    result, current = [], ""
    for section in sections:
        if len(current) + len(section) > max_chars and current:
            result.append(current.strip())
            current = section
        else:
            current += "\n" + section
    if current.strip():
        result.append(current.strip())
    return result
```

### SSE streaming con throttling para Telegram (bot_handler.py)

```python
import httpx, asyncio
from aiogram import Router
from aiogram.types import Message

router = Router()
RAG_URL = "http://127.0.0.1:8001/query/stream"

@router.message()
async def handle_query(message: Message):
    thinking_msg = await message.answer("🧠 Consultando vault...")
    full_response, last_edit, token_count = "", 0, 0
    THROTTLE_TOKENS = 8
    async with httpx.AsyncClient(timeout=60.0) as client:
        async with client.stream("POST", RAG_URL, json={"query": message.text}) as response:
            async for chunk in response.aiter_text():
                if chunk.startswith("data: "):
                    token = chunk[6:].strip()
                    if token == "[DONE]": break
                    full_response += token
                    token_count += 1
                    now = asyncio.get_event_loop().time()
                    if token_count % THROTTLE_TOKENS == 0 and (now - last_edit) > 1.0:
                        try:
                            await thinking_msg.edit_text(full_response + " ▌")
                            last_edit = now
                        except Exception:
                            pass
    await thinking_msg.edit_text(full_response)
```

### Systemd con health check real

```ini
[Unit]
Description=Yggdrasil Local Brain RAG Engine
After=network.target ollama.service
Requires=ollama.service

[Service]
Type=simple
User=varo14f
WorkingDirectory=/home/varo14f/Projects/yggdrasil-dew/tools/local-brain
EnvironmentFile=/home/varo14f/Projects/yggdrasil-dew/tools/local-brain/.env
ExecStartPre=/bin/bash -c 'until curl -sf http://localhost:11434/api/tags > /dev/null; do sleep 2; done'
ExecStart=/home/varo14f/Projects/yggdrasil-dew/tools/local-brain/.venv/bin/uvicorn main:app --host 127.0.0.1 --port 8001 --workers 1
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

---

## FASE 3 — ChatGPT audita producción: 3 bugs críticos

### Bug 1 (CRÍTICO) — chunk_id por posición → inestable

Añadir un párrafo arriba de una nota desplaza todos los IDs.
Chroma y SQLite asumen que son chunks nuevos → re-embedding masivo.

**Fix:** `chunk_id = sha256(content)` — si el texto no cambia, el ID no muta.

### Bug 2 (CRÍTICO) — rebote inotify de watchdog

Obsidian/Git/Syncthing emiten ráfagas de eventos `modified, modified, closed_write`.
Sin debouncer → reindexación concurrente → corrupción SQLite + ChromaDB.

**Fix:** Debouncer 500ms — solo ejecutar si el archivo dejó de cambiar.

### Bug 3 (IMPORTANTE) — Semaphore(2) ciego vs KV Cache dinámica

KV Cache crece linealmente con el contexto. Con 2 usuarios y contexto de 8000 tokens → OOM en GTX 1060.

**Fix:** VRAMBudgetScheduler — cada petición estima su coste:
```
C = tokens_contexto + max_tokens_salida (estimado 512)
```
Si `suma_coste_actual > 12000 tokens` → encolar hasta liberar.

### Propuesta arquitectónica — Grafo de conocimiento SQLite

ChromaDB como acelerador vectorial únicamente.
SQLite como SSoT con grafo semántico:

```python
# memory_nodes — entidades
# node_type: 'chunk', 'concept', 'tele_user', 'server_config'

# memory_edges — relaciones
# relation_type: 'DEPENDS_ON', 'MENTIONS', 'LOGGED_AT'
# Conecta notas Obsidian ↔ historial Telegram ↔ configs servidor
```

---

## FASE 4 — Código maestro v4

### database.py — SSoT + Grafo

```python
import sqlite3, hashlib, time

DB_PATH = "yggdrasil_master.db"

def init_v4_system():
    with sqlite3.connect(DB_PATH) as conn:
        conn.execute("""
            CREATE TABLE IF NOT EXISTS documents (
                doc_id TEXT PRIMARY KEY, path TEXT UNIQUE,
                sha256 TEXT, updated_at INTEGER
            );
        """)
        conn.execute("""
            CREATE TABLE IF NOT EXISTS chunks (
                chunk_id TEXT PRIMARY KEY,  -- sha256(content)
                doc_id TEXT, chunk_index INTEGER, content TEXT,
                FOREIGN KEY(doc_id) REFERENCES documents(doc_id) ON DELETE CASCADE
            );
        """)
        try:
            conn.execute("""
                CREATE VIRTUAL TABLE chunks_fts USING fts5(
                    chunk_id UNINDEXED, content,
                    tokenize="unicode61 remove_diacritics 1"
                );
            """)
        except sqlite3.OperationalError:
            pass
        conn.execute("""
            CREATE TABLE IF NOT EXISTS memory_nodes (
                node_id TEXT PRIMARY KEY, node_type TEXT,
                name TEXT, properties TEXT, created_at INTEGER
            );
        """)
        conn.execute("""
            CREATE TABLE IF NOT EXISTS memory_edges (
                edge_id TEXT PRIMARY KEY, source_id TEXT, target_id TEXT,
                relation_type TEXT, weight REAL DEFAULT 1.0, updated_at INTEGER,
                FOREIGN KEY(source_id) REFERENCES memory_nodes(node_id) ON DELETE CASCADE,
                FOREIGN KEY(target_id) REFERENCES memory_nodes(node_id) ON DELETE CASCADE
            );
        """)
        conn.commit()

def calculate_content_hash(text: str) -> str:
    return hashlib.sha256(text.encode('utf-8')).hexdigest()
```

---

## Aprendizaje del flujo de debate trilateral

```
Gemini → detecta fallos de sistemas (VRAM, escalabilidad)
Claude → corrige matemáticas + aporta código concreto
ChatGPT → audita producción + bugs latentes + visión arquitectónica
```

**Roles claros para próximas sesiones:**
- **Gemini primero** — análisis de sistema, hardware constraints, alternativas arquitectónicas
- **Claude segundo** — revisión por pares del código de Gemini, correcciones, implementación
- **ChatGPT tercero** — auditoría de producción, bugs latentes, escenarios de fallo real

**Protocolo optimizado (próxima vez):**
1. Dar contexto completo a cada IA con su rol explícito desde el principio
2. Gemini primero con rol Especialista Sistemas
3. Claude segundo con el output de Gemini + rol Ingeniero Software
4. ChatGPT tercero con v3 completa + rol Auditor Producción
5. Perplexity sintetiza, sube al inbox, migra cuando esté validado

---

## Checklist de migración v4

- [ ] Crear `tools/local-brain/code_aware.py`
- [ ] Crear `tools/local-brain/database.py`
- [ ] Crear `tools/local-brain/ingest_engine.py`
- [ ] Crear `tools/local-brain/scheduler.py` (VRAMBudgetScheduler)
- [ ] Actualizar `tools/local-brain/main.py` con streaming SSE
- [ ] Crear `tools/local-brain/bot_handler.py` (throttling Telegram)
- [ ] Crear `tools/systemd/local-brain.service` con health check
- [ ] Actualizar `tools/local-brain/requirements.txt` (+ httpx, aiogram)
- [ ] Testear cuando Ollama termine de descargar
