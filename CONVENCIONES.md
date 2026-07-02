---
tags: [tipo/meta, estado/activo]
actualizado: 2026-07-02
---
# 📐 Convenciones del Repositorio — yggdrasil-dew

> Este documento es la SSOT de todas las reglas que gobiernan este vault.
> **Última auditoría: 02-jul-2026**

---

## 🏗️ Orden de las Fases (Regla 0)

> La regla más importante del workflow. Las fases deben ejecutarse **en este orden exacto**.

```
Fase 1: REPOS LIMPIAS
  └─ Inbox vacía cada sesión
  └─ Árbol de directorios correcto (sin basura, sin duplicados)
  └─ Ficheros nombrados según Regla 14

Fase 2: GITHUB PROFESIONAL
  └─ Labels en ambas repos (infra, security, docs, bot, osint, cleanup, pentest, priority:*)
  └─ Issue templates (.github/ISSUE_TEMPLATE/)
  └─ Issues abiertos por cada tarea pendiente
  └─ GitHub Project kanban unificado

Fase 3: DOCUMENTACIÓN ÁRBOL
  └─ HOME.md actualizado con árbol real
  └─ ECOSISTEMA.md — referencias cruzadas dew↔secops
  └─ ESTADO-SISTEMA.md — estado real del sistema
  └─ ROADMAP.md — SSOT de lo planificado
  └─ CONVENCIONES.md — este fichero auditado

Fase 4: AUDITORÍA GOBERNANZA
  └─ Revisar reglas vs. realidad → Issue #10 dew
  └─ Crear issue templates y PR templates
  └─ Sincronizar ecosistema (dew ↔ secops ↔ batcueva)

Fase 5: TÉCNICA (solo después de fases 1-4)
  └─ Cerrar SEC-001 (FTP puerto 21)
  └─ Fijar crash-loops bots
  └─ Levantar Wazuh + Suricata + Pihole
  └─ Terminal iPhone (Termius + Tailscale)
  └─ Configurar WATCH_PATHS tripwire
  └─ GitHub Actions CI/CD
```

> ⚠️ **PROHIBIDO** saltar a Fase 5 sin tener 1-4 completadas.
> La deuda técnica de organización bloquea el trabajo real.

---

## 🏷️ Taxonomía de Etiquetas

| Etiqueta Principal | Secundarias (Ejemplos) | Uso / Contexto |
|---|---|---|
| `#estado/...` | `#estado/draft`, `#estado/activo`, `#estado/archivo` | Ciclo de vida. **Obligatorio** en todo fichero. |
| `#tipo/...` | `#tipo/adr`, `#tipo/sesion`, `#tipo/moc`, `#tipo/ficha` | Define la plantilla y estructura del documento. |
| `#ia` | `#ia/llm`, `#ia/rag`, `#ia/prompts` | Modelos locales, Ollama, Qdrant. |
| `#infra` | `#infra/docker`, `#infra/sops`, `#infra/arch` | Configuración de Madre y despliegues. |
| `#osint` | `#osint/recon`, `#osint/tools` | Inteligencia de fuentes abiertas. |
| `#proyecto` | `#proyecto/thdora`, `#proyecto/brain` | Rastreo de estado de repositorios satélite. |

> ⚠️ **PROHIBIDO:** La etiqueta `#personal` está **baneada** de este repositorio. Todo lo personal va a `huginn`.

---

## 📥 Ciclo de vida del Inbox

| Estado | Etiqueta frontmatter | Significado |
|---|---|---|
| Recién llegado | `estado: sin-empezar` | Nota cruda, sin revisar |
| Trabajando | `estado: en-proceso` | Se está procesando ahora |
| Procesado | `estado: finalizado` | Listo para cristalizar |
| Migrado | `estado: cristalizado` | Ya vive en su destino |

> Detalle completo de destinos → [[inbox/README]]

---

## 📁 Estructura de Directorios

```text
yggdrasil-dew/
├── HOME.md                      # Dashboard principal
├── MASTER-PENDIENTES.md         # SSOT de tareas técnicas
├── ESTADO-SISTEMA.md            # Salud de Madre / Red
├── ROADMAP.md                   # Visión a medio/largo plazo
├── CONVENCIONES.md              # Este fichero
├── ECOSISTEMA.md                # Topología multi-repo
├── inbox/                       # 📥 Entrada temporal (vaciar cada sesión)
├── diarios/                     # 📅 Logs técnicos y sesiones IA
├── mocs/                        # 🗺️ Maps of Content (índices conceptuales)
├── docs/                        # 📚 Conocimiento cristalizado
│   ├── adr/                     # ADRs (ADR-001, ADR-002...)
│   │   └── historico/           # Debates resueltos
│   ├── ias/                     # Fichas de modelos
│   ├── infra/                   # Docker, red, servidores
│   ├── seguridad/               # Hallazgos, hardening, pentest
│   │   └── hallazgos/           # SEC-NNN-*.md
│   ├── os/                      # Linux, Arch, Hyprland
│   ├── herramientas/            # Docker, SOPS, Git, n8n
│   └── conceptos/               # Teoría (RAG, embeddings)
├── proyectos/                   # 🏗️ Fichas de proyectos activos
├── formacion/                   # 🎓 Cursos, certs, tutoriales
├── osint/                       # 🔍 Stack y metodologías OSINT
├── docker/                      # 🐳 docker-compose files (referencia)
├── hardware/                    # 🖨️ Hardware, dispositivos
├── agentes/                     # 🤖 Prompts maestros, flujos n8n
├── templates/                   # 📝 Plantillas Obsidian
├── scripts/                     # ⚙️ Scripts de gestión del repo
└── assets/                      # 🖼️ Imágenes, diagramas
```

