---
tags: [inbox, protocolo, flujo, obsidian, sistema]
fecha-creacion: 2026-06-22
fecha-actualizacion: 2026-06-23
version: 3.0
ruta-obsidian: inbox/README.md
---

# 📥 inbox/ — Protocolo v3.0

> Zona de aterrizaje de todo lo nuevo.
> Nada se mueve sin pasar por aquí primero. Todo lo que entra, se procesa.

---

## Las 3 leyes que gobiernan el inbox

1. **Todo nuevo entra aquí primero** — sin excepciones
2. **Nunca duplicar** — si ya existe, actualiza con wikilink
3. **Infraestructura != Producto** — no mezclar en la misma ficha

---

## Estructura del inbox

```
inbox/
  README.md                    ← este archivo (protocolo)
  MASTER-PENDIENTES.md         ← fuente única de verdad de tareas
  YYYY-MM-DD-tema.md           ← archivos de sesión (temporales)
  YYYY-MM-DD-inbox-clasificado.md  ← snapshot de estado (permanente)
```

---

## Frontmatter YAML obligatorio

Todo archivo del inbox lleva este frontmatter mínimo:

```yaml
---
tags: [tema, tipo, fecha]   # tags para Obsidian
fecha: YYYY-MM-DD
tipo: adr | auditoria | plan | prompt-agente | estado | sesion | ficha
estado: pendiente | ejecutado | en-curso | obsoleto
ruta-obsidian: inbox/nombre-archivo.md
---
```

---

## Tipos de archivo y su destino final

| Tipo | Ejemplo | Destino definitivo |
|---|---|---|
| ADR | `adr-decision-X.md` | `docs/ADR/` |
| Auditoría | `auditoria-carpeta.md` | ejecutar y archivar |
| Plan | `plan-X.md` | ejecutar con agente |
| Prompt agente | `prompt-claude-X.md` | usar y archivar |
| Estado | `estado-X.md` | `setup/` o `diarios/` |
| Sesión | `sesion-X.md` | `diarios/YYYY/MM/` |
| Ficha conocimiento | `ollama-X.md` | carpeta temática |
| Ficha proyecto | `proyecto-X.md` | `proyectos/X/` |

---

## Flujo de procesamiento

```
Nuevo conocimiento/decisión
  ↓
  inbox/ (aterriza aquí)
  ↓
  clasificar (tipo + estado + destino)
  ↓
  ┌───────────────────────────────┐
  │ EJECUTADO → mover a destino  │
  │ PLAN → ejecutar con agente   │
  │ CONOCIMIENTO → mover carpeta │
  │ OBSOLETO → eliminar          │
  └───────────────────────────────┘
  ↓
  inbox vacío = sistema sano
```

---

## Agentes que trabajan con el inbox

| Agente | Rol | Cómo |
|---|---|---|
| [[agentes/perplexity]] | Documenta en tiempo real | MCP GitHub directo |
| [[agentes/claude-sonnet-4.6]] | Ejecuta planes del inbox | MCP + prompts |
| [[agentes/gemini-2.5-pro]] | Audita el inbox masivamente | Texto serializado |

---

## Permanentes (nunca mover)

- `README.md` — este archivo
- `MASTER-PENDIENTES.md` — fuente de verdad

---

## Revisión semanal (cada domingo)

1. Abrir `MASTER-PENDIENTES.md`
2. Revisar tabla `inbox-clasificado` más reciente
3. Mover archivos `EJECUTADO` a sus destinos
4. Archivar sesiones en `diarios/`
5. Actualizar MASTER con lo completado

---
_v3.0 · Actualizado 2026-06-23 · Ver [[HOME]] · [[filosofia]] · [[agentes/AGENT-SCRIPT]]_
