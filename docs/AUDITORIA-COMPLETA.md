# AUDITORÍA COMPLETA — yggdrasil-dew

> Archivo maestro de seguimiento. Cada ítem se tacha cuando entra en `main`.
> Actualizado automáticamente con cada commit de bloque.

---

## BLOQUE 0 — Base del ecosistema

- [x] ~~`mcp/mcp_client.c`~~
- [x] ~~`mcp/llm_adapters.py`~~
- [x] ~~`mcp/requirements.txt`~~
- [x] ~~`mcp/README.md`~~
- [x] ~~`scripts/agentes/llm-router.sh`~~
- [x] ~~`agentes/PLANTILLA-AGENTE.md`~~
- [x] ~~`.github/workflows/ci-agentes.yml`~~
- [x] ~~`docs/PLAYBOOK-DEPLOY.md`~~
- [x] ~~`docs/COPILOT-CONTEXT.md`~~
- [x] ~~`scripts/orquestador-total.sh` v2.0~~
- [x] ~~`scripts/agentes/agente-meta-deep.sh` (dry-run inicial)~~
- [x] ~~`scripts/agentes/galatea-fabrica-agentes.sh`~~
- [x] ~~`scripts/agentes/galatea-create-pr-sample.sh`~~
- [x] ~~`agentes/agent-docs/test.sh`~~
- [x] ~~`agentes/agent-islas/test.sh`~~
- [x] ~~`agentes/agent-tareas/test.sh`~~

---

## BLOQUE 1 — OCR + Ingest Pipeline

- [x] ~~`scripts/ingest/ocr-ingest.sh`~~
- [x] ~~`scripts/ingest/ocr-worker.service`~~
- [x] ~~`inbox/ocr/raw/.gitkeep`~~
- [x] ~~`inbox/ocr/text/.gitkeep`~~
- [x] ~~`inbox/ocr/meta/.gitkeep`~~
- [x] ~~`inbox/ocr/processed/.gitkeep`~~

---

## BLOQUE 2 — MCP Auth + Herramientas

- [x] ~~`mcp/server.py` (reescrito con auth Bearer + rate limit)~~
- [x] ~~`tools/auth_gateway.py`~~

---

## BLOQUE 3 — Vector DB + Métricas

- [x] ~~`tools/vector_adapter.py` (local + Weaviate)~~
- [x] ~~`tools/prometheus_exporter.py`~~

---

## BLOQUE 4 — Agentes de ejemplo

- [x] ~~`agentes/agent-ocr-auditor/DISEÑO.md`~~
- [x] ~~`agentes/agent-ocr-auditor/PROFILE.md`~~
- [x] ~~`agentes/agent-ocr-auditor/test.sh`~~
- [x] ~~`agentes/agent-perplexity-informer/DISEÑO.md`~~
- [x] ~~`agentes/agent-perplexity-informer/PROFILE.md`~~
- [x] ~~`agentes/agent-perplexity-informer/test.sh`~~

---

## BLOQUE 5 — Templates y Galatea completo

- [x] ~~`scripts/agentes/agent-templates/PLANTILLA-AGENTE.md`~~
- [x] ~~`scripts/agentes/agent-templates/PROFILE-TEMPLATE.md`~~
- [x] ~~`scripts/agentes/galatea-fabrica-agentes.sh` (versión completa)~~
- [x] ~~`scripts/agentes/galatea-create-pr.sh` (con draft mode)~~
- [x] ~~`scripts/agentes/llm-router.sh` (con Anthropic + circuit breaker)~~
- [x] ~~`scripts/agentes/agente-meta-deep.sh` (LLM integrado + PR draft auto)~~

---

## BLOQUE 6 — Workflows GitHub Actions

- [x] ~~`.github/workflows/orquestador-total.yml`~~
- [x] ~~`.github/workflows/meta-deep-audit.yml`~~
- [x] ~~`.github/workflows/watchdog.yml`~~

---

## BLOQUE 7 — Contexto y directorios

- [x] ~~`inbox/context/perplexity/.gitkeep`~~
- [x] ~~`reports/.gitkeep`~~
- [x] ~~`logs/.gitkeep`~~
- [x] ~~`docs/AUDITORIA-COMPLETA.md` (este archivo)~~

---

## PENDIENTE — Próximo bloque

- [ ] `tools/vector_index/` — primer indexado real tras ejecutar OCR
- [ ] `scripts/agentes/agent-ocr-auditor.sh` — script ejecutable del agente
- [ ] `scripts/agentes/agent-perplexity-informer.sh` — script ejecutable del agente
- [ ] `infra/grafana/` — dashboards Prometheus/Grafana
- [ ] `infra/docker-compose.yml` — stack completo (MCP + Prometheus + Weaviate)
- [ ] Tests E2E end-to-end
- [ ] Hardening LLM: prompt filters avanzados
- [ ] Reglas de aprobación automática de PRs

---

## Roadmap

| Horizonte | Objetivo |
|---|---|
| **48h** | OCR ingest funcional + MCP auth + meta-deep con LLM |
| **7 días** | Vector DB indexado + Perplexity ingestion + Copilot lee contexto |
| **30 días** | Grafana dashboards + reglas PR + tests E2E + hardening LLM |
