---
tipo: master-schedule
version: 1.0
fecha: 2026-07-03
tags: [orchestration, throttling, schedule]
---

# Master Schedule — Orquestación Escalonada sin Sobrecargar Madre

> Todos los crons están diseñados para NO solaparse.
> Madre tiene GTX 1060 + Ollama. Máximo 1 tarea LLM a la vez.
> Las Actions de GitHub no consumen recursos de Madre.

---

## Filosofía del throttling

```
REGLA 1: Solo 1 tarea LLM local a la vez (Ollama en Madre)
REGLA 2: Actions de GitHub = gratis (corren en runners de GH)
REGLA 3: Scripts de análisis (bash) = ligeros, pueden solaparse
REGLA 4: Gaps de 10 min entre tareas pesadas en Madre
REGLA 5: Noche = mantenimiento. Día = análisis + agentes.
```

---

## Tabla de crons escalonados

| Hora UTC | Hora CEST | Tarea | Donde corre | Peso CPU/GPU |
|----------|-----------|-------|-------------|--------------|
| 05:00 | 07:00 | `morning-check.sh` → estado mañana | Madre (bash) | Bajo |
| 05:15 | 07:15 | `health-check.yml` → ping servicios | GitHub Actions | Cero en Madre |
| 06:00 | 08:00 | `issue-creator.yml` → análisis repo | GitHub Actions | Cero en Madre |
| 07:00 | 09:00 | `autonomous-cron.yml` → limpieza inbox | GitHub Actions | Cero en Madre |
| 09:00 | 11:00 | `auto-investigacion.yml` → research | GitHub Actions | Cero en Madre |
| 11:00 | 13:00 | health-agent evaluate (n8n → Ollama) | Madre (LLM) | **Alto GPU** |
| 13:00 | 15:00 | `repo-audit.yml` → auditoría repo | GitHub Actions | Cero en Madre |
| 15:00 | 17:00 | health-agent evaluate 2ª pasada | Madre (LLM) | **Alto GPU** |
| 17:00 | 19:00 | `task-analyzer.sh` → informe semanal | GitHub Actions | Cero en Madre |
| 17:00 | 19:00 | `issue-creator.yml` → 2ª pasada | GitHub Actions | Cero en Madre |
| 20:00 | 22:00 | `diary-writer.yml` → cierre sesión | GitHub Actions | Cero en Madre |
| 21:00 | 23:00 | `macro-noche.sh` → mantenimiento Docker | Madre (bash) | Medio |
| 22:00 | 00:00 | `night-cron.sh` → backup + limpieza | Madre (bash) | Medio |
| 23:00 | 01:00 | `resumen-diario.yml` → resumen día | GitHub Actions | Cero en Madre |

---

## Regla anti-solapamiento para Ollama

Cualquier script que llame a Ollama debe usar este lock:

```bash
# Antes de llamar a Ollama:
flock -n /tmp/ollama.lock -c "curl -s http://localhost:11434/api/generate ..."
if [[ $? -ne 0 ]]; then
  log "Ollama ocupado, reintentando en 5 min..."
  sleep 300
  # reintento
fi
```

---

## Qué despiertan las Actions y los scripts

```
GitHub Actions (gratis, runners GH)
    ↓ detectan anomalía
    ↓ crean issue o llaman webhook
    ↓ n8n recibe webhook
    ↓ n8n llama a health-agent (FastAPI en Madre)
    ↓ health-agent llama Ollama (GPU local)
    ↓ Ollama responde con análisis
    ↓ health-agent propone acciones
    ↓ n8n ejecuta acciones safe
    ↓ guardianbot notifica si necesario
    ↓ diary-writer.yml registra
```

Las Actions **despiertan** a los agentes y bots. Los bots y agentes **viven en Madre**.
Las Actions son el sistema nervioso. Madre es el cerebro.

---

## Qué hace cada bot en este ciclo

| Bot | Se despierta cuando | Hace |
|-----|--------------------|----- |
| `yggdrasilwatchdog` | Cron cada 5 min | Ping Docker, reporta a n8n |
| `networkradar` | Cron cada 15 min | Escanea red, detecta intrusos |
| `tailscalemonitor` | Cron cada 10 min | Estado VPN, alertas si cae |
| `logguardianbot` | Push de logs | Analiza patrones, escala si CRITICAL |
| `localtripwire` | Cron nocturno | Hash de ficheros críticos, alerta si cambia |
| `guardianbot` | Recibe mensaje de cualquier agente | Notifica a Telegram |

---

*Actualizado: 2026-07-03 [AUTO]*
