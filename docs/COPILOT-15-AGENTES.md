# 🤖 BRIEF PARA COPILOT — 15 AGENTES + ISLAS CONECTADAS

> Pegar en Copilot Chat con el repositorio abierto.
> Lee también docs/COPILOT-CONTEXT.md antes de responder.
> Fecha: 2026-07-03

---

## CONTEXTO RÁPIDO

Este es el ecosistema yggdrasil-dew. Un repo único que actúa como
cerebro central (Madre) con automatización total entre sesiones.
Tienes acceso completo al repo. Actúa como ingeniero senior.

---

## LOS 15 AGENTES DEL ECOSISTEMA

### CAPA 1 — AGENTES DE ESTRUCTURA

**1. struct-auditor-agent** (`agentes/struct-auditor-agent.md`)
- Función: detecta carpetas duplicadas, archivos mal ubicados
- Script: `scripts/struct-auditor.sh`
- Isla: ninguna (transversal)
- Trigger: cron semanal + post-push estructura

**2. ghost-detector-agent** (`agentes/ghost-detector-agent.md`)
- Función: archivos fantasma, vacíos, referencias rotas
- Script: `scripts/ghost-file-detector.sh`
- Isla: ninguna (transversal)
- Trigger: cron semanal

**3. deuda-tecnica-agent** (`agentes/deuda-tecnica-agent.md`)
- Función: gestión completa de deuda técnica
- Action: `.github/workflows/deuda-tecnica.yml`
- Isla: conectado a todas
- Trigger: cron 12h + workflow_dispatch

### CAPA 2 — AGENTES DE INBOX

