---
tags: [pendiente, master, planificacion, urgente, python, pentest, llm, ia-local]
fecha: 2026-06-23
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
- Cuando estén las 3: `docker compose up -d`

### 3. Migrar inbox/ desde el Acer (o Madre)
```bash
cd ~/yggdrasil-dew && git pull
mkdir -p agentes/ollama agentes/prompts docs/adr docs/decisiones \
         setup proyectos/thdora proyectos/chatbot-control \
         proyectos/local-brain proyectos/terminal-ia proyectos/osint \
         diarios formacion yo
cp inbox/2026-06-23-adr-ollama-en-agentes.md docs/adr/
cp inbox/2026-06-23-auditoria-ollama.md agentes/ollama/
cp inbox/2026-06-23-ollama-*.md agentes/ollama/
cp inbox/2026-06-23-v4-pendiente-ollama.md agentes/ollama/
cp inbox/2026-06-23-prompt-*.md agentes/prompts/
cp inbox/2026-06-23-auditoria-setup.md inbox/2026-06-23-local-brain-setup.md \
   inbox/2026-06-23-estado-descargas-madre.md inbox/2026-06-23-pull-stack-madre.md \
   inbox/2026-06-23-systemd-plan.md setup/
cp inbox/2026-06-23-proyecto-thdora.md proyectos/thdora/
cp inbox/2026-06-23-proyecto-chatbot-control.md proyectos/chatbot-control/
cp inbox/2026-06-23-proyecto-local-brain.md proyectos/local-brain/
cp inbox/2026-06-23-proyecto-terminal-ia.md proyectos/terminal-ia/
cp inbox/2026-06-23-auditoria-osint.md inbox/2026-06-23-osint-rag-mover.md proyectos/osint/
cp inbox/2026-06-23-adr-docs-as-code-repos-cerebro.md docs/adr/
cp inbox/2026-06-23-decision-*.md docs/decisiones/
cp inbox/2026-06-23-estado-auditoria-repo.md inbox/2026-06-23-inbox-processor-implementacion.md \
   inbox/2026-06-23-auditoria-docs.md inbox/2026-06-23-auditoria-tools*.md \
   inbox/2026-06-23-dashboard-readme.md inbox/2026-06-23-tools-pendientes.md docs/
cp inbox/2026-06-23-sesion-completa.md inbox/2026-06-23-yggdrasil-v4-diario-maestro.md \
   inbox/2026-06-23-sesion-gemini-auditoria-inbox-perplexity.md \
   inbox/2026-06-23-sesion-perplexity-auditoria-gemini-inbox.md diarios/
cp inbox/2026-06-23-auditoria-formacion.md formacion/
cp inbox/2026-06-23-auditoria-yo.md yo/
git add -A
git commit -m "refactor: migrar inbox/ a estructura definitiva — copia sin borrar 2026-06-23"
git push
```

---

## 🔴 AHORA — Esta sesión (2026-06-23 tarde)

### Docker en Madre — descargando AHORA
- [ ] Esperar que terminen las 3 descargas: Ollama + Open WebUI + Qdrant
- [ ] `docker compose up -d` cuando terminen
- [ ] Verificar: `docker ps` + `curl http://localhost:11434/api/tags`
- [ ] Open WebUI accesible en http://localhost:3000
- [ ] Ver plan completo: [[inbox/2026-06-23-estado-descargas-madre]]

### Claude — crear repo ollama-stack (hacer YA mientras descargan)
- [ ] Abrir Claude con acceso MCP
- [ ] Copiar prompt de [[inbox/2026-06-23-prompt-claude-ecosistema-docker]]
- [ ] Claude crea `alvarofernandezmota-tech/ollama-stack` con docker-compose completo
- [ ] Claude documenta en cerebro: `ollama/README.md` + `setup/servidor/docker-stack.md`

### Post-instalación Ollama (cuando levanten los servicios)
- [ ] Pull modelos: `qwen2.5:7b`, `qwen2.5:3b`, `bge-m3`, `nomic-embed-text`
- [ ] Configurar Open WebUI — conectar con Ollama
- [ ] Configurar Qdrant — crear colección RAG del cerebro
- [ ] Test end-to-end: pregunta al cerebro via RAG

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
- [ ] Copiar Prompt Maestro v2 de [[inbox/2026-06-22-tarde-netdata-agentes-llm]]
- [ ] Pegar en Gemini con Deep Research activado
- [ ] 7 fichas nuevas en `agentes/`

### varopc — Obsidian sync
- [ ] `git pull` local para traer archivos de hoy
- [ ] Instalar plugin Obsidian Git → auto-commit
- [ ] Instalar Dataview + Templater + Calendar
- [ ] Configurar `inbox/` como carpeta por defecto nuevas notas
- [ ] Test flujo: editar Obsidian → commit → push

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
| 2026-06-23 | **filosofia.md v3.0** — 3 leyes repos + ingeniero software organizado |
| 2026-06-23 | **ADR homelab vs proyectos** — Batcueva = homelab, no proyecto |
| 2026-06-23 | **ADR docs-as-code** — cómo enlazar repos Docker con cerebro |
| 2026-06-23 | **ADR ollama vs agentes** — separación local vs API |
| 2026-06-23 | **Auditorías completas** de todas las carpetas del repo |
| 2026-06-23 | **Prompt Claude** refactor repo nivel ingeniero software |
| 2026-06-23 | **Prompt Claude** ecosistema Docker paso a paso |
| 2026-06-23 | **estado-auditoria-repo.md** — checklist master auditorías |
| 2026-06-23 | Stack batcueva definitivo documentado |
| 2026-06-23 | Maltego eliminado → SpiderFoot |
| 2026-06-22 | Netdata multi-nodo — Madre + Acer conectados |
| 2026-06-22 | 15 fichas LLM creadas en `agentes/` |
| 2026-06-22 | inbox/README.md elevado a estándar ingeniería v2.0 |
| 2026-06-20 | UFW: regla SSH añadida |
| 2026-06-20 | fail2ban active + enabled |
| 2026-06-20 | Monitores DP-1 + HDMI-A-1 scale 1 |
| 2026-06-20 | Sony Bravia overscan — Full Pixel activado |

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
_Actualizado: 23 jun 2026 21:47 · Próxima revisión: domingo 28 jun 2026_
_Ver: [[HOME]] · [[CONTEXT]] · [[ECOSISTEMA]] · [[inbox/README]] · [[filosofia]]_
