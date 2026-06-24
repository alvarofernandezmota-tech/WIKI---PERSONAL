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

## 🚨 AL LLEGAR A CASA HOY — PRIORIDAD ABSOLUTA (tarde-noche 24 jun)

### 0. Hotspot → conectar Madre a internet
- [ ] Activar hotspot en el móvil (5GHz si es posible)
- [ ] Desactivar apagado automático del hotspot
- [ ] Conectar Madre al hotspot: `nmcli device wifi connect "NOMBRE_RED" password "PASS"`
- [ ] Verificar conexión: `ping 1.1.1.1`
- [ ] Ver investigación completa: [[inbox/2026-06-24-hotspot-red-situacion]]
- [ ] Ver auditoría: [[inbox/2026-06-25-AUDITAR-HOTSPOT-RED]]

### 1. Despertar Madre (pantalla negra / suspensión)
- [ ] Pulsar tecla o mover ratón en Madre para despertarla
- [ ] Si no responde: botón de encendido corto
- [ ] **Deshabilitar suspensión para siempre:**
```bash
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
```

### 2. Verificar descargas Docker (llevan desde anoche)
```bash
docker images | grep -E "ollama|open-webui|qdrant|n8n|gitea|paperless|vaultwarden"
docker ps
```
- Descargas que deberian estar listas (desde noche 23-24 jun):
  - `ollama/ollama:latest`
  - `ghcr.io/open-webui/open-webui:main`
  - `qdrant/qdrant:latest`
  - Imágenes Fase 3: n8n, Gitea, Paperless, Vaultwarden
  - Imágenes Fase 4: LiteLLM, Nginx Proxy Manager
- Si algo falta → retry:
```bash
nohup bash -c 'for img in ollama/ollama:latest ghcr.io/open-webui/open-webui:main qdrant/qdrant:latest; do until docker pull $img; do sleep 5; done; done' > /tmp/docker-retry.log 2>&1 &
```

### 3. Levantar Fases en orden

**Fase 1 — Base Ollama (ya documentada)**
- [ ] `cd ~/yggdrasil-dew && git pull`
- [ ] `docker compose -f setup/servidor/docker-compose.yml up -d`
- [ ] `docker compose ps` → verificar healthy
- [ ] `ollama pull qwen2.5:3b` + `ollama pull nomic-embed-text`
- [ ] Ver: [[inbox/2026-06-24-fase1-revisada-con-litellm]]

**Fase 3 — Productividad (n8n, Gitea, Paperless, Vaultwarden)**
- [ ] Levantar con docker compose fase3
- [ ] Ver: [[inbox/2026-06-24-fase3-completa]]

**Fase 4 — IA Gateway (LiteLLM, Nginx PM, Qdrant)**
- [ ] Levantar con docker compose fase4
- [ ] Ver: [[inbox/2026-06-24-fase4-litellm-sops-plan]]

### 4. Tailscale — hacer permanente YA
- [ ] `sudo systemctl enable --now tailscaled`
- [ ] Generar authkey en admin.tailscale.com (Reusable + No expiry)
- [ ] `sudo tailscale up --authkey=tskey-XXXX`
- [ ] `sudo reboot` → verificar que levanta solo

### 5. UFW — activar firewall
- [ ] Ejecutar reglas de [[setup/servidor/ufw-seguridad.md]]
- [ ] `sudo ufw enable` + `sudo ufw status`

---

## 🔴 ESTA SEMANA

### Clasificar inbox → estructura definitiva
- [ ] Ejecutar migración masiva inbox/ a carpetas correctas
- [ ] Mapa de destino:
  - Diario personal / cierres sesión → **repo personal diario**
  - ADR / decisiones arquitectura → `docs/adr/`
  - Scripts / setup madre → `setup/servidor/`
  - Hotspot / red → `setup/red/`
  - ADB / móvil → `setup/movil/`
  - Proyectos (local-brain, thdora...) → repos propias
  - Investigación modelos/ollama → `docs/investigacion/`
  - Prompts / debates multi-IA → `prompts/`
- [ ] Ver guía ADB: [[inbox/2026-06-25-ADB-ANDROID-GUIA-COMPLETA]]
- [ ] Ver control móvil opensource: [[inbox/2026-06-25-OPENSOURCE-CONTROL-MOVIL]]

### Claude — refactor repo nivel ingeniero software
- [ ] Abrir Claude con acceso MCP
- [ ] Copiar prompt de [[inbox/2026-06-23-prompt-claude-refactor-repo]]
- [ ] Tareas: auditar pendientes + crear `.obsidian/` workspace + actualizar HOME.md + CONVENCIONES.md

### Repos GitHub a crear
- [ ] `alvarofernandezmota-tech/ollama-stack`
- [ ] `alvarofernandezmota-tech/osint-stack`
- [ ] `alvarofernandezmota-tech/local-brain`
- [ ] `alvarofernandezmota-tech/chatbot-control`
- [ ] `alvarofernandezmota-tech/terminal-ia`

