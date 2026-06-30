---
tags: [pendiente, master, planificacion, urgente, python, pentest, llm, ia-local]
fecha: 2026-07-01
revision: cada-domingo
owner: alvarofernandezmota-tech
perfil: dev-python · pentest-linux · ia-local · llm · ml
---

# 📋 MASTER PENDIENTES — Ecosistema completo

> Fuente única de verdad de TODO lo pendiente.
> Última auditoría: 01 jul 2026 00:44 CEST — Perplexity vía MCP
> Se revisa cada domingo. Se ejecuta cada día desde aquí.

---

## 🟢 HOY — 01 jul 2026 (miércoles)

### ✅ Completado sesión 30-jun/01-jul
- [x] **git pull --rebase en Madre** — repo local sincronizado con GitHub ✅
- [x] **AP RTL8188FTV verificado estable** — sin INTERFACE-DISABLED en toda la sesión ✅
- [x] **Fix driver RTL8188FTV** — módulo `8188fu` no existe en kernel 7.0.9, AP funciona sin fix ✅
- [x] **llama3.1:8b** — descargado (4.9GB) ✅
- [x] **nomic-embed-text** — descargado (274MB) ✅
- [x] **bge-m3** — descargado (1.2GB) ✅
- [x] **5/5 modelos Ollama** — stack IA completo (13GB total) ✅
- [x] **THDORA API mapeada** — 20 endpoints documentados ✅
- [x] **Filesystem thdora limpiado** — archivos basura + token eliminados ✅
- [x] **Repo documentado** — inbox + ESTADO-SISTEMA + CHANGELOG actualizados ✅

