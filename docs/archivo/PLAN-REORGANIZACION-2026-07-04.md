---
tags: [plan, reorganizacion, estructura, meta]
fecha: 2026-07-04
estado: EN EJECUCIÓN
---

# PLAN DE REORGANIZACIÓN — 2026-07-04

> **Documento ley de la sesión 2026-07-04.**
> Todo lo que hagamos hoy sigue este plan. Si algo no está aquí, se para y se añade antes de ejecutar.
> Última actualización: 2026-07-04 23:20 CEST

---

## ¿Por qué este plan?

El ecosistema ha crecido mezclando:
- Código de proyectos con documentación del cerebro
- Scripts locales con GitHub Actions
- Agentes/prompts IA con herramientas
- Tareas de repos distintos en un solo MASTER-PENDIENTES
- Carpetas duplicadas (`diarios/` raíz + `docs/diarios/`)
- Archivos `.md` sueltos en raíz que deberían estar en `docs/`

**El resultado:** todo está en yggdrasil-dew y nada se encuentra.

---

## PRINCIPIO FUNDAMENTAL

> **Un repo = un dominio = un equipo/herramienta responsable.**
> Los repos se conectan por referencia (links), no físicamente.
> yggdrasil-dew es el CEREBRO — solo vive documentación, no código de proyectos.

---

## MAPA DE REPOS — quién es quién

| Repo | Dominio | Qué contiene | Issues de |
|---|---|---|---|
| `yggdrasil-dew` | 🧠 Second brain | Docs, diarios, contexto, inbox, convenciones | Infra servidor, brain, meta/org |
| `thdora` | 🤖 Bot THDORA | FastAPI + handlers + Telegram bot | Handlers, bugs thdora, features |
| `yggdrasil-secops` | 🔐 Seguridad | Bots watchdog, guardian-bot, defensa | Seguridad, bots vigilancia |
| `local-brain` | 🧬 IA local | Ollama, Qdrant, RAG, embeddings | IA local, modelos, RAG |
| `osint-stack` | 🕵️ OSINT | SpiderFoot, herramientas OSINT | OSINT, investigación |
| `batcueva` *(pendiente crear)* | 🏰 Infra ejecutable | Docker configs, SOPS, Compose files | Infra ejecutable, deploys |

### Regla de oro — ¿dónde va cada tarea?
```
¿Es un handler/feature de thdora?       → Issue en thdora
¿Es un bot watchdog o seguridad?        → Issue en yggdrasil-secops
¿Es Ollama/RAG/embeddings?              → Issue en local-brain
¿Es Docker Compose / config infra?      → Issue en batcueva (cuando exista)
¿Es el servidor madre / red / hardware? → Issue en yggdrasil-dew (label: infra)
¿Es documentación / brain / obsidian?   → Issue en yggdrasil-dew (label: brain)
¿Es organización del propio repo?       → Issue en yggdrasil-dew (label: meta)
```

---

## LAS 3 CAPAS — nunca mezclarlas

### Capa 1 — GitHub Actions `.github/workflows/`
- **Qué son:** Automatizaciones que corren en servidores de GitHub.
- **Cuándo corren:** Push, schedule (cron GitHub), o manual desde GitHub web.
- **Regla:** Solo viven en `.github/workflows/`. Nunca duplicar como script local.
- **Ejemplos:** `auto-audit.yml`, `ci.yml`, `label-sync.yml`

### Capa 2 — Scripts `scripts/`
- **Qué son:** Bash/Python que ejecutas TÚ en madre/theodora, o el cron de tu sistema.
- **Cuándo corren:** Manualmente, o via `crontab` en madre.
- **Regla:** Solo en `scripts/` organizados por subdirectorio de dominio.
- **Estructura:**
  ```
  scripts/
  ├── infra/          ← docker, red, sistema (se ejecutan en madre)
  ├── maintenance/    ← cierre sesión, cron nocturno, limpieza
  ├── thdora/         ← scripts relacionados con el bot
  └── brain/          ← scripts del second brain / obsidian
  ```

