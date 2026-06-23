---
tags: [pendiente, master, planificacion, urgente, python, pentest, llm, ia-local]
fecha: 2026-06-24
revision: cada-domingo
owner: alvarofernandezmota-tech
perfil: dev-python · pentest-linux · ia-local · llm · ml
---

# 📋 MASTER PENDIENTES — Ecosistema completo

> Fuente única de verdad de TODO lo pendiente.
> Se revisa cada domingo. Se ejecuta cada día desde aquí.
> Cuando se completa una tarea → marcar con ✅ + fecha + mover al diario del día.

---

## 🚨 AL LLEGAR A CASA — PRIORIDAD 1

### 1. Despertar Madre (pantalla negra / suspensión)
- [ ] Pulsar tecla o mover ratón en Madre para despertarla
- [ ] Si no responde: botón de encendido corto
- [ ] **Deshabilitar suspensión para siempre:**
```bash
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
```

### 2. Verificar descarga Docker (se cortó con TLS error)
```bash
docker images | grep -E "ollama|open-webui|qdrant"
docker ps
```
- Si Ollama no está completo → ejecutar retry:
```bash
until docker pull ollama/ollama:latest; do echo "reintentando..."; sleep 5; done
until docker pull ghcr.io/open-webui/open-webui:main; do sleep 5; done
until docker pull qdrant/qdrant:latest; do sleep 5; done
```
- Cuando estén las 3: usar compose de [[setup/servidor/docker-compose.yml]]

### 3. Migrar inbox/ desde el Acer (o Madre)
```bash
cd ~/yggdrasil-dew && git pull
mkdir -p agentes/ollama agentes/prompts docs/adr docs/decisiones \
         setup proyectos/thdora proyectos/chatbot-control \
         proyectos/local-brain proyectos/terminal-ia proyectos/osint \
         diarios formacion yo
git add -A && git commit -m "refactor: migrar inbox/ a estructura definitiva" && git push
```

---

## 🔴 AHORA — Esta sesión (2026-06-24 noche)

### Stack Madre — EJECUTAR EN ORDEN
- [ ] `cd ~/yggdrasil-dew && git pull` → traer docker-compose.yml actualizado
- [ ] `docker compose down` (si está levantado)
- [ ] `docker compose up -d` con el nuevo compose
- [ ] `docker compose ps` → verificar 3 servicios healthy
- [ ] `ollama pull qwen2.5:3b`
- [ ] `ollama pull nomic-embed-text`
- [ ] Crear Modelfile CPU → `ollama create qwen2.5:3b-cpu -f Modelfile`
- [ ] Open WebUI: conectar Qdrant desde Admin → Settings → Documents
- [ ] Test RAG: subir un .md y preguntar

### Tailscale — hacer permanente YA
- [ ] `sudo systemctl enable --now tailscaled`
- [ ] Generar authkey en admin.tailscale.com (Reusable + No expiry)
- [ ] `sudo tailscale up --authkey=tskey-XXXX`
- [ ] `sudo reboot` → verificar que levanta solo
- [ ] Ver guía: [[setup/servidor/tailscale-autoarranque.md]]

### UFW — activar firewall
- [ ] Ejecutar reglas de [[setup/servidor/ufw-seguridad.md]]
- [ ] `sudo ufw enable`
- [ ] `sudo ufw status` → verificar

---

## 🟡 ESTA SEMANA

### Claude — refactor repo nivel ingeniero software
- [ ] Abrir Claude con acceso MCP
- [ ] Copiar prompt de [[inbox/2026-06-23-prompt-claude-refactor-repo]]
- [ ] Tareas: auditar pendientes + crear `.obsidian/` workspace + actualizar HOME.md + plan maestro + CONVENCIONES.md

### Ejecutar auditorías (plans ya en inbox)
- [ ] `osint/` → ver [[inbox/2026-06-23-auditoria-osint]]
- [ ] `formacion/` → ver [[inbox/2026-06-23-auditoria-formacion]]
- [ ] `tools/` + `cli-tools/` → ver [[inbox/2026-06-23-auditoria-tools]]
- [ ] `docs/` → ver [[inbox/2026-06-23-auditoria-docs]]
- [ ] `yo/` → ver [[inbox/2026-06-23-auditoria-yo]]
- [ ] `setup/` → ver [[inbox/2026-06-23-auditoria-setup]]
- [ ] `diarios/` → ver [[inbox/2026-06-23-auditoria-diarios]]
- [ ] `ollama/` → ver [[inbox/2026-06-23-auditoria-ollama]]
- [ ] `templates/` — pendiente auditar
- [ ] Raíz: `HOME.md`, `ECOSISTEMA.md`, `CONTEXT.md`, `AGENT.md` — pendiente actualizar

### Repos GitHub a crear
- [ ] `alvarofernandezmota-tech/ollama-stack` — Docker Ollama+WebUI+Qdrant
- [ ] `alvarofernandezmota-tech/osint-stack` — Docker SpiderFoot+IVRE+Kismet
- [ ] `alvarofernandezmota-tech/local-brain` — cerebro IA local
- [ ] `alvarofernandezmota-tech/chatbot-control` — chatbot control personal
- [ ] `alvarofernandezmota-tech/terminal-ia` — terminal con IA

### Ronda 2 LLM — Gemini Deep Research
- [ ] 7 fichas nuevas en `agentes/`

