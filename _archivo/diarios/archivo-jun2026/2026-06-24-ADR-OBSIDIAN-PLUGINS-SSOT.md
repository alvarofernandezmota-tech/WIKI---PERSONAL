---
id: 202406242240
fecha: 2026-06-24
tipo: adr
status: activo
repo: yggdrasil-dew
diario: "[[diarios/2026-06-24]]"
destino: docs/adr/
tags: [inbox, adr, obsidian, plugins, ssot, dataview, git]
---

# ADR-005 — Stack Obsidian plugins para SSOT

## Contexto
Los archivos maestros del repo (CONTEXT, ECOSISTEMA, ESTADO-SISTEMA) se dessincronizan
porque se editan manualmente. Necesitamos que Obsidian sea la interfaz que mantenga
la alineacion automaticamente.

## Decision
Adoptar el siguiente stack de plugins en Obsidian (varopc) en este orden de prioridad:

### FASE 1 — Instalar primero (core)
1. **Obsidian Git** (`Vinzent03/obsidian-git`) — auto-commit cada 2 min, auto-pull al abrir
2. **Dataview** — dashboards dinamicos que reemplazan archivos estaticos
3. **Templater** — plantillas con frontmatter estandar para inbox, diarios, ADR

### FASE 2 — Instalar despues
4. **Auto Note Mover** (`farux/obsidian-auto-note-mover`) — mueve inbox por `destino:` automatico
5. **MetaEdit** — edicion masiva frontmatter
6. **Calendar** — navegacion diarios

## Frontmatter estandar adoptado
```yaml
---
id: YYYYMMDDHHmm
fecha: YYYY-MM-DD
tipo: technical-doc | journal | adr | deep-research | pending
status: draft | activo | archivado
repo: yggdrasil-dew
diario: "[[diarios/YYYY-MM-DD]]"
destino: carpeta/destino/
tags: []
sync: true
---
```

## Consecuencias
- `HOME.md` se convierte en dashboard Dataview puro
- `ESTADO-SISTEMA.md` se fusiona en `CONTEXT.md`
- Inbox con `destino:` se mueve automaticamente con Auto Note Mover
- Commits automaticos cada 2 min sin intervencion manual

## Alternativas descartadas
- Servicios cloud (Obsidian Sync, Notion) — descartado por coste y filosofia open-source
- Submódulos Git — descartado por fragilidad en Obsidian
- Scripts bash manuales — descartado por friccion

---
_Ver: [[inbox/2026-06-24-DEEP-RESEARCH-ALINEACION-SSOT]] · [[CONVENCIONES]] · [[filosofia]]_
