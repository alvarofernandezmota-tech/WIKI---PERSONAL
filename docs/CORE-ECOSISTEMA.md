# CORE DEL ECOSISTEMA YGGDRASIL-DEW
<!-- FUNCIÓN: Documento raíz que define cómo debe funcionar el ecosistema -->
<!-- AGENTE: orquestador-supremo, watchdog-monitor, todos -->
<!-- ACTUALIZADO: 2026-07-03 -->

## 1. Identidad

Yggdrasil-dew es el repositorio Madre. Un único cerebro central que contiene:
- Documentación viva del ecosistema
- Scripts de automatización
- GitHub Actions (capas 2 y 3)
- Agentes IA locales (capa 4 — Ollama en Madre)
- Diario de sesiones
- Islas (proyectos, hardware, formación, OSINT, investigación)

Todo vive aquí por diseño. No hay repos satélite.

---

## 2. Estructura sagrada

Estas carpetas son inviolables — no se eliminan, no se renombran sin actualizar este CORE:

```
/agentes             ← configuración de agentes IA
/docs                ← documentación del ecosistema
/docs/leyes          ← reglas y convenciones
/docs/tareas         ← gestión de tareas
/islas               ← islas del ecosistema
/scripts             ← scripts de automatización
/inbox               ← entrada de archivos nuevos
/diarios             ← diario oficial de sesiones
/reports             ← reportes generados por agentes
/reports/orquestador
/reports/watchdog
/reports/struct
/reports/docs
/reports/islas
/reports/tareas
/reports/investigacion
/reports/eco
/.github/workflows   ← Actions de automatización
```

---

## 3. Agentes oficiales

| # | Agente | Responsabilidad única | Script |
|---|---|---|---|
| 1 | `clasificador-maestro` | Clasifica inbox/ automáticamente | `scripts/clasificador-maestro.sh` |
| 2 | `gestor-estados-inbox` | Gestiona estados NUEVO→ARCHIVADO | `scripts/gestor-estados-inbox.sh` |
| 3 | `struct-auditor` | Detecta duplicados y carpetas fantasma | `scripts/struct-auditor.sh` |
| 4 | `ghost-file-detector` | Detecta archivos vacíos y refs rotas | `scripts/ghost-file-detector.sh` |
| 5 | `agent-docs` | Sincroniza documentación | `scripts/agent-docs-sync.sh` |
| 6 | `agent-islas` | Orquesta islas | `scripts/agent-islas-orquestador.sh` |
| 7 | `agent-tareas` | Gestiona tareas | `scripts/agent-tareas-manager.sh` |
| 8 | `agent-investigacion` | Ordena investigación | `scripts/agent-investigacion-sync.sh` |
| 9 | `agent-ecosistema` | Auditoría global del ecosistema | `scripts/agent-ecosistema-audit.sh` |
| 10 | `cross-ref-checker` | Links internos rotos | `scripts/cross-ref-checker.sh` |
| 11 | `isla-sync-validator` | Valida MAPA-ISLAS.md vs realidad | `scripts/isla-sync-validator.sh` |
| 12 | `tool-inventory-auditor` | Audita cabeceras de scripts/Actions | `scripts/tool-inventory-auditor.sh` |
| 13 | `thdora-guardian` | Guardian de pushes y seguridad | `scripts/thdora/` |
| 14 | `orquestador-supremo` | Coordina todos los agentes | `scripts/orquestador-supremo.sh` |
| 15 | `watchdog-monitor` | Vigila al orquestador y todos los agentes | `scripts/watchdog-monitor.sh` |

---

## 4. Orden de ejecución

```
1.  clasificador-maestro       ← procesa inbox primero
2.  gestor-estados-inbox       ← gestiona estados
3.  struct-auditor             ← verifica estructura
4.  ghost-file-detector        ← elimina fantasmas
5.  agent-docs                 ← sincroniza docs
6.  agent-islas                ← actualiza islas
7.  agent-tareas               ← gestiona tareas
8.  agent-investigacion        ← ordena investigación
9.  agent-ecosistema           ← auditoría global
10. cross-ref-checker          ← links rotos
11. isla-sync-validator        ← valida MAPA-ISLAS
12. tool-inventory-auditor     ← cabeceras de scripts
13. orquestador-supremo        ← coordina todo
14. watchdog-monitor           ← vigila el resultado
```

