---
tags: [ecosistema, mapa, islas, obsidian, herramientas, gaps]
fecha-actualizacion: 2026-07-03
---

# 🌍 MAPA DE ISLAS — Ecosistema completo

> Cada isla es una parte autonoma del ecosistema con su rol, sus herramientas y sus gaps.
> El flujo es de arriba hacia abajo (ygg define las normas) y de abajo hacia arriba (cada isla reporta su estado).
> Ultima actualizacion: **03-jul-2026 08:40 CEST** — Sesion S21

---

## 🌳 NIVEL 0 — El cerebro (yggdrasil-dew)

```
                    ┌─────────────────────────┐
                    │   yggdrasil-dew          │
                    │   CEREBRO / ORQUESTADOR  │
                    │   Normas │ Mapa │ Estado  │
                    └─────────────────────────┘
                              │ (da normas)
           ┌───────────────┴───────────────┐
           │                               │
    NIVEL 1 (Infra)              NIVEL 2 (Apps)
           │                               │
   ┌──────┴────┐         ┌───────┴────────┐
   madre   batcueva    thdora secops local-brain osint-stack
```

**Flujo de normas:** ygg ↓ define → todas las repos hijas las siguen
**Flujo de estado:** todas las repos ↑ reportan → ygg consolida el estado

---

## 🏙️ ISLA 0 — yggdrasil-dew (el cerebro)

| | |
|---|---|
| **Rol** | Cerebro, orquestador, fuente de verdad global |
| **Tipo** | Obsidian vault + GitHub repo publica |
| **Acceso** | theodora (trabajo) + iPhone (lectura) |
| **Prioridad** | MAXIMA — si esto falla, el ecosistema pierde memoria |

### Carpetas del vault

| Carpeta | Rol | Estado |
|---|---|---|
| `/` (raiz) | Ficheros maestros: ECOSISTEMA, HERRAMIENTAS, MAPA-ISLAS, CONVENCIONES | ✅ Activo |
| `diarios/` | Diarios de sesion dia a dia | ✅ Activo |
| `docs/` | Documentacion tecnica extendida | ✅ Activo |
| `proyectos/` | Estado de proyectos activos | ✅ Activo |
| `inbox/` | Notas rapidas sin clasificar | ✅ Activo |
| `mocs/` | Maps of Content — indices tematicos | ⚠️ Poco usado |
| `core/` | Conocimiento fundamental del ecosistema | ⚠️ Poco documentado |
| `agentes/` | Prompts y configs de agentes IA | ⚠️ Vacio |
| `formacion/` | Aprendizaje y cursos | ✅ Activo |
| `hardware/` | Documentacion hardware fisico | ✅ Activo |
| `infra/` | Documentacion infra (red, Docker, Tailscale) | ✅ Activo |
| `docker/` | Configs y notas Docker | ✅ Activo |
| `ollama/` | Modelos, prompts, RAG | ⚠️ Poco organizado |
| `osint/` | Notas y metodologia OSINT | ⚠️ Solapado con osint-stack/ |
| `osint-stack/` | Carpeta de la repo osint-stack en ygg | ⚠️ Duplicidad con osint/ |
| `thdora/` | Notas y contexto de thdora en ygg | ⚠️ Sin limpiar |
| `setup/` | Guias de configuracion inicial | ✅ Activo |
| `tools/` | Inventario de herramientas | ⚠️ Solapado con HERRAMIENTAS-ECOSISTEMA.md |
| `cli-tools/` | Herramientas CLI especificas | ⚠️ Poco documentado |
| `yo/` | Informacion personal | ✅ Privado/OK |
| `assets/` | Imagenes y recursos | ✅ OK |
| `templates/` | Templates de docs y repos | ✅ Activo |

### Herramientas de esta isla

| Herramienta | Estado | Funcion |
|---|---|---|
| Obsidian | ✅ Activo | Edicion del vault, graf de conexiones |
| GitHub (repo publica) | ✅ Activo | Control de versiones, Actions |
| 17+ GitHub Actions | ✅ Activo | Auditoria, salud, sincronizacion |
| `scripts/maintenance/new-session.sh` | ✅ Activo | Inicia sesion en ygg |
| Obsidian Graph View | ✅ Disponible | Mapa visual de conexiones entre notas |
| Obsidian Dataview (plugin) | ⚠️ Sin explotar | Queries dinamicas sobre el vault |
| Obsidian Canvas | ⚠️ Sin explotar | Mapas visuales tipo miro dentro de Obsidian |

### Gaps de esta isla

