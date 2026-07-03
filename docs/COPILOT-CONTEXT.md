# COPILOT CONTEXT — yggdrasil-dew

> **Archivo clave para GitHub Copilot y cualquier IA que trabaje en este repo.**
> Lee este archivo COMPLETO antes de cualquier tarea. Última actualización: 2026-07-03

---

## 🧠 Identidad del ecosistema

- **Nombre:** yggdrasil-dew
- **Propósito:** Ecosistema operativo autosuficiente para automatización IA, scripts, agentes y workflows GitHub.
- **Madre:** Servidor local (Raspberry Pi / Acer) — ruta: `/srv/yggdrasil-dew`
- **MCP server:** Node.js operativo en Madre desde 2026-07-03. Arranque: `cd /srv/yggdrasil-dew/mcp && node server.js`
- **Idioma:** Español en docs, inglés en código y nombres de archivos.

---

## 🏗️ Estructura sagrada (NO modificar sin auditoría)

```
yggdrasil-dew/
├── docs/              ← Fuente de verdad. CORE-ECOSISTEMA.md es la biblia.
├── scripts/           ← Scripts bash del ecosistema (cabecera Galatea obligatoria)
│   ├── agentes/       ← Agentes especializados (función única cada uno)
│   ├── archive/       ← Scripts obsoletos o duplicados (NO borrar, archivar aquí)
│   ├── maintenance/   ← Scripts de mantenimiento del sistema
│   ├── seguridad/     ← Hardening, UFW, seg. del servidor
│   ├── infra/         ← Infraestructura y despliegue
│   ├── setup/         ← Instalación inicial del ecosistema
│   └── tests/         ← Tests automáticos de scripts y agentes
├── mcp/               ← MCP Server Node.js — expone tools a IAs externas
│   └── server.js      ← Punto de entrada MCP (OPERATIVO)
├── .github/
│   └── workflows/     ← 35 GitHub Actions activos
├── inbox/             ← TODO lo que pasa por terminal va aquí
├── diary/             ← Reportes permanentes de sesión
└── islas/             ← Proyectos específicos (isla-proyectos, isla-hardware...)
```

---

## 🔴 Reglas ABSOLUTAS para Copilot

1. **Cada script/agente/workflow tiene UNA sola función** — declarada en cabecera `FUNCIÓN:`
2. **Plantilla Galatea obligatoria** en todos los scripts (ver sección Plantilla abajo)
3. **TODO output de terminal va a `inbox/`** — usando el bloque OUTPUT→INBOX estándar
4. **Nunca borrar** `docs/CORE-ECOSISTEMA.md`, `inbox/`, `diary/` sin auditoría previa
5. **Abre issue automático** si detectas problema crítico usando `scripts/issue-creator.sh`
6. **Busca antes de crear** — revisa `scripts/` y `scripts/agentes/` antes de proponer script nuevo
7. **Duplicados van a `scripts/archive/`** antes de ser eliminados — nunca borrado directo
8. **Un solo orquestador** — punto de entrada único: `orquestador-maestro`
9. **MAPA-ISLAS.md refleja la realidad** en cada push — `isla-sync-validator.sh` lo verifica
10. **Copilot no propone cambios** incompatibles con esta arquitectura

---

## 🛠️ Plantilla Galatea estándar (TODOS los scripts)

```bash
#!/usr/bin/env bash
# ============================================================
# NOMBRE    : nombre-exacto-del-script.sh
# VERSIÓN   : 1.0.0
# FUNCIÓN   : [UNA sola frase — acción concreta y única]
# CATEGORÍA : [auditoria|orquestacion|sesion|inbox|galatea|seguridad|osint]
# TRIGGER   : [manual|on-push|cron|llamado-por:otro-script.sh]
# OUTPUT    : [qué produce: issue/log en inbox/diary/ninguno]
# AUTOR     : thdora-guardian[bot] / Álvaro
# REPO      : alvarofernandezmota-tech/yggdrasil-dew
# ACTUALIZ  : YYYY-MM-DD
# ============================================================
# DEPENDENCIAS: gh cli, git, jq
# ABRE ISSUE  : sí/no — [condición que lo dispara]
# ============================================================
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/..” && pwd)"
INBOX_DIR="${ROOT}/inbox"
```

