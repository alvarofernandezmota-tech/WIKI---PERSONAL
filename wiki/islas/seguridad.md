---
tipo: isla
nombre: Seguridad
descripcion: Defensa del ecosistema propio y capacidades OSINT/red-team
repo_principal: https://github.com/alvarofernandezmota-tech/yggdrasil-secops
github_issues: https://github.com/alvarofernandezmota-tech/yggdrasil-secops/issues
obsidian_link: "[[seguridad]]"
depende_de: [infra]
sirve_a: [cerebro]
estado: activo
---

# 🛡️ Isla: Seguridad

Dos capas diferenciadas: **defensiva** (proteger el ecosistema) y **ofensiva/investigadora** (OSINT, pentesting, red team).

## Repos

| Repo | Capa | Propósito | URL |
|---|---|---|---|
| `yggdrasil-secops` | Defensiva | Hallazgos HAL-XXX, remediaciones, blue team | https://github.com/alvarofernandezmota-tech/yggdrasil-secops |
| `osint-stack` | Ofensiva | Spiderfoot, OSINT, pentesting, red team | https://github.com/alvarofernandezmota-tech/osint-stack |

## Hallazgos activos

| ID | Descripción | Severidad | Estado |
|---|---|---|---|
| HAL-001 | Puerto 21 FTP abierto en router | 🔴 Alta | Pendiente remediación |

```bash
# Verificar HAL-001
nmap -p 21 $(curl -s ifconfig.me)
# Si devuelve open → remediación urgente
```

## Hardening aplicado en Madre

- ✅ SSH solo desde Tailscale (`100.86.119.102`)
- ✅ UFW deny incoming
- ✅ fail2ban activo (SSH jail)
- ✅ smartd activo (HDD salud)
- ⚠️ `PermitRootLogin no` → pendiente
- ⚠️ Wazuh SIEM → pendiente
- ⚠️ Suricata IDS → pendiente

## Conexiones

- ← [[infra]] (defiende los servidores del ecosistema)
- → [[cerebro]] (hallazgos se registran en yggdrasil-secops + dew)

## Docs clave

- `yggdrasil-secops/hallazgos/HAL-001-ftp-puerto21.md`
- `yggdrasil-secops/blue_team/` → configuraciones defensivas
- `yggdrasil-secops/red_team/` → herramientas y procedimientos ofensivos

---
_Actualizado: 2026-07-05 · Perplexity-MCP_
