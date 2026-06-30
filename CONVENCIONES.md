---
tags: [tipo/meta, estado/activo]
---
# 📐 Convenciones del Repositorio — yggdrasil-dew

> Este documento es la SSOT de todas las reglas que gobiernan este vault.

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
│   ├── os/                      # Linux, Arch, Hyprland
│   ├── herramientas/            # Docker, SOPS, Git, n8n
│   └── conceptos/               # Teoría (RAG, embeddings)
├── proyectos/                   # 🏗️ Fichas de proyectos activos
├── formacion/                   # 🎓 Cursos, certs, tutoriales
├── osint/                       # 🔍 Stack y metodologías OSINT
├── hardware/                    # 🖨️ Hardware, impresión 3D
├── agentes/                     # 🤖 Prompts maestros, flujos n8n
├── templates/                   # 📝 Plantillas Obsidian
├── scripts/                     # ⚙️ Scripts de gestión del repo
└── assets/                      # 🖼️ Imágenes, diagramas
```

## 📏 Reglas de Nomenclatura

* **Ficheros de inbox/diarios:** `YYYY-MM-DD-kebab-case.md`
* **ADRs:** `ADR-NNN-titulo-kebab-case.md` (NNN con padding a 3 dígitos)
* **Templates:** `tpl-tipo.md`
* **MOCs:** `MOC-TEMA.md` (mayúsculas)

## 🔀 Separación de Repositorios (Regla 13)

| Repositorio | Contiene | NO contiene |
|---|---|---|
| `yggdrasil-dew` | Conocimiento, decisiones, docs, contexto | Secretos, configs ejecutables, código |
| `batcueva` | Docker, scripts, SOPS, infraestructura | Notas personales, decisiones ADR |
| `huginn` | Diarios personales, reflexiones, metas | Cualquier cosa técnica |

> ⚠️ **Excepción docker/** — Mientras `batcueva` no esté operativo, los composes
> viven en `docker/` de este repo como referencia de conocimiento.
> Cuando `batcueva` exista, se migran allí y aquí quedan solo los links.

---

## 🟢 Estado Real vs Planificado (Regla 14)

> **La regla más importante del repo: lo que existe HOY y lo que es futuro
> NUNCA pueden estar mezclados en el mismo fichero sin señalización clara.**

### La distinción obligatoria

Todo fichero de infraestructura, compose, script o documento debe dejar claro
en qué categoría está:

| Categoría | Señal visual | Significado |
|---|---|---|
| **Estado real** | `✅ ACTIVO` / `# VALIDADO: YYYY-MM-DD` | Está corriendo en producción ahora mismo |
| **Borrador** | `🔧 WIP` / `estado/draft` | Existe pero no está desplegado |
| **Planificado** | `🔜 PENDIENTE` / `estado/planificado` | Diseñado, no construido |
| **Archivado** | `📦 ARCHIVO` / `estado/archivo` | Existió, ya no corre |

### Reglas concretas

1. **Ficheros de compose:** El nombre incluye la fase → `docker-compose.fase1.yml` (activo), `docker-compose.fase2.yml` (pendiente)
2. **Comentarios en compose:** La primera línea siempre incluye `# VALIDADO: YYYY-MM-DD` si está en producción
3. **ESTADO-SISTEMA.md:** Es la SSOT del estado real. Si algo no está ahí, no cuenta como "en producción"
4. **ROADMAP.md:** Es la SSOT de lo planificado. Si algo no está ahí, no es un plan oficial
5. **Prohibido:** Mezclar servicios reales con servicios futuros en el mismo bloque sin separación explícita

### Ejemplo correcto

```yaml
# ✅ ACTIVO — VALIDADO: 2026-06-25
services:
  ollama:        # REAL — corriendo en Madre
  qdrant:        # REAL — corriendo en Madre

# 🔜 PENDIENTE — Fase 2 (no desplegar hasta migración llama.cpp)
# services:
#   llamacpp:    # FUTURO — comentado hasta que sea real
```

### Por qué esta regla existe

En junio 2026 se detectó que `~/docker-compose.yml` en Madre (4 servicios reales)
divergía del `docker-compose.batcueva.yml` del repo (13 servicios planificados)
sin que quedara claro cuál era el estado real del sistema.
Esta regla evita que vuelva a ocurrir.
