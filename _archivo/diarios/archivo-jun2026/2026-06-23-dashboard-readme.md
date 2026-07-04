---
tags: [inbox, dashboard, tools, html, pendiente-migrar]
fecha: 2026-06-23
estado: pendiente-migrar
destino: tools/dashboard/README.md
relacionado-anterior: [[inbox/2026-06-23-auditoria-tools-inbox-dashboard]]
relacionado-siguiente:
ruta-obsidian: inbox/2026-06-23-dashboard-readme.md
---

# Dashboard README — Pendiente Documentar

> Migrar como `tools/dashboard/README.md` cuando se revise el index.html.

## Lo que sabemos

- `tools/dashboard/index.html` existe (10KB)
- Es un dashboard HTML estático
- No tiene README ni documentación

## Pendiente revisar

- [ ] Abrir `index.html` y ver qué muestra
- [ ] Documentar qué datos visualiza
- [ ] Decidir si se integra con RAG (:8001) para datos en tiempo real
- [ ] Crear README.md con:
  - Cómo lanzarlo (`python -m http.server` o similar)
  - Qué visualiza
  - Cómo conectarlo al RAG si procede
