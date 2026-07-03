---
tipo: normas
author: Alvaro Fernandez Mota <alvarofernandezmota@gmail.com>
creado: 2026-06-01 00:00 CEST
actualizado: 2026-07-03 23:55 CEST
ruta: CONVENCIONES.md
tags: [normas, convenciones, ecosistema, agentes, deuda-tecnica]
status: vigente
---

# 📐 CONVENCIONES — yggdrasil-dew

> **Fuente de verdad única** para estructura, nombrado, commits, flujo de trabajo, deuda técnica, etiquetas y protocolo de sesión.
> Todo agente IA, script, Copilot o contribuidor humano DEBE leer esto antes de tocar el repo.
> Si algo no está aquí, no está definido. Si está aquí, se cumple sin excepción.

---

## ÍNDICE
1. Estructura objetivo del repo
2. Nombrado de ficheros
3. Commits — Conventional Commits
4. Flujo de trabajo con agentes IA
5. Ramas
6. Reglas .gitignore
7. Scripts — cabecera obligatoria
8. Documentación — dónde va cada cosa
9. Issues, Labels y Estados
10. Protocolo de deuda técnica
11. Protocolo de sesión (apertura → trabajo → cierre)
12. Protocolo ELO de pruebas
13. Protocolo terminal-logger (todo en terminal queda documentado)
14. Protocolo Copilot (cuándo entra y con qué contexto)
15. Islas — mapa y owners
16. Autoría obligatoria en todos los ficheros

---

## 1. Estructura objetivo del repositorio

```
yggdrasil-dew/
│
├── README.md
├── AGENT.md
├── CHANGELOG.md
├── CONTEXT.md
├── CONVENCIONES.md
├── COPILOT-CONTEXT.md
├── ECOSISTEMA.md
├── ESTADO-SISTEMA.md
├── HOME.md
├── HERRAMIENTAS-ECOSISTEMA.md
├── MAPA-ISLAS.md
├── MASTER-PENDIENTES.md
├── PLAN-SEGURIDAD-Y-DESPLIEGUE.md
├── ROADMAP-MASTER.md
├── ROADMAP.md
│
├── .env.template
├── .gitignore
├── .github/
│   ├── workflows/
│   └── ISSUE_TEMPLATE/
│
├── scripts/
│   ├── agentes/          ← ÚNICO lugar para agentes
│   │   ├── agente-mejorador.sh
│   │   ├── agente-fixer.sh
│   │   ├── agente-vigilante.sh
│   │   ├── agente-cierre-sesion.sh
│   │   ├── agente-meta-deep.sh
│   │   ├── agente-deuda-detecta.sh
│   │   ├── agente-deuda-registra.sh
│   │   ├── agente-deuda-prioriza.sh
│   │   ├── agente-estado-tracker.sh
│   │   ├── terminal-logger.sh
│   │   └── galatea-fabrica-agentes.sh
│   └── (scripts generales)
│
├── infra/
├── docker/
├── mcp/
├── ollama/
├── islas/
├── osint/              ← ÚNICO (osint-stack/ fusionado aquí)
├── proyectos/
├── formacion/
├── hardware/
├── investigacion/
├── yo/
├── thdora/
├── templates/
├── tests/
├── inbox/
│   ├── terminal-log/   ← logs de terminal
│   ├── mejorador/      ← reports del mejorador
│   └── deuda/          ← deuda técnica detectada
└── docs/
    ├── diarios/        ← ÚNICO (diary/ y diarios/ fusionados aquí)
    ├── herramientas/
    ├── infra/
    ├── seguridad/
    ├── mocs/
    ├── filosofia/
    ├── agentes/
    └── arquitectura/
```

### Duplicados pendientes de resolver (DEUDA FASE 0)

| Duplicado actual | Destino canónico | Script de migración |
|---|---|---|
| `diary/` + `diarios/` | `docs/diarios/` | `agente-deuda-migra.sh --target diarios` |
| `osint/` + `osint-stack/` | `osint/` | `agente-deuda-migra.sh --target osint` |
| `agentes/` + `scripts/agentes/` | `scripts/agentes/` | `agente-deuda-migra.sh --target agentes` |

