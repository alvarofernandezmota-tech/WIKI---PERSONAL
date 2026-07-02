# GitHub Actions — workflows del ecosistema
#github #actions #automatizacion #fase0 #fase5

**Estado:** activos desde 2026-07-03

---

## Workflows en producción

| Workflow | Trigger | Función | Estado |
|---|---|---|---|
| `context-reminder.yml` | schedule lunes 08:00 UTC + manual | Abre issue si CONTEXT.md >7 días sin actualizar | ✅ activo |
| `lint-commits.yml` | push main + PR | Valida que los commits siguen Conventional Commits | ✅ activo |
| `inbox-health.yml` | push inbox/ + schedule diario + manual | Abre issue si inbox > 10 ficheros pendientes | ✅ activo |

---

## Workflows planificados

| Workflow | Trigger | Función | Fase |
|---|---|---|---|
| `update-diario-index.yml` | push `docs/diarios/` | Regenera índice de diarios | Fase 5 |
| `update-perplexity-docs.yml` | schedule / manual | Actualiza docs Perplexity y abre PR | Fase 5 |
| `repo-health-check.yml` | schedule semanal | Audita estado del repo y genera informe | Fase 5 |
| `notify-toki-dew.yml` | issues + PRs | Notifica TOKI-DEW vía webhook | Fase 6d |

---

## Permisos requeridos

Todos los workflows que crean issues o PRs necesitan en `permissions:`:
```yaml
permissions:
  issues: write
  contents: read
  pull-requests: write  # solo si crean PRs
```

---

## Convenciones de commits

Tipos válidos para `lint-commits.yml`:
```
feat      nueva funcionalidad
fix       corrección de bug
docs      documentación
chore     mantenimiento / limpieza
infra     infraestructura Madre/Thdora
security  hallazgo o mejora de seguridad
migration migración inbox → docs
refactor  refactorización sin cambio de comportamiento
test      tests
style     formato, sin lógica
```

> Ver: [CONVENCIONES.md](../../CONVENCIONES.md)
