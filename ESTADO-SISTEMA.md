# ESTADO DEL SISTEMA — Yggdrasil Dew

> Última actualización: 24 junio 2026, 02:56 CEST
> **Leer esto primero si entras al repo en frío.**
> Si algo no concuerda con la realidad → actualizar este fichero.

---

## Filosofía

Este repo es el **plan de rescate y cerebro completo**. Si todo se pierde — Madre muere, cambias de casa, formateas — con este repo y conexión a internet reconstruyes el ecosistema completo en menos de 1 hora.

---

## Equipos

| Equipo | Rol | OS | IP Tailscale |
|---|---|---|---|
| Torre Madre | Servidor homelab | Arch Linux / Hyprland | `100.91.112.32` |
| Portátil Acer (varopc) | Cliente principal | Arch Linux / Hyprland | `100.86.119.102` |

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

## Estructura COMPLETA del repo

```
yggdrasil-dew/
├── AGENT.md               ← instrucciones para agentes IA
├── CHANGELOG.md           ← historial de cambios
├── CONTEXT.md             ← contexto completo del ecosistema
├── CONVENCIONES.md        ← reglas del sistema (leer obligatorio)
├── ECOSISTEMA.md          ← mapa del ecosistema completo
├── ESTADO-SISTEMA.md      ← este fichero (foto viva)
├── HOME.md                ← punto de entrada Obsidian
├── MASTER-PENDIENTES.md   ← TODO lo pendiente priorizado
├── ROADMAP.md             ← visión a largo plazo, 7 fases
├── README.md              ← introducción al repo
├── filosofia.md           ← principios y valores del sistema
│
├── agentes/               ← fichas de modelos LLM y prompts
├── cli-tools/             ← herramientas CLI documentadas
├── diarios/               ← diarios de sesión procesados
├── docs/                  ← manuales de uso por servicio
│   ├── obsidian-setup.md
│   └── estructura-madre.md
├── formacion/             ← apuntes y roadmaps de formación
├── inbox/                 ← zona de aterrizaje (leer inbox/README.md)
├── ollama/                ← Modelfiles, configs y guías de modelos
├── osint/                 ← herramientas y metodología OSINT
├── proyectos/             ← fichas privadas de proyectos
├── setup/servidor/        ← infraestructura ejecutable Madre
│   ├── scripts/batcueva-state.sh   ← PUNTO DE ENTRADA PRINCIPAL
│   ├── scripts/cierre-sesion.sh    ← commit diario automático
│   ├── docker-compose.yml          (Fase 1)
│   ├── batcueva-fase2.yml          (Fase 2)
│   └── batcueva-fase3.yml          (Fase 3)
├── templates/             ← plantillas Obsidian y documentos
├── tools/                 ← herramientas y scripts generales
└── yo/                    ← información personal, CV, perfil
```

---

## Reconstruir Madre desde cero

```bash
git clone https://github.com/alvarofernandezmota-tech/yggdrasil-dew ~/Projects/yggdrasil-dew
cd ~/Projects/yggdrasil-dew
cp setup/servidor/.env.plantilla setup/servidor/.env
# Editar .env con valores reales
bash setup/servidor/scripts/batcueva-state.sh
```

---

## Pendientes críticos

- [ ] Fase 3 levantar (n8n + Paperless + Vaultwarden)
- [ ] Fase 4 crear compose + scripts
- [ ] `docs/` ampliar — manuales por servicio
- [ ] `agentes/` y `ollama/` — auditar y actualizar contenido
- [ ] Repo dotfiles separado (Hyprland, aliases, bashrc)
- [ ] Migración inbox→repo automatizada (THDORA/n8n)

---

_Ver: [CONVENCIONES.md](CONVENCIONES.md) · [MASTER-PENDIENTES.md](MASTER-PENDIENTES.md) · [ROADMAP.md](ROADMAP.md) · [inbox/README.md](inbox/README.md)_
