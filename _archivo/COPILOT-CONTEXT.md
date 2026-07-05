# COPILOT CONTEXT — yggdrasil-dew
<!-- FUNCIÓN: Contexto persistente para GitHub Copilot vía MCP GitHub -->
<!-- AGENTE: GitHub Copilot (acceso por MCP, NO VS Code) -->
<!-- ACTUALIZADO: 2026-07-04 22:07 CEST -->

---

## ⚠️ LEER ESTO PRIMERO

**Antes de hacer cualquier cosa en este repo, lee el archivo maestro:**

```
AUDITORIA-MAESTRA-COPILOT.md
```

Ese archivo contiene:
- La filosofía del ecosistema (qué está prohibido)
- Los permisos exactos que tienes
- El estado actual de la auditoría
- Los 5 bloques de trabajo con instrucciones paso a paso
- La tabla de progreso actualizada

**Regla de oro: si no está en AUDITORIA-MAESTRA-COPILOT.md, no lo hagas.**

---

## Cómo accedes al repo (contexto técnico)

Estás usando el **MCP de GitHub** — acceso directo al repo vía API, sin VS Code.
Esto significa que puedes:
- Leer archivos con `get_file_contents`
- Crear/editar archivos con `create_or_update_file`
- Mover archivos con `push_files` + `delete_file` (equivalente a git mv)
- Hacer commits directamente
- Leer el árbol de carpetas

**Orden de lectura obligatorio al iniciar cualquier sesión:**
1. `AUDITORIA-MAESTRA-COPILOT.md` — fuente de verdad de la auditoría
2. `COPILOT-CONTEXT.md` — este archivo, arquitectura general
3. `CONVENCIONES.md` — convenciones de commits y estructura

---

## Filosofía del ecosistema (no negociable)

```
Este ecosistema es LOCAL y MINIMALISTA.
- No conecta con APIs externas
- No usa Perplexity como servicio externo
- No añade complejidad nueva sin confirmación del owner (Álvaro)
- Un solo archivo de auditoría: AUDITORIA-MAESTRA-COPILOT.md
- Los reportes van SOLO a inbox/_meta/ con fecha

Antes de proponer cualquier cosa:
  1. ¿Existe ya algo que haga esto en el repo?
  2. ¿Lo ha pedido Álvaro explícitamente?
  Si (1) es sí o (2) es no → NO LO HAGAS, pregunta primero.
```

---

## Resumen del sistema

`yggdrasil-dew` es el repositorio Madre — cerebro central del ecosistema.
Todo vive aquí por diseño: scripts, workflows, agentes, documentación, diarios, islas.
El objetivo es automatizar entre sesiones: detectar problemas, abrir issues, ejecutar auditorías, actualizar docs y preparar contexto para el humano.

---

## Arquitectura por capas

```
CAPA 1 — Humano
  apertura-sesion.sh → trabajo en terminal → cierre-sesion.sh
  inbox-commit.sh    → meter archivos al ecosistema

CAPA 2 — Actions en cada push (síncronas)
  audit-on-push.yml
  diary-writer.yml
  lint-commits.yml
  tripwire-repo.yml
  new-file-bootstrap.yml
  clasificador.yml
  file-arrival-guardian.yml   ← canónico estructura

CAPA 3 — Actions por cron (asíncronas)
  autonomous-cron.yml
  health-check.yml
  repo-audit.yml
  inbox-cleanup.yml
  mapa-islas-sync.yml
  ecosystem-guardian.yml
  resumen-diario.yml
  orquestador-maestro.yml     ← canónico orquestación
  agent-monitor.yml

CAPA 4 — Agentes IA locales (Ollama en Madre)
  Modelos: gemma3, llama3, mistral, codestral, deepseek-coder
  MCP server: mcp_server.py (socket /tmp/mcp.sock — actualmente caído)
  Thdora: handlers en scripts/thdora/
```

---

## Scripts canónicos activos

```
apertura-sesion.sh         ← inicio de sesión
cierre-sesion.sh           ← cierre de sesión
orquestador-unico.sh       ← punto de entrada único del ecosistema
file-arrival-guardian.sh   ← guardián de estructura
inbox-commit.sh            ← commit rápido al ecosistema
inbox-clasificador.sh      ← clasificación de inbox/drop/
session-logger.sh          ← logger de terminal
session-terminal-doc.sh    ← documentación de cierre
copilot-mission-briefing.sh ← briefing para sesiones IA
agent-monitor.sh           ← monitorización de agentes
```

**Scripts bloqueados (NO ejecutar sin confirmación del owner):**
```
03-fase1-seguridad.sh
09-fase8-seguridad-acer.sh
deploy.sh
deploy-madre.sh
```

