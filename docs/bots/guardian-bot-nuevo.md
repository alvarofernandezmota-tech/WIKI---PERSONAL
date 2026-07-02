---
tags: [tipo/ficha, estado/activo, bot, telegram, segops]
fecha: 2026-07-02
proyecto: yggdrasil-secops
---

# 🤖 Guardian Bot — Bot Telegram independiente

> **⚠️ NOTA:** Este bot es independiente de `thdora-bot`.
> thdora-bot es el bot del proyecto THDORA (FastAPI + Ollama).
> Guardian Bot es el bot de seguridad del stack yggdrasil-secops.

## 🎯 Función

Bot Telegram central de notificaciones del ecosistema de seguridad.
Recibe alertas de todos los bots del stack (watchdog, network radar, log guardian, tripwire, tailscale monitor) y las envía al canal Telegram configurado.

## 📊 Estado actual

| Parámetro | Valor |
|---|---|
| Contenedor | `guardianbot` |
| Estado | ✅ Activo y estable |
| Repo | `yggdrasil-secops` |
| Función | Notificaciones Telegram de todos los bots |

## 🔧 Issues conocidos (a revisar en Fase 5)

- [ ] Revisar qué tipos de alertas llegan y cuáles no
- [ ] Verificar formato de mensajes Telegram
- [ ] Comprobar que recibe alertas de los 6 bots activos
- [ ] Documentar comandos disponibles si los tiene
- [ ] Comparar comportamiento con thdora-bot para no duplicar funciones

## 🗓️ Próximos pasos

Esta revisión está planificada en **Fase 5 — notificaciones**, no antes.
No tocar hasta tener fases 1-4 completadas.

## 🔗 Referencias

- [[ECOSISTEMA]] — stack completo bots
- [[proyectos/thdora/estado]] — thdora-bot (diferente)
- `yggdrasil-secops/docker-compose.yml` — definición del contenedor
- Issue secops #2 — crash-loops (otros bots, no este)
