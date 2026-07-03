# Arquitectura Bot Telegram Centralizado — Yggdrasil

> Documentado: 2026-07-03 05:02 CEST
> Principio: UN bot central, todo filtrado, cada cosa separada

---

## La Vision

```
[Tu Telegram]
     |
     v
[BOT CENTRAL — Thdora Gateway]
     |
     +──> /infra   → Bot Infraestructura (Madre, Docker, servicios)
     +──> /osint   → Bot OSINT (recon, theHarvester, nmap)
     +──> /lab     → Bot Laboratorio (Ollama, benchmarks, modelos)
     +──> /repo    → Bot GitHub (issues, commits, PRs)
     +──> /inbox   → Bot Inbox (captura notas rapidas → Obsidian)
     +──> /alerta  → Bot Alertas (Wazuh, Suricata, notificaciones)
```

Tu hablas con UN solo bot. El gateway enruta internamente.
Nunca tienes 6 bots distintos en el movil. Solo Thdora.

---

## Filtros del Sistema

### Filtro 1 — Autenticacion (solo tu)
```python
AUTORIZADOS = [TU_TELEGRAM_ID]  # nadie mas puede hablar con el bot

def autorizado(update):
    return update.effective_user.id in AUTORIZADOS
```

### Filtro 2 — Rate limiting (anti-loop)
```python
# Max 10 comandos por minuto para no saturar Madre
MAX_CMD_POR_MINUTO = 10
```

### Filtro 3 — Separacion de contextos
Cada sub-bot tiene su propio:
- Token de Telegram (opcional) o prefijo de comando
- Log separado en `logs/telegram-<subbot>.log`
- Permisos acotados (el bot OSINT no puede tocar Docker)

### Filtro 4 — Circuit breaker
Si un subbot falla 3 veces seguidas, el gateway lo desactiva
y te notifica. El resto sigue funcionando.

---

## Stack Tecnico (100% local + privado)

| Componente | Herramienta | Donde corre |
|---|---|---|
| Bot central gateway | python-telegram-bot | Docker en Madre |
| Enrutamiento | Router interno Python | Mismo contenedor |
| Sub-bots | Scripts bash/Python existentes | Madre via subprocess |
| Logs | JSON en `logs/telegram-*.log` | Disco Madre |
| Alertas Wazuh | Webhook → bot | Red interna Tailscale |
| Acceso exterior | Tailscale (sin puerto abierto) | Sin exposicion |

---

## Comandos del Bot Central (disenio)

```
/status          — estado de Madre (disco, RAM, GPU, Ollama)
/inbox <texto>   — captura nota rapida en inbox/
/modelos         — lista modelos Ollama disponibles
/lab             — lanza laboratorio_agentes.py
/osint <target>  — ejecuta osint-run.sh <target>
/issues          — lista issues GitHub abiertos
/macro           — lanza macro-noche.sh manualmente
/log             — ultimas 20 lineas del log del dia
/alerta          — resumen alertas Wazuh/Suricata
```

---

## Roadmap de Implementacion

```
Fase 1 (primera semana)
  - Bot central con /status y /inbox funcionales
  - Filtro autorizacion por Telegram ID
  - Docker container en Madre

Fase 2 (segunda semana)
  - /modelos y /lab conectados a Ollama
  - /osint conectado a osint-run.sh
  - /issues conectado a gh CLI

Fase 3 (tercera semana)
  - Alertas Wazuh/Suricata → notificacion automatica
  - /macro lanza macro-noche.sh desde Telegram
  - Circuit breakers en todos los sub-bots

Fase 4 (cuando llegue Thdora)
  - Lenguaje natural: "oye, que modelos tengo?"
  - Thdora interpreta y enruta sin comandos /
  - El humano solo supervisa, nunca opera
```

---

## Fichero base (pendiente crear)

```
thdora/
  bot/
    gateway.py          <- bot central
    routers/
      infra.py
      osint.py
      lab.py
      repo.py
      inbox.py
      alertas.py
    filters.py          <- autorizacion + rate limit + circuit breaker
    config.py           <- tokens, IDs, rutas
```

## Issue a crear
- [ ] #26 Implementar bot Telegram gateway (Fase 1)

_Perplexity MCP — 03-jul-2026 05:02 CEST_
