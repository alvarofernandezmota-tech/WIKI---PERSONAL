---
tags: [diario, sesion, iphone, movil, reorganizacion, mcp]
fecha: 2026-07-02
hora-inicio: 20:00
hora-cierre: ~20:15
maquina: iPhone 11
estado: en-proceso
commits-sesion:
  - 0f92d77 — docs: sesion iPhone + aclaracion MCP
  - 5244700 — docs: ampliar mcp-dispositivos
  - 5008ccb — chore: .gitignore + CONVENCIONES.md
  - 79ad355 — docs: plan reorganizacion + mcp-custom-setup
---

# 📓 Diario — 02-jul-2026 — Sesión noche (iPhone 11)

## Contexto

- Ubicación: Escalona (fuera de casa)
- Dispositivo: iPhone 11
- Madre: ✅ encendida, accesible vía Tailscale (`100.91.112.32`)
- Acer: disponible pero sin MCP configurado en navegador
- Herramienta: Perplexity + MCP GitHub desde móvil
- Rama activa: `main`

---

## Decisiones tomadas esta sesión

### 1. Estrategia de trabajo por dispositivo
- MCP de GitHub funciona en **cualquier dispositivo** con sesión Perplexity activa
- No está ligado al navegador ni al dispositivo
- Acer sin MCP configurado → se documenta todo aquí y se ejecuta en terminal cuando toque
- Ref: `docs/herramientas/mcp-dispositivos.md`

### 2. Opciones MCP más allá de Perplexity
- **Cursor** → opción recomendada para Acer (IA + MCP + terminal en una ventana)
- **Gemini CLI** → `gemini mcp add github` con token propio
- **Claude.ai** → plan Pro, Settings → Integrations
- **`gh` CLI** → sin IA, control total desde terminal
- **Navegador puro** → NO es posible añadir MCP propio a Perplexity desde el navegador. El MCP vive en el Space de Perplexity, no en el navegador.
- Para revisar/reconectar MCP: perplexity.ai → Settings → Spaces
- Ref: `docs/herramientas/mcp-custom-setup.md`

### 3. Auditoría de estructura del repo

**Problemas detectados:**

| Fichero | Problema |
|---|---|
| `tailscale-full.apk` | Binario commiteado — limpiar con BFG |
| `ly` | Fichero vacío basura |
| `.obsidian/` | Config local commiteada |
| `osint/` + `osint-stack/` | Duplicidad — fusionar |
| `tools/` + `cli-tools/` | Duplicidad — fusionar en `scripts/` |
| `diarios/`, `mocs/`, `filosofia.md` en raíz | Van en `docs/` |

**Acciones sin terminal — hechas:**
- [x] `.gitignore` actualizado (`.obsidian/`, `*.apk`, `ly`, binarios)
- [x] `CONVENCIONES.md` reescrito con estructura objetivo
- [x] `docs/herramientas/plan-reorganizacion-repo.md` — diagnóstico + comandos terminal listos
- [x] `docs/herramientas/mcp-dispositivos.md` — tabla acceso por dispositivo
- [x] `docs/herramientas/mcp-custom-setup.md` — setup Cursor, Gemini, Claude

**Pendiente sin terminal:**
- [ ] Profile README del perfil GitHub público
- [ ] Mover `filosofia.md` → `docs/filosofia.md`
- [ ] Crear estructura `docs/diarios/` e índice
- [ ] Revisar contenido `osint-stack/` y `cli-tools/`
- [ ] Actualizar `HOME.md` con árbol real

**Pendiente CON terminal (Acer):**
```bash
git rm ly
git rm --cached tailscale-full.apk
git rm -r --cached .obsidian/
git mv diarios docs/diarios
git mv mocs docs/mocs
git mv filosofia.md docs/filosofia.md
# fusionar osint-stack/ → osint/
# fusionar cli-tools/ tools/ → scripts/
git commit -m "refactor: reorganizar estructura segun CONVENCIONES.md"
```

### 4. Próximos pasos en orden
1. Profile README GitHub (sin terminal) ← siguiente
2. Mover `filosofia.md` a `docs/` (sin terminal)
3. Crear índice `docs/diarios/` (sin terminal)
4. Revisar `osint-stack/` y `cli-tools/` (sin terminal — leer contenido)
5. Actualizar `HOME.md` (sin terminal)
6. SSH hardening en Madre (con terminal en Acer)
7. Limpieza git (`git rm`, `git mv`) (con terminal en Acer)

---

## Notas técnicas

- El servidor MCP de GitHub es público: `github.com/github/github-mcp-server`
- Config para Cursor en `~/.cursor/mcp.json` — ver `docs/herramientas/mcp-custom-setup.md`
- BFG Repo Cleaner para limpiar APK del historial: `rtyley.github.io/bfg-repo-cleaner`
- Tailscale IP Madre: `100.91.112.32`

---
_Sesión en proceso — iPhone 11 — Perplexity vía MCP — 02-jul-2026_
