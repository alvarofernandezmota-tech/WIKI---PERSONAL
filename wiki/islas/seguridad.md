---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-10
actualizado: 2026-07-13
ruta: wiki/islas/seguridad.md
tags: [isla, seguridad, secops, blue-team, pentest, wazuh, suricata]
status: auditada
repo_principal: yggdrasil-secops
---

# Isla: Seguridad (SecOps)

> Capa de seguridad defensiva y ofensiva del ecosistema.
> Blue team activo en Madre. Repo privado: `yggdrasil-secops`.

---

## Stack de seguridad

### 🟦 Blue team (defensivo) — en Madre

| Servicio | Docker | Estado | Propósito |
|---------|--------|--------|----------|
| `log_guardian_bot` | ✅ | 🔴 Crash loop | Alertas de seguridad vía Telegram |
| `local_tripwire` | ✅ | 🔴 Crash loop | Detector de cambios en el sistema |
| `yggdrasil_watchdog` | ✅ | 🟡 Sin verificar | Watchdog general del ecosistema |
| `network-radar` | ✅ | ⚪ Sin verificar | Monitor de red local |
| SpiderFoot | ✅ | ⚪ Sin verificar | OSINT automatizado |
| Wazuh | ❌ | 🔴 Pendiente | SIEM principal |
| Suricata IDS | ❌ | 🔴 Pendiente | Detección de intrusos en red |

### 🟥 Red team (ofensivo) — en Madre

| Servicio | Docker | Estado | Propósito |
|---------|--------|--------|----------|
| Kali VNC | ✅ | ⚪ Sin verificar | Entorno pentest |

---

## Repo `yggdrasil-secops`

| Campo | Valor |
|-------|-------|
| Repo | [`yggdrasil-secops`](https://github.com/alvarofernandezmota-tech/yggdrasil-secops) |
| Visibilidad | 🔒 Privado (desde 2026-07-09) |
| Estado | 🟡 Pendiente auditoría Fase 1 |
| Hallazgo | `docs/hallazgos/SEC-001-ref.md` apunta a ruta inexistente |
| Colisión | HAL-001 existe en DEW Y en secops con distinto significado |

---

## Hallazgos de seguridad abiertos

| Hallazgo | Descripción | Issue DEW |
|---------|-------------|----------|
| Puerto 21 FTP abierto | FTP en texto plano expuesto en router | [#15](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/15) 🔴 |
| Secretos expuestos en chat | Token Telegram + claves en sesión 2026-07-10 | [#45](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/45) 🔴 |
| log_guardian + tripwire caídos | Blue team sin monitorización activa | [#46](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/46) 🔴 |

---

## Issues DEW relacionados

- [DEW #15 — Puerto 21 FTP cerrar](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/15)
- [DEW #19 — Levantar Wazuh + Suricata + Pihole](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/19)
- [DEW #37 — AUDIT-004 secops Fase 1](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/37)
- [DEW #45 — HAL-008 secretos expuestos](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/45)
- [DEW #46 — HAL-009 crash loop blue team](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/46)

---

_Actualizado: 2026-07-13 · Perplexity-MCP_
