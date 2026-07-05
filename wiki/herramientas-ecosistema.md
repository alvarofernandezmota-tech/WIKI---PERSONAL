---
tipo: conocimiento
tags: [ecosistema, herramientas, orquestacion, scripts, github-actions, bots]
estado: activo
created: 2026-07-03
actualizado: 2026-07-05
---

# ⚡ HERRAMIENTAS DEL ECOSISTEMA

> Migrado desde raíz — 2026-07-05
> Fuente de verdad: [yggdrasil-dew/HERRAMIENTAS-ECOSISTEMA.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew)

---

## Jerarquía de responsabilidad

```
yggdrasil-dew (CEREBRO)
├── HERRAMIENTAS-ECOSISTEMA.md  ← fuente de verdad global
├── CONVENCIONES.md
├── ECOSYSTEM-ARCHITECTURE.md
├── .github/workflows/          ← Actions del ecosistema entero
└── scripts/                    ← scripts de orquestación global

thdora (repo hija — bot + FastAPI)
madre-config (repo hija — infra Madre)
formacion-tech (repo hija — aprendizaje)
```

**Regla:** Si afecta a una sola repo → va en esa repo. Si afecta al ecosistema → va en dew.

---

## Herramientas Docker en Madre

| Herramienta | Puerto | Rol |
|---|---|---|
| n8n | 5678 | Automatización workflows |
| Grafana | 3000 | Dashboards métricas |
| Prometheus | 9090 | Recolectar métricas |
| Uptime Kuma | 3002 | Monitor servicios |
| Portainer | 9000 | Panel Docker |
| Gitea | 3003 | Git self-hosted |
| Ollama | 11434 | LLM local |
| code-server | 8443 | VSCode web |
| SpiderFoot | 5001 | OSINT |

## Bots activos

| Bot | Contenedor | Rol |
|---|---|---|
| thdora-bot | `thdora-bot` | Bot Telegram THDORA |
| guardian-bot | `guardianbot` | Notificaciones centrales |
| Yggdrasil Watchdog | `yggdrasilwatchdog` | Vigila contenedores |
| Network Radar | `networkradar` | Escanea LAN |

## GAPs pendientes

- [ ] thdora → ygg webhook en commits/PRs
- [ ] Repos hijas sin `CONVENCIONES-LOCAL.md`
- [ ] n8n sin workflows del ecosistema configurados
- [ ] Gitea desincronizado de GitHub
- [ ] AlertManager no configurado

_Migrado desde raíz — 2026-07-05 · Perplexity-MCP_