### 🔴 Pendiente crítico — próxima sesión
- [ ] **Auditoría THDORA src/** — leer `~/Projects/thdora/src/` para mapa handlers bot
- [ ] **Leer PLAN_MANANA.md** de thdora — plan inmediato pendiente
- [ ] **Implementar handlers Telegram:**
  - [ ] `/hoy` → `GET /summary/{date}`
  - [ ] `/semana` → `GET /summary/week/{date}`
  - [ ] `/habitos` → `GET /habits/{date}`
  - [ ] `/agenda` → `GET /appointments/{date}`
  - [ ] `/proximas` → `GET /appointments/upcoming/{date}`
- [ ] **Uptime Kuma → THDORA webhook** — configurar alertas Telegram
- [ ] **Verificar webhooks.py** — comprobar si está incluido en main.py de thdora
- [ ] **Token Telegram** — valorar revocar en @BotFather (precaución, archivo era 0 bytes)

---

## 🟡 ESTA SEMANA

### AP MadreAP — mejoras
- [ ] HT40 en hostapd — mayor velocidad MadreAP (ahora en 20MHz no HT)
- [ ] Script `ap-ctl [start|stop|status|clients]` — ver issue #5
- [ ] Documentar módulo real del driver RTL8188FTV (`sudo modinfo` + dkms)
- [ ] Mitmproxy / tcpdump en `wlan0` — interceptar tráfico clientes
- [ ] VLANs — separar red pentest de red doméstica (ver ADR-004)

### Seguridad
- [ ] SSH hardening → clave pública ambos nodos (Madre + Acer)
- [ ] Instalar Tailscale en Redmi A5 (Play Store)
- [ ] Instalar Prey en Acer: `sudo apt install prey`
- [ ] Verificar Computrace en BIOS Acer

### THDORA — handlers pendientes
- [ ] Implementar `/estado`
- [ ] Implementar `/inbox`
- [ ] Implementar `/diario`
- [ ] Implementar `/pull <modelo>`
- [ ] Integrar Uptime Kuma webhooks → THDORA

### IA local — integración
- [ ] Pipeline RAG: `nomic-embed-text` / `bge-m3` → Qdrant → Open WebUI
- [ ] Configurar Open WebUI: `llama3.1:8b` como modelo por defecto
- [ ] Crear Modelfile Erika en Ollama → primer agente local
- [ ] Local GPT Obsidian → apuntar a Ollama Madre
- [ ] n8n → pipeline: texto → nomic-embed-text → Qdrant

### Pentest — primer uso real
- [ ] Acceder Kali Desktop `http://100.91.112.32:6901`
- [ ] Primer scan Nmap desde Kali
- [ ] SpiderFoot: primer scan OSINT
- [ ] Wazuh prereq: `sudo sysctl -w vm.max_map_count=262144`
- [ ] Suricata IDS pasivo en Madre

### varopc — escritorio
- [ ] Audio sistema — mapear teclas volúmen Hyprland
- [ ] Tercer monitor → adaptador DVI-D → HDMI ~3-5€
- [ ] Obsidian Git — plugin + auto-commit + Dataview + Templater

### Repositorios GitHub a crear
- [ ] alvarofernandezmota-tech/chatbot-control
- [ ] alvarofernandezmota-tech/terminal-ia

### Repo yggdrasil-dew — limpieza
- [ ] `tailscale.apk` — archivo vacío en root, borrar o subir APK real
- [ ] `ROADMAP.md` — marcar fases completadas
- [ ] Vaciar inbox → migrar a `docs/ias/modelos-ollama.md` + `proyectos/thdora/`

---

## 🟢 PRÓXIMAS 2 SEMANAS

### Python — desarrollo
- [ ] Terminar módulo 05 del curso Python
- [ ] Script Python query a Ollama API local
- [ ] Script Python reconocimiento red básico

### SIEM — despliegue
- [ ] Levantar Wazuh (prereq sysctl primero)
- [ ] Instalar agente Wazuh en Acer
- [ ] DefectDojo: primer finding importado

### Grafana
- [ ] Dashboard CPU + RAM + temperatura + latencia Ollama + Docker

---

## 🔵 FUTURO

### BATCUEVA — expansión
- [ ] Restic backup offsite → Cloudflare R2 o Backblaze B2
- [ ] Rootless Docker
- [ ] Mozilla SOPS — secrets cifrados
- [ ] Ansible Playbooks — IaC completo
- [ ] Dockge UI — puerto 5010
- [ ] Migrar Ollama → llama.cpp puro

### Hardware
- [ ] RAM 16GB DDR4 SO-DIMM varopc (~40-50€)
- [ ] RTX 3060 12GB Madre (~200-250€ 2ª mano)
- [ ] SSD para Madre — HDD WD 28.409h en riesgo

---

## ✅ COMPLETADO (histórico)

| Fecha | Tarea |
|---|---|
| 2026-07-01 | 5/5 modelos Ollama descargados — 13GB stack IA completo |
| 2026-07-01 | bge-m3 descargado (1.2GB) |
| 2026-06-30 | llama3.1:8b + nomic-embed-text descargados |
| 2026-06-30 | THDORA API mapeada — 20 endpoints documentados |
| 2026-06-30 | Filesystem thdora limpiado — token + archivos basura eliminados |
| 2026-06-30 | AP RTL8188FTV verificado estable — sin caídas sesión completa |
| 2026-06-30 | git pull --rebase en Madre — repo sincronizado |
| 2026-06-28 | fail2ban jail sshd activo — Madre + Acer |
| 2026-06-28 | Puerto 53317 cerrado UFW — Madre + Acer |
| 2026-06-28 | dnsmasq DHCP activo en wlan0 Madre |
| 2026-06-28 | Netdata Acer activo + puerto 19999 restringido |
| 2026-06-28 | Auditoría completa repo yggdrasil-dew |
| 2026-06-27 | MadreAP WiFi resuelto — hostapd + networkd + UFW persistente |
| 2026-06-27 | Acer (theodora) conectado a MadreAP |
| 2026-06-27 | docs/infra/red-madre-ap.md creado |
| 2026-06-27 | ADR-004 seguridad privilege explosion documentado |
| 2026-06-25 | Stack 13 contenedores 100% healthy |
| 2026-06-25 | GitHub Actions CI activo |
| 2026-06-25 | ADR-001/002/003 creados |
| 2026-06-25 | Stack ciberseguridad completo |
| 2026-06-25 | SSH sin contraseña varopc→Madre |
| 2026-06-22 | Netdata multi-nodo Madre + Acer |
| 2026-06-22 | 15 fichas LLM en agentes/ |

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
_Actualizado: 01 jul 2026 00:44 CEST — Perplexity vía MCP_
_Ver: [[HOME]] · [[ECOSISTEMA]] · [[ESTADO-SISTEMA]] · [[inbox/README]]_