### Capa 3 — Agentes `agentes/`
- **Qué son:** Contexto, prompts e instrucciones para IAs (Perplexity, Copilot, thdora).
- **Cuándo se usan:** Una IA los lee antes de actuar sobre el repo.
- **Regla:** Solo en `agentes/`. No son scripts, no son workflows.
- **Estructura:**
  ```
  agentes/
  ├── AGENT.md              ← instrucciones generales para cualquier IA
  ├── perplexity/           ← contexto específico para Perplexity + MCP
  ├── copilot/              ← instrucciones para GitHub Copilot
  └── thdora/               ← prompts de los handlers del bot
  ```

---

## ESTRUCTURA FINAL yggdrasil-dew

```
yggdrasil-dew/
│
├── README.md                        ← entrada pública al repo
├── HOME.md                          ← punto de entrada diario (Obsidian)
├── ECOSYSTEM-ARCHITECTURE.md        ← ley máxima del ecosistema
├── MASTER-PENDIENTES.md             ← SOLO P0+P1 con links a Issues reales
├── CONVENCIONES.md                  ← reglas del vault
│
├── docs/
│   ├── ROADMAP-MASTER.md
│   ├── CHANGELOG.md
│   ├── CONTEXT.md                   ← contexto para IAs
│   ├── CONTRIBUTING.md
│   ├── ecosistema/
│   │   ├── ECOSISTEMA.md            ← (ya movido ✅)
│   │   ├── HERRAMIENTAS-ECOSISTEMA.md
│   │   └── MAPA-ISLAS.md
│   ├── proyectos/                   ← un .md por proyecto, NO código
│   │   ├── thdora.md
│   │   ├── secops.md
│   │   ├── local-brain.md
│   │   └── osint-stack.md
│   ├── infra/
│   │   ├── ESTADO-SISTEMA.md
│   │   ├── PLAN-SEGURIDAD-Y-DESPLIEGUE.md
│   │   └── hardware/
│   ├── seguridad/
│   │   └── hallazgos/
│   ├── diarios/                     ← ÚNICO lugar para diarios
│   ├── sesiones/
│   └── arquitectura/
│
├── inbox/                           ← entrada temporal, se vacía
│   └── _meta/                       ← scripts de auditoría
│
├── agentes/                         ← contexto para IAs
│   ├── AGENT.md
│   ├── perplexity/
│   ├── copilot/
│   └── thdora/
│
├── scripts/                         ← scripts locales (madre/theodora)
│   ├── infra/
│   ├── maintenance/
│   ├── thdora/
│   └── brain/
│
├── templates/                       ← plantillas reutilizables
├── _archivo/                        ← histórico, solo lectura
│
└── .github/
    ├── workflows/                   ← GitHub Actions ÚNICAMENTE
    ├── ISSUE_TEMPLATE/
    └── PULL_REQUEST_TEMPLATE.md
```

### Carpetas a ELIMINAR de yggdrasil-dew
```
diarios/          ← duplicado de docs/diarios/
docker/           ← mover a batcueva (repo infra ejecutable)
infra/            ← mover a batcueva
setup/            ← mover a batcueva
ollama/           ← mover a local-brain repo
osint-stack/      ← mover a osint-stack repo
hardware/         ← mover a docs/infra/hardware/
formacion/        ← mover a docs/formacion/
investigacion/    ← mover a docs/investigacion/
islas/            ← evaluar: ¿fusionar con docs/proyectos/?
core/             ← evaluar: ¿qué contiene?
cli-tools/        ← evaluar: ¿mover a scripts/ o batcueva?
tools/            ← evaluar: ¿mover a scripts/ o batcueva?
mcp/              ← mover a agentes/perplexity/ o batcueva
```

---

## MASTER-PENDIENTES — nuevo formato