**Prohibido:** ejecutar watchdog antes del orquestador. Prohibido ejecutar orquestador sin que los agentes de auditoría hayan corrido.

---

## 5. Estados del inbox

```
NUEVO       ← archivo recién llegado, sin procesar
EN-PROCESO  ← clasificador trabajando en él
PROCESADO   ← clasificado y movido a destino
ARCHIVADO   ← en inbox/archive/, ya no activo
```

Regla: ningún archivo puede permanecer en estado NUEVO más de 24h.

---

## 6. Plantillas universales

### Agente
```markdown
## Rol
## Entradas
## Salidas
## Límites
```

### Isla
```markdown
## Objetivo
## Estado
## Siguiente-paso
```

### Tarea
```markdown
PENDIENTE:
SIGUIENTE-PASO:
```

### Script (cabecera obligatoria)
```bash
# FUNCIÓN:   qué hace este script
# TRIGGER:   cuándo se ejecuta
# AGENTE:    qué agente lo usa
# ETIQUETAS: labels de issues relacionados
# RUTAS:     carpetas que lee/escribe
```

---

## 7. Reglas del ecosistema

```
✗ Ningún archivo puede permanecer en inbox >24h
✗ Ninguna isla puede estar sin "Siguiente-paso"
✗ Ningún agente puede estar sin reportes >24h
✗ Ningún workflow puede fallar sin issue abierto
✗ Ningún script crítico puede faltar
✗ Ningún archivo huérfano puede existir
✗ Ninguna carpeta duplicada puede coexistir
✗ Ningún link interno puede estar roto
✗ Ningún script puede carecer de cabecera estándar
✗ El MCP socket no puede estar caído >1h sin issue
```

---

## 8. Prioridades

```
1. Integridad estructural
2. Flujo del inbox
3. Estado de islas
4. Documentación
5. Investigación
6. Tareas
7. Auditorías
8. Reportes
9. Issues
10. Monitorización
```

---

## 9. Disparadores automáticos

| Condición | Acción automática | Label |
|---|---|---|
| Falta de reportes >24h | issue | `urgente,agentes` |
| Bloqueos detectados | issue | `urgente,automatizacion` |
| Ausencia del orquestador | issue | `urgente,orquestador` |
| Archivos huérfanos | issue | `estructura,deuda-tecnica` |
| Islas sin siguiente-paso | issue | `estructura,islas` |
| Workflow en failure | issue | `automatizacion,urgente` |
| Carpetas duplicadas | issue | `duplicado,estructura` |
| MCP socket caído | issue | `urgente,agentes,mcp` |
| Links internos rotos | issue | `documentacion,estructura` |

---

## 10. Servicios locales en Madre

| Servicio | Puerto | Crítico |
|---|---|---|
| Ollama | :11434 | ✅ sí |
| MCP agent | :8000 / /tmp/mcp.sock | ✅ sí |
| n8n | :5678 | ✅ sí |
| Qdrant | :6333 | ✅ sí |
| Portainer | :9000 | 🔶 gestión |
| Grafana | :3000 | 🔶 monitorización |
| Uptime Kuma | :3001 | 🔶 monitorización |

---

## 11. MCP tools expuestas al ecosistema

El servidor MCP (`server.js`) expone estas tools a cualquier IA cliente:

```
orquestador_supremo    ← lanza orquestador completo
watchdog_monitor       ← vigila todos los agentes
clasificador_maestro   ← clasifica inbox
struct_auditor         ← auditoría estructural
agent_docs             ← sincroniza docs
agent_islas            ← orquesta islas
agent_tareas           ← gestiona tareas
agent_investigacion    ← ordena investigación
agent_ecosistema       ← auditoría global
core_estado            ← compara CORE vs realidad del repo
```