| Gap | Impacto | Cuando |
|---|---|---|
| `agentes/` vacio — no hay prompts de agentes documentados | Alto | S22 |
| `osint/` y `osint-stack/` solapados — confusion de donde va cada cosa | Medio | S22 |
| `tools/` solapado con `HERRAMIENTAS-ECOSISTEMA.md` — uno sobra | Medio | S22 |
| Obsidian Dataview sin usar — podria generar vistas dinamicas del estado del ecosistema | Alto | S23 |
| Obsidian Canvas sin usar — podria ser el mapa visual de islas que Obsidian ya soporta | Alto | S22 |
| MOCs (`mocs/`) sin estructura clara | Bajo | Fase 4 |

---

## 🖥️ ISLA 1 — madre (hardware principal)

| | |
|---|---|
| **Rol** | Servidor principal — ejecuta todo el Docker stack |
| **Tipo** | Hardware fisico — PC torre i5-8400, 16GB RAM, GTX 1060 |
| **Acceso** | SSH desde theodora (`ssh madre`) o iPhone (Termius) via Tailscale |
| **Repo** | Sin repo propia — documentada en ygg + `batcueva` (pendiente) |

### Herramientas activas

| Herramienta | Puerto | Estado |
|---|---|---|
| Docker Engine | — | ✅ Activo |
| Ollama (LLM) | 11434 | ✅ Activo |
| Qdrant (vectores) | 6333 | ✅ Activo |
| n8n (workflows) | 5678 | ✅ Levantado ⚠️ sin configurar |
| Grafana | 3000 | ✅ Activo |
| Prometheus | 9090 | ✅ Activo |
| Netdata | 19999 | ✅ Activo |
| Uptime Kuma | 3002 | ✅ Activo |
| Portainer | 9000 | ✅ Activo |
| Gitea (git local) | 3003 | ✅ Activo ⚠️ sin mirrors |
| code-server | 8443 | ✅ Activo |
| Open WebUI | 3001 | ✅ Activo |
| SpiderFoot | 5001 | ✅ Activo |
| UFW + fail2ban | — | ✅ Activo |
| Tailscale | 100.91.112.32 | ✅ Activo |
| AP WiFi (MadreAP) | wlan0 | ✅ Activo |

### Gaps de esta isla

| Gap | Impacto | Cuando |
|---|---|---|
| `batcueva` no existe — la infra ejecutable no tiene repo | Critico | S22 |
| n8n levantado pero sin workflows — el puente GitHub→Telegram no funciona | Alto | S22 |
| Gitea sin mirror automatico desde GitHub | Medio | Fase 5 |
| AlertManager no levantado — las alertas Prometheus no llegan a Telegram | Medio | Fase 5 |
| Loki + Promtail no levantados — logs de contenedores no van a Grafana | Medio | Fase 5 |
| SEC-001: Puerto FTP 21 abierto en router Digi | CRITICO SEGURIDAD | Inmediato |
| Ollama API sin auth — expuesto en red local | Alto seguridad | Fase 5 |
| Qdrant sin auth | Alto seguridad | Fase 5 |
| Kali-pentest pendiente descargar (3.7GB) | Bajo | Cuando se necesite |
| Wazuh pendiente levantar | Medio seguridad | Fase 5 |
| Suricata pendiente (IDS pasivo wlan0) | Medio seguridad | Fase 5 |

---

## 🤖 ISLA 2 — thdora (bot + FastAPI)

| | |
|---|---|
| **Rol** | Bot Telegram + FastAPI backend + RAG con Ollama |
| **Tipo** | Repo GitHub publica + contenedor Docker en madre |
| **Ruta local** | `~/Projects/thdora/` en theodora |
| **Orquestador** | `scripts/edison.sh` — sesion/audit/close/full/migrate |

### Herramientas activas

| Herramienta | Estado | Funcion |
|---|---|---|
| FastAPI | ✅ Activo | Backend API |
| python-telegram-bot | ✅ Activo | Bot Telegram |
| Ollama (qwen2.5-coder) | ✅ Activo | LLM local |
| Qdrant | ✅ Activo | RAG |
| Docker | ✅ Activo | Contenedor en madre |
| Edison (`scripts/edison.sh`) | ✅ Activo | Orquestador de sesiones |
| GitHub Actions (8 workflows) | ✅ Activos | CI, tests, deploy, guardian, zombie-cleaner, sync |
| pytest | ✅ Configurado | Tests unitarios e integracion |
| ruff + black | ✅ Configurado | Linting y format |
| mypy | ✅ Configurado | Type checking |

### Gaps de esta isla

| Gap | Impacto | Cuando |
|---|---|---|
| Handlers de Telegram pendientes — el bot no responde a comandos reales | Critico funcional | S22 |
| GROQ_API_KEY sin configurar como secret de GitHub — AI reviewer mudo | Medio | Inmediato |
| Sin `docs/CONVENCIONES-LOCAL.md` apuntando a ygg | Medio | S21 |
| Edison `migrate` no creado — no se puede replicar estructura a otra repo | Medio | S22 |
| Sin tests de integracion con Ollama real | Bajo | Fase 5 |