### varopc — Obsidian sync
- [ ] `git pull` local para traer archivos de hoy
- [ ] Instalar plugin Obsidian Git → auto-commit
- [ ] Instalar Dataview + Templater + Calendar
- [ ] Configurar `inbox/` como carpeta por defecto nuevas notas

### varopc — escritorio pendientes
- [ ] Audio sistema — mapear teclas volumen en Hyprland
- [ ] Tercer monitor → comprar adaptador DVI-D (macho) → HDMI (hembra) ~3-5€

### SSH sin contraseña Madre → Acer
- [ ] `ssh-keygen -t ed25519 -C "varopc"` en Madre
- [ ] `ssh-copy-id varo@100.86.119.102`

### thdora — bot TOKI
- [ ] Verificar `/start` en Telegram
- [ ] Crear `docs/DEPLOY.md`, `docs/SERVIDOR_MADRE.md`, `docs/TROUBLESHOOTING.md`

---

## 🟢 PRÓXIMAS 2 SEMANAS

### 🦇 BATCUEVA — Fase 2 (después de Ollama)
- [ ] **SpiderFoot** en Madre (:5001) — OSINT
- [ ] **Portainer** en Madre (:9000) — UI Docker
- [ ] **Uptime Kuma** en Madre (:3002) — vigilar servicios
- [ ] **UFW + fail2ban** en Madre — seguridad básica
- [ ] **tmux** en Madre
- [ ] **Pi-hole** — DNS + bloqueo anuncios

### Python — desarrollo profesional
- [ ] Terminar módulo 05 del curso Python
- [ ] Crear `formacion/python/roadmap.md`
- [ ] Práctica: script Python query a Ollama API local
- [ ] Práctica: script Python reconocimiento red básico

### OSINT + Pentest
- [ ] Instalar nmap en Madre
- [ ] Primer scan real: `nmap -sV 10.134.31.0/24`
- [ ] Documentar en `osint/herramientas.md`

### IA local — integración
- [ ] Configurar Local GPT en Obsidian → apuntar a Ollama Madre
- [ ] Open WebUI → RAG sobre yggdrasil-dew
- [ ] Crear Modelfile Erika en Ollama → primer agente local

### thdora — handlers TOKI
- [ ] `/diario <texto>` — escribe en diarios/
- [ ] `/inbox <texto>` — crea nota en inbox/
- [ ] `/tarea <texto>` — añade tarea al diario
- [ ] `/estado` — muestra estado Docker en Madre

---

## 🔵 FUTURO

### 🦇 BATCUEVA — Fase 3
- [ ] **n8n** → automatización workflows
- [ ] **Homepage/Homarr** → dashboard central
- [ ] **Headscale** → reemplaza Tailscale cloud
- [ ] **Gitea** → GitHub propio self-hosted
- [ ] **Code Server** → VSCode en el browser
- [ ] **Shadowbroker** — aviones + barcos AIS
- [ ] **OSIRIS** — globo 3D satélites + CCTV

### Hardware
- [ ] RAM 16GB DDR4 SO-DIMM para varopc (~40-50€)
- [ ] RTX 3060 12GB para Madre (~200-250€ 2ª mano)
- [ ] Workstation IA futura: Ryzen 7 + 32GB + RTX 3060

---

## ✅ COMPLETADO (histórico)

| Fecha | Tarea |
|---|---|
| 2026-06-24 | **docker-compose.yml optimizado** — CPU vars + healthchecks + restart:always |
| 2026-06-24 | **ollama-cpu-setup.md** — Modelfile + vars para i5-8400 |
| 2026-06-24 | **tailscale-autoarranque.md** — guía systemd + authkey |
| 2026-06-24 | **ufw-seguridad.md** — reglas firewall stack IA |
| 2026-06-24 | **setup/servidor/README.md** — índice setup Madre |
| 2026-06-23 | **filosofia.md v3.0** — 3 leyes repos + ingeniero software organizado |
| 2026-06-23 | **ADR homelab vs proyectos** — Batcueva = homelab, no proyecto |
| 2026-06-23 | **ADR docs-as-code** — cómo enlazar repos Docker con cerebro |
| 2026-06-23 | **ADR ollama vs agentes** — separación local vs API |
| 2026-06-23 | **Auditorías completas** de todas las carpetas del repo |
| 2026-06-23 | Stack batcueva definitivo documentado |
| 2026-06-22 | Netdata multi-nodo — Madre + Acer conectados |
| 2026-06-22 | 15 fichas LLM creadas en `agentes/` |
| 2026-06-20 | UFW: regla SSH añadida |
| 2026-06-20 | fail2ban active + enabled |
| 2026-06-20 | Monitores DP-1 + HDMI-A-1 scale 1 |

---

## 🗓️ Planificación semanal

```
Lunes     → thdora + Madre (día técnico)
Martes    → formación Python
Miércoles → thdora handlers + Python bots
Jueves    → OSINT + pentest + seguridad
Viernes   → LLM + IA local + Ollama
Sábado    → libre / exploración
Domingo   → revisión semanal + auditoría inbox
```

---
_Actualizado: 24 jun 2026 01:05 · Próxima revisión: domingo 28 jun 2026_
_Ver: [[HOME]] · [[CONTEXT]] · [[ECOSISTEMA]] · [[inbox/README]] · [[filosofia]]_
