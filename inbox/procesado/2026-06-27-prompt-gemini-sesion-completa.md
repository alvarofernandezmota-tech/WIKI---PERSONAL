# Prompt Gemini — Sesión 27/06/2026 — Contexto completo ecosistema Batcueva
#prompt #gemini #infra #seguridad #investigación #sesion

**Fecha:** 2026-06-27 04:18 CEST
**Estado:** 🟢 Listo para usar — pegar en Gemini directamente
**Origen:** Sesión nocturna completa — MadreAP, SOC stack, plan seguridad, monitorización

---

> Este fichero es el prompt completo para continuar el trabajo con Gemini.
> Contiene todo el contexto técnico del ecosistema Batcueva para que Gemini
> genere los scripts y código necesarios para ejecutar en Madre en cuanto llegues a casa.

---

## PROMPT COMPLETO (copiar desde aquí)

```
Eres mi asistente de arquitectura e ingeniería de sistemas para el ecosistema "Batcueva".

## CONTEXTO DEL PROYECTO

Tengo un homelab basado en una máquina principal llamada "Madre" (Arch Linux, hardware con GPU).
El repo central de conocimiento y documentación es: https://github.com/alvarofernandezmota-tech/yggdrasil-dew

Repos del ecosistema:
- yggdrasil-dew — Second brain, base de conocimiento, documentación de toda la infra
- thdora — Bot Telegram + FastAPI + Ollama local (asistente personal IA)
- local-brain — Stack Ollama, pgvector, RAG, embeddings, memoria vectorial
- osint-stack — Spiderfoot y herramientas OSINT
- ollama-stack — Modelos LLM locales, Open WebUI, LiteLLM, Qdrant
- ai-toolkit — Claude Code + OpenRouter + n8n, stack dev IA

---

## ESTADO ACTUAL DEL SISTEMA (27/06/2026)

Servicios ya corriendo y healthy en Docker:
- Grafana (3000), Prometheus (9090), Uptime Kuma (3002)
- Qdrant (6333), Ollama (11434), Open WebUI
- THDORA bot + API (8000), Portainer (9000)
- Kali Linux desktop (6901), MadreAP WiFi (resuelto 27-jun)

Lo que YA está documentado y listo para ejecutar:
- PLAN-SEGURIDAD-Y-DESPLIEGUE.md — checklist maestro 9 fases
- inbox/2026-06-27-monitoring-pentest-research.md — SOC stack por 7 capas
- inbox/2026-06-25-auditoria-infraestructura-engineering-excellence.md — 4 pilares críticos
- setup/servidor/ufw-reglas-completas.sh — script UFW
- setup/servidor/fase1b-seguridad.md — SSH hardening

Lo que FALTA (por orden de prioridad):

1. FASE 1 — Seguridad de red (BLOQUEANTE)
   - SSH hardening (PasswordAuthentication no, fail2ban, puerto no estándar)
   - UFW activado con reglas reales
   - Tailscale autoarranque (systemctl enable tailscaled)
   - Deshabilitar suspensión del host
   - Reboot de verificación final

2. FASE 2 — Script levantamiento seguro (start-batcueva.sh)
   - Valida UFW activo, Tailscale activo, MadreAP activo antes de levantar Docker

3. FASE 3 — Backup Restic (regla 3-2-1, destino Cloudflare R2 o Backblaze B2)

4. FASE 4 — Monitorización completa
   - Dashboards Grafana: CPU, RAM, temperatura, latencia Ollama, métricas Docker
   - Uptime Kuma → webhook → THDORA API → Telegram
   - Wazuh SIEM (requiere vm.max_map_count=262144)

5. FASE 5 — Seguridad avanzada
   - Mozilla SOPS para secrets
   - Rootless Docker
   - VLANs: pentest / servicios / doméstica

6. FASE 6 — Handlers THDORA: /estado, /inbox, /diario, /pull, webhook uptime

7. FASE 7 — Modelos Ollama y RAG: llama3.1:8b, bge-m3, nomic-embed-text, Modelfile Erika

8. FASE 9 — Pentest y OSINT real: Nmap desde Kali, SpiderFoot, Bettercap, DefectDojo

---

## STACK TÉCNICO

SO Madre: Arch Linux
Acceso remoto: Tailscale (IP: 100.91.112.32)
Gestión contenedores: Docker + Portainer
IaC futuro: Ansible Playbooks
CI/CD: GitHub Actions + yamllint + hadolint
Secrets futuro: Mozilla SOPS / HashiCorp Vault
Monitorización: Prometheus + Grafana + Uptime Kuma + Wazuh
IDS/IPS: Suricata + Zeek (pendiente)
Bot/API personal: THDORA (Telegram + FastAPI + Ollama)
Red: hostapd AP, Tailscale VPN mesh zero-trust
Backup: Restic con destino remoto (pendiente)

---

## LO QUE NECESITO

Tarea 1 — Script instalación dependencias (Arch Linux, pacman/yay):
fail2ban, ufw, suricata, zeek, restic, sops, age, nmap, net-tools, arp-scan,
htop, btop, iotop, nvtop, lm_sensors, smartmontools, tcpdump, tshark

Tarea 2 — Script UFW completo para el stack:
SSH personalizado, Tailscale 41641/udp, Grafana 3000, Uptime Kuma 3002,
Ollama 11434, THDORA 8000, Qdrant 6333, Portainer 9000, Kali VNC 6901.
Solo red local + Tailscale. Nada expuesto al exterior.

Tarea 3 — Script SSH hardening Arch Linux:
Deshabilitar password auth, cambiar puerto, fail2ban SSH, límite intentos, ban temporal.

Tarea 4 — Dashboards Grafana como JSON para importar:
- Sistema Madre (CPU, RAM, disco, temperatura, procesos)
- Docker/contenedores (cAdvisor)
- Ollama/LLM (latencia, tokens/s)
- Red y seguridad (conexiones, intentos SSH, alertas Wazuh)

Tarea 5 — Webhook THDORA para Uptime Kuma:
Endpoint Python FastAPI /webhook/uptime que recibe alertas y las manda a Telegram.

Tarea 6 — Suricata IDS pasivo en Arch Linux con Docker:
Modo pasivo, reglas Emerging Threats gratuitas, integración logs con Wazuh.

Tarea 7 — Plan VLANs para el homelab:
VLAN doméstica, VLAN servicios, VLAN pentest, VLAN gestión.
Configuración macvlan en Docker.

---

## RESTRICCIONES

- Todo para Arch Linux (no Ubuntu/Debian)
- Scripts idempotentes (se pueden ejecutar varias veces sin romper)
- Verificaciones antes de cada paso con mensajes claros
- Secrets NUNCA en git
- Orden de ejecución importa: Fase 1 completa antes de continuar

## FORMATO

Para cada tarea:
1. Código completo listo para ejecutar
2. Cómo verificar que funcionó
3. Qué puede salir mal y cómo solucionarlo
4. Comando para subir al repo yggdrasil-dew

Empieza por Tarea 1 y Tarea 2 (más urgentes para Fase 1).
```

