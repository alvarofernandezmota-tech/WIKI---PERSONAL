# SCRIPTS-AUDITORIA — Yggdrasil-Dew

Última actualización: 2026-07-04T20:57:00+02:00

---

## ✅ MÓDULOS COMPLETADOS

### Sesión 2026-07-03 — Estructura base + inbox
- [x] `scripts/file-arrival-guardian.sh` — Guardián de llegada de archivos con `--dry-run`
- [x] `scripts/session-logger.sh` — Logger de terminal para sesiones
- [x] `scripts/session-terminal-doc.sh` — Generador de documentos de cierre
- [x] `scripts/orquestador-unico.sh` — Orquestador con fases (all/audit/inbox/health)
- [x] `scripts/inbox-commit.sh` — Commit de inbox en un comando
- [x] `scripts/inbox-clasificador.sh` — Clasificador automático de `inbox/drop/`
- [x] `docs/inbox-flujo.md` — Documentación del flujo inbox
- [x] `inbox/drop/.gitkeep` — Zona de aterrizaje inicializada

### Sesión 2026-07-04 — Parche Perplexity full
- [x] `scripts/maintenance/create_perplexity_patch.sh` — Script maestro idempotente (dry-run / apply)
- [x] `tools/perplexity_adapter.py` — Adaptador HTTP para Perplexity API
- [x] `agentes/agent-perplexity-informer/run.sh` — Agente OCR → Perplexity
- [x] `agentes/agent-perplexity-informer/DISEÑO.md` — Arquitectura y flujo del agente
- [x] `agentes/agent-perplexity-informer/PROFILE.md` — Metadatos y owner
- [x] `agentes/agent-perplexity-informer/test.sh` — Smoke test del agente
- [x] `inbox/context/perplexity/PERPLEXITY_PROMPT_TEMPLATE.txt` — Template de prompt estándar
- [x] `inbox/context/perplexity/.gitkeep` — Carpeta inicializada
- [x] `inbox/context/obsidian/.gitkeep` — Carpeta inicializada
- [x] `scripts/agentes/agente-meta-deep.sh` — Extractor `PERCENT_COMPLETE` + issue automático
- [x] `scripts/observador-obsidian.sh` — Observer del vault de Obsidian (últimas 24h)
- [x] `docker/mcp/Dockerfile` — Dockerfile servidor MCP (con healthcheck)
- [x] `docker/retrieval/Dockerfile` — Dockerfile API de retrieval
- [x] `docker/agent-worker/Dockerfile` — Dockerfile worker de agentes
- [x] `docker/docker-compose.yml` — Composición completa (mcp + retrieval + agent-worker)
- [x] `scripts/maintenance/master_run.sh` — Terminal Madre (8 pasos, dry-run safe)
- [x] `scripts/verify/run-smoke-tests.sh` — Suite de 20 smoke tests
- [x] `.github/workflows/ci-readonly.yml` — CI smoke tests en push/PR
- [x] `.github/workflows/bot-writer-template.yml` — Template bots → PR draft (Regla 1)
- [x] `docs/OPERATIONAL-PLAYBOOK.md` — Playbook operativo v2.0 (8 reglas)
- [x] `docs/OWNERS.md` — Tabla de ownership de módulos
- [x] `scripts/README.md` — Guía de uso de scripts/

---

## 🔴 PENDIENTE — Próxima auditoría

### Bloque A — Limpieza de scripts/ (deuda técnica)
- [ ] `git mv scripts/2026-07-03-23-05-struct-auditor-output.md inbox/_meta/`
- [ ] `git mv scripts/2026-07-03-inbox-audit-consolidado.md inbox/_meta/`
- [ ] `git mv scripts/2026-07-03-cierre-sesion-completo.md diarios/`
- [ ] `git mv scripts/2026-07-03-reality-check.md diarios/`
- [ ] `git mv scripts/gemini-brief.md docs/`
- [ ] Revisar duplicados: `orquestador-supremo.sh` vs `orquestador-total.sh` vs `orquestador-unico.sh`
- [ ] Archivar scripts `01-xx` redundantes en `scripts/archive/`

### Bloque B — Agentes (inventario y completar)
- [ ] Listar todos los agentes en `agentes/` y crear `agentes/README.md`
- [ ] Verificar que cada agente tiene DISEÑO.md + PROFILE.md + test.sh
- [ ] Crear agentes faltantes: `llm-router`, `ocr-processor`, `diario-writer`
- [ ] Añadir `agentes/README.md` con tabla de todos los agentes

### Bloque C — Workflows (auditoría completa)
- [ ] Listar todos los workflows en `.github/workflows/` y verificar que ninguno escribe en main
- [ ] Añadir `secret-scan.yml`
- [ ] Añadir `session-close.yml` (mueve `inbox/sesiones/` → `diarios/` vía PR draft)
- [ ] Añadir `inbox-guardian.yml` (dispara file-arrival-guardian en cada push)

### Bloque D — Docker (completar)
- [ ] Añadir `requirements.txt` para cada imagen Docker
- [ ] Añadir `docker/prometheus/` — Dockerfile + config de métricas
- [ ] Añadir healthchecks completos en `docker-compose.yml`
- [ ] Probar `docker-compose up -d` localmente y documentar resultado

### Bloque E — Tests (ampliar)
- [ ] Ampliar smoke tests con verificación de workflows YAML syntax
- [ ] Añadir `scripts/tests/integration/` con tests de extremo a extremo
- [ ] Configurar coverage report para agentes Python
- [ ] Añadir test para `perplexity_adapter.py` con mock HTTP

### Bloque F — Documentación (completar)
- [ ] Actualizar `ECOSISTEMA.md` con los nuevos módulos Perplexity + Docker
- [ ] Crear `docs/ARCHITECTURE-DIAGRAM.md` con diagrama Mermaid del flujo completo
- [ ] Actualizar `HOME.md` con links a los nuevos módulos
- [ ] Crear `docs/QUICKSTART.md` para nuevos colaboradores
- [ ] Actualizar `CHANGELOG.md` con los cambios de la sesión 2026-07-04

---

## 📊 Métricas de salud del repo

| Métrica | Estado | Notas |
|---|---|---|
| Scripts `.sh` con extensión correcta | ✅ | Verificado por struct-auditor |
| `.md` en `scripts/` (contaminación) | ⚠️ | 5 ficheros pendientes de mover (Bloque A) |
| Agentes con DISEÑO+PROFILE+test | ⚠️ | Solo `agent-perplexity-informer` completo |
| Workflows seguros (no escriben en main) | ✅ | ci-readonly + bot-writer-template |
| Docker compose sintácticamente correcto | ✅ | Falta requirements.txt para build |
| Smoke tests (20 checks) | ✅ | run-smoke-tests.sh |
| Documentación operativa | ✅ | OPERATIONAL-PLAYBOOK.md v2.0 |
| Ownership declarado | ✅ | docs/OWNERS.md |