**Regla:** ningún duplicado puede existir más de 7 días sin issue abierto con label `deuda-tecnica`.

---

## 2. Nombrado de ficheros

| Tipo | Convención | Ejemplo |
|---|---|---|
| Scripts | `kebab-case` + prefijo de acción | `install-docker.sh`, `check-ports.sh` |
| Agentes | `agente-<función>.sh` | `agente-mejorador.sh` |
| Documentos raíz | `MAYUSCULAS.md` | `README.md`, `ROADMAP.md` |
| Docs en `docs/` | `kebab-case.md` | `ssh-hardening.md` |
| Diarios | `YYYY-MM-DD.md` | `2026-07-03.md` |
| Logs terminal | `YYYYMMDDTHHMMSSZ-<label>.md` | `20260703T235500Z-mejorador-run.md` |
| Docker stacks | `docker-compose.yml` en carpeta nombrada | `docker/monitoring/docker-compose.yml` |
| Templates | `_plantilla-*.md` | `_plantilla-documento.md` |
| Tests | `test-<nombre>.sh` | `test-mejorador.sh` |

**Reglas absolutas:**
- Nunca espacios, tildes ni caracteres especiales en nombres de archivo
- Nunca mayúsculas en scripts o docs en subdirectorios
- Nunca `v1`, `v2`, `final`, `nuevo` — usa git para versionar
- Siempre extensión explícita
- Agentes siempre en `scripts/agentes/` — nunca en `agentes/` raíz

---

## 3. Commits — Conventional Commits estricto

Formato: `<tipo>(<scope>): <descripción imperativa en minúsculas>`

```
feat(docker):       nueva funcionalidad
fix(infra):         corrección de bug o config
docs(diarios):      solo documentación
chore(repo):        mantenimiento, limpieza
infra(madre):       cambios de infraestructura
security(ssh):      cambios de seguridad
refactor(scripts):  reestructuración sin cambio funcional
ci(github):         cambios en GitHub Actions
debt(scripts):      resolución de deuda técnica
test(agentes):      añadir o modificar tests
```

**Reglas:**
- Descripción en minúsculas, modo imperativo
- Máximo 72 caracteres primera línea
- Referencia a issue si existe: `fix(ssh): corregir puerto (#12)`
- Un commit = un cambio lógico
- Commits de agentes: incluir `[bot]` en author

---

## 4. Flujo de trabajo con agentes IA

```
Idea / hallazgo / tarea nueva
        ↓
   inbox/YYYY-MM-DD-*.md        ← siempre aquí primero
        ↓
   agente-estado-tracker.sh     ← etiqueta estado
        ↓
   procesar: mover al destino correcto
        ↓
   actualizar CONTEXT.md
        ↓
   commit con tipo correcto
        ↓
   (si procede) actualizar MASTER-PENDIENTES.md
        ↓
   (si deuda) agente-deuda-registra.sh → issue GitHub
```

**Inicio de sesión:** leer AGENT.md → CONTEXT.md → MASTER-PENDIENTES.md → estado actual
**Cierre de sesión:** agente-cierre-sesion.sh → diario → CONTEXT.md → vaciar inbox → commit cierre

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
| `agent-fix/<nombre>` | Fixes propuestos por agente-mejorador |
| `debt/<nombre>` | Resolución de deuda técnica |
| `copilot/<nombre>` | Trabajo de Copilot (siempre en rama, nunca directo a main) |

---

