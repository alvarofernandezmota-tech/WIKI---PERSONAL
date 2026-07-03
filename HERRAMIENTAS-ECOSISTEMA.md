---
tags: [ecosistema, herramientas, orquestacion, scripts, github-actions, bots]
fecha-actualizacion: 2026-07-03
---

# ⚡ HERRAMIENTAS DEL ECOSISTEMA — Inventario completo

> Fuente de verdad de TODAS las herramientas, scripts, Actions y bots del ecosistema.
> Las normas globales viven aqui. Las repos hijas (thdora, secops, etc.) apuntan a este fichero.
> Última actualizacion: **03-jul-2026 08:30 CEST** — Sesion S20

---

## 🧭 Jerarquia de responsabilidad

```
yggdrasil-dew (CEREBRO / ORQUESTADOR)
├── HERRAMIENTAS-ECOSISTEMA.md  ← este fichero, fuente de verdad global
├── ECOSISTEMA.md               ← mapa de repos, hardware, red, Docker
├── CONVENCIONES.md             ← normas de commits, estructura, estilo
├── ECOSYSTEM-ARCHITECTURE.md  ← arquitectura tecnica del ecosistema
├── .github/workflows/          ← Actions que vigilan el ecosistema ENTERO
└── scripts/                    ← scripts de orquestacion global

thdora (REPO HIJA — bot + FastAPI)
├── scripts/edison.sh           ← orquestador LOCAL de sesiones thdora
├── .github/workflows/          ← Actions que vigilan SOLO thdora
└── docs/ROADMAP.md             ← roadmap LOCAL de thdora

yggdrasil-secops (REPO HIJA — bots watchdog)
thdora / local-brain / osint-stack / ai-toolkit / batcueva
└── Cada una sigue normas globales + tiene su mini-ecosistema local
```

**Regla maestra:** Si afecta a una sola repo → va en esa repo.
Si afecta a varias repos o al ecosistema entero → va en yggdrasil-dew.

---

## 🛠️ HERRAMIENTAS ACTIVAS — Inventario completo

### 1. Scripts de sesion y orquestacion

| Script | Repo | Que hace | Cuando usarlo |
|---|---|---|---|
| `scripts/edison.sh` | `thdora` | Orquestador local: session/audit/doc/close/migrate | SIEMPRE al iniciar y cerrar sesion en thdora |
| `scripts/maintenance/new-session.sh` | `yggdrasil-dew` | Inicia sesion nueva en ygg | Al empezar en ygg |
| `scripts/edison.sh session` | `thdora` | Abre S21, muestra PLAN_MANANA.md | Inicio de cada dia en thdora |
| `scripts/edison.sh close` | `thdora` | Audit + doc + commit + push de cierre | Fin de sesion thdora |
| `scripts/edison.sh full` | `thdora` | Ciclo completo automatico sin preguntas | Cuando quieres cerrar rapido |
| `scripts/edison.sh migrate` | `thdora` | Exporta estructura ecosistema a otro repo | Al crear una nueva repo hija |
| `scripts/deploy.sh` | `thdora` | Deploy de thdora | Al desplegar nueva version |
| `scripts/deploy_madre.sh` | `thdora` | Deploy especifico en madre via SSH | Al desplegar en produccion |

### 2. GitHub Actions — yggdrasil-dew (cerebro)

| Action | Trigger | Que hace |
|---|---|---|
| `orquestador-maestro.yml` | push/schedule | Orquesta auditorias generales del ecosistema |
| `repo-health.yml` | schedule diario | Health check de todos los repos del ecosistema |
| `repo-health-check.yml` | push/PR | Health check rapido en cada cambio |
| `tripwire-repo.yml` | push | Detecta cambios criticos inesperados |
| `audit-on-push.yml` | push | Audita calidad en cada push |
| `lint-commits.yml` | push/PR | Valida Conventional Commits |
| `yamllint.yml` | push | Valida sintaxis de todos los YAML |
| `sync-estado.yml` | issue/PR close | Sincroniza ESTADO-SISTEMA.md |
| `sync-drive.yml` | schedule | Sincroniza con Google Drive |
| `resumen-diario.yml` | schedule 23:00 | Genera resumen diario del ecosistema |
| `context-reminder.yml` | schedule | Recordatorio de contexto para proxima sesion |
| `inbox-processor.yml` | push a inbox/ | Procesa notas del inbox y las clasifica |
| `inbox-health.yml` | schedule | Comprueba que el inbox no lleva +7 dias sin limpiar |
| `clasificador.yml` | push | Clasifica y etiqueta issues automaticamente |
| `test-scripts.yml` | push | Tests de los propios scripts de orquestacion |
| `ecosystem-guardian.yml` | schedule 03:00 UTC | Guardian nocturno del ecosistema |
| `new-file-bootstrap.yml` | push | Bootstrapea nuevos ficheros con header/doc |

