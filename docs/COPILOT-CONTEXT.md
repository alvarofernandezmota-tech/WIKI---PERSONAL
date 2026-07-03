# COPILOT-CONTEXT — Yggdrasil-Dew

Contexto maestro para Copilot, Claude, Perplexity y cualquier LLM que trabaje con este repo.

---

## Estructura sagrada (NO mover ni renombrar)

```
yggdrasil-dew/
├── agentes/           # Un directorio por agente: DISEÑO.md, PROFILE.md, test.sh
├── core/              # Núcleo del sistema
├── diarios/           # Cierres de sesión y health reports (destino final)
├── docs/              # Documentación técnica
├── inbox/             # Zona de trabajo viva
│   ├── drop/          # ÚNICA zona de aterrizaje para archivos externos
│   └── _meta/         # Reportes de auditoría y orquestador
├── islas/             # Islas de conocimiento (*.md con Siguiente-paso)
├── mcp/               # Servidor MCP y adaptadores LLM
├── reports/           # Reportes generados por agentes (por agente/)
├── scripts/           # Scripts del ecosistema
│   └── agentes/       # Scripts de agentes y helpers de Galatea
└── .github/workflows/ # CI/CD
```

---

## CORE — Reglas absolutas

1. **inbox/drop/** es el único punto de entrada para archivos externos. Nada aterriza en otro lugar.
2. **diarios/** es el destino final. Los archivos llegan ahí solo después de ser clasificados.
3. **Ningún cambio destructivo sin PR**. Los agentes proponen, el humano aprueba.
4. **Todo agente debe tener test.sh** que genere un reporte en `reports/<agente>/`.
5. **El orquestador-total.sh** es el único orquestador. No crear variantes paralelas.
6. **Los scripts .sh van en scripts/** (o scripts/agentes/). Nunca en la raíz.

---

## Variables de entorno clave

| Variable | Descripción | Default |
|---|---|---|
| `YGGDRASIL_ROOT` | Ruta raíz del repo | `/srv/yggdrasil-dew` |
| `GITHUB_TOKEN` | Token para PRs automáticos de Galatea | — |
| `MCP_TOKEN` | Token de autenticación del servidor MCP | — (sin auth) |
| `OPENAI_API_KEY` | API key OpenAI para llm-router | — |
| `ANTHROPIC_API_KEY` | API key Anthropic para llm-router | — |
| `LLM_TIMEOUT` | Timeout en segundos para llamadas LLM | `30` |

---

## Plantillas disponibles

- `agentes/PLANTILLA-AGENTE.md` — plantilla para crear agentes nuevos
- `scripts/agentes/galatea-fabrica-agentes.sh` — genera agente completo automáticamente

---

## Flujo de una sesión

```bash
git pull origin main
source scripts/session-logger.sh          # iniciar logging
# ... trabajar ...
bash scripts/orquestador-total.sh audit   # auditoría rápida
bash scripts/session-terminal-doc.sh "descripción"
git add inbox/sesiones/cierre-*.md
git commit -m "docs(sesion): cierre YYYY-MM-DD"
git push origin main
```

---

## Deuda técnica conocida

- [ ] `mcp/server.py` necesita pruebas de integración end-to-end
- [ ] `agente-meta-deep.sh` — implementar `--apply` con Galatea
- [ ] CI: añadir nuevos agentes a `.github/workflows/ci-agentes.yml` al crearlos
- [ ] `docs/tareas/` — crear estructura mínima para que `agent-tareas/test.sh` no avise
- [ ] Métricas de latencia por agente (logs en `reports/<agente>/metrics.json`)

---

## Agentes activos

| Agente | Tipo | Estado |
|---|---|---|
| agent-docs | reporter | ✓ test.sh |
| agent-islas | auditor | ✓ test.sh |
| agent-tareas | auditor | ✓ test.sh |

---

## MCP Tools disponibles

| Tool | Qué hace |
|---|---|
| `orquestador_total` | Corre orquestador-total.sh |
| `llm_router` | Enruta prompt a Ollama/OpenAI/Anthropic |
| `agent_test` | Corre test.sh de un agente |
| `inbox_commit` | Commitea inbox/drop |

Ver `mcp/README.md` para ejemplos de llamadas.
