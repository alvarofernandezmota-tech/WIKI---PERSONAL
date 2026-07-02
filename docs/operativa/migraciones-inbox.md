# Log de migraciones — inbox
#operativa #inbox #migraciones #fase0

Registro de todos los movimientos de `inbox/` → `docs/`. Complementa el historial Git con la **intención documental** de cada migración.

---

## Formato de entrada

```
### YYYY-MM-DD — [descripción sesión]
| Fichero origen | Destino final | Estado |
|---|---|---|
| inbox/YYYY-MM-DD-nombre.md | docs/ruta/destino.md | ✅ migrado |
```

---

## 2026-07-02 — Migración masiva bloque jun-28 + jul-01 + jul-02

| Fichero origen | Destino final | Estado |
|---|---|---|
| `inbox/2026-06-28-auditoria-sesion-completa.md` | `docs/diarios/2026-06-28.md` + `docs/seguridad/fase1-completada.md` | ✅ migrado |
| `inbox/2026-07-01-ssh-hardening-completo.md` | `docs/seguridad/ssh-hardening.md` + `docs/diarios/2026-07-01.md` | ✅ migrado |
| `inbox/2026-07-01-hallazgo-ftp-puerto21.md` | `docs/seguridad/hallazgos/ftp-puerto21.md` | ✅ migrado |
| `inbox/2026-07-02-arquitectura-bots-telegram.md` | `docs/proyectos/thdora/arquitectura-bots.md` | ✅ migrado |
| `inbox/2026-07-02-auditoria-herramientas-github.md` | `docs/herramientas/github-ecosystem.md` | ✅ migrado |

**Stubs archivados en:** `inbox/procesado/` — cada uno con `migrado_a:` apuntando al destino.

---

## 2026-07-03 — 4 pilares GitHub + workflow GitHub Actions

| Fichero creado | Destino | Estado |
|---|---|---|
| `.github/CODEOWNERS` | — | ✅ nuevo |
| `.github/PULL_REQUEST_TEMPLATE.md` | — | ✅ nuevo |
| `.github/ISSUE_TEMPLATE/bug.yml` | — | ✅ nuevo |
| `.github/ISSUE_TEMPLATE/tarea.yml` | — | ✅ nuevo |
| `.github/ISSUE_TEMPLATE/seguridad.yml` | — | ✅ nuevo |
| `.github/workflows/context-reminder.yml` | — | ✅ nuevo |
| `.github/workflows/lint-commits.yml` | — | ✅ nuevo |
| `.github/workflows/inbox-health.yml` | — | ✅ nuevo |
| `docs/operativa/workflow-inbox.md` | — | ✅ nuevo |

---

## Reglas de migración

1. **Capturar** → todo pasa primero por `inbox/`
2. **Procesar** → decidir destino en `docs/`
3. **Mover** → crear el fichero en `docs/` con contenido limpio
4. **Archivar** → dejar stub en `inbox/procesado/` con `migrado_a:`
5. **Registrar** → añadir entrada en este log
6. **Commit** → mensaje tipo `migration(inbox): descripción`

> El historial Git guarda el **qué y cuándo**. Este log guarda el **por qué y hacia dónde**.
