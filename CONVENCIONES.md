# 📐 CONVENCIONES — yggdrasil-dew

> **Fuente de verdad única** para estructura, nombrado, commits y flujo de trabajo.
> Todo agente IA, script o contribuidor humano debe leer esto antes de tocar el repo.
> Si algo no está aquí, no está definido. Si está aquí, se cumple.

---

## 1. Estructura objetivo del repositorio

Esta es la estructura **objetivo** (Fase 0 completa):

```
yggdrasil-dew/
│
├── README.md
├── AGENT.md
├── CHANGELOG.md
├── CONTEXT.md
├── CONVENCIONES.md
├── ECOSISTEMA.md
├── ESTADO-SISTEMA.md
├── HOME.md
├── MASTER-PENDIENTES.md
├── PLAN-SEGURIDAD-Y-DESPLIEGUE.md
├── ROADMAP.md
│
├── .env.template
├── .gitignore
├── .github/
│   ├── workflows/
│   └── ISSUE_TEMPLATE/
│
├── infra/
├── docker/
├── scripts/
├── ollama/
├── agentes/
├── osint/
├── proyectos/
├── formacion/
├── hardware/
├── yo/
├── templates/
├── inbox/
└── docs/
    ├── diarios/
    ├── herramientas/
    ├── infra/
    ├── seguridad/
    ├── mocs/
    ├── filosofia/
    ├── agentes/
    └── arquitectura/
```

### Estado de migración pendiente (requiere terminal)

| Origen actual | Destino | Comando |
|---|---|---|
| `diarios/` | `docs/diarios/` | `git mv diarios/ docs/diarios/` |
| `osint-stack/` | fusionar en `osint/` | `git mv osint-stack/* osint/` |
| `cli-tools/` | fusionar en `scripts/` | `git mv cli-tools/* scripts/` |
| `tools/` | revisar y fusionar en `scripts/` | manual |
| `mocs/` | `docs/mocs/` | `git mv mocs/ docs/mocs/` |
| `setup/` | `scripts/setup/` | `git mv setup/* scripts/setup/` |
| `thdora/` | `infra/thdora/` | `git mv thdora/* infra/thdora/` |

---

## 2. Nombrado de ficheros

| Tipo | Convención | Ejemplo |
|---|---|---|
| Scripts | `kebab-case` + prefijo de acción | `install-docker.sh`, `check-ports.sh` |
| Documentos raíz | `MAYUSCULAS.md` | `README.md`, `ROADMAP.md` |
| Docs en `docs/` | `kebab-case.md` | `ssh-hardening.md` |
| Diarios | `YYYY-MM-DD.md` | `2026-07-03.md` |
| Docker stacks | `docker-compose.yml` en carpeta nombrada | `docker/monitoring/docker-compose.yml` |
| Templates | `_plantilla-*.md` | `_plantilla-documento.md` |

**Reglas:**
- Nunca espacios, tildes ni caracteres especiales en nombres
- Nunca mayúsculas en scripts o docs en subdirectorios
- Nunca `v1`, `v2`, `final`, `nuevo` — usa git para versionar
- Siempre extensión explícita

---

## 3. Commits — Conventional Commits estricto

Formato: `<tipo>(<scope>): <descripción imperativa en minúsculas>`

```
feat(docker):     nueva funcionalidad
fix(infra):       corrección de bug o config
docs(diarios):    solo documentación
chore(repo):      mantenimiento, limpieza
infra(madre):     cambios de infraestructura
security(ssh):    cambios de seguridad
refactor(scripts): reestructuración sin cambio funcional
ci(github):       cambios en GitHub Actions
```

**Reglas:**
- Descripción en minúsculas, modo imperativo
- Máximo 72 caracteres primera línea
- Referencia a issue si existe: `fix(ssh): corregir puerto (#12)`
- Un commit = un cambio lógico

---

## 4. Flujo de trabajo con agentes IA

```
Idea / hallazgo / tarea nueva
        ↓
   inbox/YYYY-MM-DD-*.md     ← siempre aquí primero
        ↓
   procesar: mover al destino correcto
        ↓
   actualizar CONTEXT.md
        ↓
   commit con tipo correcto
        ↓
   (si procede) actualizar MASTER-PENDIENTES.md
```

**Inicio de sesión:** leer AGENT.md → CONTEXT.md → MASTER-PENDIENTES.md  
**Cierre de sesión:** diario → CONTEXT.md → vaciar inbox → commit cierre

---

## 5. Ramas

| Rama | Propósito |
|---|---|
| `main` | Producción — siempre estable |
| `feat/<nombre>` | Nueva funcionalidad |
| `fix/<nombre>` | Corrección |
| `docs/<nombre>` | Solo documentación |
| `chore/<nombre>` | Limpieza / mantenimiento |
| `bot/<nombre>` | Commits automáticos de agentes |

