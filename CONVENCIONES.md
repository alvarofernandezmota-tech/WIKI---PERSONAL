# 📐 CONVENCIONES — yggdrasil-dew

> **Fuente de verdad única** para estructura, nombrado, commits y flujo de trabajo.
> Todo agente IA, script o contribuidor humano debe leer esto antes de tocar el repo.
> Si algo no está aquí, no está definido. Si está aquí, se cumple.

---

## 1. Estructura objetivo del repositorio

Esta es la estructura **objetivo** (Fase 0 completa). Algunos directorios aún están en migración:

```
yggdrasil-dew/
│
├── README.md                  ← entrada pública · descripción del proyecto
├── AGENT.md                   ← contexto para agentes IA · leer al inicio de sesión
├── CHANGELOG.md               ← historial de cambios relevantes
├── CONTEXT.md                 ← estado ACTUAL del ecosistema · actualizar cada sesión
├── CONVENCIONES.md            ← este fichero · fuente de verdad
├── ECOSISTEMA.md              ← arquitectura completa del sistema
├── ESTADO-SISTEMA.md          ← estado operativo de servicios
├── HOME.md                    ← índice de navegación del repo
├── MASTER-PENDIENTES.md       ← backlog maestro · priorizado
├── PLAN-SEGURIDAD-Y-DESPLIEGUE.md ← plan de fases de seguridad
├── ROADMAP.md                 ← roadmap de producto / sistema
│
├── .env.template              ← variables de entorno (nunca .env real)
├── .gitignore                 ← ver sección reglas .gitignore
├── .github/
│   ├── workflows/             ← GitHub Actions
│   └── ISSUE_TEMPLATE/        ← templates de issues
│
├── infra/                     ← configuración de infraestructura
│   ├── madre/                 ← configs Madre (nftables, sshd, hostapd…)
│   ├── thdora/                ← configs Acer Thdora
│   └── ansible/               ← playbooks Ansible
│
├── docker/                    ← stacks docker-compose por servicio
│   ├── batcueva/              ← stack completo Madre
│   ├── monitoring/            ← Grafana + Prometheus + Alertmanager
│   ├── security/              ← Wazuh + Suricata
│   └── README.md
│
├── scripts/                   ← TODOS los scripts ejecutables
│   ├── setup/                 ← instalación inicial de máquinas
│   ├── maintenance/           ← mantenimiento y backups
│   ├── security/              ← scripts de seguridad y auditoría
│   └── README.md
│
├── ollama/                    ← modelos, prompts y config IA local
│   ├── models/
│   ├── prompts/
│   └── README.md
│
├── agentes/                   ← agentes IA · configuraciones · flujos
│
├── osint/                     ← investigación y herramientas OSINT
│   ├── metodologia/
│   ├── herramientas/
│   └── investigaciones/
│
├── proyectos/                 ← proyectos activos con estructura propia
│
├── formacion/                 ← apuntes, cursos, certificaciones
│
├── hardware/                  ← inventario, specs, diagramas de red
│
├── yo/                        ← perfil personal, contexto, CV técnico
│
├── templates/                 ← plantillas reutilizables
│
├── inbox/                     ← zona de entrada temporal · procesar y vaciar
│
└── docs/                      ← toda la documentación narrativa
    ├── diarios/               ← diarios de sesión (migrar desde /diarios/)
    ├── herramientas/          ← docs de herramientas (Perplexity, MCP…)
    ├── infra/                 ← docs narrativos de infraestructura
    ├── seguridad/             ← docs de seguridad y hardening
    ├── mocs/                  ← Maps of Content (índices temáticos)
    └── filosofia.md           ← filosofía de trabajo
```

### Estado de migración pendiente (requiere terminal en Acer)

