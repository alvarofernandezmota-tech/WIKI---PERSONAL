# ROADMAP — Yggdrasil Dew

> Plan a largo plazo del ecosistema.
> No es una lista de tareas — es la visión de hacia dónde vamos.
> Las tareas concretas están en [MASTER-PENDIENTES.md](MASTER-PENDIENTES.md).

---

## Visión

Un ecosistema personal completamente soberano:
- **Infraestructura propia** — servidores, servicios, datos bajo control total
- **IA local** — modelos corriendo en Madre, sin depender de APIs externas
- **Automatización** — agentes que gestionan el sistema, no el humano
- **Reproducible** — cualquier máquina nueva levanta el ecosistema completo en < 1 hora
- **Seguro** — hardening, backups, monitorización proactiva
- **Soberanía ofensiva** — OSINT + pentest propio sin depender de servicios externos

---

## Fase 0 — Fundamentos ✅ COMPLETA

- [x] Arch Linux + Hyprland en Madre y Acer
- [x] Tailscale operativo — red privada entre equipos
- [x] SSH entre equipos sin contraseña
- [x] Repo yggdrasil-dew como cerebro central
- [x] THDORA agente base corriendo en Madre
- [x] MadreAP WiFi — hostapd + dnsmasq + UFW persistente
- [x] fail2ban activo — Madre + Acer

---

## Fase 1 — Stack IA Base ✅ COMPLETA

- [x] Ollama corriendo en Madre (:11434)
- [x] Open WebUI (:3001) — interfaz web IA
- [x] Qdrant (:6333) — vector DB para RAG
- [x] Modelos: qwen2.5-coder:7b, qwen2.5:3b listos
- [ ] Modelos pendientes: llama3.1:8b, bge-m3, nomic-embed-text

---

## Fase 2 — Observabilidad ✅ COMPLETA

- [x] Grafana (:3000) — dashboards
- [x] Prometheus (:9090) — métricas
- [x] Portainer (:9000) — gestión Docker
- [x] Uptime Kuma (:3002) — monitorización servicios
- [x] Netdata multi-nodo — Madre + Acer streaming

---

## Fase 3 — Automatización y Productividad ✅ COMPLETA

- [x] n8n (:5678) — workflows y automatización
- [x] Gitea (:3003) — Git self-hosted
- [x] code-server (:8443) — VSCode web
- [ ] Paperless-ngx — pendiente levantar
- [ ] Vaultwarden — pendiente levantar

---

## Fase 4 — Seguridad de Red 🔄 EN PROGRESO

> Correspondencia: PLAN-SEGURIDAD-Y-DESPLIEGUE.md Fases 1-3

- [ ] SSH hardening — `PasswordAuthentication no`
- [ ] UFW completo — script `setup/servidor/ufw-reglas-completas.sh`
- [ ] Tailscale `systemctl enable tailscaled`
- [ ] Script `start-batcueva.sh` — verificación antes de levantar Docker
- [ ] Restic backup offsite — Cloudflare R2 o Backblaze B2
- [x] fail2ban activo — Madre + Acer ✅
- [x] UFW activo básico — Madre + Acer ✅

---

## Fase 5 — Proxy IA y Secrets

- [ ] LiteLLM (:4000) — proxy unificado Ollama + APIs externas
- [ ] Nginx Proxy Manager (:81) — reverse proxy con SSL
- [ ] SOPS — gestión segura de secretos (ADR-004)
- [ ] Rootless Docker — cerrar brecha privilege explosion
- [ ] VLANs — red pentest aislada de red doméstica

---

## Fase 6 — Agentes Autónomos

- [ ] THDORA handlers: `/estado` `/inbox` `/diario` `/pull <modelo>`
- [ ] Uptime Kuma → THDORA webhook — alertas Telegram
- [ ] Pipeline inbox → procesado automático → repo
- [ ] Agente de cierre de sesión autónomo
- [ ] Erika — agente local personalizado en Ollama (Modelfile)
- [ ] Open WebUI RAG sobre yggdrasil-dew

---

## Fase 7 — OSINT + Pentest Real

> Requiere Fase 4 (seguridad red) completada primero.

- [ ] Kali Desktop (:6901) — `docker-compose.kali.yml` listo
- [ ] SpiderFoot (:5001) — OSINT automatizado
- [ ] Bettercap — `network_mode: host`
- [ ] Wazuh SIEM — prereq `vm.max_map_count=262144`
- [ ] Suricata IDS pasivo en wlan0
- [ ] DefectDojo — gestión de findings
- [ ] Primer scan Nmap real desde Kali
- [ ] Primer scan OSINT con SpiderFoot

---

## Fase 8 — Soberanía Total

- [ ] Headscale self-hosted (reemplaza Tailscale cloud)
- [ ] Pi-hole DNS con listas de bloqueo
- [ ] Backups automáticos cifrados a storage externo
- [ ] iPhone + Redmi A5 como nodos Tailscale plenos

---

## Fase 9 — Hardware y Escala

- [ ] RTX 3060 12GB en Madre → modelos 13B sin cuantizar
- [ ] RAM 16GB en varopc
- [ ] SSD para Madre — HDD WD en riesgo (28.409h)
- [ ] Segundo servidor / NAS para backups

---

## Principios de diseño

1. **Todo en código** — si no está en el repo, no existe
2. **Idempotente** — ejecutar dos veces = mismo resultado
3. **Inbox primero** — nada se pierde, todo se procesa después
4. **Una cosa a la vez** — foco, no dispersión
5. **Documentar mientras se hace** — no después
6. **Seguridad antes que funcionalidad** — no exponer sin hardenizar

---
_Actualizado: 28 jun 2026 22:48 CEST — Perplexity vía MCP_
_Ver: [ESTADO-SISTEMA.md](ESTADO-SISTEMA.md) · [MASTER-PENDIENTES.md](MASTER-PENDIENTES.md) · [PLAN-SEGURIDAD-Y-DESPLIEGUE.md](PLAN-SEGURIDAD-Y-DESPLIEGUE.md)_