---

## 🛡️ ISLA 3 — yggdrasil-secops (bots watchdog)

| | |
|---|---|
| **Rol** | Bots de seguridad y vigilancia del ecosistema |
| **Tipo** | Repo GitHub privada + contenedores Docker en madre |
| **Bot central** | guardian-bot — notificaciones Telegram de todos los watchdogs |

### Herramientas activas

| Bot | Estado | Problema |
|---|---|---|
| guardian-bot | ✅ Estable | — |
| Yggdrasil Watchdog | ✅ Activo | — |
| Network Radar | ✅ Activo | — |
| Tailscale Monitor | ⚠️ Crash-loop | ~10 min crash |
| Log Guardian | ⚠️ Crash-loop | ~8 min crash |
| Local Tripwire | ⚠️ Roto | WATCH_PATHS vacio |

### Gaps de esta isla

| Gap | Impacto | Cuando |
|---|---|---|
| Tailscale Monitor en crash-loop | Alto | secops #2 |
| Log Guardian en crash-loop | Alto | secops #2 |
| Local Tripwire sin rutas vigiladas | Critico | secops #2 |
| Sin `docs/CONVENCIONES-LOCAL.md` apuntando a ygg | Medio | S21 |
| Sin GitHub Actions minimas (guardian + lint-commits) | Medio | S22 |
| No recibe alertas de n8n ni AlertManager todavia | Alto | S22 |

---

## 🧠 ISLA 4 — local-brain (RAG + embeddings)

| | |
|---|---|
| **Rol** | Stack de IA local: RAG, embeddings, memoria vectorial |
| **Tipo** | Repo GitHub privada |
| **Estado** | 🔧 En desarrollo |

### Herramientas

| Herramienta | Estado |
|---|---|
| Ollama embeddings (bge-m3, nomic-embed-text) | ✅ Activos en madre |
| Qdrant | ✅ Activo en madre |
| Codigo local-brain | ⚠️ En desarrollo |

### Gaps de esta isla

| Gap | Impacto |
|---|---|
| Sin estructura definida — no hay README claro | Alto |
| Sin `docs/CONVENCIONES-LOCAL.md` | Medio |
| Sin GitHub Actions minimas | Medio |
| Sin conexion documentada con thdora (que usa sus embeddings) | Alto |

---

## 🔍 ISLA 5 — osint-stack (OSINT automatizado)

| | |
|---|---|
| **Rol** | Stack OSINT: SpiderFoot + metodologia + automatizaciones |
| **Tipo** | Repo GitHub privada |
| **Estado** | 🔧 En desarrollo |

### Herramientas

| Herramienta | Estado |
|---|---|
| SpiderFoot | ✅ Activo en madre (puerto 5001) |
| Codigo osint-stack | ⚠️ En desarrollo |

### Gaps de esta isla

| Gap | Impacto |
|---|---|
| Sin estructura definida | Alto |
| Sin `docs/CONVENCIONES-LOCAL.md` | Medio |
| Sin GitHub Actions minimas | Medio |
| Carpeta `osint/` y `osint-stack/` en ygg solapadas | Medio |

---

## 🧰 ISLA 6 — batcueva (infra ejecutable) — PENDIENTE CREAR

| | |
|---|---|
| **Rol** | Configs ejecutables de infra: Docker Compose, SOPS, scripts de deploy |
| **Tipo** | Repo GitHub **privada** (contiene configs sensibles) |
| **Estado** | 🔜 Pendiente crear |

### Por que es necesaria

Ahora mismo toda la infra ejecutable de madre (docker-compose.yml, configs de contenedores,
scripts de despliegue) vive solo en madre sin version control. Si madre muere, se pierde todo.
`batcueva` es el backup ejecutable del ecosistema: si restauras batcueva en una maquina nueva,
puedes levantar el ecosistema completo en minutos.

### Lo que debe contener

```
batcueva/
├── docker/
│   ├── docker-compose.main.yml      # Stack principal de madre
│   ├── docker-compose.secops.yml    # Stack de bots watchdog
│   └── docker-compose.ai.yml        # Stack IA (ollama, qdrant, open-webui)
├── configs/
│   ├── tailscale/                   # Config Tailscale
│   ├── ufw/                         # Reglas UFW
│   └── fail2ban/                    # Config fail2ban
├── scripts/
│   ├── restore-madre.sh             # Script para restaurar madre desde 0
│   └── backup.sh                    # Backup incremental a disco externo
└── secrets/                         # Gestionado con SOPS (cifrado)
    └── .sops.yaml
```

