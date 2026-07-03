---
tags: [inbox, bots, telegram, arquitectura, toki, fase-6]
fecha: 2026-07-02
estado: pendiente-migrar
destino: docs/arquitectura/bots-telegram.md
mobile-ok: true
---

# 🤖 Arquitectura bots Telegram — separación de responsabilidades

> Decisión tomada: 02-jul-2026
> 3 bots, 3 funciones distintas, 0 mezcla de responsabilidades

---

## 📋 Los 3 bots del ecosistema

| Bot | Nombre | Función | Estado |
|---|---|---|---|
| **Bot 1** | TOKI-Guardian | Servidor Madre — alertas infra, Docker, Wazuh, Suricata, n8n | ✅ Base lista |
| **Bot 2** | TOKI-DEW | GitHub repo — commits, issues, PRs, health check, inbox | ❌ Por crear |
| **Bot 3** | TOKI-Personal | Diario personal, notas, tareas del día, Thdora personal | ❌ Futuro |

---

## 🤖 TOKI-Guardian (Bot 1) — ya existe

**Función:** Vigilante del servidor. Solo habla cuando algo falla o cuando le preguntas por el estado de Madre.

```
Comandos actuales (pendientes implementar):
/estado         → CPU, RAM, temp, uptime de Madre
/docker         → lista contenedores activos/caídos
/alertas        → últimas alertas Wazuh/Suricata
/reiniciar [svc]→ reinicia un contenedor
/logs [svc]     → últimas 20 líneas de logs
```

**Triggers automáticos (n8n):**
- Contenedor Docker caído → alerta inmediata
- CPU >80% sostenido → aviso
- Intrusión detectada Suricata → alerta roja
- fail2ban ban IP → notificación

---

## 🐈 TOKI-DEW (Bot 2) — nuevo — repo yggdrasil-dew

**Función:** Asistente de repo. Conecta con GitHub API / MCP para gestionar el repositorio desde Telegram.

```
Comandos planificados:
/inbox          → cuántos ficheros hay en inbox/
/pendientes     → resumen MASTER-PENDIENTES.md
/git log        → últimos 5 commits
/git status     → estado del repo
/issues         → issues abiertos
/audit          → ejecuta audit-repo.sh en Thdora
/context        → muestra resumen de CONTEXT.md
/commit [msg]   → hace commit de cambios pendientes
```

**Triggers automáticos (GitHub Actions → webhook → TOKI-DEW):**
- Nuevo issue abierto → notificación Telegram
- PR abierto/mergeado → notificación
- repo-health-check detecta problema → alerta
- CONTEXT.md >7 días sin actualizar → recordatorio
- Inbox >10 ficheros → aviso procesamiento

---

## 🗓️ TOKI-Personal (Bot 3) — futuro

**Función:** Diario personal, notas rápidas, tareas del día, Obsidian sync.

```
Ideas de comandos:
/nota [texto]   → guarda nota rápida en inbox/
/diario         → abre entrada del diario de hoy
/tarea [texto]  → añade tarea a MASTER-PENDIENTES
/resumen        → resumen del día generado por Ollama
```

---

## 🛣️ Arquitectura técnica

```
  Tu iPhone (Telegram)
       │
  ┌────┴─────────────────────┐
  │  TOKI-Guardian   TOKI-DEW  │  ← bots separados, puertos distintos
  │  FastAPI :8000   FastAPI :8001             │
  │       │               │            │
  │   Madre Docker    GitHub API (MCP)  │
  │   Wazuh/n8n       Issues/Commits    │
  └────────────────────────────┘
         │
    Red Tailscale (todo cifrado)
```

Cada bot: un token Telegram distinto, un puerto distinto, un `docker-compose` distinto. Sin mezcla.

---

## 🗓️ Orden de implementación

| Paso | Tarea | Fase |
|---|---|---|
| 1 | TOKI-Guardian: añadir handlers /estado /docker | Fase 6a |
| 2 | n8n: flows alertas Docker + Suricata | Fase 6b |
| 3 | TOKI-DEW: crear base FastAPI :8001 + token nuevo | Fase 6c |
| 4 | TOKI-DEW: handlers /inbox /pendientes /git log | Fase 6c |
| 5 | GitHub Actions webhook → TOKI-DEW | Fase 6d |
| 6 | TOKI-Personal: si se necesita | Fase 8+ |

---
_Creado: 02-jul-2026 20:41 CEST — iPhone 11 — Perplexity MCP_
_Decisión: 3 bots, responsabilidades separadas, sin mezcla_
