---
tags: [diario, sesion, 2026-06-23, resumen, ollama, rag, infraestructura]
fecha: 2026-06-23
tipo: diario-sesion
ruta-obsidian: diarios/2026-06-23-sesion-completa.md
fuente: inbox/2026-06-23-sesion-completa.md
---

# Sesión completa — 2026-06-23

> Diario maestro de la sesión. Ver también [[diarios/2026-06-23-yggdrasil-v4-diario-maestro]].

## Lo que se hizo hoy

### Mañana
- Investigación RAG con Claude y Gemini en paralelo
- Decisión: qwen2.5:3b + bge-m3 + ChromaDB (conservar)
- Bug BM25 detectado por Claude (no persiste entre reinicios → pickle)

### Tarde
- Auditoría completa de todas las carpetas del repo
- ADRs creados: ollama-en-agentes, docs-as-code, homelab-vs-proyectos
- Decisión arquitectura proyectos: repos separados
- Stack Batcueva definitivo: Ollama + WebUI + Qdrant + SpiderFoot
- Descarga Docker iniciada en Madre (3 imágenes)

### Noche
- Madre suspendida → conexión cortada desde Acer
- Suspensión deshabilitada al llegar a casa
- Descarga Docker reiniciada con retry robusto
- Migración inbox ejecutada

## Completado hoy ✅

- [x] filosofia.md v3.0
- [x] ADR homelab vs proyectos
- [x] ADR docs-as-code
- [x] ADR ollama vs agentes
- [x] Auditorías completas (9 carpetas)
- [x] Prompt Claude refactor repo
- [x] Prompt Claude ecosistema Docker
- [x] Stack Batcueva definitivo documentado
- [x] Migración inbox completa

## Referencias
- [[inbox/MASTER-PENDIENTES]]
- [[diarios/2026-06-23-yggdrasil-v4-diario-maestro]]
