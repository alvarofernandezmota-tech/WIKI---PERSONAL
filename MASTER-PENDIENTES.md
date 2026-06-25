---
tags: [pendiente, master, planificacion, urgente, python, pentest, llm, ia-local]
fecha: 2026-06-25
revision: cada-domingo
owner: alvarofernandezmota-tech
perfil: dev-python · pentest-linux · ia-local · llm · ml
---

# 📋 MASTER PENDIENTES — Ecosistema completo

> Fuente única de verdad de TODO lo pendiente.
> Última auditoría: 25 jun 2026 14:59 CEST — Perplexity vía MCP
> Se revisa cada domingo. Se ejecuta cada día desde aquí.

---

## 🟢 HOY — 25 jun 2026 (jueves)

### ✅ Completado hoy
- [x] Stack Fase 1+2 HEALTHY — ollama:11434 + open-webui:3001 + qdrant:6333
- [x] SSH sin contraseña varopc→Madre — clave instalada
- [x] litellm-config.yaml creado y correcto
- [x] ESTADO-SISTEMA.md actualizado con estado real
- [x] SSH GitHub sin passphrase — id_ed25519_github configurado
- [x] git pull/push funcionando desde Madre
- [x] Alias `bc` instalado en .zshrc
- [x] .env creado desde .env.template
- [x] **Stack OSINT YMLs creados** — batcueva-osint.yml (SpiderFoot + IVRE)
- [x] **Stack Pentest YMLs creados** — batcueva-pentest.yml (Kali + Bettercap + Metasploit + Sliver)
- [x] **Stack SIEM YMLs creados** — batcueva-siem.yml (Wazuh + DefectDojo)
- [x] **Stack Vuln YMLs creados** — batcueva-vuln.yml (Greenbone + Nuclei + ZAP)
- [x] **Orquestador maestro** — batcueva-master.yml con `include`
- [x] **Comando `bc`** — script maestro con sesion/up/down/status/inbox/pentest/osint/scan
- [x] **.env.template** — todos los puertos centralizados
- [x] **Inbox ZERO** — verificado, solo .gitkeep
- [x] **ADRs creados** — ADR-001 (Qdrant), ADR-002 (compose modular), ADR-003 (SSH)
- [x] **GitHub Actions CI** — yamllint automático en cada push
- [x] **Ansible bootstrap** — infra/ansible/bootstrap-nodo.yml
- [x] **Documentación Gemini integrada** — validación YMLs + guía cámaras + n8n pipeline + hoja de ruta
- [x] **Imágenes Docker corregidas** — smicallef/spiderfoot + ivre/base (nombres reales Docker Hub)

### 🔴 Pendiente crítico — hacer HOY
- [ ] **`git pull --rebase` en Madre** — bajar fix imágenes Docker
- [ ] **Levantar SpiderFoot** — `docker compose -f docker/batcueva-osint.yml up -d spiderfoot`
- [ ] **Verificar SpiderFoot** — `http://100.91.112.32:5001`
- [ ] **Levantar Kali Desktop** — `bc up pentest` → `http://100.91.112.32:6901`
- [ ] **Generar .env Madre** — `openssl rand -hex 32` para N8N_ENCRYPTION_KEY y LITELLM_MASTER_KEY
- [ ] **Levantar Fase 3** — `docker compose -f setup/servidor/batcueva-fase3.yml up -d`
- [ ] **Levantar Fase 4** — `docker compose -f setup/servidor/batcueva-fase4.yml up -d`
- [ ] **Modelos Ollama** — qwen2.5:7b + llama3.1:8b + bge-m3 + nomic-embed-text

---

## 🟡 ESTA SEMANA

### Red y seguridad Madre — FASE SIGUIENTE
- [ ] UFW activar — ver `setup/servidor/ufw-seguridad.md`
- [ ] SSH hardening — ver `setup/servidor/fase1b-seguridad.md`
- [ ] Tailscale autoarranque — ver `setup/servidor/tailscale-autoarranque.md`
- [ ] Wazuh prereq: `sudo sysctl -w vm.max_map_count=262144`
- [ ] Suricata: verificar nombre interfaz real (`ip link show`)
- [ ] Deshabilitar suspensión en Madre

### THDORA — handlers pendientes
- [ ] Implementar `/estado` — código documentado en investigacion/
- [ ] Implementar `/inbox` — código documentado
- [ ] Implementar `/diario` — append diario + commit automático
- [ ] Implementar `/pull <modelo>` — docker exec ollama ollama pull
- [ ] Alerta proactiva: n8n detecta evento → THDORA avisa

### Pentest — primer uso real
- [ ] Acceder Kali Desktop en `http://100.91.112.32:6901`
- [ ] Primer scan Nmap desde Kali: `nmap -sV --open 192.168.1.0/24`
- [ ] SpiderFoot: primer scan OSINT sobre dominio/IP propio
- [ ] Bettercap: activar `network_mode: host` para sniffing real (ver validacion-ymls-gemini.md)
- [ ] Suricata: configurar interfaz correcta

### Repositorios GitHub a crear
- [ ] alvarofernandezmota-tech/ollama-stack
- [ ] alvarofernandezmota-tech/osint-stack
- [ ] alvarofernandezmota-tech/local-brain
- [ ] alvarofernandezmota-tech/chatbot-control
- [ ] alvarofernandezmota-tech/terminal-ia

