# MASTER-NEXT-SESSION — Arranque Limpio

> **Generado:** 2026-07-03  
> **Propósito:** Blueprint de arranque para la próxima sesión. Leer esto PRIMERO.

---

## INSTRUCCIÓN PARA LA PRÓXIMA IA (Perplexity u otro)

Eres el arquitecto de este ecosistema. Tienes acceso directo al repo `alvarofernandezmota-tech/yggdrasil-dew` via MCP GitHub.  
ANTES de proponer nada, lee estos ficheros en orden:

1. `CONTEXT.md` — contexto del proyecto
2. `ECOSISTEMA.md` — arquitectura general
3. `agentes/REGLAS-AGENTES.md` — tus límites
4. `agentes/REGISTRO-AGENTES.md` — agentes existentes
5. `agentes/LABORATORIO-AGENTES.md` — diseño v2 (lo más actualizado)
6. `sesiones/SESION-CIERRE-2026-07-03.md` — qué pasó en la sesión anterior
7. `ROADMAP-MASTER.md` — tareas pendientes

Después de leer, presenta al usuario:
- Estado real del ecosistema (qué funciona, qué falta)
- Las 3 tareas más urgentes con justificación
- La primera pregunta para alinear prioridades

**NO empieces a generar código hasta que el usuario confirme el plan.**

---

## Estado gap al 2026-07-03

### 🔴 Crítico — No existe, bloquea todo lo demás

1. **MCP server deployado en Madre**
   - Código existe: `agentes/mcp-server/mcp_server_v2.py`
   - Falta: `Dockerfile`, `docker-compose`, deploy real en Madre
   - Impacto: Sin esto, ninguna IA puede hablar con el ecosistema real

2. **Configuración Cursor** (`.cursor/mcp.json`)
   - Falta: entrada `madre-ecosystem` apuntando a Madre:8765
   - Impacto: Cursor sigue siendo ciego al ecosistema

3. **n8n workflow `ecosystem-snapshot`**
   - Falta: el workflow que alimenta al health-agent cada 15 min
   - Impacto: el agente de salud no tiene datos

### 🟡 Importante — Existe parcialmente

4. **health-agent containerizado**
   - Existe: `agentes/health-agent/main.py`
   - Falta: Dockerfile, integración con MCP server, deploy

5. **Inbox como sistema formal**
   - Existe: directorio `inbox/`
   - Falta: formato estándar YAML, watcher n8n, gatekeeper

6. **OTel + Loki**
   - Existe: Prometheus + Grafana
   - Falta: OTel Collector, Loki, Tempo (trazas de agentes)

### 🟢 Diseñado — Pendiente implementar

7. Gatekeeper-agent
8. docs-agent
9. optimization-agent
10. Evals (fixtures + tests)
11. Protocolo A2A entre agentes

---

## Fases del proyecto (propuesta limpia)

### Fase 0 — Núcleo comunicante (Sprint 0-1, ~1 semana)
**Objetivo:** Cursor/Perplexity pueden ver el ecosistema real en tiempo real.

- [ ] MCP server Gen-3 deployado en Docker (Madre:8765)
- [ ] Tools READ activas: `check_docker`, `get_ecosystem_state`, `read_roadmap`, `list_services`
- [ ] `.cursor/mcp.json` configurado
- [ ] Audit log activo en `logs/mcp-audit/`
- [ ] **Hito:** Cursor responde "hay 12 contenedores corriendo" con datos reales

### Fase 1 — Primer agente autónomo (Sprint 2, ~1 semana)
**Objetivo:** health-agent corre solo, alerta por Telegram.

- [ ] health-agent containerizado y conectado al MCP
- [ ] n8n workflow `ecosystem-snapshot` activo (cron 15min)
- [ ] Primera alerta real por Telegram desde el agente
- [ ] Log de decisiones en `logs/health-agent/`
- [ ] **Hito:** el agente detecta un contenedor caído y lo reporta sin intervención humana

### Fase 2 — Orquestación (Sprint 3, ~1 semana)
**Objetivo:** Gatekeeper + Inbox = ecosistema que reacciona solo.

- [ ] Gatekeeper-agent operativo
- [ ] Inbox como entrada formal (watcher n8n)
- [ ] roadmap-agent leyendo tareas `[AUTO]`
- [ ] OTel Collector activo (traces básicos)
- [ ] **Hito:** un fichero en inbox/ dispara una cadena de acciones autónomas

### Fase 3 — Inteligencia completa (Sprint 4, ~1 semana)
**Objetivo:** El ecosistema se investiga y documenta solo.

- [ ] docs-agent activo (resúmenes de commits)
- [ ] optimization-agent reportando semanalmente
- [ ] Evals: fixtures OK/WARN/CRITICAL funcionando en CI
- [ ] Dashboard Grafana unificado con métricas de agentes
- [ ] **Hito:** semana entera sin intervención humana excepto decisiones [HUMAN]

### Fase 4 — Soberanía total (contínuo)
**Objetivo:** El ecosistema crece solo y puede convertirse en producto.

- [ ] RAG sobre el ecosistema (preguntas complejas via Qdrant)
- [ ] Protocolo A2A entre agentes
- [ ] osint-agent con Spiderfoot integrado
- [ ] security-agent con inotify sobre logs
- [ ] Documentación para open-source / SaaS

---

## La pregunta para empezar la próxima sesión

> **"¿Arrancamos por el MCP server (Fase 0) o hay algo que cambiar en el plan antes de ejecutar?"**

---

## Archivos a crear en próxima sesión (por orden)

1. `agentes/mcp-server/Dockerfile` ← ya creado en esta sesión
2. `agentes/mcp-server/requirements.txt` ← ya creado en esta sesión
3. `agentes/mcp-server/config/scopes.yaml`
4. `agentes/mcp-server/config/whitelist.yaml`
5. `agentes/mcp-server/config/services.yaml`
6. `agentes/mcp-server/tools/docker_tools.py`
7. `agentes/mcp-server/tools/ecosystem_tools.py`
8. `agentes/mcp-server/middleware/audit.py`
9. `agentes/mcp-server/middleware/dry_run.py`
10. `n8n/workflows/ecosystem-snapshot.json`

---

_Blueprint generado por Perplexity · 2026-07-03_
