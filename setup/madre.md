---
tags: [setup, hardware, servidor, docker, produccion]
fecha-actualizacion: 2026-06-20
---

# 🖥️ Madre — Servidor Central 24/7

## Qué es

Ordenador de sobremesa reconvertido en servidor doméstico permanente.
Nombre dispositivo: **Alvaro** · Alias en el sistema: **Madre**.

## Hardware real

| Componente | Detalle |
|---|---|
| CPU | Intel Core i5-8400 @ 2.80GHz (6 núcleos) |
| RAM | 16 GB |
| GPU | NVIDIA GeForce GTX 1060 |
| Pantallas | 2 monitores |
| OS | Linux (Ubuntu / WSL — verificar estado actual) |
| IP Tailscale | `100.91.112.32` |
| IP local | `10.134.31.228` |

> 💡 Upgrade recomendado: **RTX 3060 12GB (~200-250€ segunda mano)** para modelos 14B sin sudar.

## Cómo conectar

```bash
# Desde varopc — siempre por Tailscale
ssh alvaro@100.91.112.32

# Antes de builds largos — tmux primero
tmux new -s deploy
cd <ruta-repo-thdora>
git pull
docker compose up -d --build
```

> ⚠️ Si SSH se corta, Docker sigue corriendo en background. tmux evita perder la sesión.

## Servicios corriendo

| Servicio | Puerto | Estado | Para qué |
|---|---|---|---|
| thdora API (FastAPI) | 8000 | ✅ healthy | Backend bot TOKI |
| thdora-bot | — | ✅ healthy | Bot Telegram (polling) |
| Prometheus | 9090 | ✅ up | Métricas |
| Grafana | 3000 | ✅ up | Dashboard métricas |
| Ollama | 11434 | ✅ up | LLM local |
| PostgreSQL | 5432 | ✅ Docker | Base de datos |
| Open WebUI | — | ⏳ pendiente | RAG sobre yggdrasil-dew |
| Uptime Kuma | — | ⏳ pendiente | Monitoreo servicios |
| Pi-hole | — | ⏳ pendiente | DNS + bloqueo anuncios |
| n8n | — | ⏳ pendiente | Automatización |
| UFW | — | ⏳ pendiente | Firewall |
| fail2ban | — | ⏳ pendiente | Protección SSH |

## Rutas en Madre

| Ruta | Contenido |
|---|---|
| Repo thdora | ⏳ **pendiente documentar** — `find ~ -name docker-compose.yml` |

## Comandos útiles

```bash
# Estado contenedores
docker compose ps

# Logs del bot
docker compose logs --tail=50 thdora-bot

# Rebuild completo
git pull && docker compose up -d --build

# Inspeccionar salud
docker inspect thdora-bot --format='{{json .State.Health}}'

# Hardware
inxi -F
df -h
free -h
```

## Upgrades pendientes

| Upgrade | Coste | Impacto | Prioridad |
|---|---|---|---|
| RTX 3060 12GB | ~200-250€ 2ª mano | Modelos 14B sin sudar | 🔴 Alta |
| RAM 32GB DDR4 | ~40-50€ | Docker + LLMs fluidos | 🟡 Media |
| SSD NVMe (si aún HDD) | ~40€ | Velocidad general | 🟡 Media |

## Próximos pasos

- [ ] Documentar ruta exacta repo thdora: `find ~ -name docker-compose.yml`
- [ ] Documentar OS actual: `uname -a` y `cat /etc/os-release`
- [ ] Instalar tmux
- [ ] UFW + fail2ban (Fase 2 roadmap)
- [ ] Open WebUI en Docker

---

_Ver también: [[setup/varopc]] · [[setup/red]] · [[proyectos/thdora]] · [[HOME]]_
