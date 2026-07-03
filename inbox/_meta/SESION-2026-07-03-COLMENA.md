# Sesión 2026-07-03 — Entrega colmena de agentes

## Qué se entregó y subió

### Scripts nuevos
- `scripts/agentes/agente-mejorador.sh` — detecta problemas, genera branches agent-fix/* y PRs
- `scripts/agentes/agente-fixer.sh` — aplica fixes de reports JSON del mejorador
- `scripts/agentes/agente-vigilante.sh` — monitor SLA inbox/diary, abre issues
- `scripts/agentes/galatea-fabrica-agentes.sh` — fábrica de agentes con plantilla unificada
- `scripts/template-insure.sh` — verifica salud mínima del repo
- `scripts/entrypoint.sh` — entrypoint para agentes en contenedor

### Tests
- `tests/run-agent-tests.sh` — runner: syntax check + insure dry-run + mejorador dry-run

### Documentación
- `docs/PROCESSOS.md` — plantilla por trabajador + tabla de agentes registrados + flujo colmena
- `scripts/agentes/OWNERS` — owners de agentes
- `inbox/agentes/agente-mejorador/README.md`
- `inbox/agentes/agente-fixer/README.md`

### GitHub Actions
- `.github/workflows/auto-pr.yml` — crea PRs desde branches agent-fix/*
- `.github/workflows/watchdog.yml` — watchdog SLA cada 6h

## Pendientes próxima sesión

- [ ] MCP server socket operativo
- [ ] agente-investigador con RAG local
- [ ] agente-self-heal
- [ ] agente-roadmap-master generando issue maestro
- [ ] Integrar logger de terminal en inbox (ver nota abajo)
- [ ] Consolidar diarios/ + diary/
- [ ] Consolidar osint/ + osint-stack/

## Nota: documentar lo que se escribe en terminal

Para que todo lo que se ejecuta en terminal quede en inbox:

```bash
# En ~/.bashrc o ~/.bash_profile de Madre:
export PROMPT_COMMAND='bash ~/yggdrasil-dew/scripts/terminal-logger.sh "$?" "$(history 1)"'
```

El script `terminal-logger.sh` (pendiente de crear) escribe cada comando ejecutado
en `inbox/sesiones/terminal-YYYY-MM-DD.md` con timestamp, comando y exit code.
Así queda rastro completo de la sesión de terminal sin intervención manual.

_Yggdrasil Ecosystem — sesión cerrada 03-jul-2026 23:38 CEST_