| Origen actual | Destino | Comando |
|---|---|---|
| `diarios/` | `docs/diarios/` | `git mv diarios/ docs/diarios/` |
| `filosofia.md` | `docs/filosofia.md` | `git mv filosofia.md docs/filosofia.md` |
| `osint-stack/` | fusionar en `osint/` | `git mv osint-stack/* osint/ && git rm -r osint-stack/` |
| `cli-tools/` | fusionar en `scripts/` | `git mv cli-tools/* scripts/ && git rm -r cli-tools/` |
| `tools/` | revisar y fusionar en `scripts/` | manual |
| `mocs/` | `docs/mocs/` | `git mv mocs/ docs/mocs/` |
| `setup/` | `scripts/setup/` | `git mv setup/* scripts/setup/` |
| `thdora/` | `infra/thdora/` | `git mv thdora/* infra/thdora/` |

### Limpieza crítica pendiente (requiere terminal)

```bash
# Eliminar binarios y configs privadas trackeados
git rm --cached tailscale-full.apk
git rm --cached ly
git rm -r --cached .obsidian/
git commit -m "chore: eliminar binarios y .obsidian del tracking"
```

---

## 2. Nombrado de ficheros

| Tipo | Convención | Ejemplo |
|---|---|---|
| Scripts | `kebab-case` + prefijo de acción | `install-docker.sh`, `check-ports.sh` |
| Documentos raíz | `MAYUSCULAS.md` | `README.md`, `ROADMAP.md` |
| Docs en `docs/` | `kebab-case.md` | `ssh-hardening.md` |
| Diarios | `YYYY-MM-DD[-descripcion].md` | `2026-07-02-sesion-noche.md` |
| Docker stacks | `docker-compose.yml` dentro de carpeta nombrada | `docker/monitoring/docker-compose.yml` |
| Configs | `kebab-case` con extensión real | `nftables.conf`, `sshd_config` |
| Templates | `_plantilla-*.md` | `_plantilla-diario.md` |

### Reglas de nombrado
- **Nunca** espacios, tildes, caracteres especiales en nombres de fichero
- **Nunca** mayúsculas en scripts o docs dentro de subdirectorios
- **Nunca** `v1`, `v2`, `final`, `nuevo` en nombres — usa git para versionar
- **Siempre** extensión explícita (`.sh`, `.md`, `.yml`, `.conf`)

---

## 3. Commits — Conventional Commits estricto

Formato: `<tipo>(<scope>): <descripción imperativa en minúsculas>`

```
feat(docker):     nueva funcionalidad
fix(infra):       corrección de bug o config
docs(diarios):    solo documentación
chore(repo):      mantenimiento, limpieza, deps
infra(madre):     cambios de infraestructura
security(ssh):    cambios de seguridad
refactor(scripts): reestructuración sin cambio funcional
ci(github):       cambios en GitHub Actions
test:             añadir o corregir tests
```

**Reglas de commit:**
- Descripción en minúsculas, modo imperativo: `add`, `update`, `remove`, `fix` — nunca `Added`, `Updated`
- Máximo 72 caracteres en la primera línea
- Si el commit afecta a más de un scope, usar el más relevante
- Referencia a issue si existe: `fix(ssh): corregir puerto en sshd_config (#12)`
- **Un commit = un cambio lógico.** No mezclar infraestructura con docs con scripts.

---

## 4. Flujo de trabajo con agentes IA

```
Idea / hallazgo / tarea nueva
        ↓
   inbox/YYYY-MM-DD-*.md     ← siempre aquí primero, nunca editar directo
        ↓
   procesar: mover al destino correcto
        ↓
   actualizar CONTEXT.md     ← estado actual del sistema
        ↓
   commit con tipo correcto
        ↓
   (si procede) actualizar MASTER-PENDIENTES.md / ROADMAP.md
```

**Orden de actualización al inicio de sesión:**
1. Leer `AGENT.md` — contexto estructural
2. Leer `CONTEXT.md` — estado actual
3. Leer `MASTER-PENDIENTES.md` — qué está pendiente

