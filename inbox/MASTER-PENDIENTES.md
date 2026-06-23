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

## 🟣 PERFIL PROFESIONAL

- **Lenguaje principal:** Python 3.x — scripting, automatización, bots, ML, APIs
- **Seguridad ofensiva:** pentesting Linux, OSINT, reconocimiento redes, CTF
- **IA local:** Ollama, LLMs open source, RAG, fine-tuning, agentes autónomos
- **Infraestructura:** Linux Arch/Hyprland, Docker, Tailscale, homelab Batcueva

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
- [ ] 7 fichas nuevas en `agentes/`: tecnicas-entrenamiento, parametros-inferencia, fine-tuning-local, erika-persona, arquitecturas-emergentes, seguridad-ataques-llm, etica-principios-por-modelo

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
- [ ] Ver [[inbox/2026-06-23-auditoria-osint]] para osint-stack

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
_Actualizado: 23 jun 2026 18:40 · Próxima revisión: domingo 28 jun 2026_
_Ver: [[HOME]] · [[CONTEXT]] · [[ECOSISTEMA]] · [[inbox/README]] · [[filosofia]]_
