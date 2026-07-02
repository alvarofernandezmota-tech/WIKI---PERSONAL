# Pendientes — Labels y Milestones
#github #labels #milestones #fase0 #mobile-ok

**Estado:** pendiente — hacer en GitHub web o desde Cursor con token full  
**Tiempo estimado:** 5-10 minutos

---

## Opción A — GitHub web (mobile-ok, ahora mismo)

👉 [github.com/alvarofernandezmota-tech/yggdrasil-dew/labels](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/labels)

1. Borra todos los labels por defecto (hay 38)
2. Crea los 22 labels de la tabla de abajo
3. Crea los 2 milestones

---

## Opción B — Cursor/Gemini CLI con token full (needs-terminal)

Una vez configurado el token `repo` completo (ver `docs/operativa/mcp-setup-multi-ia.md`),
la IA crea todos los labels de golpe sin que toques nada.

---

## Labels a crear (22 total)

### Fases del plan

| Nombre | Color | Descripción |
|---|---|---|
| `fase-0` | `#0075ca` | Estructura y limpieza del repo |
| `fase-1` | `#006b75` | Tailscale / red segura |
| `fase-2` | `#e4e669` | SSH hardening |
| `fase-3` | `#d93f0b` | Wazuh SIEM |
| `fase-4` | `#b60205` | Suricata IDS |
| `fase-5` | `#0e8a16` | GitHub Actions |
| `fase-6` | `#1d76db` | Cursor + MCP Thdora |
| `fase-7` | `#5319e7` | Ollama agentes IA |

### Ejecución

| Nombre | Color | Descripción |
|---|---|---|
| `mobile-ok` | `#0e8a16` | Se puede hacer desde móvil/Perplexity |
| `needs-terminal` | `#fbca04` | Requiere Acer con terminal |

### Tipo

| Nombre | Color | Descripción |
|---|---|---|
| `bug` | `#d73a4a` | Algo roto en producción |
| `docs` | `#0075ca` | Solo documentación |
| `blocked` | `#e11d48` | Bloqueado por dependencia |
| `security` | `#b60205` | Issue de seguridad |
| `infra` | `#006b75` | Infraestructura Madre/Thdora |
| `ai` | `#5319e7` | IA local / agentes |
| `migration` | `#c5def5` | Migración inbox → docs |

### Prioridad

| Nombre | Color | Descripción |
|---|---|---|
| `p0-critico` | `#b60205` | Sistema caído o brecha activa |
| `p1-urgente` | `#d93f0b` | Resolver esta semana |
| `p2-normal` | `#fbca04` | Backlog normal |
| `p3-cuando-pueda` | `#c5def5` | No urgente |

---

## Milestones a crear

👉 [github.com/alvarofernandezmota-tech/yggdrasil-dew/milestones/new](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/milestones/new)

| Título | Due date | Descripción |
|---|---|---|
| `Fase 0 — Repo limpio` | `2026-07-10` | CODEOWNERS, templates, Actions, labels, milestones |
| `Fase 2 — SSH Hardening` | `2026-07-15` | PasswordAuthentication no, fail2ban, test desde Toledo |

---

## Branch protection (Settings → Branches)

👉 Settings → Branches → Add rule

- Branch name pattern: `main`
- ✅ Automatically delete head branches
- ❌ NO require PR (trabajas solo, push directo a main)
- ❌ NO require status checks (aún)
