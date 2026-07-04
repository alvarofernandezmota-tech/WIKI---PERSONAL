---
tags: [inbox, home, ecosistema, context, update, pendiente-mover]
fecha: 2026-06-24
destino: HOME.md + ECOSISTEMA.md + CONTEXT.md
estado: borrador-listo
---

# Update HOME + ECOSISTEMA + CONTEXT — Stack real 24 jun 2026

> Estos cambios hay que aplicarlos a los 3 archivos raiz cuando toque refactor.
> El repo actualmente NO refleja el stack real levantado hoy.

---

## Cambios para HOME.md

Anadir seccion:
```markdown
## Stack activo (desde 24 jun 2026)
- Ollama :11434 — qwen2.5:3b-cpu + nomic-embed-text
- Open WebUI :3001 — RAG sobre yggdrasil-dew
- Qdrant :6333 — vector store
- Tailscale — red privada Madre + Acer + varopc
```

## Cambios para CONTEXT.md

Anadir:
```markdown
## Maquinas
- Madre (varpc, 100.91.112.32) — servidor principal, i5-8400, 16GB, Arch
- Acer (varo12f, 100.86.119.102) — portatil secundario
- varopc (theodora) — escritorio principal, Hyprland

## Stack Docker en Madre
- docker-compose en ~/yggdrasil-dew/docker-compose.yml
- Docs en setup/servidor/
```

## Cambios para ECOSISTEMA.md

Anadir seccion Batcueva Fase 1 como COMPLETADA:
```markdown
## Batcueva Fase 1 — COMPLETADA (jun 2026)
- Ollama + Open WebUI + Qdrant en Docker
- CPU optimizado: NUM_THREADS=6, NUM_PARALLEL=1
- Tailscale red privada
- UFW firewall basico
```

---
_Aplicar en: HOME.md, CONTEXT.md, ECOSISTEMA.md_