## 6. Reglas .gitignore

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
inbox/terminal-log/*.typescript
```

---

## 7. Scripts — cabecera obligatoria

Todo script ejecutable DEBE tener esta cabecera exacta:

```bash
#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# =============================================================================
# Nombre:       nombre-script.sh
# Función única: UNA SOLA FRASE que describe exactamente qué hace
# Rol:          auditor | mejorador | vigilante | fixer | fabrica | logger | tracker
# Versión:      X.Y
# Autor:        Alvaro Fernandez Mota <alvarofernandezmota@gmail.com>
# Creado:       YYYY-MM-DD HH:MM CEST
# Actualizado:  YYYY-MM-DD HH:MM CEST
# Ruta:         scripts/agentes/nombre-script.sh
# Tags:         [tag1, tag2]
# Flags:
#   --dry-run   Simula sin escribir nada
#   --verbose   Log detallado
#   --out DIR   Directorio de salida (default: inbox/nombre/)
# =============================================================================

log(){ printf '%s %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$*"; }
on_err(){ log "ERROR at line $1"; exit 2; }
trap 'on_err $LINENO' ERR
```

**Reglas adicionales de scripts:**
- Siempre `set -euo pipefail` en la línea 2
- Siempre `trap` de errores
- Siempre función `log()` con timestamp UTC
- Siempre soporte `--dry-run` para operaciones destructivas
- Siempre soporte `--verbose`
- Siempre guardar output en `inbox/<nombre-agente>/`
- Scripts sin cabecera completa = detectados por `agente-deuda-detecta.sh` como deuda

---

## 8. Documentación — dónde va cada cosa

| Tipo de contenido | Dónde va |
|---|---|
| Diario de sesión | `docs/diarios/YYYY-MM-DD.md` |
| Log de terminal | `inbox/terminal-log/YYYYMMDDTHHMMSSZ-<label>.md` |
| Report de agente | `inbox/<nombre-agente>/YYYYMMDDTHHMMSSZ.json` |
| Deuda técnica detectada | `inbox/deuda/YYYYMMDDTHHMMSSZ-<tipo>.json` |
| Howto / tutorial herramienta | `docs/herramientas/nombre.md` |
| Arquitectura / diseño | `docs/arquitectura/nombre.md` |
| Hardening / seguridad | `docs/seguridad/nombre.md` |
| Filosofía / reflexión | `docs/filosofia/FILOSOFIA.md` |
| Agentes / bots | `docs/agentes/nombre.md` |
| Estado operativo | `ESTADO-SISTEMA.md` |
| Backlog tareas | `MASTER-PENDIENTES.md` |
| Inventario hardware | `hardware/inventario.md` |
| Procesos por trabajador | `docs/PROCESSOS.md` |

---

## 9. Issues, Labels y Estados

### Labels de GitHub (sistema completo)

| Label | Color | Uso |
|---|---|---|
| `fase-0` … `fase-8` | azul | Por fase del roadmap |
| `bug` | rojo | Algo roto |
| `docs` | verde claro | Solo documentación |
| `blocked` | naranja | Bloqueado por dependencia |
| `needs-terminal` | amarillo | Requiere Madre/Acer |
| `mobile-ok` | verde | Se puede hacer desde iPhone |
| `deuda-tecnica` | morado oscuro | Deuda técnica detectada |
| `duplicado` | gris | Carpeta/archivo duplicado |
| `sin-tests` | rojo claro | Sin cobertura de tests |
| `sin-docs` | naranja claro | Sin documentación |
| `copilot-ready` | azul claro | Contexto suficiente para Copilot |
| `en-proceso` | amarillo | Trabajo activo en curso |
| `completado` | verde | Terminado y validado |
| `por-hacer` | blanco/gris | Pendiente, sin empezar |
| `sla-violation` | rojo | Violación de SLA detectada |
| `agent-fix` | azul oscuro | Fix propuesto por agente |

### Estados de artefactos (usado por agente-estado-tracker)

Todo archivo en `inbox/` tiene un estado en su frontmatter o nombre:

```
🔴 por-hacer     → detectado, sin acción
🟡 en-proceso    → asignado, trabajo en curso
🟢 completado    → terminado, validado, puede archivarse
⚪ archivado     → movido a docs/ o destino final
🔵 bloqueado     → necesita algo externo para avanzar
```

### Reglas de etiquetado
- Todo issue abierto por un agente lleva `agent-fix` + label de tipo
- Todo issue de deuda lleva `deuda-tecnica` + label de categoría
- Ningún issue puede estar más de 72h sin label de estado
- `agente-estado-tracker.sh` revisa y actualiza estados automáticamente

---

## 10. Protocolo de deuda técnica

La deuda técnica tiene un ciclo de vida con 4 agentes especializados:

```
DETECCIÓN  →  REGISTRO  →  PRIORIZACIÓN  →  MIGRACIÓN
   agente-deuda-detecta.sh
                   ↓
            agente-deuda-registra.sh  →  issue GitHub (label: deuda-tecnica)
                                 ↓
                    agente-deuda-prioriza.sh  →  ordena por impacto
                                        ↓
                           agente-deuda-migra.sh  →  aplica con dry-run primero
```

### Categorías de deuda detectadas automáticamente

| Categoría | Qué busca | Prioridad |
|---|---|---|
| `duplicados` | Carpetas/archivos duplicados | ALTA |
| `sin-shebang` | Scripts sin `#!/usr/bin/env bash` | ALTA |
| `sin-strict` | Scripts sin `set -euo pipefail` | ALTA |
| `sin-cabecera` | Scripts sin bloque de autoría completo | MEDIA |
| `sin-tests` | Scripts sin test correspondiente en `tests/` | MEDIA |
| `sin-docs` | Scripts/agentes sin doc en `docs/agentes/` | MEDIA |
| `todos-fixmes` | Archivos con TODO/FIXME/HACK | BAJA |
| `archivos-vacios` | Archivos con 0 bytes o solo whitespace | ALTA |
| `links-rotos` | Referencias a rutas inexistentes en docs | MEDIA |

### Comando para ejecutar ciclo completo de deuda
```bash
bash scripts/agentes/terminal-logger.sh --label "deuda-ciclo-$(date +%F)" -- bash -c "
  bash scripts/agentes/agente-deuda-detecta.sh --verbose &&
  bash scripts/agentes/agente-deuda-registra.sh --verbose &&
  bash scripts/agentes/agente-deuda-prioriza.sh --verbose
"
```

---

## 11. Protocolo de sesión

### Apertura
```bash
bash scripts/agentes/terminal-logger.sh --session --label "sesion-$(date +%F)"
# Dentro de la sesión grabada:
git pull origin main
cat AGENT.md
cat CONTEXT.md
cat MASTER-PENDIENTES.md
bash scripts/agentes/agente-vigilante.sh --verbose
```

### Trabajo
- Todo comando relevante pasa por `terminal-logger.sh` o se ejecuta dentro de la sesión grabada
- Cada acción completada: actualizar estado en `inbox/` con `agente-estado-tracker.sh`
- Cada deuda detectada: `agente-deuda-detecta.sh` + `agente-deuda-registra.sh`

### Cierre
```bash
bash scripts/agentes/agente-cierre-sesion.sh --verbose
# Esto hace:
# 1. Escribe diario en docs/diarios/YYYY-MM-DD.md
# 2. Actualiza CONTEXT.md
# 3. Vacía inbox procesado
# 4. Commit de cierre
# 5. Push a main
exit  # cierra la sesión grabada → guarda en inbox/terminal-log/
```

---

## 12. Protocolo ELO de pruebas

Antes de marcar cualquier script como `completado` debe pasar el protocolo ELO:

```
E — Ejecutar en dry-run
  bash scripts/agentes/<agente>.sh --dry-run --verbose
  ↓ Output guardado en inbox/terminal-log/

L — Leer output y verificar
  - ¿Tiene timestamp en cada línea? ✓
  - ¿Muestra qué haría sin hacer nada? ✓
  - ¿No tiene errores de sintaxis? ✓
  - ¿Sale con código 0? ✓

O — Operar (aplicar si L pasa)
  bash scripts/agentes/<agente>.sh --apply --verbose
  ↓ Output guardado en inbox/terminal-log/
  ↓ agente-estado-tracker.sh --mark completado <archivo>
```

**Regla:** ningún agente pasa a producción sin haber pasado ELO completo con log en `inbox/terminal-log/`.

---

## 13. Protocolo terminal-logger

**Regla fundamental:** TODO lo que se ejecuta en terminal relacionado con el repo debe quedar documentado en `inbox/terminal-log/`.

### Cómo usar

```bash
# Wrappear cualquier comando:
bash scripts/agentes/terminal-logger.sh --label "<etiqueta>" -- <comando>

# Sesión completa (recomendado para trabajo largo):
bash scripts/agentes/terminal-logger.sh --session --label "sesion-$(date +%F)"

# Pipe de output:
<comando> | bash scripts/agentes/terminal-logger.sh --stdin --label "<etiqueta>"

# Nota manual:
bash scripts/agentes/terminal-logger.sh --note "Hice X porque Y"
```

### Cuándo es obligatorio
- Siempre que se ejecute un agente por primera vez
- Siempre que se ejecute una migración o fix
- Siempre en sesiones de prueba (protocolo ELO)
- Siempre en ejecuciones de GitHub Actions locales

---

## 14. Protocolo Copilot

Copilot entra en **dos fases únicas** y nunca antes:

### Fase 1 — Copilot como lector de contexto
**Cuándo:** cuando `inbox/` tiene al menos 3 artefactos procesados y `CONTEXT.md` está actualizado.
**Qué hace:** lee `COPILOT-CONTEXT.md`, `AGENT.md`, `CONVENCIONES.md` y propone código.
**Restricción:** siempre en rama `copilot/<nombre>`, nunca directo a `main`.

### Fase 2 — Copilot como revisor de PRs
**Cuándo:** cuando hay PRs de branches `agent-fix/*` o `debt/*`.
**Qué hace:** revisa el diff, añade comentarios de revisión.
**Restricción:** sus sugerencias se validan con `agente-fixer.sh --dry-run` antes de aplicar.

### Lo que Copilot NUNCA debe hacer
- Crear archivos en `main` directamente
- Modificar `CONVENCIONES.md`, `AGENT.md`, `CONTEXT.md` sin revisión humana
- Ejecutar migraciones sin dry-run
- Crear issues o labels sin que el agente-deuda-registra lo haya hecho primero

### Contexto mínimo para Copilot
Antes de invocar Copilot, verificar que existen y están actualizados:
- `COPILOT-CONTEXT.md` ✓
- `AGENT.md` ✓
- `CONVENCIONES.md` ✓ (este archivo)
- `HERRAMIENTAS-ECOSISTEMA.md` ✓
- `MAPA-ISLAS.md` ✓

---

## 15. Islas — mapa y owners

| Isla | Carpeta | Owner | Estado | Agente responsable |
|---|---|---|---|---|
| OSINT | `osint/` | alvaro | ⚠️ duplicado con osint-stack/ | agente-deuda-migra |
| Hardware | `hardware/` | alvaro | 🟢 ok | agente-vigilante |
| Formación | `formacion/` | alvaro | 🟡 en progreso | agente-meta-deep |
| Investigación | `investigacion/` | alvaro | 🟡 en progreso | agente-meta-deep |
| Proyectos | `proyectos/` | alvaro | 🟡 en progreso | agente-mejorador |
| Yo / Perfil | `yo/` | alvaro | 🟢 ok | — |
| Thdora | `thdora/` | alvaro | 🟡 pendiente migración | agente-deuda-migra |
| Infra | `infra/` | alvaro | 🟡 en progreso | agente-vigilante |
| MCP | `mcp/` | alvaro | 🔴 socket pendiente | — |

**Regla:** cada isla tiene un `README.md` propio con su estado, owner y agente responsable.

---

## 16. Autoría obligatoria en todos los ficheros

Todo fichero creado en el repo debe incluir un bloque de autoría:

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

### Reglas
- `creado` = fecha y hora exacta del primer commit
- `actualizado` = fecha y hora del último commit que lo modifica
- `ruta` = ruta relativa desde raíz del repo
- `tags` = mínimo 2, máximo 6, en minúsculas
- Los agentes IA usan: `author: Perplexity-MCP <alvarofernandezmota@gmail.com>`
- **Ficheros sin bloque de autoría = deuda técnica detectada por agente-deuda-detecta**

### Estructura obligatoria del diario de sesión

```markdown
## 🟢 INICIO SESIÓN
- Hora: HH:MM CEST
- Dispositivo: iPhone | Acer | Madre
- Objetivo: ...
- Estado anterior: (leer ESTADO-SISTEMA.md)

## Completado
- [ ] tarea 1

## En proceso
- [ ] tarea 2

## Pendiente
- [ ] tarea 3

## Decisiones tomadas
...

## Deuda detectada
...

## 🔴 CIERRE SESIÓN
- Hora: HH:MM CEST
- Commits esta sesión: N
- Log terminal: inbox/terminal-log/FECHA-sesion.md
- Siguiente acción: ...
```

---

_Actualizado: 2026-07-03 23:55 CEST · Fase 0 activa · Perplexity-MCP_