**Orden de actualización al cierre de sesión:**
1. Escribir diario en `diarios/` (o `docs/diarios/` tras migración)
2. Actualizar `CONTEXT.md` con cambios de la sesión
3. Procesar o vaciar `inbox/` si hay items
4. Commit de cierre

---

## 5. Ramas

| Rama | Propósito |
|---|---|
| `main` | Producción — siempre estable |
| `feat/<nombre>` | Nueva funcionalidad |
| `fix/<nombre>` | Corrección |
| `docs/<nombre>` | Solo documentación |
| `refactor/<nombre>` | Reestructuración |
| `chore/<nombre>` | Limpieza / mantenimiento |
| `bot/<nombre>` | Commits automáticos de agentes |

**Regla:** nada va directo a `main` que no sea:
- Commits de diarios / documentación de sesión
- Hotfixes críticos
- Commits de cierre de sesión

Cualquier cambio de infraestructura, script o config → rama + PR.

---

## 6. Reglas `.gitignore` — qué NUNCA entra en el repo

```
# Secrets y datos sensibles
.env
*.env
*.key
*.pem
*.p12
id_rsa
id_ed25519

# Binarios y APKs
*.apk
*.bin
*.exe
*.iso
*.img
ly

# IDEs y configs privadas
.obsidian/
.vscode/
.idea/
*.swp

# Build artifacts
__pycache__/
*.pyc
node_modules/
dist/
build/

# OS
.DS_Store
Thumbs.db
```

---

## 7. Scripts — cabecera obligatoria

Todo script ejecutable debe tener esta cabecera:

```bash
#!/usr/bin/env bash
# =============================================================================
# Nombre:       install-docker.sh
# Descripción:  Instala Docker en Arch Linux y configura el servicio
# Uso:          ./install-docker.sh [--dry-run]
# Requiere:     root / sudo
# Máquina:      Madre | Thdora | Cualquiera
# Actualizado:  YYYY-MM-DD
# =============================================================================
set -euo pipefail
```

---

## 8. Documentación — dónde va cada cosa

| Tipo de contenido | Dónde va |
|---|---|
| Diario de sesión | `docs/diarios/YYYY-MM-DD[-desc].md` |
| Howto / tutorial de herramienta | `docs/herramientas/nombre-herramienta.md` |
| Arquitectura / diseño | `docs/infra/nombre.md` |
| Hardening / seguridad | `docs/seguridad/nombre.md` |
| Filosofía / reflexión | `docs/filosofia.md` |
| Mapa de contenidos temático | `docs/mocs/nombre.md` |
| Estado operativo de servicios | `ESTADO-SISTEMA.md` (raíz) |
| Backlog de tareas | `MASTER-PENDIENTES.md` (raíz) |
| Inventario hardware | `hardware/inventario.md` |

---

## 9. Issues de GitHub — etiquetas y plantillas

| Label | Uso |
|---|---|
| `fase-0` | Limpieza y estructura del repo |
| `fase-1` | Tailscale / acceso remoto |
| `fase-2` | SSH hardening |
| `fase-3` | Wazuh SIEM |
| `fase-4` | Suricata IDS |
| `fase-5` | GitHub Actions / automatización |
| `fase-6` | Cursor + MCP Thdora |
| `bug` | Algo roto |
| `docs` | Solo documentación |
| `blocked` | Bloqueado por dependencia |
| `needs-terminal` | Requiere ejecutar comandos en Acer |
| `mobile-ok` | Se puede hacer desde móvil/Perplexity |

---

## 10. Profile README

El Profile README de GitHub (`alvarofernandezmota-tech`) **no vive en este repo**.
Vive en un repo público separado llamado exactamente `alvarofernandezmota-tech`.
La copia de trabajo está en `yo/profile-README.md` dentro de este repo.

---

_Actualizado: 02-jul-2026 · Fase 0 activa · Perplexity vía MCP_
