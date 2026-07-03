# 🔗 FICHEROS CRÍTICOS — Mapa de dependencias

> Cuando tocas un fichero, ¿qué otros hay que actualizar?
> Este fichero evita que la documentación se desincronice del código.

---

## Regla general

Cada vez que haces un commit con cambios significativos:
1. Mira la tabla de abajo
2. Actualiza los ficheros relacionados
3. El commit debe mencionar qué ficheros secundarios se actualizaron

---

## Mapa de dependencias

| Si tocas esto... | También actualiza | TTL | Prioridad |
|---|---|---|---|
| Cualquier `docker-compose.yml` | `infra/MAPA-FICHEROS-MADRE.md`, `ESTADO-SISTEMA.md` | Inmediato | 🔴 CRÍTICA |
| Nuevo bot en `docker/bots/` | `docs/ISLAS-ECOSISTEMA.md`, `ECOSYSTEM-ARCHITECTURE.md`, `scripts/SCRIPTS.md` | 24h | 🟡 ALTA |
| Nuevo script en `scripts/` | `scripts/SCRIPTS.md` | Inmediato | 🟡 ALTA |
| Nueva GitHub Action | `docs/ORQUESTACION.md`, `scripts/SCRIPTS.md` | 24h | 🟡 ALTA |
| Nuevo sprint en thdora | `ROADMAP.md`, `MASTER-PENDIENTES.md`, `docs/SPRINTS.md` | Inmediato | 🔴 CRÍTICA |
| Cambio de arquitectura | `ECOSYSTEM-ARCHITECTURE.md`, `ECOSISTEMA.md`, `HOME.md` | Inmediato | 🔴 CRÍTICA |
| Nueva regla del ecosistema | `CONVENCIONES.md`, `CONTRIBUTING.md`, `AGENT.md` | 24h | 🟡 ALTA |
| Cambio de puertos Docker | `infra/MAPA-FICHEROS-MADRE.md` | Inmediato | 🔴 CRÍTICA |
| Nueva herramienta en `tools/` | `scripts/SCRIPTS.md`, `docs/ISLAS-ECOSISTEMA.md` | 24h | 🟡 ALTA |
| Fix de issue | `CHANGELOG.md`, issue de GitHub cerrado | Inmediato | 🟡 ALTA |
| Nueva fase/sprint | `ROADMAP.md`, `MASTER-PENDIENTES.md`, `CHANGELOG.md` | Inmediato | 🔴 CRÍTICA |
| Cambio en red/VPN | `infra/MAPA-FICHEROS-MADRE.md`, `PLAN-SEGURIDAD-Y-DESPLIEGUE.md` | 24h | 🟡 ALTA |
| Añadir agente IA | `agentes/`, `ECOSISTEMA.md`, `ECOSYSTEM-ARCHITECTURE.md` | 24h | 🟡 ALTA |

---

## Ficheros que NUNCA deben quedarse obsoletos

Estos ficheros son la **fuente de verdad** del ecosistema.
Si pasa más de su TTL sin tocarse y hay actividad en la repo, es un bug:

| Fichero | TTL máximo | Por qué es crítico |
|---|---|---|
| `MASTER-PENDIENTES.md` | 7 días | Es el tablero de control |
| `ESTADO-SISTEMA.md` | 7 días | Refleja el estado real de Madre |
| `docs/SPRINTS.md` | 7 días | Planificación del sprint activo |
| `ROADMAP.md` | 14 días | Fases del ecosistema |
| `infra/MAPA-FICHEROS-MADRE.md` | 14 días | Mapa de Madre |
| `ECOSISTEMA.md` | 30 días | Descripción del ecosistema |
| `ECOSYSTEM-ARCHITECTURE.md` | 30 días | Arquitectura técnica |

---

## Cómo saber si algo está vencido

```bash
# Ver cuando se tocó por última vez un fichero:
git log -1 --format='%aI %s' -- MASTER-PENDIENTES.md

# Ver todos los ficheros criticos y su último commit:
git log --pretty=format:'%aI %f' --name-only -- \
  MASTER-PENDIENTES.md ESTADO-SISTEMA.md ROADMAP.md 2>/dev/null | head -30
```

O la GitHub Action `repo-health.yml` lo hace automáticamente cada lunes.

---

_Actualizado: 2026-07-03 — TTL: 30 días_
