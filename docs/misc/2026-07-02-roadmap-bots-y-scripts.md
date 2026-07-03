---
tags: [inbox, bots, scripts, automatizacion, roadmap, fase-5]
fecha: 2026-07-02
estado: pendiente-migrar
destino: docs/arquitectura/bots-automatizacion.md
mobile-ok: true
---

# 🤖 Roadmap bots y scripts — sí, es posible y está en el plan

> Respuesta directa: sí, tendremos scripts para todo y bots que trabajen solos.
> Está en Fase 5 (GitHub Actions) y Fase 6 (TOKI + n8n).
> Esto no es futuro lejano — algunas piezas ya existen.

---

## 📊 Estado actual de automatización

| Pieza | Estado | Hace qué |
|---|---|---|
| `audit-repo.sh` | ✅ draftado | Audita repo en 5s: inbox, archivos críticos, secrets, commits |
| `repo-health-check.yml` | ✅ draftado | Bot GitHub que abre issue si algo está mal |
| `context-reminder.yml` | ✅ draftado | Avisa si CONTEXT.md tiene más de 7 días sin tocarse |
| `update-diario-index.yml` | ✅ draftado | Regenera índice diarios automáticamente |
| `lint-commits.yml` | ✅ draftado | Valida Conventional Commits en cada push |
| TOKI (FastAPI) | ⚠️ handlers pendientes | Bot Telegram — base lista, sin comandos |
| n8n | ⚠️ corriendo (0.0.0.0) | Orquestador de flujos — pendiente hardening |
| Gemini mega-prompt | ✅ listo | Puede ejecutar 7 tareas GitHub de una vez |

---

## 🛣️ El sistema de bots completo — arquitectura objetivo

```
                    ┌────────────────────────┐
                    │  GitHub Actions (Fase 5)  │
                    │  └ repo-health-check       │
                    │  └ lint-commits            │
                    │  └ context-reminder        │
                    │  └ update-diario-index     │
                    └────────────────────────┘
                              ↓ abre Issues
  ┌───────────┐          ┌────────────┐          ┌───────────┐
  │  TOKI bot  │←─────│  n8n flows  │─────→│  Ollama    │
  │ (Telegram) │          │ (orquesta) │          │  (local)   │
  └───────────┘          └────────────┘          └───────────┘
       ↑                         ↓
  Tu iPhone                  Madre (Docker)
```

### Lo que hace cada capa

**Capa 1: GitHub Actions (bots de repo)**
- Viven en `.github/workflows/`
- Se ejecutan solos por schedule o por eventos (push, PR, issue)
- No necesitan servidor, no consumen recursos de Madre
- Coste: 0€ (plan gratuito, repo público)
- Ejemplo real: `repo-health-check.yml` — lunes 8:00 abre issue si inbox > 10 ficheros

**Capa 2: TOKI — bot Telegram (Fase 6)**
- Ya existe la base en FastAPI
- Comandos pendientes: `/estado`, `/inbox`, `/pendientes`, `/git log`
- Conecta con Madre vía Tailscale — desde el iPhone mandas un mensaje y TOKI ejecuta
- Ejemplo: `/git status` → TOKI responde con el estado real del repo en 2 segundos

**Capa 3: n8n — orquestador (Fase 6)**
- Ya está corriendo en Madre (0.0.0.0:5678 — hardening pendiente)
- Flujos que crearemos:
  - Nuevo commit en GitHub → TOKI avisa por Telegram
  - Issue abierto → TOKI avisa + pide confirmación
  - CONTEXT.md sin actualizar 7 días → notificación móvil
  - Nuevo contenedor Docker caído → alerta inmediata

**Capa 4: scripts/ — automatización local**
- Ya existen en `scripts/` — se irán completando fase a fase
- `audit-repo.sh` — auditoría local del repo (listo)
- `gen-diario-index.py` — regenera índice diarios (por hacer)
- `update_perplexity_docs.py` — actualiza docs Perplexity (por hacer)
- `hardening-batcueva.sh` — aplicar sed a compose files (por hacer)

---

## 🗓️ Orden de implementación (por fases)

| Fase | Bot/Script | Cuándo | Prerequisito |
|---|---|---|---|
| **5** | GitHub Actions (5 workflows) | Próxima sesión Thdora | Terminal |
| **6a** | TOKI handlers básicos | Fase 5 completa | FastAPI corriendo |
| **6b** | n8n flows básicos | Fase 5 completa | n8n hardened |
| **7** | n8n + Ollama local integrado | Fases 5+6 completas | Modelos descargados |
| **8+** | Agente autónomo completo | Futuro | Todo lo anterior |

---

## ⚡ Qué se puede hacer ahora mismo sin terminal

1. Usar el mega-prompt Gemini para ejecutar las 7 tareas de Fase 0
2. Decirle a Perplexity que cree los labels, milestones y archivos .github/
3. Todo lo demás necesita terminal (Thdora)

---
_Creado: 02-jul-2026 20:30 CEST — iPhone 11 — Perplexity vía MCP_
_Destino: docs/arquitectura/bots-automatizacion.md_
