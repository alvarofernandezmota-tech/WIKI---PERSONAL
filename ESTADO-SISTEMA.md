# ESTADO DEL SISTEMA — Yggdrasil Dew

> Última actualización: 24 junio 2026, 02:45 CEST
> Leer esto primero si entras al repo en frío.

---

## Filosofía

Este repo es el **plan de rescate completo**. Si todo se pierde — Madre muere, cambias de casa, formateas — con este repo y conexión a internet reconstruyes el ecosistema desde cero en menos de 1 hora.

---

## Equipos

| Equipo | Rol | OS | IP Tailscale |
|---|---|---|---|
| Torre Madre | Servidor homelab | Arch Linux / Hyprland | `100.91.112.32` |
| Portátil Acer | Cliente principal | Arch Linux / Hyprland | `100.86.119.102` |

---

## Stack Madre — Estado actual

| Servicio | Puerto | Estado | Fase |
|---|---|---|---|
| THDORA (agente IA) | :8000 | ✅ running | 0 |
| Ollama | :11434 | ✅ running | 1 |
| Qdrant | :6333 | ✅ running | 1 |
| Open WebUI | :3001 | ✅ running | 1 |
| Portainer | :9000 | ✅ healthy | 2 |
| Grafana | :3000 | ✅ healthy | 2 |
| Prometheus | :9090 | ✅ healthy | 2 |
| Uptime Kuma | :3002 | ✅ healthy | 2 |
| n8n | :5678 | ⏳ pendiente | 3 |
| Paperless-ngx | :8010 | ⏳ pendiente | 3 |
| Vaultwarden | :8888 | ⏳ pendiente | 3 |
| LiteLLM | :4000 | ⏳ pendiente | 4 |
| Nginx Proxy Manager | :81 | ⏳ pendiente | 4 |
| Watchtower | — | ⏳ pendiente | 4 |

---

## Modelos Ollama en Madre

| Modelo | Uso |
|---|---|
| `qwen2.5:7b` | General, razonamiento |
| `qwen2.5:3b` | Rápido, agentes |
| `bge-m3` | Embeddings RAG |
| `llama3.2:3b` | Fallback |

---

## Estructura del repo

```
yggdrasil-dew/
├── ESTADO-SISTEMA.md          ← este fichero (leer primero)
├── inbox/                     ← ideas, sesiones, pendientes sin procesar
│   ├── MASTER-PENDIENTES.md   ← lista maestra de pendientes
│   └── README.md              ← cómo funciona el inbox
├── setup/
│   └── servidor/              ← todo para levantar Madre desde cero
│       ├── docker-compose.yml           (Fase 1)
│       ├── batcueva-fase2.yml           (Fase 2)
│       ├── batcueva-fase3.yml           (Fase 3)
│       ├── batcueva-fase2-doc.md
│       ├── batcueva-fase3-doc.md
│       ├── plan-maestro.md              (desfasado — ver este fichero)
│       ├── .env.plantilla
│       └── scripts/
│           ├── batcueva-state.sh        ← PUNTO DE ENTRADA PRINCIPAL
│           ├── arranque-madre.sh
│           ├── pre-descarga-todo.sh
│           ├── configurar-fase2.sh
│           ├── configurar-fase3.sh
│           └── cierre-sesion.sh        ← commit diario automático
├── docs/                      ← (pendiente) manuales de uso por servicio
└── diarios/                   ← diarios de sesión procesados
```

---

## Reconstruir Madre desde cero

```bash
# 1. Clonar repo
git clone https://github.com/alvarofernandezmota-tech/yggdrasil-dew ~/Projects/yggdrasil-dew
cd ~/Projects/yggdrasil-dew

# 2. Copiar variables de entorno
cp setup/servidor/.env.plantilla setup/servidor/.env
# Editar .env con tus valores reales

# 3. Ejecutar state script (hace todo)
bash setup/servidor/scripts/batcueva-state.sh
```

---

## Pendientes críticos

- [ ] Fase 3 levantar (n8n + Paperless + Vaultwarden)
- [ ] Fase 4 crear compose + scripts (LiteLLM + Nginx + Watchtower)
- [ ] `docs/` — manuales de uso por servicio
- [ ] Repo dotfiles separado (Hyprland, aliases, bashrc)
- [ ] Migración inbox→repo automatizada (THDORA/n8n)

---

_Ver: [MASTER-PENDIENTES.md](inbox/MASTER-PENDIENTES.md) · [inbox/README.md](inbox/README.md)_