---

## Ficheros de referencia en la repo

- [`PLAN-SEGURIDAD-Y-DESPLIEGUE.md`](../PLAN-SEGURIDAD-Y-DESPLIEGUE.md)
- [`inbox/2026-06-27-monitoring-pentest-research.md`](./2026-06-27-monitoring-pentest-research.md)
- [`inbox/2026-06-25-auditoria-infraestructura-engineering-excellence.md`](./2026-06-25-auditoria-infraestructura-engineering-excellence.md)
- [`MASTER-PENDIENTES.md`](../MASTER-PENDIENTES.md)
- [`ROADMAP.md`](../ROADMAP.md)

---

## Resumen de la sesión 27-jun 03:00–04:18 CEST

1. Problema MadreAP WiFi → resuelto completamente (hostapd + systemd-networkd + UFW)
2. Inbox migrada a docs/ y diarios/
3. Documentación repo actualizada (ESTADO-SISTEMA, ADR-004, red-madre-ap.md)
4. Plan de acción ordenado: primero seguridad red, luego scripts, luego monitorización, luego Docker
5. Investigación SOC homelab stack (7 capas) documentada en inbox
6. Prompt Gemini generado con contexto completo técnico
7. Este fichero subido como referencia permanente de la sesión

---

*Sesión: 2026-06-27 03:00–04:18 CEST — Batcueva homelab*
*Próxima sesión: en casa → ejecutar scripts Gemini en Madre*