---

## 6. Reglas `.gitignore`

```
.env
*.env
*.key
*.pem
*.apk
*.bin
.obsidian/
.vscode/
__pycache__/
*.pyc
node_modules/
.DS_Store
ly
```

---

## 7. Scripts — cabecera obligatoria

Todo script ejecutable:

```bash
#!/usr/bin/env bash
# =============================================================================
# Nombre:       nombre-script.sh
# Descripción:  Qué hace
# Uso:          ./nombre-script.sh [opciones]
# Requiere:     root / sudo / usuario
# Máquina:      Madre | Thdora | Cualquiera
# Autor:        Alvaro Fernandez Mota <alvarofernandezmota@gmail.com>
# Creado:       YYYY-MM-DD HH:MM CEST
# Actualizado:  YYYY-MM-DD HH:MM CEST
# =============================================================================
set -euo pipefail
```

---

## 8. Documentación — dónde va cada cosa

| Tipo de contenido | Dónde va |
|---|---|
| Diario de sesión | `docs/diarios/YYYY-MM-DD.md` |
| Howto / tutorial herramienta | `docs/herramientas/nombre.md` |
| Arquitectura / diseño | `docs/arquitectura/nombre.md` |
| Hardening / seguridad | `docs/seguridad/nombre.md` |
| Filosofía / reflexión | `docs/filosofia/FILOSOFIA.md` |
| Agentes / bots | `docs/agentes/nombre.md` |
| Estado operativo | `ESTADO-SISTEMA.md` |
| Backlog tareas | `MASTER-PENDIENTES.md` |
| Inventario hardware | `hardware/inventario.md` |

---

## 9. Issues de GitHub

| Label | Uso |
|---|---|
| `fase-0` a `fase-8` | Por fase del roadmap |
| `bug` | Algo roto |
| `docs` | Solo documentación |
| `blocked` | Bloqueado por dependencia |
| `needs-terminal` | Requiere Acer/Madre |
| `mobile-ok` | Se puede hacer desde iPhone |

---

## 10. Profile README

Vive en repo público `alvarofernandezmota-tech`.
Copia de trabajo en `yo/profile-README.md`.

---

## 11. Autoría obligatoria en todos los ficheros 🆕

**Todo fichero creado en el repo debe incluir un bloque de autoría** en el frontmatter YAML (documentos .md) o en la cabecera (scripts .sh, .py, .yml).

### Formato frontmatter YAML (documentos .md)

```yaml
---
tipo: <tipo>              # diario | doc | script | config | arquitectura | filosofia
author: Alvaro Fernandez Mota <alvarofernandezmota@gmail.com>
creado: YYYY-MM-DD HH:MM CEST
actualizado: YYYY-MM-DD HH:MM CEST
ruta: docs/categoria/nombre-fichero.md
tags: [tag1, tag2, tag3]
status: borrador | vigente | deprecado
---
```

### Formato cabecera scripts (.sh / .py)

```bash
# author:    Alvaro Fernandez Mota <alvarofernandezmota@gmail.com>
# creado:    YYYY-MM-DD HH:MM CEST
# actualizado: YYYY-MM-DD HH:MM CEST
# ruta:      scripts/categoria/nombre.sh
# tags:      [tag1, tag2]
```

### Reglas
- `creado` = fecha y hora exacta del primer commit del fichero (CEST)
- `actualizado` = fecha y hora del último commit que lo modifica
- `ruta` = ruta relativa desde raíz del repo
- `tags` = mínimo 2, máximo 6, en minúsculas
- `author` = siempre nombre completo + email
- Los agentes IA que crean ficheros usan el mismo formato con `author: Perplexity-MCP <alvarofernandezmota@gmail.com>` hasta que haya agente propio
- **Ficheros sin bloque de autoría son considerados incompletos** y el workflow inbox-health los marca como pendientes

### Dónde va el bloque de inicio/fin de sesión

El diario `docs/diarios/YYYY-MM-DD.md` es el documento de sesión. Estructura obligatoria:

```markdown
## 🟢 INICIO SESIÓN
- Hora: HH:MM CEST
- Dispositivo: iPhone | Acer | Madre
- Objetivo: ...

## Completado
...

## Pendiente
...

## Decisiones tomadas
...

## 🔴 CIERRE SESIÓN  ← solo si se cierra
- Hora: HH:MM CEST
- Commits esta sesión: N
- Siguiente acción: ...
```

---

_Actualizado: 2026-07-03 01:05 CEST · Fase 0 activa · Perplexity-MCP_
