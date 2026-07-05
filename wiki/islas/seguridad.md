---
tipo: isla
nombre: Seguridad
descripcion: Defensa del ecosistema propio y capacidades OSINT/red-team
repo_principal: https://github.com/alvarofernandezmota-tech/yggdrasil-secops
github_issues: https://github.com/alvarofernandezmota-tech/yggdrasil-secops/issues
obsidian_link: "[[seguridad]]"
depende_de: [infra]
sirve_a: [cerebro]
estado: estable
author: Alvaro Fernandez Mota
creado: 2026-07-05
actualizado: 2026-07-05
---

# 🛡️ Isla: Seguridad

Dos capas diferenciadas: **defensiva** (proteger el ecosistema) y **ofensiva/investigadora** (OSINT, pentesting, red team).

> ⚡ Hallazgos y procedimientos técnicos → [`yggdrasil-secops`](https://github.com/alvarofernandezmota-tech/yggdrasil-secops)

---

## Repos

| Repo | Capa | Propósito | URL |
|---|---|---|---|
| `yggdrasil-secops` | Defensiva | Hallazgos HAL-XXX, remediaciones, blue team | https://github.com/alvarofernandezmota-tech/yggdrasil-secops |
| `osint-stack` | Ofensiva | Spiderfoot, OSINT, pentesting, red team | https://github.com/alvarofernandezmota-tech/osint-stack |

---

## Hallazgos activos

| ID | Descripción | Severidad | Estado |
|---|---|---|---|
| [HAL-001](https://github.com/alvarofernandezmota-tech/yggdrasil-secops) | Puerto 21 FTP abierto en router Digi | 🔴 Alta | ⚠️ Pendiente remediación |

---

## Estado hardening Madre

- ✅ SSH solo desde Tailscale
- ✅ UFW deny incoming
- ✅ fail2ban activo
- ⚠️ `PermitRootLogin no` → pendiente
- ⚠️ Wazuh SIEM → pendiente
- ⚠️ Suricata IDS → pendiente

---

## Conexiones

- ← [[infra]] (defiende los servidores del ecosistema)
- → [[cerebro]] (hallazgos registrados en yggdrasil-secops + dew)

---
_Actualizado: 2026-07-05 21:00 CEST · Perplexity-MCP_
