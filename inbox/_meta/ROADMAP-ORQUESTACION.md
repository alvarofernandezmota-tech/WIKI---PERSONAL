# ROADMAP Y ORQUESTACIÓN

## Mapa de agentes

| Agente | Función única |
|---|---|
| `agente-vigilante` | Monitor continuo: servicios, red, disk, procesos |
| `agente-self-heal` | Reintentos automáticos, recuperación de fallos |
| `agente-roadmap-master` | Centraliza pendientes, genera issue maestro |
| `agente-investigador` | Busca contexto para otros agentes vía RAG/MCP |
| `agente-sync-reglas` | Alinea reglas entre Madre, islas e inbox |
| `agente-filtro-info` | Filtra entradas inbox, descarta ruido |
| `orquestador-inbox` | Mueve y clasifica entradas por ecosistema |
| `thdora-guardian[bot]` | Audita pushes GitHub, mueve a inbox |

## Principio de orquestación

Nada se deja suelto.
Cada hallazgo genera:
1. Clasificación en ecosistema
2. Documentación en inbox o diary
3. Decisión: implementar / aplazar / descartar
4. Pendiente registrado o cierre con commit

## Estado actual (2026-07-03)

### ✅ Operativo
- thdora-guardian[bot]
- inbox/.estados sistema
- PLANTILLA-INBOX.md
- diary/ funcionando
- audit scripts básicos

### ⚠️ Pendiente
- MCP server socket (docker build ✅, socket ❌)
- agente-vigilante completo
- agente-self-heal
- agente-investigador con RAG
- struct-auditor abriendo issues automáticos
- ghost-file-detector
- isla-sync-validator
- apertura/cierre sesión escribiendo en inbox automáticamente

### 🎯 Próximo hito
MCP server operativo → agentes con autonomía real en GitHub

## Conexiones entre agentes

```
vigilante ──────────────────→ self-heal (si falla servicio)
vigilante ──────────────────→ inbox/infra/ (si alerta)
orquestador-inbox ──────────→ clasificados (si no encaja)
agente-filtro-info ─────────→ orquestador-inbox
agente-investigador ────────→ roadmap-master (contexto)
roadmap-master ─────────────→ GitHub Issues
todos ──────────────────────→ inbox/_meta/ (traza)
```
