---
actualizado: 2026-07-18
---

# CONTEXT — yggdrasil-wiki

## Estado actual

Repo activo. Segundo cerebro del ecosistema. Base de conocimiento organizada en islas por dominio. Última actividad 2026-07-17.

## Nombre real del repo

`WIKI---PERSONAL` en GitHub (nombre canon interno: `yggdrasil-wiki`)

## Estructura verificada

```
wiki/islas/       ← fuente de verdad — ver INDEX.md
wiki/conocimiento/
wiki/infra/
wiki/agentes/
wiki/operaciones/
wiki/vida/
wiki/relaciones/
HOME.md
```

## Pendientes

- [ ] Revisar issue #1 abierto
- [ ] Verificar que `wiki/islas/INDEX.md` está actualizado post-reestructuración
- [ ] Confirmar que `local-brain` apunta a este repo para embeddings RAG

## Relación con local-brain

Este repo es fuente de datos para pipeline RAG:
`yggdrasil-wiki` → `local-brain` (embeddings) → `Qdrant` → `Ollama`

## Última sesión

2026-07-17 — última actividad
2026-07-18 — AGENT.md + CONTEXT.md reescritos con estructura real (auditoría MCP)
