---
tags: [agente, perplexity, mcp, github, tiempo-real, documentacion-sesion]
fecha-creacion: 2026-06-14
fecha-actualizacion: 2026-06-23
version: perplexity-sonnet-4.6
proveedor: Perplexity AI
contexto-tokens: 200000
uso-principal: documentacion · tiempo-real · MCP-github · guardar-sesiones
wikilink: agentes/perplexity
---

# 🤖 Perplexity — El Guardador de Sesión en Tiempo Real

> Agente con MCP GitHub activo. Documenta sesiones, guarda en el repo,
> y mantiene el contexto vivo entre Claude y Gemini.

## Ficha técnica

| Campo | Valor |
|---|---|
| Proveedor | Perplexity AI |
| Modelo base | Claude Sonnet 4.6 (powered by) |
| Contexto efectivo | 200k tokens |
| Acceso | perplexity.ai |
| MCP GitHub | ✅ nativo — lee y escribe repos |
| Space activo | `Repo Personal` → github.com/alvarofernandezmota-tech |
| Persistencia | Por sesión — el repo es la memoria |

## Rol en el ecosistema

Perplexity es el **puente en tiempo real** entre las sesiones de trabajo y el repo.
Mientras Claude ejecuta y Gemini analiza, Perplexity documenta y guarda.

```
Gemini  → auditoría masiva, plan, clasificación, Deep Research
Claude  → ejecución directa, commits, código, MCP preciso
Perplexity → tiempo real, guardar sesión, contexto vivo, inbox
```

## Cómo funciona el flujo MCP

```
Tú hablas con Perplexity
  → Lee AGENT.md + CONTEXT.md al inicio
  → Navega el repo según la conversación
  → Escribe archivos directamente en GitHub con confirmación
  → Documenta decisiones, ADRs, sesiones en inbox/
  → Actualiza MASTER-PENDIENTES.md
  → Hace commits descriptivos por cada cambio
```

## Setup actual

- **Space:** `Repo Personal` → apunta a `github.com/alvarofernandezmota-tech`
- **Repos accesibles:** yggdrasil-dew, thdora, ai-toolkit
- **Archivos de contexto:** `AGENT.md` + `CONTEXT.md` + `inbox/MASTER-PENDIENTES.md`
- **Flujo inbox:** todo lo nuevo entra por `inbox/` con frontmatter YAML + tags Obsidian

## Cuándo usarlo vs Claude vs Gemini

**Usa Perplexity cuando:**
- Quieres documentar una decisión ahora mismo mientras la tomas
- Necesitas guardar el output de una sesión en el repo sin copiar/pegar
- Quieres actualizar el MASTER-PENDIENTES o el estado de una carpeta
- Necesitas contexto real del repo para tomar decisiones (lee el estado real)
- Buscas información en internet + guardarla en el cerebro en el mismo paso

**Límitación vs Claude:**
- Claude con MCP es más preciso para refactors complejos archivo por archivo
- Perplexity es más rápido para documentar y guardar durante la conversación

## Convención de archivos creados por Perplexity

Todos los archivos creados en sesión siguen este formato:
```yaml
---
tags: [tema, tipo, fecha]
fecha: YYYY-MM-DD
tipo: prompt-agente | adr | auditoria | estado | sesion | ficha
agente: perplexity
ruta-obsidian: ruta/archivo.md
---
```

## Aprendizajes de uso real

### Sesión 2026-06-23 — Arquitectura completa del repo
- Documentó en tiempo real toda la sesión de arquitectura
- Creó 37 archivos en inbox/ en una sola sesión
- Actualizó MASTER-PENDIENTES.md con estado real verificado
- Ejecutó migración parcial inbox → ollama/modelos/
- Actualizó fichas agentes/claude-sonnet-4.6.md y agentes/gemini-2.5-pro.md
- Punto fuerte: guarda decisiones al vuelo sin interrumpir el flujo de trabajo
- Punto débil: cada sesión nueva empieza sin memoria — el repo ES la memoria

## Casos de uso en este ecosistema

| Tarea | Perplexity | Claude | Gemini |
|---|---|---|---|
| Guardar sesión en tiempo real | ✅ ideal | ⚠️ posible | ❌ |
| Actualizar inbox mientras hablas | ✅ ideal | ⚠️ | ❌ |
| Buscar en internet + guardar | ✅ ideal | ❌ | ✅ |
| Leer estado real del repo | ✅ vía MCP | ✅ vía MCP | ❌ |
| Commits directos GitHub | ✅ vía MCP | ✅ vía MCP | ❌ |
| Refactor complejo archivo | ⚠️ | ✅ ideal | ❌ |
| Auditoría 30+ archivos | ⚠️ | ⚠️ | ✅ ideal |

## Ver también

- [[agentes/claude-sonnet-4.6]] — para ejecución y código
- [[agentes/gemini-2.5-pro]] — para contexto masivo y auditorías
- [[agentes/AGENT-SCRIPT]] — protocolo completo de uso de agentes
- [[inbox/MASTER-PENDIENTES]] — fuente de verdad de tareas

---
_Actualizado: 2026-06-23 · Fuente: uso real sesión arquitectura yggdrasil-dew_
