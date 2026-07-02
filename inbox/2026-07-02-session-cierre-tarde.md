---
titulo: Cierre sesión tarde — 02-jul-2026
fecha: 2026-07-02
estado: borrador
destino: docs/diarios/2026-07-02.md
tags: [diary, session, bots, mcp, ia]
---

# Cierre sesión tarde — 02-jul-2026

> Sesión realizada desde iPhone · Perplexity MCP
> Bloques documentados en esta sesión:
> 1. Naming definitivo de bots Thdora
> 2. Fases pendientes y estado de issues
> 3. Visión MCP multi-IA (Gemini, DeepSeek, Perplexity, Claude)
> 4. IAs gratuitas adoptables con MCP y código

---

## 1. Naming definitivo — Bots Thdora

> Decisión tomada 02-jul-2026. SSOT: este doc → migrar a ECOSISTEMA.md

| Bot | Nombre correcto | Función principal |
|---|---|---|
| **Thdora** | Thdora | Bot personal — diario, notas, tareas, Obsidian |
| **Thdora Guardián** | Thdora Guardián | Servidor Madre — Docker, Wazuh, Suricata, alertas infra |
| **Thdora Dev** | Thdora Dev | GitHub repo — commits, issues, inbox, audit, MCP |

**Regla**: Thdora es el ecosistema personal. Los bots son extensiones con rol claro.
**Corrección pendiente**: El issue #12 dice `TOKI-DEW` y `TOKI-Guardian` — hay que actualizar al naming `Thdora Dev` / `Thdora Guardián` en cuanto se migre.

---

## 2. Limpieza repo — tareas pendientes Thdora

```bash
# Ejecutar desde terminal madre en próxima sesión Thdora

# Limpiar archivos rastreados incorrectamente
git rm --cached tailscale-full.apk ly
git rm -r --cached .obsidian/

# Migraciones de estructura
git mv diarios/ docs/diarios/
git mv filosofia.md docs/
git mv cli-tools/* scripts/

# Migrar inbox a docs/ (ver destino: en frontmatter de cada fichero)
# Los ficheros de hoy tienen destino: docs/diarios/2026-07-02.md y docs/herramientas/
```

---

## 3. Estado fases — lo que hay y lo que falta

### Fases documentadas en issues actuales

| Fase | Issue | Título | Estado |
|---|---|---|---|
| Fase 1 | #1 (cerrado) | Setup Acer varo12f | ✅ Completo |
| Fase 2 | #3 | Setup varpc Madre | 🔄 Abierto |
| Fase 3 | - | Netdata dashboard | ✅ En #2 roadmap |
| Fase 4 | - | Centinelas y alertas | ⏳ En #2 roadmap |
| Fase 5 | - | Obsidian vault | ⏳ En #2 roadmap |
| Fase 6a | - | TOKI bot Telegram handlers | ⏳ Sin issue propio |
| Fase 6b | - | n8n hardened | ⏳ Sin issue propio |
| Fase 6c | #12 | TOKI-DEW bot repo | 🔄 Abierto |
| Fase 6d | - | Gemini/DeepSeek vía n8n→GitHub | ⏳ **Sin issue — crear** |
| Fase 7 | - | Ollama local en Madre | ⏳ **Sin issue — crear** |
| Fase 8 | - | MCP server propio en Madre | ⏳ **Sin issue — crear** |
| Fase 9 | - | Dashboard control IAs | ⏳ **Sin issue — crear** |

### Issues de hoy sin fase asignada aún

- **#10** — Gobernanza repo (auditoría) → Fase 4 governance
- **#11** — GitHub Actions update docs → Fase 5 automation
- **#8** — Terminal iPhone Termius+Tailscale → Fase 2b mobile
- **#9** — Stack Wazuh+Suricata+Pihole+SearXNG → Fase 3 security

**Acción pendiente**: Crear issues #13–#16 para fases 6d, 7, 8, 9.

---

## 4. Visión MCP multi-IA — arquitectura decidida

> Objetivo: usar cada IA como uso Perplexity con @GitHub — todo queda en la repo documentado.

### Estado por IA

