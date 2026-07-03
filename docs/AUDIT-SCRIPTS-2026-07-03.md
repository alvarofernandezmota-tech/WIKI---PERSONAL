# Auditoría de Scripts — 2026-07-03

> **Autor:** Perplexity MCP  
> **Fecha:** 2026-07-03 06:40 CEST  
> **Scope:** `scripts/` completo + raíz repo  
> **Resultado:** 37 scripts inventariados, 3 zombies confirmados, 10 a reorganizar, 6 pendientes de crear

---

## Resumen Ejecutivo

El directorio `scripts/` tiene **estructura correcta** en subdirectorios pero **caos en la raíz** del directorio. Hay scripts sueltos que no están donde deben, dos scripts de inbox duplicados (uno zombie de 2024), y 6 scripts críticos que el bot necesita pero **no existen todavía**.

La numeración `01-10` de las fases tiene **saltos y descuadres** con el ROADMAP real — esto es deuda técnica de alineamiento, no funcional.

---

## Hallazgos por Categoría

### 🔴 Crítico — Bloquea al Bot

| Problema | Impacto |
|----------|----------|
| `close-session.sh` no existe | El bot no puede cerrar sesiones automáticamente |
| `night-cron.sh` no existe | No hay automatización nocturna real |
| `bot-session-report.sh` no existe | El bot no puede reportar el estado de la sesión |
| `docker-health-check.sh` no existe | No hay monitoreo automático de contenedores |

### 🟡 Deuda Técnica — Reorganización

| Archivo | Problema |
|---------|----------|
| `bootstrap.sh` en raíz repo | Debe estar en `scripts/setup/` |
| `macro-noche.sh` en raíz repo | Debe estar en `scripts/maintenance/` |
| `thdora-handlers.py` en `scripts/` raíz | Debe estar en `scripts/thdora/` |
| `batcueva-control.sh` en `scripts/` raíz | Debe estar en `scripts/infra/` |
| `watchdog_adb.sh` en `scripts/` raíz | Debe estar en `scripts/infra/` |
| `uptime-kuma-webhook.py` en `scripts/` raíz | Debe estar en `scripts/infra/` |
| `fix-permisos.sh` en `scripts/` raíz | Debe estar en `scripts/setup/` |

### 🧟 Zombies — Eliminar

| Archivo | Razón de muerte |
|---------|------------------|
| `scripts/inbox-cleanup-jun2024.sh` | Duplicado de `inbox-cleanup-jun2026.sh` — 2 años antiguo |
| `scripts/bc` | 4.8KB sin extensión, sin header, propósito desconocido |
| `scripts/inicio-sesion.sh` | 161 bytes — obsoleto desde `maintenance/new-session.sh` |

### 🔵 A Investigar

| Archivo | Duda |
|---------|------|
| `scripts/inbox-migrate.sh` vs `scripts/thdora-dev/inbox_migrate.py` | ¿Duplicados? ¿Cuál es el activo? |
| `scripts/migrar-inbox.sh` | ¿Tercera versión del mismo proceso? |
| `scripts/thdora/` vs `scripts/thdora-dev/` | Separación prod/dev — confirmar criterio |

---

## Arquitectura Propuesta — Estructura Final

```
scripts/
├── SCRIPTS.md                    ← índice maestro
├── README.md
├── fases/                        ← (renombrar los 01-10 a esta carpeta)
│   ├── 01-fix-driver-rtl8188ftu.sh
│   ├── 02-git-pull-rebase.sh
│   └── ...
├── backup/
├── infra/
│   ├── batcueva-control.sh       ← mover aquí
│   ├── docker-health-check.sh    ← CREAR
│   ├── uptime-kuma-webhook.py    ← mover aquí
│   └── watchdog_adb.sh           ← mover aquí
├── maintenance/
│   ├── new-session.sh
│   ├── close-session.sh          ← CREAR
│   └── night-cron.sh             ← CREAR
├── osint/
├── seguridad/
│   └── hardening-ufw.sh
├── setup/
│   ├── bootstrap.sh              ← mover aquí
│   └── fix-permisos.sh           ← mover aquí
├── thdora/
│   ├── thdora-handlers.py        ← mover aquí
│   ├── bot-session-report.sh     ← CREAR
│   └── inbox-auto-process.sh     ← CREAR
└── thdora-dev/
    ├── README.md
    └── inbox_migrate.py
```

---

## Plan de Acción — Orden de Ejecución

### Sprint inmediato (hoy, vía MCP)
- [x] Crear `SCRIPTS.md` con índice completo
- [x] Crear `AUDIT-SCRIPTS-2026-07-03.md` (este archivo)
- [ ] Crear `scripts/maintenance/close-session.sh`
- [ ] Crear `scripts/maintenance/night-cron.sh`
- [ ] Crear `scripts/thdora/bot-session-report.sh`
- [ ] Crear `scripts/infra/docker-health-check.sh`

### Sprint siguiente (reorganización)
- [ ] Mover scripts sueltos a subdirectorios correctos
- [ ] Eliminar zombies confirmados
- [ ] Realinear numeración 01-10 con ROADMAP

---

## Decisión sobre Microservicios

**Decisión tomada 2026-07-03:** Los microservicios se posponen hasta Sprint post-Docker estable.

Razón: cada script `.sh` actual es un micro-procedimiento monolítico funcional. Extraerlos en microservicios FastAPI tiene sentido cuando:
1. ✅ Docker stack estable (en progreso)
2. ⬜ pytest verde en thdora (deuda técnica activa)
3. ⬜ Al menos 3 endpoints de bot funcionando

---

*Próxima auditoría programada: cuando se complete la reorganización de scripts sueltos.*