### Ejecutar auditorías de carpetas
- [ ] `osint/` `formacion/` `tools/` `docs/` `yo/` `setup/` `diarios/` `ollama/`
- [ ] Raíz: `HOME.md`, `ECOSISTEMA.md`, `CONTEXT.md`, `AGENT.md` — actualizar

### SSH sin contraseña Madre → Acer
- [ ] `ssh-keygen -t ed25519 -C "varopc"` en Madre
- [ ] `ssh-copy-id varo@100.86.119.102`

### varopc — Obsidian sync
- [ ] `git pull` local para traer archivos de hoy
- [ ] Instalar plugin Obsidian Git → auto-commit
- [ ] Instalar Dataview + Templater + Calendar

### varopc — escritorio pendientes
- [ ] Audio sistema — mapear teclas volumen en Hyprland
- [ ] Tercer monitor → comprar adaptador DVI-D (macho) → HDMI (hembra) ~3-5€

### thdora — bot TOKI
- [ ] Verificar `/start` en Telegram
- [ ] Crear `docs/DEPLOY.md`, `docs/SERVIDOR_MADRE.md`, `docs/TROUBLESHOOTING.md`
- [ ] `/diario`, `/inbox`, `/tarea`, `/estado` handlers

---

## 🟢 PRÓXIMAS 2 SEMANAS

### 🦇 BATCUEVA — Fase 2 (después de Ollama)
- [ ] **SpiderFoot** (:5001) · **Portainer** (:9000) · **Uptime Kuma** (:3002)
- [ ] **UFW + fail2ban** · **tmux** · **Pi-hole**

### Python — desarrollo profesional
- [ ] Terminar módulo 05 del curso Python
- [ ] Script Python query a Ollama API local
- [ ] Script Python reconocimiento red básico

### OSINT + Pentest
- [ ] Instalar nmap en Madre → primer scan real
- [ ] Documentar en `osint/herramientas.md`

### IA local — integración
- [ ] Open WebUI → RAG sobre yggdrasil-dew
- [ ] Crear Modelfile Erika en Ollama → primer agente local
- [ ] Local GPT Obsidian → apuntar a Ollama Madre

---

## 🔵 FUTURO

### 🦇 BATCUEVA — Fase 3 (ya documentada en inbox)
- [ ] n8n · Homepage/Homarr · Headscale · Gitea · Code Server
- [ ] Shadowbroker (AIS aviones+barcos) · OSIRIS (satélites+CCTV)

### Hardware
- [ ] RAM 16GB DDR4 SO-DIMM varopc (~40-50€)
- [ ] RTX 3060 12GB Madre (~200-250€ 2ª mano)

---

## ✅ COMPLETADO (histórico)

| Fecha | Tarea |
|---|---|
| 2026-06-24 | **Fases 1-4 documentadas** — docker-compose completo con LiteLLM + Nginx PM |
| 2026-06-24 | **Investigación hotspot** — situación red + auditoría documentada |
| 2026-06-24 | **ADB Android guía completa** — control móvil desde Madre |
| 2026-06-24 | **docker-compose.yml optimizado** — CPU vars + healthchecks + restart:always |
| 2026-06-24 | **ollama-cpu-setup.md** — Modelfile + vars para i5-8400 |
| 2026-06-24 | **tailscale-autoarranque.md** — guía systemd + authkey |
| 2026-06-24 | **ufw-seguridad.md** — reglas firewall stack IA |
| 2026-06-24 | **setup/servidor/README.md** — índice setup Madre |
| 2026-06-23 | **filosofia.md v3.0** — 3 leyes repos + ingeniero software organizado |
| 2026-06-23 | **ADR homelab vs proyectos** · **ADR docs-as-code** · **ADR ollama vs agentes** |
| 2026-06-23 | **Auditorías completas** de todas las carpetas del repo |
| 2026-06-23 | Stack batcueva definitivo documentado |
| 2026-06-22 | Netdata multi-nodo — Madre + Acer conectados |
| 2026-06-22 | 15 fichas LLM creadas en `agentes/` |

---

## 🗓️ Planificación semanal

```
Lunes     → thdora + Madre (día técnico)
Martes    → formación Python
Miércoles → thdora handlers + Python bots   ← HOY
Jueves    → OSINT + pentest + seguridad
Viernes   → LLM + IA local + Ollama
Sábado    → libre / exploración
Domingo   → revisión semanal + auditoría inbox
```

---
_Actualizado: 24 jun 2026 19:10 · Próxima revisión: domingo 28 jun 2026_
_Ver: [[HOME]] · [[CONTEXT]] · [[ECOSISTEMA]] · [[inbox/README]] · [[filosofia]]_
