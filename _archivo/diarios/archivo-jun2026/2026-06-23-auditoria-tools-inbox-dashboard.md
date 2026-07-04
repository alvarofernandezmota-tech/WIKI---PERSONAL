---
tags: [inbox, auditoria, tools, inbox-processor, dashboard, pendiente-migrar]
fecha: 2026-06-23
estado: pendiente-migrar
destino: tools/
relacionado-anterior: [[inbox/2026-06-23-tools-pendientes]]
relacionado-siguiente:
ruta-obsidian: inbox/2026-06-23-auditoria-tools-inbox-dashboard.md
---

# Auditoría tools/ — inbox-processor y dashboard

## tools/inbox-processor/

**Estado:** Solo tiene README.md — el código está pendiente de implementar.

**Qué hace (diseñado):**
- Vigila `inbox/` con watchdog
- Lee frontmatter + contenido de cada nota nueva
- Llama a Ollama local para decidir carpeta destino
- Mueve el archivo y hace git commit automático

**Dos modos:**
- Modo manual — reglas fijas por prefijo (disponible sin Ollama)
- Modo inteligente — Ollama decide destino (requiere RAG funcionando)

**Pendiente crear:**
- [ ] `inbox_processor.py` — script principal
- [ ] `rules.py` — reglas de clasificación
- [ ] `config.yaml` — rutas configurables
- [ ] `requirements.txt`
- [ ] `.env.example`

**Prioridad:** Alta — cuando Ollama esté funcionando esto automatiza el flujo inbox

---

## tools/dashboard/

**Estado:** Tiene `index.html` (10KB) — dashboard HTML estático existente.

**Pendiente:**
- [ ] Leer el contenido de index.html y documentar qué muestra
- [ ] Añadir README.md con descripción y cómo lanzarlo
- [ ] Decidir si se integra con el RAG (consultas en tiempo real)

**Prioridad:** Media — documentar primero, luego integrar

---

## Resumen estado tools/

| Tool | Archivos | Estado real |
|---|---|---|
| `local-brain/` | main.py + deploy + README + requirements + .env + TROUBLESHOOTING | ✅ Completo |
| `local-brain-claude/` | main + deploy + README | ✅ Completo |
| `inbox-processor/` | Solo README | ⏳ Pendiente implementar |
| `dashboard/` | Solo index.html | ⏳ Pendiente documentar |
| `rag_osint_engine.py` | Suelto sin carpeta | ⚠️ Pendiente mover |
