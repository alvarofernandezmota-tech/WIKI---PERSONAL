---
tags: [inbox, osint, rag, qdrant, ivre, batcueva, pendiente-migrar]
fecha: 2026-06-23
estado: pendiente-migrar
destino: tools/osint-rag/
relacionado-anterior: [[inbox/2026-06-23-auditoria-tools-inbox-dashboard]]
relacionado-siguiente:
ruta-obsidian: inbox/2026-06-23-osint-rag-mover.md
---

# OSINT RAG Engine — Mover a tools/osint-rag/

> Actualmente suelto en `tools/rag_osint_engine.py`.
> Mover a `tools/osint-rag/` con estructura completa.

## Qué hace este script

Pipeline de ciberinteligencia completo:

```
IVRE MongoDB (escaneos de red)
        ↓
Ollama nomic-embed-text (embeddings locales)
        ↓
Qdrant (base vectorial para correlación histórica)
        ↓
Ollama llama3 (análisis de vulnerabilidades + CVEs)
        ↓
Obsidian inbox/ (genera nota .md con el reporte)
```

## Diferencias con local-brain

| | local-brain | osint-rag |
|---|---|---|
| Base vectorial | ChromaDB | **Qdrant** |
| Fuente de datos | Vault .md | **IVRE MongoDB** |
| Propósito | Segundo cerebro personal | **Ciberinteligencia OSINT** |
| Output | Respuesta en API | **Nota .md en inbox** |
| IP Ollama | localhost | **100.91.112.32 (Madre remota)** |

## Estructura destino

```
tools/osint-rag/
├── README.md
├── rag_osint_engine.py   ← mover desde tools/
├── requirements.txt
└── .env.example
```

## Requirements

```
pymongo>=4.0.0
requests>=2.32.0
qdrant-client>=1.9.0
```

## .env.example

```bash
IP_MADRE=100.91.112.32
OLLAMA_PORT=11434
MONGO_URL=mongodb://127.0.0.1:27017/
QDRANT_HOST=127.0.0.1
QDRANT_PORT=6333
OBSIDIAN_INBOX=~/Projects/yggdrasil-dew/inbox
```

## Pendiente

- [ ] Crear `tools/osint-rag/`
- [ ] Mover `tools/rag_osint_engine.py` a `tools/osint-rag/rag_osint_engine.py`
- [ ] Crear README.md con arquitectura
- [ ] Crear requirements.txt
- [ ] Crear .env.example
- [ ] Hardcoded IP_MADRE → variable de entorno
- [ ] Actualizar `tools/README.md` con la nueva tool
