# MCP GitHub — Setup multi-IA
#mcp #github #operativa #fase6 #needs-terminal

**Fecha:** 2026-07-03  
**Estado:** parcial — Perplexity conectado, Cursor/Gemini pendientes

---

## Qué es el MCP de GitHub

El Model Context Protocol (MCP) permite que una IA controle GitHub directamente:
crea ficheros, commits, issues, PRs, lee repos... sin que el usuario toque nada.

Perplexity ya tiene el MCP conectado con un token de scope limitado.
Cursor y Gemini CLI necesitan un token con scope `repo` completo para poder
hacer labels, milestones y branch protection también.

---

## Estado por IA

| IA | MCP soporte | GitHub MCP | Gratis | Scope actual |
|---|---|---|---|---|
| **Perplexity** | ✅ activo | ✅ conectado | ✅ | Limitado — sin labels/settings |
| **Cursor** | ✅ nativo | ✅ sí | ✅ parcial | Pendiente configurar |
| **Gemini CLI** | ✅ MCP | ✅ sí | ✅ gratis | Pendiente configurar |
| **Claude** | ✅ MCP nativo | ✅ sí | ❌ pago | — |
| **Grok** | ❌ no MCP | ❌ no | — | — |
| **ChatGPT** | ❌ no MCP | ❌ no | — | — |
| **Windsurf** | ✅ MCP | ✅ sí | ✅ parcial | Pendiente |

**Combo óptimo gratuito:**
- Perplexity → GitHub MCP + docs + research (ya activo)
- Cursor → código + MCP local filesystem en Acer
- Gemini CLI → terminal en Madre, gratis ilimitado

---

## Paso 1 — Crear token GitHub con scope completo

👉 [github.com/settings/tokens/new](https://github.com/settings/tokens/new)

**Nombre:** `mcp-full-repo-2026`  
**Expiration:** 90 days (o No expiration)

**Scopes necesarios:**
- ✅ `repo` (completo — incluye labels, milestones, branch protection)
- ✅ `workflow` (para GitHub Actions)
- ✅ `read:org` (opcional, para teams)

Guarda el token — solo se muestra una vez.

---

## Paso 2 — Configurar en Cursor (Acer)

En el Acer, abre o crea `~/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "TU_TOKEN_AQUI"
      }
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/home/alvaro"]
    }
  }
}
```

Reinicia Cursor. Verifica en Settings → MCP que aparecen los dos servidores en verde.

---

## Paso 3 — Configurar en Gemini CLI (Acer o Madre)

Instalar Gemini CLI si no está:
```bash
npm install -g @google/gemini-cli
```

Crear/editar `~/.gemini/settings.json`:
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

Verificar:
```bash
gemini mcp list
```

---

## Paso 4 — Verificar que labels ya funcionan

Con el token `repo` completo, desde Cursor o Gemini CLI:
```
@github crea el label "fase-0" color #0075ca descripción "Estructura y limpieza del repo" en alvarofernandezmota-tech/yggdrasil-dew
```

Si responde OK → el scope es correcto y ya puedes delegar todo a la IA.

---

## Qué puede hacer cada IA con MCP repo completo

| Acción | Perplexity (actual) | Cursor/Gemini (token full) |
|---|---|---|
| Crear ficheros / commits | ✅ | ✅ |
| Crear issues / PRs | ✅ | ✅ |
| Crear labels | ❌ | ✅ |
| Crear milestones | ❌ | ✅ |
| Branch protection | ❌ | ✅ |
| Ejecutar comandos en Acer | ❌ | ✅ (filesystem MCP) |
| Conectar a Madre vía SSH | ❌ | ✅ (Fase 6) |

---

## Próximos pasos (needs-terminal)

- [ ] Crear token `mcp-full-repo-2026` en GitHub Settings
- [ ] Configurar `~/.cursor/mcp.json` en Acer
- [ ] Verificar labels funcionan desde Cursor
- [ ] Configurar Gemini CLI en Madre
- [ ] Fase 6 — MCP bash/filesystem para control total desde IA

> Ver también: `docs/operativa/github-pillars.md` y `docs/operativa/github-actions.md`