### 3. GitHub Actions — thdora (repo hija)

| Action | Trigger | Que hace |
|---|---|---|
| `ci.yml` | push/PR | CI: lint + format + typecheck |
| `tests.yml` | push/PR | Tests unitarios e integracion |
| `deploy.yml` | push main | Deploy automatico |
| `docker-health.yml` | schedule | Health check del contenedor Docker |
| `zombie-cleaner.yml` | push | Limpia ficheros .py de 0 bytes |
| `ecosystem-sync.yml` | issue/PR | Actualiza ECOSYSTEM-STATE.md |
| `ecosystem-guardian.yml` | schedule 03:00 | Guardian nocturno de thdora |
| `ai-pr-reviewer.yml` | PR abierto | Revisa PR con IA (Groq) + valida commits |

### 4. Herramientas Docker en madre

| Herramienta | Puerto | Rol en el ecosistema |
|---|---|---|
| **n8n** | 5678 | Automatizacion de workflows — complementa GitHub Actions |
| **Grafana** | 3000 | Dashboards de metricas del ecosistema |
| **Prometheus** | 9090 | Recoleccion de metricas |
| **Uptime Kuma** | 3002 | Monitor de servicios — alerta si algo cae |
| **Portainer** | 9000 | Panel Docker — gestion visual de contenedores |
| **Gitea** | 3003 | Git self-hosted — espejo local del ecosistema |
| **Netdata** | 19999 | Monitor de hardware en tiempo real |
| **code-server** | 8443 | VSCode web — edicion remota desde movil |
| **Ollama** | 11434 | LLM local — base de thdora y local-brain |
| **Qdrant** | 6333 | Base vectorial para RAG |
| **Open WebUI** | 3001 | Chat UI para modelos Ollama |
| **SpiderFoot** | 5001 | OSINT automatizado |

### 5. Bots activos en madre

| Bot | Contenedor | Rol |
|---|---|---|
| **thdora-bot** | `thdora-bot` | Bot Telegram del proyecto THDORA |
| **guardian-bot** | `guardianbot` | Notificaciones Telegram centrales del ecosistema |
| **Yggdrasil Watchdog** | `yggdrasilwatchdog` | Vigila 7 contenedores, reinicia unhealthy |
| **Tailscale Monitor** | `tailscalemonitor` | Ping a nodos VPN ⚠️ crash-loop |
| **Network Radar** | `networkradar` | Escanea LAN — detecta intrusos |
| **Log Guardian** | `logguardianbot` | Vigila auth.log, ufw.log ⚠️ crash-loop |
| **Local Tripwire** | `localtripwire` | Integridad de archivos ⚠️ sin rutas |

---

## 🔍 GAPS DETECTADOS — Que falta

### GAP 1: Sin enlace thdora → ygg en commits/PRs
**Problema:** Cuando cierras una sesion en thdora con Edison, no hay ningun mecanismo que
automaticamente actualice `ECOSISTEMA.md` o `HERRAMIENTAS-ECOSISTEMA.md` en ygg.
**Solucion propuesta:** Webhook desde la Action `ecosystem-sync.yml` de thdora
hacia un endpoint de n8n que actualice ygg via API de GitHub.
**Prioridad:** Media — S22

### GAP 2: Repos hijas sin CONVENCIONES.md local
**Problema:** thdora, secops, local-brain no tienen fichero explici que diga
"seguimos las normas de yggdrasil-dew" + sus reglas locales.
**Solucion propuesta:** Crear `docs/CONVENCIONES-LOCAL.md` en cada repo hija
apuntando a `CONVENCIONES.md` de ygg como fuente de verdad.
**Prioridad:** Alta — S21

