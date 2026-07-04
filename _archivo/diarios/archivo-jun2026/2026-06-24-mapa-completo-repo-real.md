# Mapa completo del repo REAL — 24 jun 2026 03:13

> Generado tras leer el git pull completo de Madre.
> Esto es lo que hay REALMENTE en yggdrasil-dew ahora mismo.

---

## Estado descarga Madre — CONFIRMADO ✅

```
PID: 187452
Log: /tmp/pre-descarga.log
[03:12:40] FASE 1: Stack IA Core
[03:12:44] ✅ ollama/ollama:latest          — ya tenía, actualizado
[03:12:58] ✅ open-webui:main               — ya tenía, actualizado
[03:12:58] ⏳ qdrant/qdrant:latest          — descargando
... fases 2 y 3 pendientes en background
```

Verificar progreso: `tail -f /tmp/pre-descarga.log`

---

## Mapa REAL del repo (del git pull)

### inbox/ — 7 ficheros pendientes de procesar
```
inbox/
├── 2026-06-24-script-obsidian-git-sync.md      ← pendiente procesar
├── 2026-06-24-script-thdora-handlers.md         ← pendiente procesar
├── 2026-06-24-sesion-stack-madre-levantado.md   ← pendiente procesar
├── 2026-06-24-ssh-hardening.md                  ← pendiente procesar
├── 2026-06-24-vaultwarden-docker.md             ← pendiente procesar
├── 2026-06-24-watchtower-backups.md             ← pendiente procesar
├── 2026-06-24-descubrimiento-tools-local-brain.md (esta sesión)
├── 2026-06-24-vaciado-sesion-completa-madrugada.md (esta sesión)
└── 2026-06-24-mapa-completo-repo-real.md        (este fichero)
```

### ollama/ — 12 fichas de modelos documentadas
```
ollama/
├── README.md
├── codegemma-starcoder2.md
├── deepseek-r1.md
├── gemma3.md
├── llama3.2-3b.md
├── llama3.3-70b.md
├── mistral-7b.md
├── nomic-embed-text.md
├── phi4.md
├── qwen2.5-72b.md
└── modelos/
    ├── bge-m3.md
    ├── qwen2.5-3b.md
    └── qwen2.5-7b.md
```
- [ ] Hay modelos documentados que NO están en Madre (llama3.3-70b, qwen2.5-72b, phi4 — muy grandes para CPU)
- [ ] Unificar estructura: fichas sueltas + `modelos/` es inconsistente → todo a `ollama/modelos/`

### proyectos/ — 5 proyectos activos documentados
```
proyectos/
├── batcueva/README.md
├── chatbot-control/2026-06-23-proyecto-chatbot-control.md
├── local-brain/2026-06-23-proyecto-local-brain.md
├── osint/
├── terminal-ia/2026-06-23-proyecto-terminal-ia.md
└── thdora/2026-06-23-proyecto-thdora.md
```
- THDORA ✅ proyecto principal
- local-brain ✅ ya tiene ficha (y código en tools/)
- terminal-ia, chatbot-control — auditar estado

### setup/ — muchos ficheros sueltos pendientes de ordenar
```
setup/
├── 2026-06-23-auditoria-setup.md           ← MOVER a docs/
├── 2026-06-23-estado-descargas-madre.md    ← MOVER a docs/ o archivar
├── 2026-06-23-instalacion-3-dockers-llm.md ← MOVER a docs/
├── 2026-06-23-local-brain-setup.md         ← MOVER a proyectos/local-brain/
├── 2026-06-23-pull-stack-estado-descarga.md ← ARCHIVAR
├── 2026-06-23-pull-stack-madre.md          ← ARCHIVAR
├── 2026-06-23-systemd-plan.md              ← MOVER a docs/sistema/
├── ias/
│   ├── PLANTILLA-AGENTE.md
│   ├── grok.md
│   ├── perplexity.md                        ← ficha de Perplexity como IA del sistema!
│   └── protocolo-onboarding.md
└── servidor/                               ✅ bien organizado
```
- [ ] Limpiar ficheros sueltos en `setup/` → mover a destinos correctos
- [ ] `setup/ias/` — debería estar en `agentes/` → mover

### osint/ — 2 ficheros activos
```
osint/
├── 2026-06-23-auditoria-osint.md
└── 2026-06-23-osint-rag-mover.md
```
- [ ] Auditar si el RAG OSINT sigue activo o está en proyectos/osint/

### tools/ — 2 proyectos activos
```
tools/
├── README.md
├── 2026-06-23-script-vaciado-inbox-gemini.md
├── pull-stack-robusto.sh
├── local-brain/                  ← código activo Python
└── local-brain-claude/           ← variante Claude
```
- [ ] `local-brain/` tiene código real → ¿mover a proyectos/local-brain/ o mantener en tools/?
- [ ] `pull-stack-robusto.sh` → comparar con `pre-descarga-todo.sh`

### yo/ — contenido personal en repo técnico (pendiente migrar)
```
yo/
├── README.md
├── 2026-06-23-auditoria-yo.md
├── auditoria-personal-repo.md
├── begona.md           ← MIGRAR a personal/00_yo/
├── cv.md               ← MIGRAR a personal/00_yo/
├── empleabilidad.md    ← MIGRAR a personal/06_empleabilidad/
├── habitos.md          ← MIGRAR a personal/00_yo/
├── objetivos-2026.md   ← MIGRAR a personal/02_metas/
└── perfil.md           ← MIGRAR a personal/00_yo/
```

---

## Limpieza pendiente (priorizada)

| Prioridad | Acción | Dónde |
|---|---|---|
| P1 | Migrar `yo/*.md` a repo `personal/` | Esta semana |
| P1 | Mover `setup/ias/` a `agentes/` | Esta semana |
| P2 | Limpiar ficheros sueltos en `setup/` | Próxima sesión |
| P2 | Unificar estructura `ollama/` | Próxima sesión |
| P3 | Auditar `tools/local-brain/main.py` | Próxima sesión |
| P3 | Revisar proyectos terminal-ia y chatbot-control | Esta semana |

---
_Ver: [MASTER-PENDIENTES.md](../MASTER-PENDIENTES.md) · [vaciado-sesion](2026-06-24-vaciado-sesion-completa-madrugada.md)_
