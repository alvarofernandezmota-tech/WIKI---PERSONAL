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
