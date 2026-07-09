---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-09
actualizado: 2026-07-10
ruta: wiki/islas/madre.md
tags: [isla, madre, infra, docker, servidor, homelab]
status: vigente
repo_principal: madre-config
---

# Isla: Madre

> Servidor HP Ubuntu — núcleo físico del ecosistema Yggdrasil.
> Todo el stack Docker corre aquí. Acceso remoto vía Tailscale.

---

## Identidad del servidor

| Campo | Valor |
|-------|-------|
| Hostname | `varpc` |
| Usuario | `varopc` |
| OS | Ubuntu Server |
| Cifrado | LUKS + Btrfs |
| GPU | GTX 1060 (Ollama) |
| Red local | WiFi `wlan0` 192.168.x.x |
| VPN | Tailscale |
| SSH | Puerto 22, solo clave pública |
| Acceso móvil | Blink Shell / Shellfish (iPhone) |

---

## Stack Docker — 16 servicios

| Categoría | Servicio | Puerto | Estado |
|-----------|----------|--------|--------|
| 🤖 IA local | Ollama | 11434 | ▶ running |
| 🤖 IA local | Open WebUI | — | ▶ running |
| 🤖 IA local | Qdrant | 6333 | ▶ running |
| 🔧 Dev | THDORA API | 8000 | ✅ healthy |
| 🔧 Dev | THDORA Bot | — | ✅ healthy |
| 🔧 Dev | Code-server | 8443 | ▶ running |
| 🔧 Dev | Gitea | 3003 | ▶ running |
| 🔧 Dev | n8n | 5678 | ▶ running |
| 📊 Monitoring | Grafana | 3000 | ▶ running |
| 📊 Monitoring | Prometheus | 9090 | ▶ running |
| 📊 Monitoring | Uptime Kuma | 3002 | ✅ healthy |
| 📊 Monitoring | Portainer | 9000 | ▶ running |
| 🔐 SecOps | SpiderFoot | 5001 | ▶ running |
| 🔐 SecOps | Kali VNC | 6901 | ▶ running |
| 🔐 SecOps | Network Radar | — | ✅ healthy |
| 🔐 SecOps | Guardian Bot | — | ✅ healthy |

---

## ⚠️ Issues críticos abiertos

| Issue | Descripción | Prioridad |
|-------|-------------|----------|
| [#31](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/31) | HDD 28.000h — riesgo fallo | 🔴 CRÍTICO |
| [#34](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/34) | docker-compose.yml raíz sin documentar | 🔴 URGENTE |
| [#32](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/32) | Watchdog Docker — revisar logs | 🟡 ALTA |
| [#15](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/15) | Puerto 21 FTP abierto | 🔴 CRÍTICO |

---

## Pendiente crítico — IaC sin versionar

Los 16 servicios Docker corren en Madre pero **los docker-compose no están en `madre-config`**.
Si el servidor muere, todo el stack se pierde.

→ Issue pendiente de crear en DEW: `[INFRA] Versionar docker-compose de todos los servicios de Madre`

---

## Links

→ [madre-config repo](https://github.com/alvarofernandezmota-tech/madre-config)
→ [Issues Madre en DEW](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues?q=INFRA)

_Actualizado: 2026-07-10 · Perplexity-MCP_