> ⚠️ Directorios que NO deben existir en raíz:
> `thdora/` (va en `proyectos/`), `osint-stack/` (va en `docker/`), ficheros sueltos sin extensión

---

## 📈 Issues GitHub — Naming profesional

| Prefijo | Tipo | Ejemplo |
|---|---|---|
| `[INFRA]` | Infraestructura Docker/red | `🐳 [INFRA] Levantar Wazuh + Suricata` |
| `[SECURITY]` | Hallazgo / hardening | `🔴 [SECURITY] SEC-001 Puerto 21 FTP` |
| `[REPO]` | Limpieza / estructura repo | `🧹 [REPO] Limpiar raíz` |
| `[BOT]` | Bots secops | `🤖 [BOT] Fix crash-loop log_guardian` |
| `[DOCS]` | Documentación | `📚 [DOCS] Actualizar ECOSISTEMA.md` |
| `[GOVERNANCE]` | Reglas / convenciones | `📐 [GOVERNANCE] Auditar CONVENCIONES.md` |
| `[MOBILE]` | Acceso móvil | `📱 [MOBILE] Termius iPhone + Tailscale` |
| `[CI]` | GitHub Actions / automatización | `⚙️ [CI] Primera pipeline` |
| `[OSINT]` | Herramientas OSINT | `🔍 [OSINT] Spiderfoot setup` |

---

## 📈 Labels GitHub — Sistema profesional

### Por tipo
```
infra         🐳  #0075ca  Infraestructura Docker, red, Madre
security      🔒  #d93f0b  Hallazgos SEC-*, hardening, pentest
docs          📚  #0052cc  Documentación, convenciones, README
bot           🤖  #7057ff  Bots yggdrasil-secops
osint         🔍  #006b75  OSINT, recon
cleanup       🧹  #e4e669  Limpieza repo, estructura
governance    📐  #c2e0c6  Reglas, convenciones, templates
mobile        📱  #bfdadc  Acceso móvil, Termius, ADB
ci            ⚙️   #1d76db  GitHub Actions, automatización
```

### Por prioridad
```
priority:critical   🔴  #b60205
priority:high       🟠  #e99695
priority:medium     🟡  #fbca04
priority:low        🟢  #0e8a16
```

### Por estado
```
status:blocked      ⏸️   #666666
status:in-progress  ⏳   #0075ca
status:needs-review 👀  #fef2c0
```

---

## 📈 Nomenclatura de ficheros (Regla 14)

| Tipo | Formato | Ejemplo |
|---|---|---|
| Inbox / diario | `YYYY-MM-DD-kebab-case.md` | `2026-07-02-estado-bots.md` |
| ADR | `ADR-NNN-titulo.md` | `ADR-001-separacion-repos.md` |
| Hallazgo seguridad | `SEC-NNN-descripcion.md` | `SEC-001-ftp-puerto21.md` |
| Template Obsidian | `tpl-tipo.md` | `tpl-sesion.md` |
| MOC | `MOC-TEMA.md` (mayúsculas) | `MOC-DOCKER.md` |

---

## 🔀 Separación de Repositorios (Regla 13)

| Repositorio | Contiene | NO contiene |
|---|---|---|
| `yggdrasil-dew` | Conocimiento, decisiones, docs, contexto | Secretos, configs ejecutables, código |
| `yggdrasil-secops` | Código bots, docker-compose bots, scripts | Notas personales, decisiones ADR |
| `batcueva` | Docker infra, SOPS, configuraciones | Notas, diarios, decisiones |
| `huginn` | Diarios personales, reflexiones, metas | Cualquier cosa técnica |

> ⚠️ **Excepción docker/** — Mientras `batcueva` no esté operativo, los composes
> viven en `docker/` de este repo como referencia de conocimiento.
> Cuando `batcueva` exista, se migran allí y aquí quedan solo los links.

---

## 🟢 Estado Real vs Planificado (Regla 14)

> **La regla más importante del repo: lo que existe HOY y lo que es futuro
> NUNCA pueden estar mezclados en el mismo fichero sin señalización clara.**

| Categoría | Señal visual | Significado |
|---|---|---|
| **Estado real** | `✅ ACTIVO` / `# VALIDADO: YYYY-MM-DD` | Está corriendo en producción ahora mismo |
| **Borrador** | `🔧 WIP` / `estado/draft` | Existe pero no está desplegado |
| **Planificado** | `🔜 PENDIENTE` / `estado/planificado` | Diseñado, no construido |
| **Archivado** | `📦 ARCHIVO` / `estado/archivo` | Existió, ya no corre |

---

## 📌 Repos satélite — migración

> Todo lo de `osint-stack/`, `docker/` y configs ejecutables migra a `batcueva`
> cuando esa repo esté lista. No antes.
> **No hay que forzar la migración** hasta que la Fase 4 esté completa.

---

_Auditado 02-jul-2026 — Perplexity vía MCP_
