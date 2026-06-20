# 🖥️ Madre — Servidor de producción

---
tags: [setup, hardware, servidor, docker, produccion]
fecha-actualizacion: 2026-06-20
---

## Qué es

Servidor doméstico 24/7. Corre todos los servicios del ecosistema en producción.
Nombre: **Madre**. Es el único servidor activo.

## Hardware

| Componente | Detalle |
|---|---|
| OS | Linux |
| IP Tailscale | `100.91.112.32` |
| IP local | `10.134.31.228` |
| Hardware interno | **pendiente documentar** — hacer `inxi -F` en Madre y añadir aquí |

> Hardware (CPU/RAM/disco): pendiente. Conectar por SSH y ejecutar `inxi -F` o `neofetch`.

## Cómo conectar

```bash
# Desde varopc — siempre por Tailscale
ssh alvaro@100.91.112.32

# Si vas a hacer un build largo, abre tmux primero
tmux new -s deploy
cd <ruta-repo-thdora>
git pull
docker compose up -d --build
```

> ⚠️ Si SSH se corta durante un build, Docker sigue corriendo en background.
> tmux evita perder la sesión si se cae la conexión.

## Servicios corriendo

| Servicio | Puerto | Estado | Para qué |
|---|---|---|---|
| thdora API (FastAPI) | 8000 | ✅ healthy | Backend del bot TOKI |
| thdora-bot | — | ✅ healthy | Bot Telegram (polling) |
| Prometheus | 9090 | ✅ up | Métricas |
| Grafana | 3000 | ✅ up | Dashboard métricas |
| Ollama | 11434 | ✅ up | LLM local |
| Open WebUI | — | ⏳ pendiente | RAG sobre yggdrasil-dew |
| PostgreSQL | — | ⏳ pendiente | Base de datos thdora |
| Uptime Kuma | — | ⏳ pendiente | Monitoreo servicios |
| Pi-hole | — | ⏳ pendiente | DNS + bloqueo anuncios |
| n8n | — | ⏳ pendiente | Automatización / diario nocturno |
| UFW | — | ⏳ pendiente | Firewall |
| fail2ban | — | ⏳ pendiente | Protección SSH |

## Rutas en Madre

| Ruta | Contenido |
|---|---|
| Repo thdora | **pendiente documentar** — hacer `find ~ -name docker-compose.yml` |

> Pendiente: conectar a Madre y anotar la ruta exacta del repo aquí.

## Comandos útiles

```bash
# Ver estado de todos los contenedores
docker compose ps

# Ver logs del bot
docker compose logs --tail=50 thdora-bot

# Rebuild completo
git pull && docker compose up -d --build

# Ver salud de un contenedor
docker inspect thdora-bot --format='{{json .State.Health}}'
```

## Próximos pasos

- [ ] Documentar hardware real (`inxi -F`)
- [ ] Documentar ruta exacta del repo thdora
- [ ] Instalar tmux en Madre
- [ ] UFW + fail2ban (Fase 2 del roadmap)
- [ ] Open WebUI en Docker

---

_Ver también: [[setup/varopc]] · [[setup/red]] · [[proyectos/thdora]] · [[HOME]]_
