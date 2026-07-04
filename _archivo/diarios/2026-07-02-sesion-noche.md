---
tags: [diario, sesion, iphone, movil, reorganizacion, mcp, cierre]
fecha: 2026-07-02
hora-inicio: 20:00
hora-cierre: 20:17
maquina: iPhone 11
estado: cerrado
commits-sesion:
  - 0f92d77 — docs: sesion iPhone + aclaracion MCP + estado acer
  - 5244700 — docs: ampliar mcp-dispositivos con todas las opciones
  - 5008ccb — chore: .gitignore + CONVENCIONES.md actualizados
  - 79ad355 — docs: plan-reorganizacion-repo + mcp-custom-setup
  - 655ad79 — docs: diario sesion noche + inbox pendientes
  - (este commit) — cierre sesion + profile README + indice diarios
---

# 📓 Diario — 02-jul-2026 — Sesión noche (iPhone 11) — CERRADO

## Contexto

- Ubicación: Escalona (fuera de casa)
- Dispositivo: iPhone 11
- Madre: ✅ encendida, accesible vía Tailscale (`100.91.112.32`)
- Acer (Thdora): disponible pero sin MCP configurado
- Herramienta: Perplexity + MCP GitHub desde móvil
- Rama: `main`
- Duración: ~17 minutos

---

## Sesiones del día 02-jul-2026

| Sesión | Fichero | Estado |
|---|---|---|
| Tarde | `2026-07-02-sesion-tarde.md` | ✅ cerrada |
| General | `2026-07-02.md` | ✅ cerrada |
| **Noche (esta)** | `2026-07-02-sesion-noche.md` | ✅ cerrada |

**Total hoy: 3 sesiones.** Las de tarde y general ya estaban en el repo antes de esta sesión. Esta es la última del día.

---

## Trabajo realizado esta sesión

### Documentación creada

| Fichero | Contenido |
|---|---|
| `docs/herramientas/mcp-dispositivos.md` | Tabla acceso MCP por dispositivo y condiciones |
| `docs/herramientas/mcp-custom-setup.md` | Setup MCP propio en Cursor, Gemini CLI, Claude |
| `docs/herramientas/plan-reorganizacion-repo.md` | Diagnóstico completo + estructura objetivo + comandos terminal |
| `inbox/2026-07-02-pendientes-sesion-noche.md` | Lista procesable de pendientes con/sin terminal |
| `diarios/2026-07-02-sesion-noche.md` | Este diario |

### Cambios en el repo

| Fichero | Cambio |
|---|---|
| `.gitignore` | Añadido `.obsidian/`, `*.apk`, `ly`, binarios |
| `CONVENCIONES.md` | Reescrito con estructura objetivo del repo |

### Decisiones tomadas

1. **MCP en navegador puro: NO posible.** El MCP vive en el Space de Perplexity, no en el navegador. Para revisar/reconectar: Settings → Spaces.
2. **Cursor es la opción óptima para Acer** — IA + MCP + terminal en una ventana. Setup: `yay -S cursor-bin` + `~/.cursor/mcp.json` con token GitHub.
3. **Estrategia de trabajo:** todo lo que no requiere terminal se hace desde Perplexity móvil; terminal se ejecuta en Acer cuando toque.
4. **Repo tiene problemas serios de estructura** — `tailscale-full.apk`, `ly`, `.obsidian/` trackeados; carpetas duplicadas (`osint/osint-stack`, `tools/cli-tools`); docs narrativos en raíz en vez de en `docs/`.

---

## Pendiente para próxima sesión

### Sin terminal (Perplexity móvil)
- [ ] Mover `filosofia.md` → `docs/filosofia.md`
- [ ] Revisar contenido `osint-stack/` y `cli-tools/`
- [ ] Actualizar `HOME.md` con árbol real
- [ ] Tareas pendientes en `inbox/2026-07-02-pendientes-sesion-noche.md`

### Con terminal (Acer)
- [ ] SSH hardening Madre completo
- [ ] `git rm ly && git rm --cached tailscale-full.apk`
- [ ] `git rm -r --cached .obsidian/`
- [ ] `git mv diarios docs/diarios`
- [ ] Fusionar `osint-stack/` → `osint/` y `cli-tools/` → `scripts/`
- [ ] Instalar Cursor + configurar MCP GitHub

---
_Cerrado: 02-jul-2026 20:17 CEST — iPhone 11 — Perplexity vía MCP_