### Bloque OUTPUT→INBOX (obligatorio al final de CADA script)

```bash
# ============================================================
# OUTPUT → INBOX
# ============================================================
TIMESTAMP=$(date +%Y-%m-%d-%H-%M)
SCRIPT_NAME=$(basename "$0" .sh)
OUTPUT_FILE="${INBOX_DIR}/${TIMESTAMP}-${SCRIPT_NAME}-output.md"
mkdir -p "$INBOX_DIR"
cat > "$OUTPUT_FILE" << EOF
---
fecha: $(date +%Y-%m-%d)
hora: $(date +%H:%M)
script: ${SCRIPT_NAME}
estado: completado
---
# Output: ${SCRIPT_NAME}
## Resultado
${RESULTADO:-Sin output registrado}
## Errores detectados
${ERRORES:-Ninguno}
## Acción requerida
${ACCION:-Ninguna}
EOF
echo "[${SCRIPT_NAME}] → inbox: ${OUTPUT_FILE}"
```

---

## 🤖 Agentes MCP disponibles (MCP server Node.js OPERATIVO)

| Tool MCP | Script bash equivalente | Función |
|---|---|---|
| `orquestador_total` | `scripts/orquestador-maestro.sh` | Coordina todo el ecosistema |
| `galatea_fabrica_agente` | `scripts/agentes/galatea-fabrica-agentes.sh` | Genera agentes nuevos |
| `agente_meta_deep` | `scripts/agentes/agente-meta-deep.sh` | Auditoría profunda con LLM |
| `llm_router` | `scripts/agentes/llm-router.sh` | Enruta a Ollama/OpenAI/Anthropic |
| `struct_auditor` | `scripts/struct-auditor.sh` | Detecta duplicados y estructuras |
| `ghost_file_detector` | `scripts/ghost-file-detector.sh` | Archivos huérfanos y fantasmas |
| `isla_sync_validator` | `scripts/isla-sync-validator.sh` | Valida MAPA-ISLAS.md |
| `watchdog` | `scripts/watchdog.sh` | Monitor SLAs |
| `diary_writer` | `scripts/diary-writer.sh` | Escribe entradas de diario |
| `issue_creator` | `scripts/issue-creator.sh` | Crea issues GitHub automáticos |
| `health_check` | `scripts/health-check.sh` | Pulso del ecosistema |

---

## ⚡ Arranque rápido en Madre

```bash
# MCP server (Node.js — OPERATIVO desde 2026-07-03)
cd /srv/yggdrasil-dew/mcp
export YGGDRASIL_ROOT="/srv/yggdrasil-dew"
node server.js
# Confirma: [MCP] yggdrasil-ecosistema server arrancado

# Auditoría completa (Fase 1 — sólo lee, no modifica)
cd /srv/yggdrasil-dew
bash scripts/struct-auditor.sh          # PASO 1: duplicados
bash scripts/ghost-file-detector.sh     # PASO 2: fantasmas
bash scripts/tool-inventory-auditor.sh  # PASO 3: cabeceras
bash scripts/cross-ref-checker.sh       # PASO 4: refs rotas
bash scripts/audit-and-migrate.sh       # PASO 5: migrar duplicados

# Crear agente nuevo con Galatea
bash scripts/agentes/galatea-fabrica-agentes.sh "mi-agente" "Función específica" "auditor"
```

---

## 📊 Workflows activos: 35 en `.github/workflows/`

