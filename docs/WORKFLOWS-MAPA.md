# ⚙️ Mapa de Workflows

> Tabla de los 23 workflows activos. Trigger, función, solapas detectadas.
> Generado: 03-Jul-2026

---

## Workflows activos

| Workflow | Trigger | Qué hace | Solapa con |
|---|---|---|---|
| `audit-on-push.yml` | push main | Auditoría rápida en cada push | `repo-audit.yml` |
| `auto-investigacion.yml` | schedule 04:30 CEST | Velocidad, islas inactivas, TODOs, docs viejas | `ecosystem-guardian.yml` |
| `clasificador.yml` | issue/PR nuevo | Clasifica y etiqueta automáticamente | — |
| `context-reminder.yml` | PR abierto | Añade contexto del ecosistema al PR | — |
| `diary-writer.yml` | schedule / dispatch | Escribe entrada del diario diario | — |
| `ecosystem-guardian.yml` | schedule 03:00 CEST | Auditoría profunda: zombies, TODOs, islas, islands | `auto-investigacion.yml` |
| `inbox-health.yml` | schedule / push | Verifica salud del inbox | `inbox-processor.yml` |
| `inbox-processor.yml` | push inbox/ | Procesa ficheros nuevos en inbox/ | `inbox-health.yml` |
| `isla-context-sync.yml` | issue/PR cerrado | Actualiza ECOSYSTEM-STATE.md | `mapa-islas-sync.yml` |
| `islas-health.yml` | schedule / dispatch | Health check de cada isla | `ecosystem-guardian.yml` |
| `lint-commits.yml` | push/PR | Valida Conventional Commits | — |
| `mapa-islas-sync.yml` | push / dispatch | Sincroniza MAPA-ISLAS.md | `isla-context-sync.yml` |
| `new-file-bootstrap.yml` | push (nuevo fichero) | Añade header a ficheros nuevos sin metadata | — |
| `orquestador-maestro.yml` | schedule / dispatch | Orquesta el resto de workflows | — |
| `repo-audit.yml` | schedule / dispatch | Auditoría completa del repo | `audit-on-push.yml`, `repo-health.yml` |
| `repo-health-check.yml` | schedule / dispatch | Health check básico | `repo-health.yml` |
| `repo-health.yml` | schedule / push | Health check completo | `repo-health-check.yml` |
| `resumen-diario.yml` | schedule 08:00 CEST | Genera resumen del día anterior | `diary-writer.yml` |
| `session-close.yml` | dispatch manual | Cierra sesión de trabajo | — |
| `sync-drive.yml` | ? | Sincroniza con Drive | ⚠️ Sin documentar |
| `sync-estado.yml` | push / schedule | Sincroniza ESTADO-SISTEMA.md | — |
| `test-scripts.yml` | push scripts/ | Testea scripts de la carpeta scripts/ | — |
| `tripwire-repo.yml` | push | Detecta cambios inesperados en ficheros críticos | — |
| `yamllint.yml` | push .github/ | Valida sintaxis de todos los YAMLs | — |

---

## 🚨 Solapas a resolver

### Fusionar: `repo-health.yml` + `repo-health-check.yml`
Hacen lo mismo con distinto nombre. Mantener `repo-health.yml` y eliminar `repo-health-check.yml`.

### Fusionar: `audit-on-push.yml` dentro de `repo-audit.yml`
`audit-on-push.yml` es una versión reducida de `repo-audit.yml`. Añadir trigger `push` a `repo-audit.yml` y eliminar `audit-on-push.yml`.

### Fusionar: `inbox-health.yml` dentro de `inbox-processor.yml`
La salud del inbox se puede verificar al procesar. Un solo workflow.

### Documentar: `sync-drive.yml`
No está claro qué Drive sincroniza. Necesita comentarios o eliminarse.

### Aclarar: `isla-context-sync.yml` vs `mapa-islas-sync.yml`
Distinto enfoque (ECOSYSTEM-STATE vs MAPA-ISLAS) — son complementarios, no solapas reales. Documentar la diferencia en cada fichero.

---

## 🕐 Calendario de ejecuciones nocturnas

```
01:00 CEST  — (vacío)
02:30 CEST  — resumen-diario.yml
03:00 CEST  — ecosystem-guardian.yml  
04:30 CEST  — auto-investigacion.yml
06:00 CEST  — agente-autonomo (F3, pendiente)
08:00 CEST  — daily report via ygg-bot (F2, pendiente)
```

---

## ✅ Workflows que NO tienen solapa (seguros)

`clasificador.yml`, `context-reminder.yml`, `diary-writer.yml`, `lint-commits.yml`,
`new-file-bootstrap.yml`, `orquestador-maestro.yml`, `session-close.yml`,
`sync-estado.yml`, `test-scripts.yml`, `tripwire-repo.yml`, `yamllint.yml`

---

*Actualizar este fichero cuando se añada o elimine un workflow.*
*Ver `docs/BOTS-ARQUITECTURA.md` para la capa de bots.*
