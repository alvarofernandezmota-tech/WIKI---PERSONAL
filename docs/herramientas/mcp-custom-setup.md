---
tags: [mcp, github, gemini, cursor, setup, perplexity]
fecha: 2026-07-02
---

# 🔧 MCP GitHub — Setup propio (Cursor, Gemini, navegador)

## El servidor MCP de GitHub es público

El servidor MCP que usa Perplexity internamente es el oficial de GitHub:
- Repo: `github.com/github/github-mcp-server`
- Es open source, gratuito, auto-hosteable
- Cualquier cliente que soporte MCP puede conectarse

---

## Opción A — Cursor (recomendado para Acer) ⭐

### Setup
```bash
# 1. Instalar Cursor en Arch
yay -S cursor-bin
# o descargar AppImage desde cursor.com

# 2. Abrir Cursor → Settings (Ctrl+,) → buscar "MCP"
# 3. Añadir servidor con esta config:
```

**`~/.cursor/mcp.json`** (Cursor lo crea automáticamente, también puedes editarlo a mano):
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "TU_TOKEN_AQUI"
      }
    }
  }
}
```

### Crear el token GitHub
1. github.com → Settings → Developer settings → Personal access tokens → Fine-grained
2. Permisos mínimos: `Contents: Read/Write`, `Pull requests: Read/Write`, `Issues: Read/Write`
3. Pegar el token en el JSON de arriba

### Resultado
Cursor tiene IA (Claude/GPT) + MCP GitHub + terminal integrada. Entorno completo.

---

## Opción B — Gemini CLI

```bash
# Instalar Gemini CLI
npm install -g @google/gemini-cli
# o
pip install gemini-cli

# Configurar MCP
gemini mcp add github \
  --command "npx @modelcontextprotocol/server-github" \
  --env GITHUB_PERSONAL_ACCESS_TOKEN=TU_TOKEN

# Usar
gemini chat
# Dentro del chat ya tiene acceso al repo
```

---

## Opción C — Claude Desktop (macOS/Windows/Linux)

Fichero de config `claude_desktop_config.json`:
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "TU_TOKEN_AQUI"
      }
    }
  }
}
```

---

## Opción D — Navegador (respuesta directa)

> ¿Se puede añadir el mismo MCP a Perplexity en otro navegador?

**No.** El MCP de Perplexity está configurado en la plataforma, no en el navegador. Perplexity decide qué servidores MCP expone — tú no puedes añadir servidores propios al Perplexity de otro usuario ni al navegador directamente.

**Lo que sí puedes hacer:** usar Cursor o Claude Desktop en Acer, que sí te dejan poner tu propio servidor MCP. El resultado es idéntico (o mejor, porque además tienes terminal).

---

## Resumen de acceso

| Situación | Herramienta | MCP propio |
|---|---|---|
| Móvil / fuera de casa | Perplexity web | ❌ (el de Perplexity ya configurado) |
| Acer — trabajo de código | **Cursor** | ✅ con tu token |
| Acer — terminal puro | `gh` CLI | (no es MCP, pero acceso completo) |
| Acer — chat IA flexible | Gemini CLI | ✅ con tu token |

---
_Documentado: 02-jul-2026 — iPhone 11 — Perplexity vía MCP_