Deja de ser un documento de tareas completo.
Pasa a ser **solo un índice de P0 y P1** con links a Issues reales.

```markdown
## P0-CRÍTICO
- [ ] Puerto 21 FTP abierto → [secops #1](link)

## P1-URGENTE  
- [ ] Smoke test thdora → [thdora #15](link)
- [ ] PasswordAuthentication no en madre → [dew #XX](link)

## Links rápidos por dominio
- Tareas thdora → github.com/.../thdora/issues
- Tareas secops → github.com/.../yggdrasil-secops/issues
- Tareas brain/infra → github.com/.../yggdrasil-dew/issues
```

---

## FASES DE EJECUCIÓN — en orden

### ✅ FASE 0 — Documentar el plan (ESTE ARCHIVO)
- [x] Plan documentado en `docs/PLAN-REORGANIZACION-2026-07-04.md`

### 🔄 FASE 1 — Limpiar raíz yggdrasil-dew
- [ ] Mover `.md` sueltos a `docs/` según estructura
- [ ] Eliminar carpeta `diarios/` raíz (contenido ya en `docs/diarios/`)
- [ ] Evaluar carpetas: `core/`, `islas/`, `cli-tools/`, `tools/`

### 🔄 FASE 2 — Separar capas
- [ ] Reorganizar `agentes/` con subcarpetas `perplexity/`, `copilot/`, `thdora/`
- [ ] Verificar `scripts/` tiene subdirectorios correctos
- [ ] Verificar `.github/workflows/` solo tiene Actions (no scripts)

### 🔄 FASE 3 — Crear repo `batcueva`
- [ ] Crear repo `batcueva` (privado)
- [ ] Mover `docker/`, `infra/`, `setup/` a batcueva
- [ ] Documentar batcueva en ECOSISTEMA.md

### 🔄 FASE 4 — Mover contenido a repos correctos
- [ ] `ollama/` → local-brain repo
- [ ] `osint-stack/` → osint-stack repo
- [ ] `mcp/` → agentes/ o batcueva

### 🔄 FASE 5 — Actualizar MASTER-PENDIENTES
- [ ] Reducir a solo P0+P1 con links a Issues
- [ ] Crear Issues reales en repos correctos para cada tarea

### 🔄 FASE 6 — Conectar Obsidian + Cursor
- [ ] Confirmar que Obsidian apunta solo a yggdrasil-dew (vault = repo)
- [ ] Configurar Cursor workspace para abrir repos por dominio separados
- [ ] AGENT.md actualizado con nueva estructura para que IAs la respeten

---

## REGLA ANTI-CAOS

Antes de crear cualquier archivo nuevo:
```
1. ¿A qué dominio pertenece? → repo correcto
2. ¿Es documentación? → docs/
3. ¿Es script local? → scripts/
4. ¿Es automatización GitHub? → .github/workflows/
5. ¿Es contexto para IA? → agentes/
6. ¿Es infra ejecutable? → batcueva
7. ¿No sabes dónde va? → inbox/ y lo procesas después
```

> **Si no cabe en ninguna categoría, el plan tiene un hueco → actualiza este documento primero.**

---

## CONEXIÓN ENTRE REPOS (sin mezclar archivos)

Los repos se referencian por links, nunca copiando archivos:

```markdown
<!-- En thdora/README.md -->
> Documentación de arquitectura: [yggdrasil-dew/docs/proyectos/thdora.md](link)

<!-- En yggdrasil-dew/docs/proyectos/thdora.md -->
> Código fuente: [github.com/alvarofernandezmota-tech/thdora](link)
> Issues activos: [thdora/issues](link)
```

Nunca subir a yggdrasil-dew:
- Código fuente de proyectos
- Docker Compose files de proyectos específicos  
- Dependencias, node_modules, requirements.txt de proyectos

---

_Plan creado: 2026-07-04 23:20 CEST — sesión Perplexity MCP_
_Próxima revisión: al completar Fase 3_