### varopc — escritorio
- [ ] Audio sistema — mapear teclas volúmen Hyprland
- [ ] Tercer monitor → adaptador DVI-D → HDMI ~3-5€
- [ ] Obsidian Git — plugin + auto-commit + Dataview + Templater + Calendar
- [ ] Instalar Tailscale en Redmi A5 (Play Store)

### Windows 11 ISO (UUP)
- [ ] Generar nuevo set en uupdump.net (W11 24H2 · amd64 · es-ES · Pro)
- [ ] Lanzar ~/Downloads/uup/uup_download_linux.sh

---

## 🟢 PRÓXIMAS 2 SEMANAS

### IA local — integración
- [ ] Open WebUI → RAG sobre yggdrasil-dew
- [ ] Crear Modelfile Erika en Ollama → primer agente local
- [ ] Local GPT Obsidian → apuntar a Ollama Madre
- [ ] n8n → pipeline: logs nmap → Qdrant
- [ ] n8n pipeline auditoría automática (ver docs/pentesting/lab-setup/n8n-pipeline-auditoria.md)

### Python — desarrollo
- [ ] Terminar módulo 05 del curso Python
- [ ] Script Python query a Ollama API local
- [ ] Script Python reconocimiento red básico

### SIEM — despliegue
- [ ] Levantar Wazuh (prereq sysctl primero)
- [ ] Instalar agente Wazuh en Acer
- [ ] Script `scripts/bootstrap-node.sh` para nuevos nodos
- [ ] DefectDojo: primer finding importado

### Auditorías carpetas pendientes
- [ ] osint/ · formacion/ · tools/ · docs/ · yo/ · setup/ · diarios/ · ollama/
- [ ] Raíz: HOME.md · ECOSISTEMA.md · CONTEXT.md · AGENT.md — actualizar

---

## 🔵 FUTURO

### BATCUEVA — expansión
- [ ] Dockge (UI docker-compose visual) — puerto 5010
- [ ] n8n · Homepage/Homarr · Headscale · Gitea · Code Server
- [ ] Shadowbroker (AIS aviones+barcos) · OSIRIS (satélites+CCTV)
- [ ] Migrar Ollama → llama.cpp puro (mejor rendimiento CPU)
- [ ] Ansible: migrar scripts Bash → Playbooks

### Hardware
- [ ] RAM 16GB DDR4 SO-DIMM varopc (~40-50€)
- [ ] RTX 3060 12GB Madre (~200-250€ 2ª mano)

---

## ✅ COMPLETADO (histórico)

| Fecha | Tarea |
|---|---|
| 2026-06-25 | **Inbox ZERO** — verificado, solo .gitkeep |
| 2026-06-25 | **CI/CD activo** — GitHub Actions yamllint en cada push |
| 2026-06-25 | **ADR-001/002/003** — decisiones de arquitectura documentadas |
| 2026-06-25 | **Ansible bootstrap** — infra/ansible/bootstrap-nodo.yml |
| 2026-06-25 | **Imágenes Docker corregidas** — smicallef/spiderfoot + ivre/base |
| 2026-06-25 | **Stack ciberseguridad completo** — OSINT + Pentest + SIEM + Vuln YMLs |
| 2026-06-25 | **Comando `bc`** — script maestro instalado |
| 2026-06-25 | **.env.template** — todos los puertos centralizados |
| 2026-06-25 | **Orquestador maestro** — batcueva-master.yml |
| 2026-06-25 | **Stack Fase 1+2 HEALTHY** — ollama + open-webui + qdrant |
| 2026-06-25 | **SSH sin contraseña** varopc→Madre |
| 2026-06-25 | **SSH GitHub** sin passphrase — id_ed25519_github |
| 2026-06-25 | **Documentación Gemini integrada** — validación YMLs + guía cámaras + n8n + hoja de ruta |
| 2026-06-24 | Script migración inbox generado |
| 2026-06-24 | Fases 1-4 documentadas — docker-compose completo |
| 2026-06-24 | ADB Android guía completa |
| 2026-06-24 | docker-compose.yml optimizado — CPU vars + healthchecks |
| 2026-06-24 | ollama-cpu-setup.md — Modelfile + vars i5-8400 |
| 2026-06-24 | tailscale-autoarranque.md |
| 2026-06-24 | ufw-seguridad.md |
| 2026-06-23 | filosofia.md v3.0 — 3 leyes repos |
| 2026-06-23 | ADR homelab + docs-as-code + ollama vs agentes |
| 2026-06-23 | Auditorías completas todas las carpetas |
| 2026-06-22 | Netdata multi-nodo Madre + Acer |
| 2026-06-22 | 15 fichas LLM en agentes/ |

---

## 🗓️ Planificación semanal

```
Lunes     → thdora + Madre (día técnico)
Martes    → formación Python
Miércoles → thdora handlers + Python bots
Jueves    → OSINT + pentest + seguridad     ← HOY
Viernes   → LLM + IA local + Ollama
Sábado    → libre / exploración
Domingo   → revisión semanal + auditoría inbox
```

---
_Actualizado: 25 jun 2026 14:59 CEST — Perplexity vía MCP_
_Ver: [[HOME]] · [[CONTEXT]] · [[ECOSISTEMA]] · [[ESTADO-SISTEMA]] · [[inbox/README]]_
