---
title: Isla MCP — Model Context Protocol en Yggdrasil
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-13
actualizado: 2026-07-13
ruta: wiki/islas/mcp.md
tags: [mcp, protocolo, llm, agentes, isla]
status: vigente
fuentes:
  - docs/mcp/PLAN-MCP-YGGDRASIL.md (archivado)
  - docs/arquitectura/llm-mcp-investigacion.md (archivado)
  - docs/operativa/mcp-setup-multi-ia.md (archivado)
  - docs/herramientas/mcp-dispositivos.md (archivado)
  - docs/herramientas/mcp-custom-setup.md (archivado)
  - docs/GATEWAY-MCP.md (archivado)
---

# 🔌 Isla MCP — Model Context Protocol

> Esta isla es la fuente única de verdad sobre el protocolo MCP en Yggdrasil.
> Consolida 6 archivos anteriores (ver `fuentes` en frontmatter).
> Los originales han sido archivados en `wiki/_archivo/`.

---

## ¿Qué es MCP en Yggdrasil?

MCP (Model Context Protocol) es el protocolo que permite a los LLMs (Claude, Perplexity, Gemini)
interactuar con herramientas externas de forma estandarizada. En Yggdrasil es la capa que desacopla
el **cerebro** (LLMs) de la **interfaz** (Open WebUI / LibreChat) y de los **repos** (GitHub MCP).

**La apuesta arquitectural clave:** en lugar de configurar cada herramienta para cada IA,
MCP actua como bus universal. Una herramienta implementa el protocolo una vez y todas las IAs
pueden usarla sin puentes intermedios.

---

## Arquitectura MCP en Madre

```
┌─────────────────────────────────────────┐
│              MADRE (nodo central)              │
│                                                │
│  ┌─────────┐  ┌─────────┐  ┌────────┐   │
│  │ LiteLLM │  │  Ollama  │  │  n8n   │   │
│  │ (proxy)  │  │(modelos)│  │(flows)│   │
│  └─────────┘  └─────────┘  └────────┘   │
│            ↓ MCP tools                       │
│  ┌──────────────────────────────────┐    │
│  │  GitHub MCP │ filesystem │ fetch  │    │
│  │  memory MCP │ brave MCP  │  ...   │    │
│  └──────────────────────────────────┘    │
└─────────────────────────────────────────┘
```

---

## Servidores MCP activos en Madre

| Servidor | Función | Estado |
|---|---|---|
| `github-mcp-direct` | Lectura/escritura repos GitHub | ✅ Activo |
| `filesystem` | Acceso a archivos locales del nodo | ✅ Activo |
| `fetch` | Peticiones HTTP desde el agente | ✅ Activo |
| `memory` | Memoria persistente entre sesiones | ✅ Activo |
| `brave-search` | Búsquedas web privadas | 🔄 Pendiente verificar |
| `n8n-mcp` | Trigger de flujos n8n desde agente | 🔄 Planificado |

---

## Agentes configurados

Ver `wiki/agentes/` para cada agente. Resumen:

| Agente | Modelo base | Herramientas MCP |
|---|---|---|
| Perplexity | Sonnet 4.6 | GitHub MCP, search, calendar, email |
| Claude (Artifacts) | Claude 3.7 | filesystem, fetch, memory |
| Thdora-bot | LLM local vía LiteLLM | n8n flows, Telegram |

---

## Convención de naming

- Prefijo `mcp-` para archivos de configuración de servidores MCP
- Los servidores se registran en `~/.config/claude/` o en la config del cliente IA correspondiente
- Un servidor MCP = un archivo de config + su documentación en esta isla

---

## Issues relacionados (DEW)

- `#43` — IaC docker-compose drift — afecta al entorno donde corren los MCP servers
- `#46` — Crash loop log_guardian — puede interferir con herramientas MCP que usan logs

---

## Pendiente (F4 parcial)

- [ ] Auditar `wiki/agentes/` (thdora.md, perplexity.md, README.md) — decidir si es isla separada o fusionar aquí
- [ ] Verificar que los 6 archivos fuente originales han sido archivados o redirigen aquí
- [ ] Documentar configuración exacta de `brave-search` MCP en Madre

---

_Creado: 2026-07-13 · Perplexity-MCP · Consolida F4 del Plan Maestro_
