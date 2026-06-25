---
tags: [inbox, workflow, reglas]
fecha: 2026-06-25
---

# Inbox — Reglas y Workflow

> La inbox es la zona de aterrizaje. Nada vive aquí permanentemente.
> **Regla de oro: si entró, tiene que salir.**

---

## Estados de un fichero en inbox

Cada fichero lleva el estado en el frontmatter o en el nombre:

| Estado | Significado | Acción |
|--------|-------------|--------|
| `añadido` | Recién llegado, sin revisar | Revisar en la próxima sesión |
| `empezado` | En proceso de procesar | Terminar antes de añadir más |
| `en-proceso` | Activamente trabajando en ello | Prioridad del día |
| `finalizado` | Procesado, listo para migrar | Mover al destino y borrar de inbox |

---

## Convenciones de nombre

```
FECHA-descripcion-breve.md
2026-06-25-ideas-pentest.md
2026-06-25-notas-sesion-gemini.md
```

---

## Destinos de migración

| Tipo de contenido | Destino |
|-------------------|---------|
| Diario / log sesión | `diarios/YYYY-MM-DD.md` |
| Documentación infraestructura | `setup/servidor/` o `docs/` |
| Pendientes nuevos | Mover a `MASTER-PENDIENTES.md` |
| Investigación OSINT/Pentest | `docs/pentesting/` |
| Notas IA/LLM | `docs/ias/` o `ollama/` |
| Scripts | `scripts/` |
| Notas personales | `yo/` |
| Sin destino claro | `archivo/YYYY-MM/` |

---

## Regla de procesado diario

1. Ejecutar `bc inbox` al inicio de la sesión
2. Revisar qué hay en `inbox/`
3. Cada fichero: leer → decidir destino → mover → borrar de inbox
4. La inbox debe quedar **vacía** al cerrar la sesión
5. Si no se puede procesar hoy: marcar como `empezado` y dejar nota en el fichero

---

## Estado actual

**✅ INBOX ZERO — 25 jun 2026 14:59**

No hay ficheros pendientes. Todo migrado.

---
_Reglas del ecosistema: ver [[ECOSISTEMA]] · [[CONVENCIONES]]_