| Categoría | Workflows |
|---|---|
| **Orquestación** | orquestador-maestro.yml, orquestador-supremo.yml ⚠️, orquestador-total.yml ⚠️ |
| **Auditoría** | audit-on-push.yml, meta-deep-audit.yml, ghost-file-detector.yml, cross-ref-checker.yml, struct-auditor.yml |
| **Inbox** | inbox-cleanup.yml, inbox-dispatcher.yml, inbox-health.yml, inbox-processor.yml, gestor-estados-inbox.yml, clasificador.yml, clasificador-maestro.yml |
| **Islas** | isla-context-sync.yml, isla-sync-validator.yml, islas-health.yml, mapa-islas-sync.yml |
| **Salud** | health-check.yml, agent-monitor.yml, ecosystem-guardian.yml, watchdog.yml |
| **Sesiones** | diary-writer.yml, between-sessions.yml, context-reminder.yml |
| **Galatea** | galatea.yml, new-file-bootstrap.yml |
| **Deuda/CI** | deuda-tecnica.yml, code-drift.yml, lint-commits.yml, issue-creator.yml, auto-investigacion.yml, autonomous-cron.yml |

⚠️ = duplicado pendiente de consolidar en `orquestador-maestro`

---

## 🚫 Deuda técnica conocida (2026-07-03)

### CRÍTICO
- [ ] Triplicación de orquestadores: maestro + supremo + total → consolidar en maestro
- [ ] Clasificadores duplicados: clasificador.yml + clasificador-maestro.yml
- [ ] `guardian-maestro.sh` no existe aún — es la pieza que orquesta la limpieza completa

### IMPORTANTE
- [ ] Scripts sin cabecera Galatea: scripts numerados (01- al 10-), `bc` sin extensión
- [ ] `inbox-cleanup-jun2026.sh` — específico de fecha, candidato a archivar
- [ ] `watchdog_adb.sh` — naming inconsistente (guión bajo vs guión medio)
- [ ] `issue-creator.sh` vs `create-issues.sh` — posible duplicado de función

### MENOR
- [ ] `diary/` vs `diarios/` — consolidar en `diary/`
- [ ] `osint/` vs `osint-stack/` — consolidar
- [ ] scripts/agentes/, scripts/thdora/, scripts/thdora-dev/ — inventariar contenido

---

## 🔄 Flujo completo: terminal → inbox → diary → issue

```
Terminal (ejecutas script)
    ↓
script.sh corre su lógica
    ↓
Deposita output en inbox/ (bloque OUTPUT→INBOX obligatorio)
    ↓
inbox-processor.yml lo recoge (cron 6h o on-push)
    ↓
clasificador-maestro.yml lo clasifica
    ↓
Si hay deuda/error → issue-creator.sh abre issue en GitHub
    ↓
diary-writer.yml lo registra en diary/
```

**Invariante del ecosistema:** nada se pierde, todo queda trazado.

---

## 🧩 Pieza faltante crítica: `guardian-maestro.sh`

Agente que orquesta la limpieza completa en secuencia:

```
1. struct-auditor.sh          → detecta duplicados
2. ghost-file-detector.sh     → detecta fantasmas
3. tool-inventory-auditor.sh  → verifica cabeceras
4. cross-ref-checker.sh       → verifica refs rotas
5. galatea-scan.sh            → detecta scripts sin plantilla
6. issue-creator.sh           → abre issues de todo lo encontrado
7. ecosystem-snapshot.sh      → documenta estado final
8. isla-sync-validator.sh     → sincroniza MAPA-ISLAS.md
```

Pendiente de crear con plantilla Galatea completa.

---

## 📋 Variables de entorno necesarias en Madre

```bash
export YGGDRASIL_ROOT=/srv/yggdrasil-dew
export OPENAI_API_KEY=sk-...        # opcional
export ANTHROPIC_API_KEY=sk-ant-... # opcional
# Ollama: preferido (local). OpenAI/Anthropic: fallback remoto
```

---

*Última actualización: 2026-07-03 23:00 CEST — Sesión blindaje ecosistema Álvaro + Perplexity [AUTO]*
