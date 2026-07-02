# GitHub Ecosystem — Herramientas y configuración
#herramientas #github #fase0 #organización

**Fecha auditoría:** 2026-07-02  
**Fecha implementación:** 2026-07-03  
**Repo:** yggdrasil-dew

---

## Estado actual — post implementación

| Herramienta | Existe | Configurado | Usando |
|---|---|---|---|
| Issues | ✅ | ✅ issue forms | ✅ |
| Labels | ✅ nativas | ❌ pendiente custom | ⏳ |
| Milestones | ✅ | ❌ pendiente crear | ⏳ |
| Pull Requests | ✅ | ✅ PR template | ✅ |
| GitHub Actions | ✅ | ✅ 3 workflows activos | ✅ |
| CODEOWNERS | ✅ | ✅ activo | ✅ |
| Branch protection | ✅ | ❌ pendiente | ⏳ |
| Wiki | ✅ | ❌ no activada | ❌ |
| Discussions | ✅ | ❌ no activada | ❌ |

---

## Labels a crear (22 total) — pendiente

Ver spec completa en: `docs/operativa/pendientes-labels-milestones.md`

```
Fases:      fase-0 al fase-7
Ejecución:  mobile-ok, needs-terminal
Tipo:       bug, docs, blocked, security, infra, ai, migration
Prioridad:  p0-critico, p1-urgente, p2-normal, p3-cuando-pueda
```

---

## Workflows activos

| Workflow | Trigger | Función |
|---|---|---|
| `context-reminder` | lunes 08:00 UTC | Alerta si CONTEXT.md >7 días sin tocar |
| `lint-commits` | push main + PR | Valida Conventional Commits |
| `inbox-health` | push inbox/ + diario | Alerta si inbox >10 ficheros |

---

## ❌ No activar

| Herramienta | Razón |
|---|---|
| Wiki | Duplica `docs/` |
| Discussions | Trabajamos solo |
| Dependabot | Sin dependencias de paquetes |
| GitHub Pages | No necesario hasta Fase 8+ |
