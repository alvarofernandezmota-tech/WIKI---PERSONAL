---
title: Isla Seguridad
tipo: isla
nombre: Seguridad
descripcion: Mapa conceptual de la estrategia de seguridad del ecosistema
repo_principal: https://github.com/alvarofernandezmota-tech/yggdrasil-secops
github_issues: https://github.com/alvarofernandezmota-tech/yggdrasil-secops/issues
obsidian_link: "[[seguridad]]"
depende_de: [infra]
sirve_a: [thdora, cerebro, ia-local]
estado: activo-con-deuda
author: Alvaro Fernandez Mota
creado: 2026-07-05
actualizado: 2026-07-05
tags: [seguridad, secops, hal, docker]
---

# 🛡️ Isla: Seguridad

Seguridad es la capa que protege todo el ecosistema. No es un servicio único — es un conjunto de capas defensivas que trabajan juntas.

> ⚡ Hallazgos, issues y auditorías → [`yggdrasil-secops`](https://github.com/alvarofernandezmota-tech/yggdrasil-secops)

---

## Capas de defensa

| Capa | Herramienta | Función |
|---|---|---|
| Red | UFW | Deny incoming por defecto, servicios solo Tailscale |
| Red | Tailscale | VPN privada, acceso entre dispositivos |
| Acceso | fail2ban | Bloqueo automático de ataques fuerza bruta |
| Acceso | SSH `PermitRootLogin no` | Root deshabilitado por SSH |
| Contenedores | `yggdrasil_watchdog` | Vigila y reinicia contenedores caídos |
| Contenedores | `guardian_bot` | Alertas Telegram de seguridad |
| Red interna | `network_radar` | Detecta dispositivos no autorizados |
| Logs | `log_guardian_bot` | Analiza logs buscando anomalías |
| Archivos | `local_tripwire` | Detecta cambios en archivos críticos |
| OSINT/Pentest | `spiderfoot` + `kali-pentest` | Herramientas ofensivas para auditoría propia |

---

## Hallazgos activos (HAL)

| ID | Resumen | Severidad | Estado |
|---|---|---|---|
| HAL-001 | Token THDORA en historial git | 🔴🔴 Crítica | Abierto |
| HAL-002 | `log_guardian_bot` unhealthy | 🔴 Alta | Abierto |
| HAL-003 | Rotar token THDORA | 🔴🔴 Crítica | Abierto |
| HAL-004 | `tailscale_monitor` unhealthy | 🔴 Alta | ✅ Cerrado |
| HAL-005 | HDD 28.715h sin backup | 🟡 Media | Abierto |
| HAL-006 | SSH puerto 22 abierto a internet | 🔴 Alta | Abierto |

> Detalle completo → [`yggdrasil-secops/issues`](https://github.com/alvarofernandezmota-tech/yggdrasil-secops/issues)

---

## Próximas acciones

1. **HAL-001/003** — Rotar token THDORA (crítico)
2. **HAL-006** — Restringir SSH a solo Tailscale
3. **HAL-002** — Fix `log_guardian_bot` (mismo patrón que HAL-004)
4. **HAL-005** — Backup HDD antes de que falle

---

_Actualizado: 2026-07-05 23:43 CEST · Perplexity-MCP_
