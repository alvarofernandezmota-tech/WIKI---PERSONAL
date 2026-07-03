# 🤖 COPILOT CONTEXT — yggdrasil-dew

> Pegar este archivo como primer mensaje en Copilot Chat o configurarlo
> como instrucción de proyecto en GitHub Copilot.
> Última actualización: 2026-07-03

---

## QUÉ ES ESTE REPO

yggdrasil-dew es el cerebro central (Madre) de un ecosistema de automatización
personal. Es un único repo que contiene TODO: documentación, scripts,
GitHub Actions, agentes IA, diario de sesiones, e islas de proyectos.
No hay repos separados — todo vive aquí por diseño deliberado.

---

## ARQUITECTURA DE CAPAS

```
CAPAPA 1 — Humano
  apertura-sesion.sh → sesión de trabajo → cierre-sesion.sh

CAPA 2 — Actions en cada push (síncronas)
  audit-on-push.yml       → audita estructura en cada push
  diary-writer.yml        → escribe entrada diary automáticamente
  lint-commits.yml        → valida formato de commits
  tripwire-repo.yml       → detecta cambios estructurales inesperados
  new-file-bootstrap.yml  → añade cabecera a archivos nuevos
  clasificador.yml        → clasifica archivos del inbox
  clasificador-maestro.yml → decisor principal de destino

CAPA 3 — Actions por cron (asíncronas, entre sesiones)
  autonomous-cron.yml     → ciclos autónomos cada X horas
  health-check.yml        → pulso de servicios
  repo-audit.yml          → auditoría profunda semanal
  inbox-cleanup.yml       → limpia inbox si supera 10 archivos
  mapa-islas-sync.yml     → actualiza MAPA-ISLAS.md
  ecosystem-guardian.yml  → vigila comportamiento global
  resumen-diario.yml      → resumen al final del día
  orquestador-maestro.yml → coordina otros workflows
  gestor-estados-inbox.yml → mueve tareas por los 3 estados

CAPA 4 — Agentes IA locales (Ollama en Madre)
  Modelos: gemma3, llama3, mistral (Ollama en localhost:11434)
  MCP server: mcp_server.py (socket /tmp/mcp.sock) → expone tools a agentes
  Thdora: bot GitHub que ejecuta handlers en scripts/thdora/
```

---

## ESTRUCTURA DE ISLAS

```
inbox/           → zona temporal, máx 10 archivos, 24h máx
diarios/         → un .md por día, TODO lo de esa sesión
diary/           → DUPLICADO de diarios/ — DEUDA PENDIENTE de merge
docs/            → documentación permanente
scripts/         → bash/python ejecutables
agentes/         → modelfiles y prompts de agentes
proyectos/       → thdora, local-brain, batcueva, chatbot-control
investigacion/   → research en proceso
osint/           → DUPLICADO de osint-stack/ — DEUDA PENDIENTE
islas/           → placeholder para islas futuras
```

---

## DEUDA TÉCNICA ACTIVA

```
🔴 MCP socket /tmp/mcp.sock no operativo (docker build OK, socket KO)
🟠 Carpetas duplicadas: diarios/+diary/, osint/+osint-stack/
🟠 inbox/ tiene 26 archivos — supera límite de 10
🟡 Falta: struct-auditor.sh + Action que abra issue automático
🟡 Falta: ghost-file-detector.sh + Action
🟡 Falta: between-sessions.yml (cron nocturno con tareas programadas)
🟡 Falta: agent-monitor.yml (centinela que vigila a todos los agentes)
🟡 Diary solo usa git log — falta capa de análisis con Ollama
🟡 script-inicio-sesion.sh no existe todavía
🟡 script-cierre-sesion.sh no existe todavía
```

---

## REGLAS DE COMMIT

```
feat:     nueva funcionalidad
fix:      corrección de bug
chore:    mantenimiento/scripts/automatización
docs:     documentación
refactor: reestructuración sin cambio funcional
[AUTO]    sufijo para commits generados por Actions
```

---

## ETIQUETAS DE ISSUES

```
deuda-tecnica, automatizacion, estructura, agentes,
seguridad, osint, investigacion, urgente, duplicado,
inbox, clasificacion, centinela, islas
```

---

## SERVICIOS EN MADRE

```
Ollama:      :11434
n8n:         :5678
Portainer:   :9000
Grafana:     :3000
Uptime Kuma: :3001
Qdrant:      :6333
MCP agent:   :8000 / /tmp/mcp.sock (CAÍDO)
```

---

## FLUJO DEL INBOX (3 ESTADOS)

```
📥 NUEVO → 🔄 EN-PROCESO → ✅ PROCESADO
```

El clasificador-maestro.sh decide automáticamente:
- Si el archivo es documentación → docs/
- Si es un script → scripts/
- Si es diseño de agente → agentes/
- Si es investigación → investigacion/
- Si es plan de islas → islas/
- Si es regla/ley → docs/leyes/
- Si está expirado → inbox/archive/

---

## OBJETIVO FINAL

Que el repo trabaje SOLO entre sesiones: detecte problemas,
abra issues, proponga fixes, ejecute auditorías, actualice docs,
y cuando el humano vuelva, tenga todo preparado y el contexto cargado.
Nunca parado. Siempre avanzando.

---

## CABECERA ESTÁNDAR PARA SCRIPTS

Todo script debe empezar con:
```bash
#!/usr/bin/env bash
# =============================================================
# FUNCIÓN:   [qué hace exactamente]
# TRIGGER:   [cuándo se ejecuta: manual / push / cron / hook]
# AGENTE:    [qué agente lo llama, si aplica]
# ETIQUETAS: [etiquetas de issue si genera uno]
# RUTAS:     [rutas que lee/escribe]
# =============================================================
```

---

## CABECERA ESTÁNDAR PARA ACTIONS (.yml)

```yaml
# =============================================================
# FUNCIÓN:   [qué hace]
# TRIGGER:   [push / schedule / workflow_dispatch / ...]
# ETIQUETAS: [etiquetas de issue si genera uno]
# DEPS:      [scripts que llama, si aplica]
# =============================================================
```
