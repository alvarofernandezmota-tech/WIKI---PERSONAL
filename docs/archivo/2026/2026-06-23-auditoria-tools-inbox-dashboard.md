---
tags: [auditoria, tools, inbox, dashboard, dataview]
fecha: 2026-06-23
estado: pendiente-ejecutar
tipo: auditoria
ruta-obsidian: docs/2026-06-23-auditoria-tools-inbox-dashboard.md
fuente: inbox/2026-06-23-auditoria-tools-inbox-dashboard.md
---

# Dashboard inbox — Dataview

> Un dashboard Obsidian que muestra el estado de la inbox en tiempo real.

## Queries Dataview útiles

### Archivos pendientes de migrar
```dataview
TABLE file.mtime AS "Modificado", estado
FROM "inbox"
WHERE estado = "pendiente-migrar"
SORT file.mtime DESC
```

### Archivos por destino
```dataview
TABLE destino-1, destino-2
FROM "inbox"
WHERE destino-1 != null
```

### Resumen por carpeta destino
```dataview
TABLE count(rows) AS "Archivos"
FROM "inbox"
GROUP BY destino-1
```

## Pasos

- [ ] Instalar plugin Dataview en Obsidian
- [ ] Crear `docs/dashboard-inbox.md` con estas queries
- [ ] Probar que funciona con los archivos de inbox

## Referencias
- [[inbox/README]]