### GAP 3: Sin checklist de "nueva repo del ecosistema"
**Problema:** No existe un checklist estandar de los pasos obligatorios
cuando se crea una nueva repo que forma parte del ecosistema.
**Solucion propuesta:** Crear `templates/nueva-repo-checklist.md` en ygg.
**Prioridad:** Alta — S21

### GAP 4: `resumen-diario.yml` no llega a Telegram
**Problema:** El resumen diario lo genera la Action pero no lo envia
al guardian-bot para recibirlo en Telegram.
**Solucion propuesta:** Anaddir step final en `resumen-diario.yml` que
haga POST al webhook de n8n → guardian-bot → Telegram.
**Prioridad:** Media — S22

### GAP 5: Gitea desincronizado de GitHub
**Problema:** Gitea esta levantado en madre pero no hace mirror automatico
de los repos de GitHub. Si GitHub cae, Gitea no tiene copia fresca.
**Solucion propuesta:** Configurar mirror automatico GitHub → Gitea
para los 7 repos del ecosistema.
**Prioridad:** Baja — Fase 5

### GAP 6: n8n sin workflows del ecosistema
**Problema:** n8n esta levantado pero sin workflows configurados.
Es la herramienta perfecta para el puente GitHub Actions → Telegram.
**Solucion propuesta:** Crear en n8n los workflows:
  - Resumen diario → Telegram
  - Issue creado en cualquier repo → Telegram
  - Docker container unhealthy → Telegram
**Prioridad:** Alta — S22

### GAP 7: AlertManager no configurado
**Problema:** Prometheus tiene metricas pero las alertas no llegan a Telegram.
AlertManager esta propuesto pero no levantado.
**Solucion propuesta:** Levantar AlertManager + configurar reglas
para los umbrales criticos de CPU/RAM/disco/contenedores.
**Prioridad:** Media — Fase 5

---

## 🚀 HERRAMIENTAS RECOMENDADAS — Las que nos faltan

### Tier 1 — Encajan perfectamente con lo que ya tenemos

| Herramienta | Tipo | Por que encaja | Integracion |
|---|---|---|---|
| **n8n workflows** | Automatizacion | Ya esta levantado, solo falta configurar | GitHub Actions → n8n → Telegram |
| **Loki + Promtail** | Logs | Centraliza logs de todos los contenedores en Grafana | Docker → Loki → Grafana |
| **AlertManager** | Alertas | Enruta alertas Prometheus a Telegram | Prometheus → AlertManager → guardian-bot |
| **CrowdSec** | Seguridad | Complementa fail2ban con inteligencia colectiva | Capa sobre UFW |
| **Ntfy** | Notificaciones | Push ligero alternativo a Telegram para alertas | Cualquier script → Ntfy |
| **Renovate Bot** | Dependencias | Abre PRs automaticos cuando hay dependencias desactualizadas | GitHub App en cada repo |

### Tier 2 — Interesantes para el siguiente nivel

| Herramienta | Tipo | Por que encaja | Cuando |
|---|---|---|---|
| **Dagger.io** | CI portable | Pipelines de CI que corren local y en GitHub Actions identicos | Cuando thdora CI crezca |
| **act** | CI local | Ejecutar GitHub Actions localmente antes de hacer push | Desarrollo de Actions |
| **Watchtower** | Docker | Actualiza contenedores Docker automaticamente cuando hay nueva imagen | Fase 5 |
| **Semaphore UI** | Ansible | Panel web para ejecutar scripts/playbooks de forma visual | Si usamos Ansible |
| **Dasherr / Homepage** | Dashboard | Dashboard unificado de todos los servicios de madre | Vida diaria |
| **Vaultwarden** | Secrets | Bitwarden self-hosted — gestionar secrets del ecosistema | Antes de Fase 5 |

### Tier 3 — Futuro / cuando escale