---

## Estructura de carpetas clave

| Carpeta | Propósito | Estado |
|---------|-----------|--------|
| `inbox/drop/` | Zona de aterrizaje — archivos nuevos | ✅ activo |
| `inbox/sesiones/` | Logs y cierres de sesión | ✅ activo |
| `inbox/_meta/` | Reportes de auditoría con fecha | ✅ activo |
| `diarios/` | Diario oficial de sesiones archivado | ✅ canónico |
| `diary/` | ⚠️ DUPLICADO de diarios/ — consolidar | ❌ deuda técnica |
| `sesiones/` | ⚠️ DUPLICADO de inbox/sesiones/ — consolidar | ❌ deuda técnica |
| `scripts/` | Scripts operacionales | ✅ en auditoría |
| `scripts/archive/` | Scripts archivados (crear en Bloque 1) | 🔴 pendiente |
| `agentes/` | Agentes IA del ecosistema | 🔵 pendiente auditar |
| `docs/` | Documentación técnica | 🔴 faltan 6 archivos |
| `.github/workflows/` | 47 workflows (22 stubs, 22 parciales, 11 OK) | 🔴 en auditoría |
| `islas/` | Proyectos satélite | 🔵 pendiente |
| `osint/` | Investigación OSINT | ✅ |
| `osint-stack/` | ⚠️ DUPLICADO de osint/ | ❌ deuda técnica |
| `docker/` | Docker/compose — NO TOCAR sin confirmación | ⛔ protegido |
| `hardware/` | Config hardware — NO TOCAR sin confirmación | ⛔ protegido |
| `infra/` | Infraestructura — NO TOCAR sin confirmación | ⛔ protegido |

---

## Deuda técnica activa

```
🔴 CRÍTICO
  - MCP socket /tmp/mcp.sock no operativo → agentes no pueden usar GitHub API autónomamente
  - Carpetas duplicadas: diarios/ + diary/ → consolidar en diarios/
  - Carpetas duplicadas: osint/ + osint-stack/ → consolidar en osint/
  - sesiones/ en raíz duplica inbox/sesiones/ → consolidar
  - 22 workflows stub vacíos → implementar o deprecar

🟡 IMPORTANTE
  - inbox/ con archivos sin clasificar → ejecutar inbox-clasificador.sh
  - 5 scripts sin auditar (between-sessions, code-drift, copilot-2fases, cross-ref, deploy*)
  - 6 archivos docs faltantes (ver AUDITORIA-MAESTRA-COPILOT.md Sección 4)

🟢 PENDIENTE (post-auditoría)
  - Agentes: revisar README.md por agente
  - Islas: auditar yggdrasil-nosek + resto
  - MCP local: reconectar socket
```

---

## Servicios locales en Madre

| Servicio | Puerto | Estado |
|----------|---------|--------|
| Ollama | :11434 | ✅ |
| n8n | :5678 | ✅ |
| Portainer | :9000 | ✅ |
| Grafana | :3000 | ✅ |
| Uptime Kuma | :3001 | ✅ |
| Qdrant | :6333 | ✅ |
| MCP agent | :8000 | ❌ socket caído |

---

## Reglas de commit

```
feat:          nueva funcionalidad
fix:           corrección de bug
chore:         mantenimiento
chore(scripts): limpieza o archivado de scripts
docs:          documentación
docs(agentes): documentación de agentes
audit:         trabajo de auditoría
audit(workflows): auditoría de workflows
refactor:      refactorización sin cambio funcional
[AUTO]         sufijo para commits generados por Actions
```

---

## Etiquetas de issues

`deuda-tecnica` `automatizacion` `estructura` `agentes` `seguridad` `osint` `investigacion` `urgente` `duplicado`

---

## Estado de la auditoría en curso

Ver tabla completa y progreso en: **`AUDITORIA-MAESTRA-COPILOT.md` → Sección PROGRESO DE LA AUDITORÍA**

Resumen rápido:
- ✅ Archivo maestro creado y actualizado
- ✅ Scripts nuevos canónicos añadidos
- 🔴 Bloque 1 (scripts) — SIGUIENTE
- 🔴 Bloque 2 (workflows) — pendiente
- 🔴 Bloque 3 (docs) — pendiente
- 🔴 Bloque 4 (agentes) — pendiente
- 🔴 Bloque 5 (cierre + módulos siguientes) — pendiente

---

_Actualizado 2026-07-04 22:07 CEST_  
_Fuente de verdad de la auditoría: AUDITORIA-MAESTRA-COPILOT.md_
