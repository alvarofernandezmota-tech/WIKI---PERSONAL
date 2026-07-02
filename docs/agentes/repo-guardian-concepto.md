---
tipo: arquitectura
author: Perplexity-MCP <alvarofernandezmota@gmail.com>
creado: 2026-07-03 01:05 CEST
actualizado: 2026-07-03 01:05 CEST
ruta: docs/agentes/repo-guardian-concepto.md
tags: [agente, bot, github, guardian, automatizacion, mcp]
status: borrador
---

# REPO-GUARDIAN — Bot de vigilancia del repositorio

> Un agente que conoce la estructura del repo y vigila activamente
> discordancias, inbox sin procesar, y ficheros fuera de lugar.

---

## Concepto

TOKI-GUARDIAN ya vigila Madre (Docker, servicios, alertas hardware).
REPO-GUARDIAN es su homólogo para el repositorio GitHub:
- Detecta discordancias entre CONTEXT.md y estado real del repo
- Procesa inbox automáticamente: clasifica ficheros nuevos según CONVENCIONES.md
- Alerta cuando un fichero entra en inbox y no tiene destino claro
- Verifica que todo fichero tenga bloque de autoría (regla 11)
- Comprueba que CHANGELOG y CONTEXT estén actualizados tras cada sesión

---

## Arquitectura propuesta

```
                    ┌────────────────────────┐
                    │    GitHub Actions          │
                    │  (trigger: push, cron)    │
                    └─────────┬──────────────┘
                             │
              ┌──────────┴──────────┐
              │                        │
    ┌───────┴──────┐        ┌─────┴──────┐
    │  repo-guardian.py  │        │  inbox-router.py │
    │  (verificador)     │        │  (clasificador)  │
    └──────────────────┘        └────────────────┘
              │                        │
              └──────────┬──────────┘
                         │
              ┌─────────┴─────────┐
              │   Telegram (TOKI-DEW)  │
              │   GitHub Issues        │
              └───────────────────┘
```

---

## Módulo 1: repo-guardian.py — verificador de discordancias

### Checks automáticos

| Check | Qué verifica | Frecuencia |
|---|---|---|
| `check_context_sync` | CONTEXT.md menciona ficheros que ya no existen | cada push |
| `check_authorship` | Todo `.md` tiene frontmatter con `author` y `creado` | cada push |
| `check_inbox_age` | Ficheros en inbox/ con más de 48h sin procesar | cron diario |
| `check_changelog_fresh` | CHANGELOG.md actualizado en las últimas 24h si hubo commits | cron diario |
| `check_diario_today` | Existe `docs/diarios/YYYY-MM-DD.md` del día actual | cron 23:00 |
| `check_conventions` | Nombres de fichero siguen CONVENCIONES.md | cada push |
| `check_root_clean` | Raíz solo contiene ficheros permitidos (lista blanca) | cada push |

### Output
- `✅ OK` — sin acción
- `⚠️ WARN` — Issue GitHub automático con label `repo-health`
- `🔴 CRITICO` — Issue + notificación Telegram TOKI-DEW

---

## Módulo 2: inbox-router.py — clasificador automático

Cuando entra un fichero en `inbox/`, el router:
1. Lee el contenido y el nombre del fichero
2. Consulta CONVENCIONES.md (sección 8) para determinar destino
3. Propone mover al destino correcto vía PR automático
4. Añade bloque de autoría si falta
5. Crea issue con propuesta si el contenido es ambiguo

### Reglas de clasificación automática

| Patrón en nombre/contenido | Destino propuesto |
|---|---|
| `YYYY-MM-DD*` | `docs/diarios/` |
| `docker*`, `compose*` | `docker/` |
| `script*`, `*.sh` | `scripts/` |
| `seguridad*`, `hardening*`, `ssh*` | `docs/seguridad/` |
| `arquitectura*`, `diseño*` | `docs/arquitectura/` |
| `herramienta*`, nombre de tool conocida | `docs/herramientas/` |
| `filosofia*`, `principios*` | `docs/filosofia/` |
| Sin patrón claro | Issue `inbox-sin-clasificar` para revisión manual |

---

## Implementación por fases

| Fase | Qué | Cómo | Cuando |
|---|---|---|---|
| **Fase A** | `check_root_clean` + `check_inbox_age` | GitHub Action Python | Ahora (Fase 0) |
| **Fase B** | `check_authorship` + `check_conventions` | GitHub Action Python | Fase 5 |
| **Fase C** | `inbox-router.py` completo | GitHub Action + LLM local | Fase 7 |
| **Fase D** | Notificaciones Telegram | TOKI-DEW integrado | Fase 7 |

---

## Relación con TOKI-GUARDIAN

| Bot | Dominio | Trigger | Output |
|---|---|---|---|
| TOKI-GUARDIAN | Madre (hardware, Docker, red) | cron + Prometheus | Telegram alertas |
| REPO-GUARDIAN | GitHub repo (estructura, docs) | GitHub Actions | Issues + Telegram |
| TOKI-DEW | Interfaz unificada usuario | Telegram commands | Respuestas + acciones |

Los tres se integran en Fase 7 bajo TOKI-DEW como orquestador.

---

## Issue a crear

**#17 — feat(agentes): implementar repo-guardian Fase A**
- `check_root_clean`: lista blanca de ficheros permitidos en raíz
- `check_inbox_age`: alerta si inbox tiene ficheros > 48h
- Label: `fase-5`, `mobile-ok: NO`, `needs-terminal: SÍ`
