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

---

## Fase 0 — Fundamentos ✅ COMPLETA

- [x] Arch Linux + Hyprland en Madre y Acer
- [x] Tailscale operativo — red privada entre equipos
- [x] SSH entre equipos
- [x] Repo yggdrasil-dew como cerebro central
- [x] THDORA agente base corriendo en Madre

---

## Fase 1 — Stack IA Base ✅ COMPLETA

- [x] Ollama corriendo en Madre (:11434)
- [x] Open WebUI (:3001) — interfaz web IA
- [x] Qdrant (:6333) — vector DB para RAG
- [x] Modelos: qwen2.5:7b, qwen2.5:3b, bge-m3

---

## Fase 2 — Observabilidad ✅ COMPLETA

- [x] Grafana (:3000) — dashboards
- [x] Prometheus (:9090) — métricas
- [x] Portainer (:9000) — gestión Docker
- [x] Uptime Kuma (:3002) — monitorización servicios

---

## Fase 3 — Automatización y Datos 🔄 EN PROGRESO

- [ ] n8n (:5678) — workflows y automatización
- [ ] Paperless-ngx (:8010) — gestión documental
- [ ] Vaultwarden (:8888) — gestor de contraseñas self-hosted

---

## Fase 4 — Proxy IA y Seguridad Avanzada

- [ ] LiteLLM (:4000) — proxy unificado Ollama + APIs externas
- [ ] Nginx Proxy Manager (:81) — reverse proxy con SSL
- [ ] Watchtower — actualización automática contenedores
- [ ] SOPS — gestión segura de secretos

---

## Fase 5 — Agentes Autónomos

- [ ] THDORA con acceso a repo + Docker + n8n
- [ ] Pipeline inbox → procesado automático → repo
- [ ] Agente de cierre de sesión autónomo
- [ ] Erika — agente local personalizado en Ollama

---

## Fase 6 — Soberanía Total

- [ ] Headscale self-hosted (reemplaza Tailscale cloud)
- [ ] Gitea self-hosted (reemplaza GitHub para repos privados)
- [ ] Code Server (VSCode en el browser desde cualquier sitio)
- [ ] Pi-hole DNS con listas de bloqueo
- [ ] Backups automáticos cifrados a storage externo

---

## Fase 7 — Hardware y Escala

- [ ] RTX 3060 12GB en Madre → modelos 13B sin cuantizar
- [ ] RAM 16GB en varopc
- [ ] Segundo servidor / NAS para backups y almacenamiento
- [ ] MacBook como tercer nodo Tailscale

---

## Principios de diseño

1. **Todo en código** — si no está en el repo, no existe
2. **Idempotente** — ejecutar dos veces = mismo resultado
3. **Inbox primero** — nada se pierde, todo se procesa después
4. **Una cosa a la vez** — foco, no dispersión
5. **Documentar mientras se hace** — no después

---
_Actualizado: 24 jun 2026 · Ver: [ESTADO-SISTEMA.md](ESTADO-SISTEMA.md) · [MASTER-PENDIENTES.md](MASTER-PENDIENTES.md)_