| Herramienta | Tipo | Cuando tiene sentido |
|---|---|---|
| **Woodpecker CI** | CI self-hosted | Si queremos CI en Gitea sin depender de GitHub Actions |
| **Traefik** | Reverse proxy | Cuando haya mas de 5 servicios expuestos con dominios |
| **Vault (HashiCorp)** | Secrets | Cuando Vaultwarden no sea suficiente |
| **Kubernetes (k3s)** | Orquestacion | Cuando Docker Compose no escale |

---

## 📍 NORMAS GLOBALES DEL ECOSISTEMA

> Estas normas aplican a TODAS las repos. Las repos hijas pueden anadir reglas locales pero no pueden contradecir estas.

### Commits
- Formato Conventional Commits obligatorio: `feat:`, `fix:`, `docs:`, `chore:`, `refactor:`, `test:`
- Cada commit debe ser atomico (un cambio logico)
- Mensajes en ingles o espanol, consistente por repo

### Estructura minima de cada repo hija
```
repo-hija/
├── README.md                    ← descripcion, rol en ecosistema, link a ygg
├── docs/
│   ├── CONVENCIONES-LOCAL.md     ← normas locales + enlace a ygg/CONVENCIONES.md
│   └── ROADMAP.md                ← roadmap local
├── scripts/                     ← scripts de esa app
├── .github/workflows/
│   ├── ci.yml                    ← CI minimo
│   ├── ecosystem-guardian.yml    ← guardian nocturno
│   └── ecosystem-sync.yml        ← sincroniza estado
└── PLAN_MANANA.md               ← tareas proxima sesion
```

### Inicio de sesion (protocolo)
```bash
# yggdrasil-dew
cd ~/yggdrasil-dew && git pull && bash scripts/maintenance/new-session.sh

# thdora
cd ~/Projects/thdora && git pull && bash scripts/edison.sh session

# Cualquier repo hija futura
cd ~/Projects/<repo> && git pull && bash scripts/edison.sh session
```

### Cierre de sesion (protocolo)
```bash
# thdora y repos hijas
bash scripts/edison.sh close      # con preguntas
bash scripts/edison.sh full       # automatico sin preguntas
```

### GitHub Actions obligatorias por repo
Toda repo hija del ecosistema debe tener como minimo:
- [ ] `ecosystem-guardian.yml` — auditor nocturno
- [ ] `ecosystem-sync.yml` — sincroniza estado al cerrar issues/PRs
- [ ] `lint-commits.yml` — valida Conventional Commits
- [ ] `ci.yml` o equivalente — CI basico

---

## 📋 CHECKLIST — Al crear una nueva repo del ecosistema

```
[ ] 1. Crear repo en GitHub (privada por defecto si tiene codigo)
[ ] 2. Ejecutar: bash scripts/edison.sh migrate <ruta-nueva-repo>
       (copia Actions base, estructura docs, scripts de sesion)
[ ] 3. Actualizar ECOSISTEMA.md en ygg (anadir la nueva repo a la tabla)
[ ] 4. Crear docs/CONVENCIONES-LOCAL.md apuntando a ygg/CONVENCIONES.md
[ ] 5. Anadir Actions obligatorias: guardian + sync + lint-commits + ci
[ ] 6. Crear PLAN_MANANA.md con las primeras tareas
[ ] 7. Primer commit: feat: inicializar ecosistema desde yggdrasil-dew
[ ] 8. Abrir issue #1 en la nueva repo: [META] Estructura inicial del ecosistema
```

---

## 🔗 REFERENCIAS CRUZADAS

- [[ECOSISTEMA]] — mapa de repos, hardware, red, Docker
- [[CONVENCIONES]] — normas de commits y estilo
- [[ECOSYSTEM-ARCHITECTURE]] — arquitectura tecnica
- [[ESTADO-SISTEMA]] — estado operativo actual
- [[MASTER-PENDIENTES]] — tareas pendientes globales
- [thdora/docs/ROADMAP.md](https://github.com/alvarofernandezmota-tech/thdora/blob/main/docs/ROADMAP.md) — roadmap local de thdora
- [thdora/scripts/edison.sh](https://github.com/alvarofernandezmota-tech/thdora/blob/main/scripts/edison.sh) — orquestador de sesiones thdora

---
_Actualizado: 03-jul-2026 08:30 CEST — Sesion S20 — Perplexity via MCP_
