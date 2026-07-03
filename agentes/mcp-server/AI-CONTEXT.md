---
tipo: context-for-ai
version: 1.0
fecha: 2026-07-03
destino: [Gemini, Copilot, Claude, Cursor, cualquier IA con acceso MCP]
---

# Contexto del Ecosistema para IAs Externas

> Lee este fichero antes de cualquier tarea. Es el estado real del ecosistema.

---

## Quién soy y qué es esto

- **Propietario:** Álvaro Fernández Mota
- **Repo principal:** `yggdrasil-dew` (second brain + orquestación)
- **Objetivo:** Ecosistema personal autónomo con agentes, RAG local y autonomía operativa.
- **Filosofia:** Autonomía con límites. Transparencia radical. Responsabilidad humana en decisiones críticas.

---

## Reglas obligatorias para cualquier IA

1. **NUNCA** tocar código de producción directamente.
2. **NUNCA** hacer merge a `main` sin aprobación humana.
3. **NUNCA** borrar ficheros (solo archivar).
4. **SIEMPRE** usar `dry_run: true` en acciones de riesgo.
5. **SIEMPRE** documentar en Markdown antes de actuar.
6. Tareas `[AUTO]` = puedes ejecutar. `[HUMAN]` = espera. `[RISKY]` = notifica.
7. Si algo va mal → crea issue, no lo arregles sin preguntar.

Ver: `agentes/REGLAS-AGENTES.md` (obligatorio)

---

## Estado actual del plan (2026-07-03)

### COMPLETADO ✅

| Componente | Ubicación |
|-----------|----------|
| Inbox pipeline completo | `.github/workflows/` (27 Actions) |
| Sistema diary automático | `diary-writer.yml` + `diary/` |
| Inbox cleanup + archive | `inbox-cleanup.yml` + `autonomous-cron.yml` |
| Scripts cierre/apertura sesión | `scripts/cierre-sesion.sh`, `apertura-sesion.sh` |
| Scripts mantenimiento | `scripts/maintenance/*.sh` |
| Repo analyzer | `scripts/maintenance/repo-analyzer.sh` |
| Macro-spec ecosistema | `agentes/MACRO-SPEC-ECOSISTEMA.md` |
| Esqueleto MCP server | `agentes/mcp-server/mcp_server.py` |
| Ecosystem-snapshot n8n | `agentes/ecosystem-snapshot/n8n-workflow.json` |
| REGLAS-AGENTES | `agentes/REGLAS-AGENTES.md` |
| ROADMAP-MASTER | `ROADMAP-MASTER.md` |
| Reality check + tripwire | `reality-check.yml`, `tripwire-repo.yml` |
| Cron autónomo 24/7 | `autonomous-cron.yml` |

### EN CONSTRUCCIÓN 🔨

| Componente | Prioridad | Quién lo construye |
|-----------|-----------|-------------------|
| health-agent desplegado en Docker | ALTA | Álvaro + Cursor |
| MCP server corriendo en Madre | ALTA | Álvaro + Cursor |
| n8n ecosystem-snapshot workflow activo | ALTA | Álvaro en n8n UI |

### PENDIENTE ❌

| Componente | Semana |
|-----------|--------|
| Roadmap-agent (Actions) | S2 |
| Docs-agent (Actions) | S2 |
| OSINT-agent (Docker + n8n) | S3 |
| Security-agent (Docker + n8n) | S3 |
| Obsidian-agent (Docker + RAG) | S4 |
| PERFIL-ALVARO.md | S4 |
| Álvaro-agent (Docker + RAG + MCP) | S4 |
| Optimization-agent | S4 |

---

## Qué puede hacer cada IA aquí

### Copilot (vía GitHub MCP o Cursor)
- Leer cualquier fichero del repo.
- Proponer cambios en branches `agent/` o `docs/`.
- Generar código para los agentes pendientes.
- Documentar componentes según el estilo del repo.
- Crear issues con etiquetas `[AUTO]` cuando detecte huecos.

### Gemini (vía MCP server Madre o API)
- Mismas capacidades que Copilot cuando el MCP server esté activo.
- Hasta entonces: leer este fichero + los docs de `agentes/` para entender el contexto.
- Sintetizar investigación → escribir en `inbox/` con formato correcto.
- Proponer tareas `[AUTO]` para el ROADMAP.

### Claude / Perplexity (sesiones de trabajo)
- Rol: orquestador de sesión. Ayuda a decidir qué construir.
- Puede pushear directamente a `main` vía MCP GitHub.
- Siempre documenta antes de actuar.

---

## Estructura del repo (mapa rápido)

```
yggdrasil-dew/
├── agentes/              ← cerebro de agentes
│   ├── MACRO-SPEC-ECOSISTEMA.md
│   ├── REGLAS-AGENTES.md
│   ├── mcp-server/           ← MCP server (en construcción)
│   └── ecosystem-snapshot/   ← n8n workflow
├── diary/                ← memoria de sesiones
├── docs/                 ← documentación técnica
├── inbox/                ← sistema nervioso de entrada
│   └── archive/              ← procesados
├── scripts/
│   ├── cierre-sesion.sh
│   ├── apertura-sesion.sh
│   └── maintenance/          ← scripts de mantenimiento
├── .github/workflows/    ← 27 Actions activas
├── ROADMAP-MASTER.md     ← fuente de verdad del plan
└── REGISTRO-AGENTES.md   ← registro de todos los agentes
```

---

## Cómo conectar al MCP server (cuando esté activo en Madre)

```json
// .cursor/mcp.json o config de tu cliente MCP
{
  "mcpServers": {
    "yggdrasil-madre": {
      "url": "http://[IP-MADRE-TAILSCALE]:8001/mcp",
      "description": "MCP server del ecosistema Yggdrasil en Madre"
    }
  }
}
```

Tools disponibles (cuando esté desplegado):
- `check_docker` — estado de contenedores
- `get_ecosystem_state` — snapshot completo
- `read_roadmap` — ROADMAP-MASTER.md
- `list_services` — servicios activos
- `create_issue` — crear issue [AUTO]
- `write_inbox` — escribir en inbox/

---

*Última actualización: 2026-07-03 [AUTO]*
