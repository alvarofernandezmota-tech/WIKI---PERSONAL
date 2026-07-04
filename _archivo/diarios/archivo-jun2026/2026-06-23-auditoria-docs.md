---
tags: [auditoria, docs, estructura, documentacion]
fecha: 2026-06-23
estado: pendiente-ejecutar
tipo: auditoria
ruta-obsidian: inbox/2026-06-23-auditoria-docs.md
---

# Auditoría `docs/` — plan de mejora

> Generado en sesión 2026-06-23 · objetivo: escalar al nivel de `agentes/`

## Decisión arquitectura (ADR 2026-06-23)

`docs/` = documentación técnica pública del propio repo yggdrasil-dew.
NO es para documentación de proyectos externos — esos tienen su propia repo.

## Estructura objetivo

```
docs/
  README.md                    ← qué es este repo, cómo usarlo
  ARQUITECTURA.md              ← estructura de carpetas explicada
  COMO-CONTRIBUIR.md           ← cómo añadir nueva info (flujo inbox)
  OBSIDIAN-SETUP.md            ← cómo conectar Obsidian a este repo
  WIKILINKS.md                 ← convenciones de enlace
```

## Pasos a ejecutar

- [ ] Listar contenido actual de `docs/`
- [ ] Verificar que no hay docs de proyectos externos aquí
- [ ] Crear `ARQUITECTURA.md` con la estructura decidida hoy
- [ ] Crear `OBSIDIAN-SETUP.md` — instrucciones sync con Obsidian Git
- [ ] Actualizar README principal del repo
