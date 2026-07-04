---
tags: [auditoria, tools, cli, scripts, pendiente]
fecha: 2026-06-23
estado: pendiente-ejecutar
tipo: auditoria
ruta-obsidian: docs/2026-06-23-auditoria-tools.md
fuente: inbox/2026-06-23-auditoria-tools.md
---

# Auditoría `tools/` — plan de mejora

> Sesión 2026-06-23

## Estructura objetivo

```
tools/
  README.md
  scripts/            ← scripts bash/python utilitarios
  cli-tools/          ← herramientas CLI instaladas
  agentes/            ← agentes Python (migrador, etiquetador, auditor)
```

## Agentes a construir

| Agente | Función | Modelo |
|---|---|---|
| Migrador | Lee inbox/, decide destino, hace git mv + commit | qwen2.5:7b |
| Etiquetador | Añade frontmatter a cada archivo | qwen2.5:3b |
| Auditor | Verifica wikilinks rotos, stubs vacíos | qwen2.5:7b |

## Pasos

- [ ] Auditar contenido actual de `tools/`
- [ ] Mover scripts sueltos a `tools/scripts/`
- [ ] Crear estructura `tools/agentes/`
- [ ] Primer agente: migrador inbox automatizado

## Referencias
- [[setup/servidor/scripts/README]]
- [[proyectos/local-brain/README]]
