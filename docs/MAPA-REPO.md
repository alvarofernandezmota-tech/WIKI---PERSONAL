---
tipo: mapa
nombre: Mapa del Repositorio WIKI-PERSONAL
estado: vigente
created: 2026-06-25
actualizado: 2026-07-05
---

# Mapa del Repositorio — WIKI-PERSONAL

> **Actualizado:** 2026-07-05  
> **Estado:** VIVO — actualizar cuando cambie la estructura

---

## Estructura de directorios

```
WIKI---PERSONAL/
│
├── 📋 RAÍZ (documentos maestros — MAYÚSCULAS)
│   ├── README.md              ← Entrada pública del repo
│   ├── HOME.md                ← Dashboard de navegación (islas + repos)
│   ├── AGENT.md               ← Instrucciones para agentes IA
│   ├── CONTEXT.md             ← Estado actual del ecosistema
│   ├── CONTRIBUTING.md        ← Flujo de trabajo y commits
│   └── CHANGELOG.md           ← Cambios por versión/sesión
│
├── 📁 wiki/                   ← Documentación conceptual del ecosistema
│   ├── 00-mapa.md             ← Mapa maestro: islas + repos + estado
│   ├── mapa-islas.md          ← Tabla completa de islas
│   ├── estructura-ecosistema.md
│   ├── herramientas-ecosistema.md
│   ├── plan-seguridad.md
│   ├── islas/                 ← Una ficha Markdown por isla
│   │   ├── cerebro.md
│   │   ├── conocimiento.md
│   │   ├── formacion.md
│   │   ├── infraestructura.md
│   │   ├── ia-local.md
│   │   ├── thdora.md
│   │   ├── seguridad.md
│   │   └── labs.md
│   ├── infra/                 ← Docs de infraestructura (Madre, Acer, red)
│   ├── agentes/               ← Fichas de agentes IA del ecosistema
│   ├── operaciones/           ← Rutinas y procesos operativos
│   ├── conocimiento/          ← Conocimiento técnico general
│   ├── vida/                  ← Hábitos, finanzas, personal
│   └── relaciones/            ← Relaciones entre islas/componentes
│
├── 📁 docs/                   ← Documentación técnica de soporte
│   ├── adr/                   ← Architecture Decision Records
│   ├── agentes/               ← Configuración de agentes
│   ├── arquitectura/          ← Arquitectura del sistema
│   ├── auditorias/            ← Auditorías periódicas
│   ├── archivo/               ← Docs obsoletos (archivar, no borrar)
│   ├── bitacora/              ← Registro de eventos
│   ├── bots/                  ← Bots y automatizaciones
│   ├── decisiones/            ← Decisiones técnicas puntuales
│   ├── diarios/               ← Diarios de sesión (destino definitivo)
│   ├── ecosistema/            ← Documentos del ecosistema
│   ├── filosofia/             ← Principios y valores
│   ├── fixes/                 ← Soluciones documentadas
│   ├── github/                ← GitHub Actions, labels, workflows
│   ├── hardware/              ← Inventario de máquinas
│   ├── herramientas/          ← Stack de herramientas
│   ├── ias/                   ← Fichas de modelos y agentes IA
│   ├── infra/                 ← Infraestructura técnica
│   ├── investigacion/         ← Investigaciones técnicas
│   ├── leyes/                 ← Leyes y normas del sistema
│   ├── madre/                 ← Documentos maestros del sistema
│   ├── mcp/                   ← Model Context Protocol
│   ├── misc/                  ← Miscelánea sin clasificar
│   ├── normas/                ← Normas operativas
│   ├── operativa/             ← Procesos operativos
│   ├── pentesting/            ← Seguridad ofensiva
│   ├── procesos/              ← Workflows y procesos
│   ├── proyectos/             ← Gestión de proyectos
│   ├── referencias/           ← Referencias externas
│   ├── reglas/                ← Reglas del sistema
│   ├── seguridad/             ← Seguridad defensiva
│   ├── sesiones/              ← Registro de sesiones
│   ├── setup/                 ← Guías de instalación y configuración
│   ├── sistema/               ← Core del sistema
│   ├── tareas/                ← Gestión de tareas
│   ├── thdora-guardian/       ← Agente Thdora Guardian
│   └── CONVENCIONES.md        ← ⚠️ Leer antes de crear cualquier fichero
│
├── 📁 diarios/                ← Diarios raíz (pendiente migrar a docs/diarios/)
├── 📁 hardware/               ← Inventario hardware en raíz
├── 📁 inbox/                  ← ZONA DE ATERRIZAJE (máx. 20 ficheros)
│   └── YYYY-MM-DD-*.md
│
├── 📁 _archivo/               ← Archivado histórico (no tocar salvo consulta)
│   ├── AUDITORIA-COMPLETA-YGG.md
│   ├── AUDITORIA-MAESTRA-COPILOT.md
│   ├── COPILOT-AUDIT-PLAN.md
│   ├── COPILOT-CONTEXT.md
│   ├── COPILOT-MASTER-CONTEXT.md
│   ├── diarios/
│   ├── mocs/
│   └── thdora/
│
└── 📁 .github/                ← Templates de PR/issues, CODEOWNERS, Actions
```

---

## Convenciones de nomenclatura

| Contexto | Regla | Ejemplo |
|---|---|---|
| Raíz del repo | `MAYÚSCULAS.md` | `AGENT.md` |
| Carpetas temáticas en `docs/` o `wiki/` | `kebab-case` minúsculas | `flujo-sesiones.md` |
| Diarios | `YYYY-MM-DD.md` | `2026-07-05.md` |
| ADRs | `ADR-NNN-descripcion.md` | `ADR-001-estructura.md` |

Ver [`docs/CONVENCIONES.md`](./CONVENCIONES.md) para la guía completa.

---

## Flujo de trabajo

```
 INICIO DE SESIÓN
   → Leer AGENT.md + CONTEXT.md
   → Revisar inbox/

 DURANTE LA SESIÓN
   → Todo material nuevo entra por inbox/
   → Migrar con git mv al destino correcto

 CIERRE DE SESIÓN
   → Escribir diario en docs/diarios/YYYY-MM-DD.md
   → Actualizar CONTEXT.md
   → Vaciar inbox/
   → Commit de cierre
```

---

*Mantenido por: Álvaro Fernández Mota · Actualizado: 2026-07-05 · Perplexity-MCP*
