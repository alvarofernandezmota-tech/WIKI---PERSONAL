# Arquitectura bots Telegram — 3 bots, 3 funciones
#thdora #bots #telegram #arquitectura #fase6

**Decisión tomada:** 2026-07-02
**Principio:** Separación total de responsabilidades. Sin mezcla.

---

## Los 3 bots del ecosistema

| Bot | Nombre | Función | Estado |
|---|---|---|---|
| **Bot 1** | TOKI-Guardian | Servidor Madre — alertas infra, Docker, Wazuh, Suricata, n8n | ✅ Base lista |
| **Bot 2** | TOKI-DEW | GitHub repo — commits, issues, PRs, health check, inbox | ❌ Por crear |
| **Bot 3** | TOKI-Personal | Diario personal, notas, tareas del día, Thdora personal | ❌ Futuro |

---

## TOKI-Guardian (Bot 1)

**Función:** Vigilante del servidor. Solo habla cuando algo falla o cuando le preguntas el estado de Madre.

### Comandos
```
/estado         → CPU, RAM, temp, uptime de Madre
/docker         → lista contenedores activos/caídos
/alertas        → últimas alertas Wazuh/Suricata
/reiniciar [svc]→ reinicia un contenedor
/logs [svc]     → últimas 20 líneas de logs
```

### Triggers automáticos (n8n)
- Contenedor Docker caído → alerta inmediata
- CPU >80% sostenido → aviso
- Intrusión detectada Suricata → alerta roja
- fail2ban ban IP → notificación

---

## TOKI-DEW (Bot 2) — nuevo

**Función:** Asistente de repo. Conecta con GitHub API para gestionar yggdrasil-dew desde Telegram.

### Comandos planificados
```
/inbox          → cuántos ficheros hay en inbox/
/pendientes     → resumen MASTER-PENDIENTES.md
/git log        → últimos 5 commits
/git status     → estado del repo
/issues         → issues abiertos
/audit          → ejecuta audit-repo.sh en Thdora
/context        → muestra resumen de CONTEXT.md
/commit [msg]   → hace commit de cambios pendientes
```

### Triggers automáticos (GitHub Actions → webhook → TOKI-DEW)
- Nuevo issue abierto → notificación Telegram
- PR abierto/mergeado → notificación
- Inbox >10 ficheros → aviso procesamiento
- CONTEXT.md >7 días sin actualizar → recordatorio

---

## TOKI-Personal (Bot 3) — futuro

```
/nota [texto]   → guarda nota rápida en inbox/
/diario         → abre entrada del diario de hoy
/tarea [texto]  → añade tarea a MASTER-PENDIENTES
/resumen        → resumen del día generado por Ollama
```

---

## Arquitectura técnica

```
  Tu iPhone (Telegram)
       │
  ┌────┴───────────────────────────┐
  │  TOKI-Guardian    TOKI-DEW        │
  │  FastAPI :8000    FastAPI :8001   │
  │       │               │          │
  │  Madre Docker   GitHub API (MCP)  │
  │  Wazuh/n8n      Issues/Commits    │
  └──────────────────────────────┘
         │
    Red Tailscale (todo cifrado)
```

Cada bot: token Telegram distinto, puerto distinto, `docker-compose` distinto.

---

## Orden de implementación

| Paso | Tarea | Fase |
|---|---|---|
| 1 | TOKI-Guardian: añadir handlers `/estado` `/docker` | 6a |
| 2 | n8n: flows alertas Docker + Suricata | 6b |
| 3 | TOKI-DEW: crear base FastAPI :8001 + token nuevo | 6c |
| 4 | TOKI-DEW: handlers `/inbox` `/pendientes` `/git log` | 6c |
| 5 | GitHub Actions webhook → TOKI-DEW | 6d |
| 6 | TOKI-Personal: si se necesita | 8+ |

> Implementación TOKI-Guardian: ver `docs/proyectos/thdora/toki-guardian-handlers.md`
