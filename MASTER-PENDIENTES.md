---
tags: [pendiente, master, planificacion, urgente]
fecha: 2026-06-24
revision: cada-domingo
owner: alvarofernandezmota-tech
perfil: dev-python · pentest-linux · ia-local · llm · homelab
---

# MASTER PENDIENTES — Ecosistema completo

> Fuente única de verdad de TODO lo pendiente.
> Siempre en la raíz del repo — cualquier IA lo encuentra en frío.
> Se revisa cada domingo. Se ejecuta cada día desde aquí.
> Completada una tarea → ✅ + fecha + mover a sección historial.

---

## P0 — Madre descargando AHORA

- [ ] Verificar descarga en background: `tail -f /tmp/pre-descarga.log`
- [ ] Cuando termine: `bash setup/servidor/scripts/batcueva-state.sh`
- [ ] Verificar stack completo Fase 1 + 2 healthy

---

## P1 — Esta sesión (24 jun 2026 madrugada)

### Stack Madre
- [ ] Fase 3 levantar: `docker compose -f setup/servidor/batcueva-fase3.yml up -d`
- [ ] Verificar n8n :5678 + Paperless :8010 + Vaultwarden :8888
- [ ] Deshabilitar suspensión Madre: `sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target`

### Repo
- [ ] Crear `setup/servidor/batcueva-fase4.yml` (LiteLLM + Nginx + Watchtower)
- [ ] Crear `setup/servidor/scripts/batcueva-fase4.sh`
- [ ] Crear `docs/` — manuales de uso por servicio
- [ ] Mover `setup/servidor/plan-maestro.md` → archivar en `diarios/`

### Seguridad Madre
- [ ] SSH hardening: ver `inbox/2026-06-24-ssh-hardening.md`
- [ ] UFW activar: ver `inbox/2026-06-23-auditoria-setup.md`
- [ ] Kernel sysctl: ver `inbox/2026-06-24-kernel-sysctl-hardening.md`

---

## P2 — Esta semana

### Automatización
- [ ] Alias `cierre` → `bash ~/Projects/yggdrasil-dew/setup/servidor/scripts/cierre-sesion.sh`
- [ ] THDORA handler `/estado` → muestra `batcueva-state.sh` output
- [ ] THDORA handler `/inbox <texto>` → crea nota en inbox/
- [ ] THDORA handler `/diario <texto>` → append al diario del día

### IA Local
- [ ] Open WebUI RAG: subir docs yggdrasil-dew y probar queries
- [ ] Crear Modelfile Erika en Ollama
- [ ] LiteLLM config: proxy unificado Ollama + APIs externas
- [ ] n8n: primer workflow — inbox → procesar → repo

### Formación
- [ ] Terminar módulo 05 Python
- [ ] Script Python → query Ollama API local
- [ ] Script Python → reconocimiento red básico con nmap

### SSH
- [ ] SSH sin contraseña Madre → Acer: `ssh-copy-id varo@100.86.119.102`
- [ ] Deshabilitar auth por password en sshd tras configurar clave

---

## P3 — Próximas 2 semanas

### Hardware
- [ ] Adaptador DVI-D → HDMI para tercer monitor (~3-5€)
- [ ] Audio Hyprland: mapear teclas volumen

### OSINT + Pentest
- [ ] SpiderFoot en Madre (:5001)
- [ ] Primer scan: `nmap -sV 10.134.31.0/24`
- [ ] Documentar en `docs/osint/herramientas.md`

### Repos GitHub a crear
- [ ] `ollama-stack` — Docker Ollama+WebUI+Qdrant público
- [ ] `osint-stack` — Docker SpiderFoot+IVRE
- [ ] `dotfiles` — Hyprland + aliases + bashrc

---

## P4 — Futuro

- [ ] Headscale self-hosted (reemplaza Tailscale cloud)
- [ ] Gitea self-hosted
- [ ] Code Server (VSCode en browser)
- [ ] Pi-hole DNS
- [ ] RAM 16GB para varopc (~40-50€)
- [ ] RTX 3060 12GB para Madre (~200-250€ 2ª mano)
- [ ] Migración inbox→repo automatizada con THDORA/n8n

---

## ✅ Completado

| Fecha | Tarea |
|---|---|
| 2026-06-24 | `ESTADO-SISTEMA.md` en raíz — foto viva del sistema |
| 2026-06-24 | `batcueva-state.sh` — script idempotente todas las fases |
| 2026-06-24 | `cierre-sesion.sh` — commit diario automático |
| 2026-06-24 | Stack Fase 1+2 levantado y healthy en Madre |
| 2026-06-24 | Estructura inbox/ con README y subcarpetas definidas |
| 2026-06-24 | docker-compose.yml optimizado — CPU vars + healthchecks |
| 2026-06-24 | batcueva-fase2.yml + fase3.yml + docs completos |
| 2026-06-24 | scripts/ completo: arranque, descarga, configuración |
| 2026-06-23 | ADR homelab vs proyectos, docs-as-code, ollama en agentes |
| 2026-06-23 | Auditorías completas de todas las carpetas |
| 2026-06-22 | Netdata multi-nodo Madre + Acer |
| 2026-06-20 | UFW + fail2ban activos |

---

## Planificación semanal

```
Lunes     → THDORA + Madre (día técnico)
Martes    → Formación Python
Miércoles → THDORA handlers + Python bots
Jueves    → OSINT + pentest + seguridad
Viernes   → LLM + IA local + Ollama
Sábado    → Libre / exploración
Domingo   → Revisión semanal + auditoría inbox
```

---
_Actualizado: 24 jun 2026 02:49 CEST_
_Ver: [ESTADO-SISTEMA.md](ESTADO-SISTEMA.md) · [ROADMAP.md](ROADMAP.md) · [inbox/README.md](inbox/README.md)_