**4. clasificador-maestro-agent**
- Función: decide destino de cada archivo inbox
- Script: `scripts/clasificador-maestro.sh`
- Action: `.github/workflows/clasificador-maestro.yml`
- Isla: isla-diary
- Trigger: push inbox/**

**5. gestor-estados-agent**
- Función: mueve tareas NUEVO→EN-PROCESO→PROCESADO
- Script: `scripts/gestor-estados-inbox.sh`
- Action: `.github/workflows/gestor-estados-inbox.yml`
- Isla: isla-diary
- Trigger: push inbox/** + cron 6h

### CAPA 3 — AGENTES DE SESIÓN

**6. diary-agent**
- Función: escribe entrada diary por cada commit
- Action: `.github/workflows/diary-writer.yml`
- Isla: isla-diary
- Trigger: push main
- ⚠️ MEJORA PENDIENTE: añadir análisis Ollama

**7. session-close-agent**
- Función: snapshot + cierre de sesión
- Action: `.github/workflows/session-close.yml`
- Isla: transversal
- Trigger: workflow_dispatch

**8. resumen-diario-agent**
- Función: resumen al final del día
- Action: `.github/workflows/resumen-diario.yml`
- Isla: isla-diary
- Trigger: cron 23:00

### CAPA 4 — AGENTES DE SALUD

**9. health-check-agent**
- Función: pulso de servicios Madre
- Action: `.github/workflows/health-check.yml`
- Isla: isla-health
- Trigger: cron horario

**10. agent-monitor-agent** ← NUEVO
- Función: centinela de centinelas — vigila que todos estén vivos
- Script: `scripts/agent-monitor.sh`
- Action: `.github/workflows/agent-monitor.yml`
- Isla: transversal
- Trigger: cron 6h

**11. ecosystem-guardian-agent**
- Función: vigila comportamiento global
- Action: `.github/workflows/ecosystem-guardian.yml`
- Isla: transversal
- Trigger: cron diario

### CAPA 5 — AGENTES DE INTELIGENCIA

**12. investigador-agent** ← NUEVO
- Función: busca IAs, repos, soluciones externas
- Modelo: ollama/llama3
- Isla: isla-obsidian
- Trigger: cron semanal + workflow_dispatch con tema

**13. auto-investigacion-agent**
- Función: investigación automática en GitHub y fuentes
- Action: `.github/workflows/auto-investigacion.yml`
- Isla: isla-obsidian
- Trigger: cron semanal

### CAPA 6 — AGENTES ORQUESTADORES

**14. orquestador-maestro-agent**
- Función: coordina todos los workflows
- Action: `.github/workflows/orquestador-maestro.yml`
- Isla: transversal
- Trigger: cron + post-eventos

**15. copilot-orquestador-agent** ← NUEVO
- Función: conecta Copilot con todas las islas
- Modelo: GitHub Copilot + ollama/mistral local
- Isla: todas
- Trigger: post-sesión + workflow_dispatch

---

## MAPA DE ISLAS → AGENTES

| Isla | Agentes asignados | Estado |
|---|---|---|
| isla-health | health-check-agent, agent-monitor-agent | ✅ Parcial |
| isla-diary | diary-agent, clasificador-maestro, gestor-estados, resumen-diario | ✅ Operativa |
| isla-mcp | (vacante — MCP caído) | 🔴 Bloqueada |
| isla-obsidian | investigador-agent, auto-investigacion | 🟡 Planificada |
| isla-alvaro | copilot-orquestador-agent | 🟡 Planificada |
| isla-secops | (vacante) | 🟡 Planificada |
| isla-roadmap | orquestador-maestro | 🟡 Parcial |

---

## PROMPTS DE ALTA PRECISIÓN PARA COPILOT

### Para completar diary-writer.yml con Ollama
```
Mejora .github/workflows/diary-writer.yml para que después de
generar la entrada con git log, haga una llamada a Ollama local
(localhost:11434/api/generate) con el modelo mistral para:
1. Analizar el patrón de commits del día
2. Detectar si hay deuda técnica implícita
3. Proponer el siguiente paso recomendado
Incluye manejo de timeout y fallback si Ollama no responde.
```

### Para crear apertura-sesion.sh completo
```
Crea scripts/apertura-sesion.sh completo que:
1. Cargue y muestre PERFIL-ALVARO.md si existe
2. Muestre los últimos 3 issues con label urgente (gh issue list)
3. Muestre estado del inbox (número de archivos)
4. Muestre el último diary (tail -20)
5. Verifique si MCP socket está activo (test -S /tmp/mcp.sock)
6. Active agent-monitor.yml via gh workflow run
7. Muestre resumen de deuda técnica activa
Sigue la cabecera estándar del proyecto.
```

### Para struct-auditor con merge automático
```
Extiende scripts/struct-auditor.sh para que cuando detecte
los duplicados diarios/+diary/ tenga un flag --fix que:
1. Copie todos los archivos de diary/ a diarios/ (sin sobreescribir)
2. Cree un commit de merge automático
3. Elimine la carpeta diary/ del tracking de git
4. Actualice todas las referencias en docs/ que apunten a diary/
El flag --fix solo actúa si se pasa explícitamente.
```

### Para investigación profunda con GitHub API
```
Crea .github/workflows/deep-research.yml que:
1. Use gh api para buscar repos con topics: agent, ollama, mcp, autonomous
2. Filtre por: stars>100, updated en los últimos 3 meses, licencia libre
3. Para cada repo encontrado, descargue el README
4. Genere un resumen en investigacion/YYYY-MM-DD-deep-research.md
5. Si encuentra algo que solucione la deuda MCP, cree issue urgente
Usa jq para procesar la respuesta de la API.
```

---

## INSTRUCCIÓN FINAL PARA COPILOT

```
Tienes el contexto completo en docs/COPILOT-CONTEXT.md.
Tienes los 15 agentes documentados en este archivo.
Tienes la deuda técnica en docs/VISION-COMPLETA-ECOSISTEMA.md.

Prioridades de trabajo:
1. 🔴 MCP socket — busca alternativas y propone fix
2. 🟠 Merge diarios/+diary/ — genera el script con flag --fix
3. 🟠 apertura-sesion.sh — crea el completo
4. 🟡 diary-writer.yml — añade análisis Ollama
5. 🟡 deep-research.yml — investigación automática

Siempre: cabecera estándar, manejo de errores, logs en diarios/.
```
