# CONVENCIONES — WIKI-PERSONAL

> Normas de estructura, nomenclatura y flujo. Obligatorio leer antes de crear cualquier fichero.
> **Actualizado:** 2026-07-05

---

## 1. Nomenclatura de ficheros

| Contexto | Convención | Ejemplo |
|---|---|---|
| Documentos en `docs/*/` | `kebab-case` minúsculas | `flujo-sesiones.md` |
| Documentos maestros en raíz | `MAYUSCULAS` | `AGENT.md`, `CONTEXT.md` |
| Diarios de sesión | `YYYY-MM-DD.md` | `2026-07-05.md` |
| Ficheros de archivo | `YYYY-MM-DD-descripcion.md` | `2026-07-04-auditoria-copilot.md` |
| ADRs | `ADR-NNN-descripcion.md` | `ADR-001-estructura-repos.md` |

**Regla absoluta:** nunca mezclar MAYÚSCULAS y kebab-case en la misma carpeta temática.

---

## 2. Estructura de carpetas

```
WIKI---PERSONAL/
├── README.md            ← Entrada pública
├── HOME.md              ← Dashboard de navegación (actualizar siempre)
├── AGENT.md             ← Contexto para agentes IA (leer al inicio)
├── CONTEXT.md           ← Estado actual del sistema (actualizar cada sesión)
├── CONTRIBUTING.md      ← Flujo de trabajo y commits
├── CHANGELOG.md         ← Cambios por versión/sesión
│
├── wiki/                ← Documentación conceptual por islas
│   ├── 00-mapa.md       ← Mapa maestro del ecosistema
│   ├── mapa-islas.md    ← Tabla de islas y repos
│   ├── islas/           ← Una ficha por isla
│   ├── infra/           ← Infraestructura técnica
│   ├── agentes/         ← Agentes IA
│   ├── operaciones/     ← Procesos y rutinas
│   ├── conocimiento/    ← Conocimiento técnico general
│   ├── vida/            ← Personal / hábitos
│   └── relaciones/      ← Relaciones entre islas/componentes
│
├── docs/                ← Documentos técnicos y de soporte
│   ├── adr/             ← Architecture Decision Records
│   ├── auditorias/      ← Auditorías periódicas
│   ├── bitacora/        ← Registro de eventos
│   ├── bots/            ← Bots y automatizaciones
│   ├── decisiones/      ← Decisiones técnicas puntuales
│   ├── diarios/         ← Diarios de sesión (destino definitivo)
│   ├── ecosistema/      ← Documentos del ecosistema
│   ├── filosofia/       ← Principios y valores
│   ├── fixes/           ← Soluciones documentadas
│   ├── github/          ← GitHub Actions, labels, workflows
│   ├── hardware/        ← Inventario de máquinas
│   ├── herramientas/    ← Stack de herramientas
│   ├── ias/             ← Fichas de modelos y agentes IA
│   ├── infra/           ← Infraestructura técnica
│   ├── investigacion/   ← Investigaciones técnicas
│   ├── madre/           ← Documentos maestros del sistema
│   ├── mcp/             ← Model Context Protocol
│   ├── normas/          ← Normas operativas
│   ├── operativa/       ← Procesos operativos
│   ├── pentesting/      ← Seguridad ofensiva
│   ├── procesos/        ← Workflows y procesos
│   ├── proyectos/       ← Gestión de proyectos
│   ├── referencias/     ← Referencias externas
│   ├── reglas/          ← Reglas del sistema
│   ├── seguridad/       ← Seguridad defensiva
│   ├── sesiones/        ← Registro de sesiones
│   ├── setup/           ← Guías de instalación
│   ├── sistema/         ← Core del sistema
│   ├── tareas/          ← Gestión de tareas
│   ├── thdora-guardian/ ← Agente Thdora
│   ├── leyes/           ← Leyes y normas del sistema
│   ├── misc/            ← Miscelánea sin clasificar
│   └── archivo/         ← Documentos obsoletos (no borrar, archivar)
│
├── diarios/             ← Diarios raíz (pendiente migrar a docs/diarios/)
├── hardware/            ← Inventario hardware en raíz
├── inbox/               ← Zona de aterrizaje (máx. 20 ficheros, limpiar siempre)
├── _archivo/            ← Archivado histórico del repo
└── .github/             ← Templates, workflows, CODEOWNERS
```

---

## 3. Front matter obligatorio

Todo documento en `docs/` o `wiki/` debe incluir front matter YAML:

```yaml
---
tipo: [mapa | referencia | guia | auditoria | diario | adr | ficha]
nombre: Nombre legible del documento
estado: [vigente | obsoleto | borrador | archivado]
created: YYYY-MM-DD
actualizado: YYYY-MM-DD
tags: [tag1, tag2]
obsidian_link: "[[nombre-sin-extension]]"  # opcional
---
```

---

## 4. Estructura de commits (Conventional Commits)

```
feat(scope):      nueva funcionalidad o documento
fix(scope):       corrección de contenido
docs(scope):      actualización de documentación
chore(scope):     mantenimiento, limpieza, renombrado
infra(scope):     cambios de infraestructura
security(scope):  seguridad
refactor(scope):  reestructuración sin cambio de contenido
ci(scope):        GitHub Actions
```

Ejemplos reales:
```
docs(diarios): cierre sesion 05-jul noche
chore(docs): migrar archivos sueltos a carpetas temáticas
docs(wiki): actualizar 00-mapa con estado 2026-07-05
chore(inbox): migración 2026-07-05
```

---

## 5. Reglas de la inbox

1. La `inbox/` **no es almacenamiento** — es zona de tránsito
2. **Máximo 20 ficheros** antes de procesar
3. Naming: `YYYY-MM-DD-descripcion-corta.md`
4. Procesar con `git mv` al destino correcto
5. Commit tras migración: `chore(inbox): migración YYYY-MM-DD`

---

## 6. Reglas para agentes IA

1. **Leer siempre** `AGENT.md` → `CONTEXT.md` → `CONTRIBUTING.md` antes de actuar
2. **Nunca sobreescribir** documentos sin leer el contenido actual
3. **Verificar SHA** antes de actualizar un fichero existente
4. **No crear stubs vacíos** — si no hay contenido, no crear el fichero
5. **Actualizar CONTEXT.md** al final de cada sesión de trabajo
6. **Respetar el front matter** — incluirlo siempre
7. **Usar kebab-case** para cualquier fichero nuevo en `docs/` o `wiki/`

---

## 7. Qué NUNCA commitear

```
❌  .env o cualquier fichero con secrets
❌  Claves SSH, tokens, certificados
❌  APKs, binarios, ISOs
❌  .obsidian/ modificaciones privadas
❌  Logs con datos sensibles
❌  Ficheros con contraseñas en texto plano
```

---

_Mantenido por: Álvaro Fernández Mota · Actualizado: 2026-07-05 · Perplexity-MCP_
