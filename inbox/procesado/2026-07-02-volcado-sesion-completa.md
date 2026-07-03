---
titulo: Volcado sesión completa — 02-jul-2026
fecha: 2026-07-02T21:01
estado: borrador
destino: docs/diarios/2026-07-02.md
tags: [diary, session, volcado, mcp, ia, bots, github]
---

# Volcado sesión completa — 02-jul-2026

> Sesión realizada 100% desde iPhone · Perplexity MCP
> Inicio: ~14:00 CEST · Cierre: 21:01 CEST

---

## Resumen ejecutivo

Sesión larga de iPhone. Se trabajó exclusivamente con Perplexity + MCP GitHub desde móvil.
No hubo acceso a terminal ni a Madre. Todo lo ejecutado fue a través de la API de GitHub.

**Bloques completados:**
1. Auditoría Perplexity vs Comet vs @GitHub — qué funciona y qué no
2. Revisión y actualización de CONVENCIONES.md, AGENT.md
3. Creación de issues #8 al #12 con toda la info técnica
4. Decisión naming definitivo bots Thdora
5. Identificación fases nuevas 6d / 7MCP / 8 / 9
6. Arquitectura MCP multi-IA documentada
7. Auditoría inbox completa (32 ficheros catalogados)
8. MASTER-PENDIENTES actualizado y alineado
9. Plan migración inbox → docs/ creado con script
10. Cierre de sesión documentado

---

## Bloque 1 — Perplexity, Comet, @GitHub

### Hallazgos
- Perplexity web tiene integración `@GitHub` pero NO es MCP completo — es una integración limitada
- Comet (app desktop Perplexity) existe pero NO tiene soporte oficial Linux; en Arch hay workarounds no soportados
- Los LLMs disponibles en Perplexity: Sonar, Claude Sonnet 4.5/4.5 mini, Gemini 2.5 Pro/Flash, GPT-4o, Grok 3
- Perplexity usa actualmente Claude Sonnet 4.6 como motor de este Space
- Firefox y Brave son los navegadores más recomendados para Perplexity web en Linux

### Alternativas MCP reales (sin @)
| Método | Cómo | Resultado |
|---|---|---|
| Claude Desktop + config MCP | `claude_desktop_config.json` | MCP completo |
| Cursor IDE + `.cursor/mcp.json` | Configurar token | MCP completo en editor |
| n8n webhook → GitHub API | Flujo n8n | Para Gemini/DeepSeek |
| Servidor MCP propio en Madre | Node.js/Python local | Control total |

---

## Bloque 2 — Naming definitivo bots

**Decisión tomada y documentada como SSOT en MASTER-PENDIENTES:**

| Bot | Nombre | Función |
|---|---|---|
| Thdora | Thdora | Personal — diario, notas, Obsidian |
| Thdora Guardián | Thdora Guardián | Madre — infra, Docker, Wazuh |
| Thdora Dev | Thdora Dev | GitHub — commits, issues, MCP |

Anterior naming `TOKI-Guardian` / `TOKI-DEW` queda obsoleto.
Issue #12 pendiente de actualizar con nuevo naming.

---

## Bloque 3 — Issues creados hoy

| # | Título | Fase |
|---|---|---|
| #8 | Terminal iPhone → Madre via Termius+Tailscale | Fase 9 |
| #9 | Stack Wazuh+Suricata+Pihole+SearXNG | Fase 4 |
| #10 | Governance auditoría repo | Fase 2/3 |
| #11 | GitHub Actions automatización docs | Fase 5 |
| #12 | Thdora Dev bot repo (antes TOKI-DEW) | Fase 6 |

Issues #13-#15 pendientes de crear (Fases 6d, 7, 8MCP).

---

## Bloque 4 — Fases nuevas identificadas

| Fase | Descripción | Issue |
|---|---|---|
| Fase 6d | Multi-IA vía n8n (Gemini, DeepSeek → GitHub) | #13 (pendiente) |
| Fase 7 | Ollama + RAG + Qdrant + agente autónomo | #14 (pendiente) |
| Fase 8 MCP | Servidor MCP propio en Madre | #15 (pendiente) |
| Fase 9 Mobile | Terminal iPhone completo | #8 |

---

## Bloque 5 — Arquitectura MCP multi-IA

```
SISTEMA OBJETIVO (Fase 8):

Cualquier IA
    │
    ├── Claude Desktop → MCP config → github-mcp-server → yggdrasil-dew
    ├── Cursor → .cursor/mcp.json → github-mcp-server → yggdrasil-dew  
    ├── Gemini → n8n webhook → GitHub API REST → yggdrasil-dew
    ├── DeepSeek → n8n webhook → GitHub API REST → yggdrasil-dew
    └── Ollama local → MCP server propio (Madre:3000) → yggdrasil-dew

TODO queda documentado en la repo siempre.
```

---

## Bloque 6 — IAs gratuitas adoptables

| IA | MCP | Código | Self-hosted | Veredicto |
|---|---|---|---|---|
| Claude free | ✅ nativo | ✅ | ❌ | Mejor opción ahora |
| Gemini free | ⚠️ n8n | ✅ | ❌ | Vía n8n |
| DeepSeek | ⚠️ n8n | ✅ excelente | ❌ | Para código |
| Ollama+Llama3 | 🔧 propio | ✅ | ✅ Madre | Objetivo final |
| Ollama+Mistral | 🔧 propio | ✅ | ✅ Madre | Alternativa local |
| Groq | ⚠️ n8n | ✅ rápido | ❌ | Inferencia rápida |

---

## Bloque 7 — Auditoría inbox

- **32 ficheros** pendientes de migrar
- **2 con naming incorrecto**: `GEMINI-AUDITORIA-ECOSISTEMA-2026-07-01.md` y `PROCEDIMIENTO-MADRE-HOY.md`
- Plan de migración con script bash: `inbox/2026-07-02-auditoria-inbox-migracion.md`
- La migración física requiere terminal en Madre (Thdora)

---

## Bloque 8 — Alineación MASTER-PENDIENTES

Estado real al cierre 21:01:
- ✅ MASTER-PENDIENTES actualizado con fases 6d, 7, 8MCP, naming Thdora, tabla issues
- ✅ Inbox auditada y plan de migración documentado
- ❌ Issues #13-#15 aún sin crear
- ❌ Migración física inbox → docs/ pendiente (needs-terminal)
- ❌ Renombrar ficheros con naming incorrecto (needs-terminal)

---

## Pendientes para próxima sesión (Thdora — terminal)

1. Ejecutar `migrar-inbox.sh` desde raíz del repo
2. Crear issues #13, #14, #15
3. Actualizar issue #12 con naming Thdora Dev
4. Limpiar basura git (`tailscale-full.apk`, `ly`, `.obsidian/`)
5. Migraciones de estructura (`diarios/` → `docs/diarios/`, etc.)
6. Instalar Cursor + configurar MCP GitHub
7. Desplegar 5 workflows GitHub Actions

---

_Volcado sesión completa — 02-jul-2026 21:01 CEST — Perplexity vía MCP_
