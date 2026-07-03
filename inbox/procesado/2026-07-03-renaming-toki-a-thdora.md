---
tipo: decision-arquitectura
author: Perplexity-MCP <alvarofernandezmota@gmail.com>
creado: 2026-07-03 01:28 CEST
actualizado: 2026-07-03 01:28 CEST
ruta: inbox/2026-07-03-renaming-toki-a-thdora.md
tags: [thdora, naming, bots, renaming, decision]
status: pendiente-procesar
destino: docs/agentes/ + CONVENCIONES.md + ECOSISTEMA.md
---

# Decisión: Renaming TOKI → THDORA en todo el ecosistema

> TOKI era un nombre provisional. El nombre definitivo y personal es THDORA.
> Esta decisión afecta a todos los bots, documentos y referencias del ecosistema.

---

## Mapa de renaming

| Nombre antiguo | Nombre nuevo | Rol | Repo |
|---|---|---|---|
| TOKI-DEW | **THDORA-DEW** | Bot personal principal — interfaz Telegram usuario | repo propia anexada |
| TOKI-GUARDIAN | **THDORA-GUARDIAN** | Bot vigilancia Madre — Docker, servicios, hardware | repo propia anexada |
| REPO-GUARDIAN | **THDORA-GUARDIAN** (módulo repo) | Vigilancia repositorio GitHub | dentro de yggdrasil-dew |

> **THDORA** es la identidad principal, personal y viva.
> Los bots son extensiones de THDORA, no entidades separadas.

---

## Ficheros a actualizar (renaming)

- [ ] `docs/agentes/repo-guardian-concepto.md` → renombrar TOKI → THDORA
- [ ] `inbox/2026-07-03-auditoria-repo-completa.md` → ya tiene TOKI, actualizar
- [ ] `inbox/2026-07-03-sistema-logs-guardian.md` → actualizar referencias
- [ ] `ECOSISTEMA.md` → todas las referencias TOKI → THDORA
- [ ] `ROADMAP.md` → idem
- [ ] `CONTEXT.md` → idem
- [ ] `AGENT.md` → idem
- [ ] Cualquier `.md` que mencione TOKI

---

## Acción inmediata

Buscar en todo el repo: `grep -r "TOKI" --include="*.md" .`
Reemplazar: `sed -i 's/TOKI-DEW/THDORA-DEW/g; s/TOKI-GUARDIAN/THDORA-GUARDIAN/g; s/TOKI/THDORA/g'`

Esto se puede hacer con un script o vía MCP fichero por fichero.
