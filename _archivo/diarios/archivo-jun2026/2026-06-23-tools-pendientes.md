---
tags: [inbox, tools, pendiente, migrar, local-brain, rag, ollama]
fecha: 2026-06-23
estado: pendiente-migrar
destino: tools/
relacionado-anterior: [[inbox/2026-06-23-local-brain-setup]]
relacionado-siguiente: 
ruta-obsidian: inbox/2026-06-23-tools-pendientes.md
---

# Tools Pendientes — 2026-06-23

> Captura rápida de todo lo que falta crear en `tools/`.
> Migrar a sus carpetas definitivas cuando Ollama esté funcionando y se valide todo.

## Flujo de esta nota

```
inbox/2026-06-23-local-brain-setup.md   (anterior ←)
        ↓
inbox/2026-06-23-tools-pendientes.md    (← esta nota)
        ↓
[siguiente nota cuando se migre todo]
```

---

## 1. tools/README.md — Índice maestro

**Destino:** `tools/README.md`
**Prioridad:** Alta — falta el índice que une todo

Contenido que debe tener:
- Tabla de todas las tools con estado
- Cómo contribuir una tool nueva
- Convenciones de nombre de carpetas
- Links a cada subcarpeta

---

## 2. tools/local-brain/requirements.txt

**Destino:** `tools/local-brain/requirements.txt`
**Prioridad:** Alta — necesario para reproducibilidad

```
fastapi>=0.111.0
uvicorn>=0.30.0
chromadb>=0.5.0
requests>=2.32.0
rank_bm25>=0.2.2
pydantic>=2.0.0
```

---

## 3. tools/local-brain/.env.example

**Destino:** `tools/local-brain/.env.example`
**Prioridad:** Alta — documentar variables de entorno

```bash
OBSIDIAN_VAULT=~/Projects/yggdrasil-dew
OLLAMA_URL=http://localhost:11434
LLM_MODEL=llama3.2:3b
EMBED_MODEL=nomic-embed-text
```

---

## 4. tools/local-brain/TROUBLESHOOTING.md

**Destino:** `tools/local-brain/TROUBLESHOOTING.md`
**Prioridad:** Media — ya tuvimos errores hoy

Errores a documentar:
- `tls: bad record MAC` en docker pull → usar install.sh nativo
- Ollama no responde en :11434 → comprobar `ollama serve`
- ChromaDB duplicate IDs → hacer delete_collection antes de re-indexar
- uv no encontrado → `source $HOME/.local/bin/env`

---

## 5. tools/systemd/

**Destino:** `tools/systemd/`
**Prioridad:** Media — para arranque automático

Unit files necesarios:
- `ollama.service` — arrancar Ollama al boot
- `local-brain.service` — arrancar FastAPI RAG al boot

---

## 6. tools/thdora-rag/

**Destino:** `tools/thdora-rag/`
**Prioridad:** Media — conectar thdora con el RAG

Pendiente después de validar local-brain funcionando.

---

## 7. Renombrar tools/local-brain/ → tools/ollama-rag/

**Prioridad:** Baja — discutir si merece la pena
**Nota:** `local-brain` es más descriptivo del propósito, `ollama-rag` es más técnico.
Decidir con criterio antes de mover.

---

## Estado de tools/ ahora mismo

| Tool | Estado | Prioridad siguiente |
|---|---|---|
| `local-brain/` | ✅ Código listo, pendiente desplegar | Esperar Ollama (14%) |
| `local-brain-claude/` | ✅ Código listo | Necesita ANTHROPIC_API_KEY |
| `inbox-processor/` | ❓ Existe, revisar contenido | Auditar |
| `dashboard/` | ❓ Existe, revisar contenido | Auditar |
| `rag_osint_engine.py` | ⚠️ Suelto sin carpeta | Mover a `tools/osint-rag/` |
| `systemd/` | ❌ No existe | Crear después de validar RAG |
| `thdora-rag/` | ❌ No existe | Crear después de validar RAG |

---

## Pendiente auditar

- [ ] Ver qué hay dentro de `tools/inbox-processor/`
- [ ] Ver qué hay dentro de `tools/dashboard/`
- [ ] Decidir si `rag_osint_engine.py` va a `tools/osint-rag/`
- [ ] Crear `tools/README.md` maestro
- [ ] Crear `requirements.txt` y `.env.example` en local-brain
- [ ] Crear `TROUBLESHOOTING.md` en local-brain
