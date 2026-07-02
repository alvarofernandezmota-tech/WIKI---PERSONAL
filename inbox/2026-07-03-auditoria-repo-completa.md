---
tipo: auditoria
author: Perplexity-MCP <alvarofernandezmota@gmail.com>
creado: 2026-07-03 01:12 CEST
actualizado: 2026-07-03 01:12 CEST
ruta: inbox/2026-07-03-auditoria-repo-completa.md
tags: [auditoria, repo-health, discordancias, limpieza, pendientes]
status: pendiente-procesar
destino: docs/agentes/ + docs/arquitectura/ + scripts/
---

# Auditoría Repo Completa — 2026-07-03 01:12 CEST

> Auditoría realizada por Perplexity-MCP analizando raíz, commits recientes
> y estructura de carpetas. Lista de discordancias y plan de acción.

---

## 🔴 CRÍTICOS — Arreglar inmediatamente

### C1 — `.obsidian/` versionada en el repo
- **Problema**: La carpeta `.obsidian/` está commiteada y visible en la raíz
- **Por qué**: `.gitignore` tiene `*.obsidian` (incorrecto) en vez de `.obsidian/` (con barra)
- **Fix**: `git rm -r --cached .obsidian/` + corregir `.gitignore`
- **Quién**: Terminal Acer o yo vía MCP
- **Issue a crear**: sí — label `repo-health`, `needs-terminal: SÍ`

### C2 — Duplicidad `/diarios/` raíz vs `docs/diarios/`
- **Problema**: Dos carpetas de diarios. `/diarios/` raíz marcada deprecated en commits pero sin eliminar
- **Fix**: Eliminar `/diarios/` raíz o dejar solo un `README.md` de redirección
- **Quién**: Yo vía MCP (delete_file por cada fichero)
- **Issue a crear**: sí

### C3 — Duplicidad `osint/` + `osint-stack/`
- **Problema**: Dos carpetas del mismo dominio. Sin documentación de diferencia en CONVENCIONES ni HOME
- **Fix**: Auditar contenido → fusionar o documentar diferencia en README de cada carpeta
- **Quién**: Tú (revisar contenido) + yo (documentar)
- **Issue a crear**: sí

### C4 — Duplicidad `infra/` raíz + `docs/infra/`
- **Problema**: `infra/` en raíz y `docs/infra/` dentro de docs. Sin separación código/docs clara
- **Fix**: `infra/` raíz = configs/código real. `docs/infra/` = documentación. Documentar en CONVENCIONES
- **Quién**: Tú (decidir criterio) + yo (documentar CONVENCIONES)
- **Issue a crear**: sí

### C5 — Duplicidad `agentes/` raíz + `docs/agentes/`
- **Problema**: Misma situación que infra. Carpeta `/agentes/` en raíz sin README
- **Fix**: Añadir README explicando propósito o fusionar con `docs/agentes/`
- **Quién**: Yo vía MCP

---

## 🟠 DISCORDANCIAS ESTRUCTURALES

### D1 — Tres carpetas de herramientas solapadas
- `tools/`, `cli-tools/`, `scripts/` — propósitos sin documentar
- **Fix**: En CONVENCIONES.md añadir sección que explique:
  - `scripts/` = scripts de automatización del repo (Python, bash)
  - `cli-tools/` = herramientas CLI externas configuradas
  - `tools/` = ¿deprecado? ¿fusionar con scripts/?
- **Prioridad**: Media

### D2 — `setup/` invisible para el ecosistema
- No aparece en HOME.md, ECOSISTEMA.md ni ROADMAP.md
- **Fix**: Añadir README o referenciar en HOME.md

### D3 — `mocs/` convención Obsidian mezclada con repo Git
- MOCs son concepto de Obsidian. En repo debería estar en `docs/mocs/` o eliminarse
- **Fix**: Mover a `docs/mocs/` y referenciar desde HOME.md

### D4 — `alvarofernandezmota-tech/` carpeta de perfil GitHub en repo equivocado
- El perfil README de GitHub debe estar en un repo SEPARADO llamado `alvarofernandezmota-tech`
- Tenerlo aquí dentro es confuso y no funciona como perfil público
- **Fix**: Crear repo `alvarofernandezmota-tech` en GitHub y mover el README ahí
- **Prioridad**: Media

### D5 — `yo/` — propósito completamente opaco
- Ningún colaborador ni IA sabe qué contiene
- **Fix**: Añadir README o documentar en HOME.md / CONVENCIONES.md

---

## 🟡 ROOT BLOAT — Demasiados .md en raíz

**Estado actual**: 12 ficheros .md en raíz (límite profesional: 4-5)

```
RAÍZ ACTUAL (12 .md):
  README.md          ← MANTENER
  CHANGELOG.md       ← MANTENER
  CONTRIBUTING.md    ← MANTENER
  CONVENCIONES.md    ← MANTENER (o mover a docs/)
  AGENT.md           ← MANTENER (lo usan las IAs)
  HOME.md            ← MOVER a docs/ o fusionar con README
  CONTEXT.md         ← MOVER a docs/context/
  ECOSISTEMA.md      ← MOVER a docs/ecosistema/
  ESTADO-SISTEMA.md  ← MOVER a docs/infra/
  MASTER-PENDIENTES  ← MOVER a docs/ o convertir en Project GitHub
  PLAN-SEGURIDAD...  ← MOVER a docs/seguridad/
  ROADMAP.md         ← DEBATIR: puede quedarse en raíz
```

**Candidatos claros a mover**: HOME, CONTEXT, ECOSISTEMA, ESTADO-SISTEMA, PLAN-SEGURIDAD-Y-DESPLIEGUE

---

## ✅ LO QUE ESTÁ BIEN (no tocar)

- `.github/` — bien estructurado (templates, CODEOWNERS, Actions)
- `CONVENCIONES.md` — sólido y reciente
- `inbox/procesado/` — flujo inbox funcionando
- `templates/` — tiene sentido en raíz
- `docker/`, `ollama/` — carpetas técnicas con propósito claro
- Commits con Conventional Commits — consistentes

---

## Issues a crear (cuando tengamos labels)

| # | Título | Labels |
|---|---|---|
| - | fix(repo): eliminar .obsidian/ del repo y corregir .gitignore | `repo-health`, `bug` |
| - | fix(repo): eliminar /diarios/ raíz deprecated | `repo-health`, `limpieza` |
| - | fix(repo): fusionar osint/ + osint-stack/ | `repo-health`, `discordancia` |
| - | fix(repo): documentar infra/ raíz vs docs/infra/ | `repo-health`, `docs` |
| - | feat(repo): limpiar root bloat — mover 5 .md a docs/ | `repo-health`, `refactor` |
| - | fix(repo): mover perfil README a repo propio | `repo-health`, `mejora` |
