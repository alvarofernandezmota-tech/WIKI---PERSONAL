# Thdora — Estado Actual

> Última actualización: 2026-07-03

## Qué es Thdora

Thdora es el agente IA central del ecosistema Yggdrasil.
Su rol: procesar el inbox, documentar, coordinar tareas, hacer guardia del sistema.

## Estado actual: 🟡 EN DISEÑO

| Componente | Estado | Notas |
|---|---|---|
| `thdora/routers/` | ⚠️ Carpeta creada | Sin contenido todavía |
| Agente base | ❌ No iniciado | Pendiente issue #1 |
| Conexión Ollama | ❌ Pendiente | Depende de modelos descargados |
| Inbox processor | ❌ Pendiente | Lógica por diseñar |
| Guardian mode | ❌ Pendiente | Monitoreo del sistema |

## Visión Thdora Guardián

Cuando esté completo, Thdora hará:

```
👁️  WATCH  — monitorea inbox/, logs, alertas de sistema
📄  READ   — lee archivos nuevos en inbox/
🧠  THINK  — clasifica, resume, extrae tareas (Ollama local)
✍️  WRITE  — crea docs en docs/, actualiza ESTADO-SISTEMA.md
📤  PUSH   — git add + commit + push automático
🔔  ALERT  — notifica anomalías por Telegram/log
```

## Próximos pasos para activar Thdora

1. Verificar modelos Ollama OK (issue #25)
2. Crear `thdora/thdora.py` — agente base con LlamaIndex
3. Crear `thdora/inbox_processor.py` — lector de inbox/
4. Crear `thdora/guardian.py` — watchdog del sistema
5. Configurar cron job para ejecución automática
6. Cerrar issue #1

## Bots en camino

| Bot | Estado | Función |
|---|---|---|
| **Thdora** | 🟡 En diseño | Agente IA central, inbox, docs, guardian |
| **Bot Telegram** | 🔴 No iniciado | Notificaciones del ecosistema al móvil |
| **Bot GitHub Actions** | 🟠 Parcial | CI/CD automático (issue #11) |

_Perplexity MCP — 03-jul-2026_
