---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-13
actualizado: 2026-07-13
ruta: wiki/islas/mcp.md
tags: [isla, mcp, protocolo, agentes, integraciones]
estado: auditado
---

# Isla MCP — Model Context Protocol

> Protocolo de comunicación entre agentes IA y herramientas externas.
> Consolidado desde 6 archivos dispersos en WIKI---PERSONAL (AUDIT-005 · #42).

---

## ¿Qué es MCP?

**Model Context Protocol** es el protocolo estándar que permite a los modelos de lenguaje (Claude, Perplexity, etc.) conectarse con herramientas externas de forma estructurada.

En el ecosistema Yggdrasil, MCP es la capa de integración entre:
- Los agentes IA (Perplexity, Claude, Grok)
- Los servicios del ecosistema (GitHub, Google Drive, ficheros locales)
- La wiki y el DEW (lectura/escritura directa por MCP)

---

## Arquitectura MCP en Yggdrasil

```
Agente IA (Perplexity / Claude)
        │
        │  MCP Protocol
        ▼
  MCP Server (local o remoto)
        │
   ┌────┴────────────────────┐
   │                         │
   ▼                         ▼
GitHub MCP             Google Drive MCP
(repos, issues,        (docs, sheets)
PRs, commits)
        │
        ▼
yggdrasil-dew / yggdrasil-wiki / VIDAPERSONAL
```

---

## Servidores MCP activos

| Servidor | Herramienta | Estado | Notas |
|----------|-------------|--------|-------|
| `github_mcp_direct` | GitHub | ✅ Activo | Repos, issues, PRs, commits, archivos |
| Google Drive MCP | Google Drive | 🟡 Configurado | Docs, Sheets |
| Filesystem MCP | Ficheros locales | ⚪ Pendiente | Requiere setup en Madre |

---

## Operaciones habituales por MCP

### Escritura en repos
```
create_or_update_file → crear/actualizar archivos
push_files            → multi-archivo en un commit
create_branch         → nueva rama
create_pull_request   → PR desde rama
```

### Issues y trazabilidad
```
issue_write (create)  → abrir issue con contexto
issue_write (update)  → cerrar/actualizar issue
list_issues           → ver estado del plan
search_issues         → buscar por label/texto
```

### Lectura
```
get_file_contents     → leer archivos del repo
list_commits          → historial de cambios
pull_request_read     → revisar PRs
```

---

## Convención de uso en sesiones DEW

> **Regla:** Todo lo que Perplexity puede hacer por MCP, lo hace directamente sin esperar confirmación innecesaria.
> Todo lo que requiere terminal queda como issue con comandos exactos.

1. **Leer antes de escribir** — siempre `get_file_contents` antes de `create_or_update_file`
2. **Un commit por contexto** — no mezclar cambios de distintas islas en un commit
3. **Issues como contrato** — cada tarea pendiente = issue en DEW, nunca en el chat
4. **SHA obligatorio en updates** — nunca sobreescribir sin leer el SHA actual

---

## Decisión pendiente

> ¿MCP merece isla propia o se fusiona con `cerebro.md`?

**Decisión provisional (2026-07-13):** isla propia. MCP es infraestructura de protocolo, no filosofía de sistema. `cerebro.md` describe el triángulo DEW↔Wiki↔VIDAPERSONAL; MCP es la fontanería que lo hace funcionar.

---

## Relaciones

- → [`cerebro.md`](cerebro.md) — arquitectura del sistema
- → [`orquestador.md`](orquestador.md) — n8n + THDORA + MCP
- → [DEW #42](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/42) — AUDIT-005 origen
- → [DEW `docs/canon/ARQUITECTURA-C4.md`](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/canon/ARQUITECTURA-C4.md)

---

_Auditado: 2026-07-13 · Perplexity-MCP · AUDIT-005_
