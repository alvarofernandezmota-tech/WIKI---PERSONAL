---
tags: [docs, dashboard, readme, obsidian, dataview]
fecha: 2026-06-23
estado: pendiente-ejecutar
ruta-obsidian: docs/2026-06-23-dashboard-readme.md
fuente: inbox/2026-06-23-dashboard-readme.md
---

# Dashboard README — yggdrasil-dew

> Vista general del cerebro. Pendiente implementar en Obsidian con Dataview.

## Secciones del dashboard

- **Inbox**: archivos pendientes de procesar
- **Proyectos activos**: estado de cada proyecto
- **Pendientes**: tareas urgentes de MASTER-PENDIENTES
- **Últimas notas**: modificadas recientemente
- **Docker Madre**: estado de servicios

## Implementación

```dataview
## Inbox pendiente
TABLE file.name, estado
FROM "inbox"
WHERE estado = "pendiente-migrar"

## Proyectos activos  
TABLE estado, file.mtime
FROM "proyectos"
WHERE tipo = "proyecto" AND estado = "activo"
```

## Referencias
- [[inbox/README]]
- [[HOME]]