| IA | MCP GitHub | Cómo conectar | Estado |
|---|---|---|---|
| **Perplexity** | ✅ `@GitHub` web | Ya funcionando — este método | ✅ Activo |
| **Claude** (Cursor/CLI) | ✅ MCP nativo | `claude_desktop_config.json` con servidor MCP GitHub | ⏳ Instalar en Madre |
| **Gemini** | ⚠️ No MCP nativo aún | n8n webhook → GitHub API REST | ⏳ Fase 6d |
| **DeepSeek** | ⚠️ No MCP nativo | n8n webhook → GitHub API REST | ⏳ Fase 6d |
| **Ollama local** | 🔧 Via servidor MCP propio | Servidor MCP custom en Madre → Ollama API | ⏳ Fase 7–8 |

### Pasos MCP para Perplexity (terminal web — pendiente ejecutar)

Esto es lo que había que hacer en la terminal web de Perplexity para instalar el servidor MCP GitHub:

```bash
# En terminal web Perplexity o en Madre
npx @modelcontextprotocol/create-server github
# o usando el servidor oficial
npm install -g @modelcontextprotocol/server-github
export GITHUB_PERSONAL_ACCESS_TOKEN=ghp_xxxx
mcp-server-github
```

Actualmente Perplexity ya tiene `@GitHub` integrado en la web — no necesitamos instalar nada para el flujo actual.

### Flujo Gemini → GitHub (Fase 6d)

```
Gemini (prompt) → n8n webhook → GitHub API REST → commit/issue/PR
                                      ↑
                              Token PAT GitHub
```

### Flujo Ollama local → MCP (Fase 7–8)

```
Ollama (Madre, GTX 1060) → servidor MCP custom → yggdrasil-dew
         ↑                         ↑
    modelo local              Node.js/Python
    (llama3, mistral)         puerto :3000
```

---

## 5. IAs gratuitas adoptables con MCP y código

### Criterios de selección
- Gratuitas o self-hosted
- Soportan MCP o tienen API abierta para integrarse
- Pueden ejecutar/generar código

| IA | Tier gratuito | MCP | Código | Self-hosted | Veredicto |
|---|---|---|---|---|---|
| **Claude.ai** (Anthropic) | ✅ Plan free | ✅ MCP nativo | ✅ | ❌ Cloud | ⭐ Mejor opción para MCP |
| **Gemini** (Google) | ✅ Free tier | ⚠️ No nativo | ✅ | ❌ Cloud | Bueno vía n8n |
| **DeepSeek** | ✅ API gratuita (limits) | ⚠️ No nativo | ✅ excelente | ❌ Cloud | Bueno para código |
| **Ollama + Llama 3.1** | ✅ 100% free | 🔧 Via servidor propio | ✅ | ✅ **En Madre** | ⭐ Objetivo final |
| **Ollama + Mistral** | ✅ 100% free | 🔧 Via servidor propio | ✅ | ✅ **En Madre** | ⭐ Alternativa local |
| **Ollama + CodeLlama** | ✅ 100% free | 🔧 Via servidor propio | ✅ **especializado** | ✅ **En Madre** | Para código puro |
| **Groq** (cloud) | ✅ Free tier generoso | ⚠️ No nativo | ✅ rápido | ❌ Cloud | Inferencia rápida |

### Recomendación adoptada

1. **Ahora**: Perplexity @GitHub (ya funcionando) + Claude free para MCP avanzado
2. **Fase 6d**: Gemini + DeepSeek vía n8n → mismo resultado que MCP
3. **Fase 7**: Ollama en Madre — IA 100% local, sin depender de nadie, GTX 1060 6GB soporta modelos 7B
4. **Fase 8**: Servidor MCP propio en Madre que conecta Ollama local + yggdrasil-dew

> Modelo final: **Ollama local + MCP propio = IA privada con acceso completo al ecosistema sin ningún servicio externo**

---

## Pendientes directos de esta sesión

- [ ] Actualizar issue #12 naming TOKI → Thdora Dev / Thdora Guardián
- [ ] Crear issue Fase 6d: Gemini+DeepSeek vía n8n
- [ ] Crear issue Fase 7: Ollama en Madre
- [ ] Crear issue Fase 8: MCP server propio
- [ ] Actualizar ECOSISTEMA.md con naming definitivo bots
- [ ] Ejecutar limpieza repo desde Thdora (bloque bash sección 2)

---

_Documentado desde iPhone · Perplexity MCP · 02-jul-2026 20:47 CEST_
