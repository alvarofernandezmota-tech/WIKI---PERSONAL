---
tags: [herramientas, mcp, perplexity, dispositivos, claude, cursor]
fecha-actualizacion: 2026-07-02
---

# 📱 MCP — Opciones de acceso y plataformas

## Qué es un MCP

MCP (Model Context Protocol) es un protocolo abierto creado por Anthropic. Permite que cualquier IA se conecte a herramientas externas (repos, bases de datos, APIs) de forma estándar. Lo importante: **no es exclusivo de Perplexity** — cualquier plataforma que soporte MCP puede usar el mismo servidor de GitHub.

---

## Todas las opciones para usar el MCP de GitHub

### Opción 1 — Perplexity web / app 🥇 (actual)
- **Dónde:** perplexity.ai desde cualquier dispositivo con tu cuenta
- **Setup:** ya configurado ✅
- **Funciona en:** iPhone, Acer, cualquier navegador
- **Límite:** no puede ejecutar comandos en terminal

### Opción 2 — Claude.ai (Anthropic)
- **Dónde:** claude.ai → Settings → Integrations → GitHub MCP
- **Setup:** conectar cuenta GitHub, autorizar repos
- **Ventaja:** Claude Sonnet/Opus directamente con acceso al repo, sin pasar por Perplexity
- **Disponible:** plan Pro de Claude (claude.ai/upgrade)
- **Mismo resultado** que Perplexity + Claude, pero más directo

### Opción 3 — Cursor (editor de código) ⭐ recomendado para Acer
- **Dónde:** cursor.com — editor basado en VS Code con IA integrada
- **Setup en Acer:**
  ```bash
  # Instalar Cursor en Arch
  yay -S cursor-bin
  # o descargar AppImage desde cursor.com
  ```
- **Configurar MCP GitHub en Cursor:**
  - Cursor → Settings → MCP → Add Server
  - Pegar config del servidor GitHub MCP
  - Autorizar con token GitHub
- **Ventaja:** IA con MCP + terminal integrada + editar ficheros locales del repo
- **Ideal para:** cuando estés en Acer — tienes IA + MCP + terminal todo junto

### Opción 4 — VS Code + extensión GitHub Copilot MCP
- **Dónde:** VS Code con extensión oficial GitHub Copilot
- **Setup:** instalar extensión → autenticar GitHub → MCP disponible
- **Disponible en Arch:** `sudo pacman -S code` o `yay -S visual-studio-code-bin`
- **Ventaja:** ya conoces VS Code, integración muy sólida con el repo

### Opción 5 — Terminal directo con `gh` CLI
- **No es MCP** pero da acceso completo al repo desde terminal
- **Setup en Acer/Madre:**
  ```bash
  sudo pacman -S github-cli
  gh auth login
  gh repo view alvarofernandezmota-tech/yggdrasil-dew
  # Crear issues, PRs, etc:
  gh issue create --title "..." --body "..."
  gh pr create
  ```
- **Ventaja:** sin depender de ninguna IA, control total

---

## Tabla resumen

| Opción | Dispositivo | IA incluida | Terminal | Setup necesario |
|---|---|---|---|---|
| Perplexity web/app | Cualquiera | ✅ Multi-motor | ❌ | ✅ Ya listo |
| Claude.ai | Cualquiera | ✅ Claude | ❌ | Plan Pro + conectar GitHub |
| Cursor | Acer | ✅ Multi-modelo | ✅ | Instalar Cursor + config MCP |
| VS Code + Copilot | Acer | ✅ Copilot | ✅ | Instalar extensión |
| `gh` CLI | Acer/Madre | ❌ | ✅ | `pacman -S github-cli` |

## Recomendación para tu caso

| Situación | Usa |
|---|---|
| Fuera de casa, desde móvil | **Perplexity** (actual) |
| En Acer, trabajo intenso de código | **Cursor** — IA + MCP + terminal |
| En Acer, solo gestión repo rápida | **`gh` CLI** |
| Quieres Claude directo sin Perplexity | **Claude.ai** con integración GitHub |

---
_Actualizado: 02-jul-2026 — Perplexity vía MCP_
