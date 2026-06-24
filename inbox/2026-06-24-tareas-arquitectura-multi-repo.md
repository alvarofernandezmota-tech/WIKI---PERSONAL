# Tareas pendientes — arquitectura multi-repo — 24 jun 2026

> Todo lo hablado en la sesión que falta por ejecutar.
> Mover a MASTER-PENDIENTES cuando se procese.

---

## P1 — Esta semana

- [ ] Crear repo `batcueva` (privado) — infraestructura Madre
- [ ] Mover `setup/servidor/` completo a `batcueva/`
- [ ] Dejar `setup/` en yggdrasil-dew como puntero: "ver repo batcueva"
- [ ] Migrar `yo/*.md` a `personal/00_yo/`
- [ ] Mover `setup/ias/` a `agentes/`
- [ ] Actualizar ECOSISTEMA.md con nueva arquitectura 5 repos

## P2 — Próxima semana

- [ ] Limpiar ficheros sueltos en `setup/` con fecha → `docs/` o archivar
- [ ] Unificar `ollama/` — todo bajo `ollama/modelos/`
- [ ] Crear `docs/sistema/red-alternativas.md` (desde inbox hotspot)
- [ ] Auditar `tools/local-brain/main.py` — ¿proyecto activo?
- [ ] Auditar proyectos terminal-ia y chatbot-control

## P3 — Cuando haya tiempo

- [ ] Repo público `thdora` separado
- [ ] Repo público `local-brain` separado
- [ ] Setup Obsidian móvil (Working Copy + Obsidian Git)
- [ ] Router 4G/5G propio — eliminar dependencia hotspot
- [ ] tmux como estándar en Madre para sesiones persistentes

## Arquitectura objetivo

```
personal       ← vida (privado) ✅
yggdrasil-dew  ← conocimiento (cerebro)
batcueva       ← infraestructura Madre ⏳ pendiente crear
thdora         ← agente IA ⏳ pendiente separar
local-brain    ← cerebro local ⏳ pendiente separar
```

Todo unido por Obsidian vault + wikilinks + ECOSISTEMA.md

---
_Mover a: MASTER-PENDIENTES.md_
_Ver: [CONVENCIONES.md Regla 13](../CONVENCIONES.md) · [ECOSISTEMA.md](../ECOSISTEMA.md)_
