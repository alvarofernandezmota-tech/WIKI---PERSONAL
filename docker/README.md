# docker/ — Infraestructura Batcueva

Este directorio contiene todos los `docker-compose` del ecosistema.
Cada máquina y cada fase tiene su propio fichero, bien separado.

---

## Estructura

```
docker/
├── README.md                        ← este fichero
│
├── madre/                           ← Stack de Madre (i5-8400, 16GB, sin GPU)
│   ├── docker-compose.fase1.yml     ← ✅ ACTIVO — IA base validada (4 servicios)
│   └── docker-compose.fase2.yml     ← 🔜 PENDIENTE — migración llama.cpp
│
├── batcueva-master.yml              ← Stack completo Batcueva (13 servicios, varopc)
├── batcueva-osint.yml               ← OSINT stack (spiderfoot, maltego, etc.)
├── batcueva-pentest.yml             ← Pentest stack (kali, metasploit, etc.)
├── batcueva-siem.yml                ← SIEM stack (wazuh, elasticsearch, etc.)
├── batcueva-vuln.yml                ← Vuln scanner stack
├── docker-compose.batcueva.yml      ← Compose full batcueva (13 servicios)
│
└── grafana/                         ← Configs de Grafana (dashboards, datasources)
```

---

## Máquinas y su compose

| Máquina | Compose activo | Servicios | Estado |
|---|---|---|---|
| **Madre** (`100.64.x.x`) | `madre/docker-compose.fase1.yml` | 4 (IA base) | ✅ Validado 2026-06-25 |
| **varopc** (`100.91.112.32`) | `docker-compose.batcueva.yml` | 13 (full stack) | 🔧 En construcción |

---

## Fases Madre

### Fase 1 — Stack IA base ✅ ACTIVA
Fichero: `madre/docker-compose.fase1.yml`

Servicios:
- `ollama` — LLM chat (qwen2.5:7b) en puerto 11434
- `ollama-embeddings` — RAG embeddings (bge-m3) en puerto 11435
- `qdrant` — Vector DB en puerto 6333
- `open-webui` — UI web en puerto 3001

Límites críticos en i5-8400 / 16GB sin GPU:
- `OLLAMA_MAX_LOADED_MODELS=1` — nunca 2 modelos a la vez
- `OLLAMA_NUM_THREADS=3` — máximo seguro
- RAM estimada: ~11.5 GB / 16 GB
- **❌ NUNCA** `qwen2.5:14b` con stack activo

### Fase 2 — llama.cpp 🔜 PENDIENTE (2-4 semanas)
Fichero: `madre/docker-compose.fase2.yml` (por crear)

Objetivo: sustituir `ollama` por `llama.cpp` para menor overhead de RAM
y permitir modelos más grandes sin OOM.

---

## Cómo levantar en Madre

```bash
# Desde Madre, directamente con el fichero del repo:
cd ~
docker compose -f docker/madre/docker-compose.fase1.yml up -d

# O con el symlink actual (mientras siga en ~/docker-compose.yml):
docker compose up -d

# Ver estado
docker compose ps
docker stats --no-stream
```

---

## Links relacionados

- [ESTADO-SISTEMA.md](../ESTADO-SISTEMA.md) — estado actual de todos los servicios
- [ROADMAP.md](../ROADMAP.md) — fases y próximos pasos
- [ECOSISTEMA.md](../ECOSISTEMA.md) — mapa completo del ecosistema
- [ollama/](../ollama/) — modelos cargados y configuración
