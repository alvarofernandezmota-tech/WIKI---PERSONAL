# Patrón GitHub Action → Bot — Arquitectura Profesional

> Decisión de diseño — 2026-07-03  
> Basada en investigación de patrones reales en producción

---

## La pregunta clave

> «¿Es mejor un GitHub Action que prepara el archivo y el bot lo consume desde allí?"

**Sí. Eso es exactamente el patrón correcto.** Se llama **Event-Driven File Handoff**.

---

## Cómo lo hacen los profesionales

### Patrón 1 — GitHub Action como productor, Bot como consumidor

```
Evento (push/schedule/webhook)
    ↓
GitHub Action
    ├── Analiza el repo
    ├── Genera ARTIFACT.json / REPORT.md
    ├── Hace commit del artifact al repo
    └── Dispara webhook a Telegram
            ↓
        Bot Telegram
            ├── Lee el artifact del repo
            ├── Formatea para Telegram
            └── Envía mensaje al usuario
```

**Por qué funciona:**
- GitHub Action tiene acceso completo al repo (filesystem, git, secrets)
- El bot NO necesita lógica de análisis — solo presentación
- El artifact queda en el repo como historial auditável
- Si el bot está caído, el artifact sigue ahí esperando

### Patrón 2 — Bot como trigger, GitHub Action como executor

```
Usuario → /audit (Telegram)
    ↓
Bot recibe comando
    ↓
Bot llama GitHub API → workflow_dispatch
    ↓
GitHub Action ejecuta análisis pesado
    ↓
Action commit results → repo
    ↓
Action notifica bot via webhook
    ↓
Bot envía resultados al usuario
```

**Cuándo usar este patrón:** cuando el análisis tarda >30s o necesita recursos que el bot no tiene.

---

## Decision Tree — Script vs GitHub Action vs Bot

```
¿La tarea necesita ejecutarse?
    │
    ├── ¿En tu máquina local (Madre)? → SCRIPT bash/Python
    │       └── ¿Se repite en horario fijo? → CRON en Madre
    │
    ├── ¿En el repo (push/PR/schedule)? → GITHUB ACTION
    │       ├── Produce un archivo/report → guarda en repo como artifact
    │       └── Necesita notificar → llama webhook del bot al final
    │
    └── ¿El usuario lo pide manualmente? → BOT TELEGRAM
            ├── Respuesta rápida (<5s) → bot procesa directamente
            └── Respuesta lenta (>5s) → bot dispara GitHub Action
                                        bot responde "procesando..."
                                        action notifica cuando acaba
```

---

## Aplicado a nuestro ecosistema

| Tarea | Dónde vive | Artifact generado | Bot notifica |
|---|---|---|---|
| Auditoría ecosistema diaria | GitHub Action (03:00) | `docs/AUDIT-FECHA.md` | TOKI-DEW |
| Inbox acumulada | GitHub Action (push main) | Issue GitHub | TOKI-DEW |
| Estado Docker | Script Madre (cron 5min) | `~/.status/docker.json` | TOKI-Guardian |
| Alerta Wazuh | Script Madre (tail log) | — (directo) | TOKI-Guardian |
| Commit manual | Bot (`/git log`) | — (lee repo live) | — |
| Análisis deuda técnica | GitHub Action (semanal) | `docs/DEUDA-FECHA.md` | TOKI-DEW |
| Modelos Ollama status | Script Madre | `~/.status/ollama.json` | TOKI-Personal |

### La regla de oro

> **GitHub Action = analiza y escribe el artifact**  
> **Bot = lee el artifact y habla con el humano**  
> **Script = ejecuta en Madre lo que no pertenece al repo**

Nunca mezclar. Cada capa tiene exactamente una responsabilidad.

---

## Formato del artifact (estándar del ecosistema)

Todo artifact generado por GitHub Action sigue esta estructura:

```json
{
  "generated_at": "2026-07-03T05:00:00Z",
  "type": "ecosystem_audit | inbox_report | debt_report",
  "severity": "ok | warning | critical",
  "summary": "Texto corto para Telegram (máx 200 chars)",
  "findings": [...],
  "issues_created": ["#28", "#29"],
  "doc_path": "docs/AUDIT-2026-07-03.md"
}
```

El bot lee `severity` para decidir si notificar o no. Solo notifica `warning` y `critical`.

---

## Bitácora de investigación → `docs/bitacora/BITACORA-FUENTES.md`

Ver archivo hermano para todas las fuentes consultadas.

---

_Decisión: 2026-07-03 — Perplexity vía MCP_  
_Revisado con: GitHub Agentic Workflows docs, papers arxiv.org/2305.04772, patrones open source_
