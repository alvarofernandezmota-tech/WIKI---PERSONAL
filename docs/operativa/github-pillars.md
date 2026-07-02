# Los 4 pilares GitHub — yggdrasil-dew
#github #fase0 #operativa #organizacion

**Implementados:** 2026-07-03
**Estado:** ✅ Fase 0 completada

---

## Los 4 pilares

| Pilar | Fichero(s) | Estado |
|---|---|---|
| **1. Ownership** | `.github/CODEOWNERS` | ✅ activo |
| **2. Plantillas** | `.github/PULL_REQUEST_TEMPLATE.md` + `.github/ISSUE_TEMPLATE/*.yml` | ✅ activo |
| **3. Automatización** | `.github/workflows/` — 3 workflows | ✅ activo |
| **4. Operativa documentada** | `docs/operativa/` | ✅ activo |

---

## Pilar 1 — Ownership (CODEOWNERS)

Todo el repo bajo `@alvarofernandezmota-tech`. La carpeta `docs/seguridad/` y `.github/` tienen mención explícita para dejar claro qué requiere revisión consciente.

---

## Pilar 2 — Plantillas

### PR Template
Pregunta: tipo de cambio, descripción, contexto de sesión y checklist de calidad.

### Issue Forms (3 tipos)
- **Bug** → sistema roto, p0-crítico por defecto
- **Tarea** → accionable, clasifica por fase y por dónde se ejecuta
- **Seguridad** → hallazgo con severidad, sin credenciales
- **config.yml** → deshabilita issues en blanco, enlaza MASTER-PENDIENTES

---

## Pilar 3 — Automatización (GitHub Actions)

| Workflow | Valor |
|---|---|
| `context-reminder` | Te avisa si CONTEXT.md lleva >7 días parado |
| `lint-commits` | Fuerza Conventional Commits en cada push |
| `inbox-health` | Avisa si la inbox se acumula (>10 ficheros) |

> Ver detalle: [`docs/operativa/github-actions.md`](github-actions.md)

---

## Pilar 4 — Operativa documentada

| Doc | Contenido |
|---|---|
| `workflow-inbox.md` | Flujo completo de procesado de inbox |
| `migraciones-inbox.md` | Log histórico de migraciones |
| `github-actions.md` | Workflows activos y planificados |
| `github-pillars.md` | Este fichero |

---

## Qué queda por hacer (needs-terminal / web-github)

- [ ] Crear **labels personalizados** en GitHub Settings → Labels
  - Ver spec completa en `docs/herramientas/github-ecosystem.md`
- [ ] Crear **milestones** Fase 0 (due: 2026-07-10) y Fase 2 (due: 2026-07-15)
- [ ] Configurar **branch protection** en Settings → Branches (allow direct push)
- [ ] Crear **repo `alvarofernandezmota-tech`** con Profile README
- [ ] Pinear repos en perfil público

> Todo lo anterior requiere GitHub web UI o GitHub CLI — no se puede hacer vía API con el token actual.
