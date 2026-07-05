---
tipo: isla
isla: seguridad
repos: [yggdrasil-secops, osint-stack]
actualizado: 2026-07-05 15:03 CEST
tags: [seguridad, secops, osint, pentest, blue-team, red-team]
---

# 🛡️ Isla: Seguridad

> Dos capas distintas y complementarias:
> **Defensiva** — proteger el ecosistema propio.
> **Ofensiva/Investigadora** — atacar y descubrir.

---

## Repos

### [`yggdrasil-secops`](https://github.com/alvarofernandezmota-tech/yggdrasil-secops) 🔒 Privado — DEFENSIVO
Seguridad del ecosistema Yggdrasil:
- `hallazgos/` — vulnerabilidades encontradas (formato HAL-XXX)
- `blue_team/` — bastionado, hardening, monitoreo
- `red_team/` — ejercicios ofensivos sobre infra propia
- `osint/` — auto-OSINT del perfil público
- **HAL-001** — FTP puerto 21 abierto (pendiente remediar)

### [`osint-stack`](https://github.com/alvarofernandezmota-tech/osint-stack) 🔒 Privado — OFENSIVO
Herramientas de investigación y reconocimiento:
- **Spiderfoot** — OSINT automático
- Pipelines de reconocimiento de objetivos
- Automatización de recon pasivo/activo

---

## Hallazgos activos

| ID | Descripción | Severidad | Estado |
|---|---|---|---|
| HAL-001 | FTP puerto 21 abierto en router | Alta | 🔴 Pendiente |

---

## Herramientas
- **Spiderfoot** — OSINT automatizado
- **Nmap** — escaneo de puertos
- **Wazuh** — SIEM (planificado)
- **UFW** — firewall en Madre
- **Fail2ban** — protección SSH
- **Canary tokens** — tripwires

---

← [HOME](../../HOME.md)
