---
id: 202406242242
fecha: 2026-06-24
tipo: proyecto
status: activo
repo: thdora
tags: [proyecto, #repo/thdora, telegram, bot, fastapi, python, independiente]
sync: true
---

# Proyecto: thdora — INDEPENDIENTE

> ⚠️ IMPORTANTE: thdora es un proyecto COMPLETAMENTE INDEPENDIENTE.
> NO es parte de yggdrasil-dew ni de ollama-stack.
> Se conecta al ecosistema mediante API (Ollama, GitHub MCP) pero tiene su propio ciclo de vida,
> su propio repo, su propio Docker y sus propias decisiones de arquitectura.

- **Repo**: [thdora](https://github.com/alvarofernandezmota-tech/thdora) — público
- **Descripción**: Bot Telegram TOKI + FastAPI + Ollama local — asistente personal IA
- **Lenguaje**: Python
- **Independencia**: ✅ repo propio · Docker propio · ciclo de vida propio

---

## 🐳 Stack Docker (propio)

| Contenedor | Puerto | Rol |
|---|---|---|
| thdora-bot | — | Bot principal Python + handlers |
| redis | 6379 | Cache + estado sesiones |

> Ollama se consume via red desde ollama-stack — NO lo incluye thdora.

---

## 🔗 Cómo se conecta al ecosistema (sin depender de él)

```
thdora (independiente)
    ├── → Ollama API (http://madre:11434) — consume, no incluye
    ├── → GitHub MCP — para sync yggdrasil-dew
    ├── → n8n webhooks (futuro) — disparar workflows
    └── → Telegram API — interfaz usuario
```

---

## 🤖 Handlers — estado

| Handler | Estado | Descripción |
|---|---|---|
| Comandos base | ✅ | /start, /help, etc. |
| /estado | ❌ pendiente | Estado del sistema en tiempo real |
| /pendientes | ❌ pendiente | MASTER-PENDIENTES desde Telegram |
| /inbox | ❌ pendiente | Ver inbox maestra desde móvil |
| /cierre | ❌ pendiente | Sync automático ygg al cerrar sesión |
| /ollama | ❌ pendiente | Chat directo con Ollama local |
| /docker | ❌ pendiente | Ver estado contenedores Madre |

---

## 📌 Pendiente
- [ ] Implementar handlers IA (prioridad: /estado, /cierre, /ollama)
- [ ] Integrar Ollama local (qwen2.5:3b para respuestas rápidas)
- [ ] Handler /cierre → sync automático CONTEXT.md + diario + git push
- [ ] Documentar ADR de arquitectura en su propio repo

---
_Ver: [[ECOSISTEMA]] · [[proyectos/ollama-stack/README]] · [[inbox/2026-06-24-PENDIENTES-THDORA-COMANDOS-Y-DOCKER]]_
