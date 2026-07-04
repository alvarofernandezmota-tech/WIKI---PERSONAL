# AUDITORÍA COMPLETA — Yggdrasil Dew

## BLOQUE 1 — Estructura base
- [x] ~~Estructura de carpetas~~
- [x] ~~`scripts/orquestador-unico.sh`~~
- [x] ~~`scripts/session-logger.sh`~~
- [x] ~~`scripts/session-terminal-doc.sh`~~

## BLOQUE 2 — File Arrival Guardian
- [x] ~~`scripts/file-arrival-guardian.sh`~~
- [x] ~~`inbox/_meta/`~~

## BLOQUE 3 — MCP Server base
- [x] ~~`mcp/server.py`~~

## BLOQUE 4 — Inbox commit flow
- [x] ~~`scripts/inbox-commit.sh`~~
- [x] ~~`scripts/inbox-clasificador.sh`~~
- [x] ~~`inbox/drop/.gitkeep`~~
- [x] ~~`docs/inbox-flujo.md`~~

## BLOQUE 5 — OCR Ingest
- [x] ~~`scripts/ingest/ocr-ingest.sh`~~
- [x] ~~`scripts/ingest/ocr-worker.service`~~
- [x] ~~`scripts/ingest/ocr-worker-loop.sh`~~

## BLOQUE 6 — Agentes base
- [x] ~~`scripts/agentes/agent-informador.sh`~~
- [x] ~~`scripts/agentes/agente-meta-deep.sh`~~
- [x] ~~`scripts/agentes/llm-router.sh`~~ (requerido por agentes)

## BLOQUE 7 — Herramientas y métricas
- [x] ~~`tools/vector_adapter.py`~~
- [x] ~~`tools/prometheus_exporter.py`~~
- [x] ~~`.github/workflows/meta-deep-audit.yml`~~
- [x] ~~`.github/workflows/e2e-agents.yml`~~
- [x] ~~`docs/OPERATIONAL-PLAYBOOK.md`~~

## BLOQUE 8 — Agentes de ejemplo + Gateway + Vector + Grafana + E2E
- [x] ~~`agentes/agent-ocr-auditor/DISEÑO.md`~~
- [x] ~~`agentes/agent-ocr-auditor/PROFILE.md`~~
- [x] ~~`agentes/agent-ocr-auditor/run.sh`~~
- [x] ~~`agentes/agent-perplexity-informer/DISEÑO.md`~~
- [x] ~~`agentes/agent-perplexity-informer/run.sh`~~
- [x] ~~`tools/auth_gateway.py`~~
- [x] ~~`tools/weaviate_adapter.py`~~
- [x] ~~`tools/grafana/dashboard-yggdrasil.json`~~
- [x] ~~`.github/workflows/meta-deep-draft-pr.yml`~~
- [x] ~~`.github/workflows/e2e-full-flow.yml`~~
- [x] ~~`scripts/verify/run-smoke-tests.sh`~~

## Pendiente — BLOQUE 9
- [ ] Retrieval API para vector index (search endpoint)
- [ ] Draft PRs reales abiertos en GitHub (requiere GITHUB_TOKEN)
- [ ] Grafana dashboard con queries Prometheus completas
- [ ] Rate limiting en auth_gateway.py
- [ ] PII sanitization en llm-router.sh
- [ ] Scopes y role mapping avanzado en gateway