### Gaps (todo es gap, no existe aun)

| Gap | Impacto |
|---|---|
| La repo no existe | CRITICO — sin batcueva madre no tiene backup |
| Sin SOPS configurado — los secrets no estan cifrados | CRITICO seguridad |
| Sin script de restauracion | Alto |

---

## 💻 ISLA 7 — theodora (maquina de trabajo)

| | |
|---|---|
| **Rol** | Desarrollo, Obsidian, terminal, SSH a madre |
| **Tipo** | Hardware fisico — Acer Ryzen 5, Arch Linux, Hyprland |
| **Sin repo propia** | Se configura desde `batcueva` y `setup/` de ygg |

### Herramientas activas

| Herramienta | Estado |
|---|---|
| Obsidian | ✅ Activo |
| Hyprland (WM) | ✅ Activo |
| git + gh CLI | ✅ Activo |
| SSH a madre | ✅ Activo |
| Tailscale | ✅ Activo |
| UFW + fail2ban | ⚠️ Parcial |

### Gaps de esta isla

| Gap | Impacto |
|---|---|
| UFW/fail2ban parcialmente configurado | Medio seguridad |
| Sin dotfiles en repo — si theodora muere, hay que reconfigurar todo a mano | Alto |
| Termius en iPhone pendiente configurar | Bajo |

---

## 📱 ISLA 8 — dispositivos moviles

| Dispositivo | Rol | Estado |
|---|---|---|
| iPhone 11 | Terminal SSH via Termius, acceso movil | ⚠️ Termius pendiente configurar |
| Xiaomi | Tailscale activo | ✅ OK |
| Redmi A5 | Hotspot 4G → internet a madre | ⚠️ Tailscale pendiente login |

### Gaps

| Gap | Impacto |
|---|---|
| Termius sin configurar en iPhone | Bajo — sin acceso movil |
| Redmi A5 Tailscale sin login | Bajo |

---

## 📊 TABLA RESUMEN — Estado de todas las islas

| Isla | Nombre | Estado | Issues criticos | Siguiente accion |
|---|---|---|---|---|
| 0 | yggdrasil-dew | 🟡 Madurando | Carpetas solapadas, agentes/ vacio | Limpiar osint/ y tools/ — S22 |
| 1 | madre | 🟡 Activa con gaps | SEC-001 critico, n8n sin configurar | Crear batcueva — S22 |
| 2 | thdora | 🟢 Limpia + deuda cerrada | Handlers pendientes, GROQ_KEY | Handlers Telegram — S22 |
| 3 | yggdrasil-secops | 🔴 3 bots rotos | crash-loops, tripwire sin rutas | secops #2 — S21 |
| 4 | local-brain | ⚪ Sin definir | Sin estructura ni conexion con thdora | Definir estructura — S23 |
| 5 | osint-stack | ⚪ Sin definir | Solapado con osint/ de ygg | Deduplicar carpetas — S22 |
| 6 | batcueva | 🔜 No existe | Sin backup ejecutable de madre | Crear repo + docker-compose — S22 |
| 7 | theodora | 🟡 Activa con gaps | Sin dotfiles en repo | Dotfiles repo — Fase 5 |
| 8 | moviles | 🟡 Parcial | Termius, Redmi Tailscale | Configurar Termius — Cuando se necesite |

---

## 💡 Como usar Obsidian Canvas para este mapa

Obsidian Canvas (ya incluido en Obsidian) puede renderizar este mapa de islas de forma visual:

1. En Obsidian: `Ctrl+N` → elige `Canvas`
2. Nombra el fichero `MAPA-ISLAS-VISUAL.canvas`
3. Crea un nodo por isla y enlazalos segun la jerarquia de arriba
4. Cada nodo puede abrir directamente la nota de esa isla
5. El resultado es un mapa tipo Miro dentro de Obsidian, con links vivos

Esto complementa este fichero Markdown con una vista visual navegable.

---

## 🔗 REFERENCIAS

- [[ECOSISTEMA]] — hardware, red, repos, Docker stack completo
- [[HERRAMIENTAS-ECOSISTEMA]] — inventario de todas las herramientas + gaps + recomendaciones
- [[CONVENCIONES]] — normas globales del ecosistema
- [[ESTADO-SISTEMA]] — estado operativo en tiempo real
- [[MASTER-PENDIENTES]] — todas las tareas pendientes
- [thdora repo](https://github.com/alvarofernandezmota-tech/thdora)
- [yggdrasil-secops repo](https://github.com/alvarofernandezmota-tech/yggdrasil-secops)

---
_Actualizado: 03-jul-2026 08:40 CEST — Sesion S21 — Perplexity via MCP_
