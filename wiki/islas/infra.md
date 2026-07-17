---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-13
actualizado: 2026-07-18
ruta: wiki/islas/infra.md
tags: [infra, madre, docker, tailscale, batcueva, acer, servidores, red]
status: auditado
repos: [madre-config, acer-config]
---

# 🖥️ Infraestructura — Madre + Acer

> Hardware y servicios del ecosistema. Madre es el núcleo 24/7. Acer es la estación de trabajo.

| Campo | Valor |
|---|---|
| **Repos** | [`madre-config`](https://github.com/alvarofernandezmota-tech/madre-config) · [`acer-config`](https://github.com/alvarofernandezmota-tech/acer-config) |
| **Estado operativo** | ✅ Online 24/7 (Madre) · ✅ Activo (Acer) |
| **Última auditoría** | 2026-07-18 |

---

## 🖥️ Madre — Servidor principal

> Torre de sobremesa · Madrid · Arch Linux (Omarchy) · IP Tailscale `100.91.112.32`

Madre es el servidor principal del ecosistema. Corre Docker con más de 20 servicios productivos (Batcueva), la GPU GTX 1060 6GB que alimenta Ollama, y actúa como hub de red con Tailscale, Pi-hole y hostapd WiFi.

### Batcueva — Stack Docker completo

| Servicio | Estado | Notas |
|---|---|---|
| Portainer | ✅ Activo | Gestión Docker |
| Grafana + Prometheus + Alertmanager | ✅ Activo | Monitorización |
| Ollama + Open WebUI | ✅ Activo | IA local · GTX 1060 6GB |
| Nextcloud | ✅ Activo | Almacenamiento privado |
| Vaultwarden | ✅ Activo | Gestor contraseñas |
| Nginx + Let's Encrypt | ✅ Activo | Reverse proxy |
| Pi-hole + Unbound DoT | ✅ Activo | DNS + filtrado |
| hostapd WiFi AP | ✅ Activo | r8852be |
| nftables firewall | ✅ Activo | Reglas activas |
| Wazuh SIEM | 🟡 En progreso | Fase 3 |
| Suricata IDS | 🟡 En progreso | Fase 4 |
| Fail2ban | 🔴 Pendiente | No instalado |
| yggdrasil-mcp | 🔴 Caído | Puerto 3000 — issue #75 |
| THDORA (thdora-bot + thdora-api) | 🔴 Caído | Token caducado — issue #74 |
| Qdrant | 🟡 Falso positivo | Healthcheck — issue #71 |

### Red Madre

```
Tailscale (WireGuard mesh)     — activo
Pi-hole DNS                    — activo
hostapd WiFi AP                — activo
VLANs / macvlan para OSINT     — en progreso
SSH: ed25519 only              — hardening parcial
FTP puerto 21 router Digi      — 🔴 EXPUESTO — P0
```

### Estado Madre — 2026-07-18

| Servicio | Estado | Última verificación |
|---|---|---|
| Online / SSH | ✅ | 2026-07-16 |
| Docker stack | ✅ | 2026-07-16 |
| Tailscale | ✅ | 2026-07-16 |
| SSH `PasswordAuthentication no` | 🔴 Pendiente | — |
| FTP puerto 21 router | 🔴 EXPUESTO | 2026-07-16 |
| Hardware CPU/Placa | 🟡 Sin documentar | F20 — dmidecode pendiente |
| HDD | ⚠️ 28.000+ horas | S.M.A.R.T. — DEW #31 urgente |

---

## 💻 Acer — Estación de trabajo

> Arch Linux + Hyprland · IP Tailscale `100.86.119.102`

Estación de trabajo diaria. Entorno Hyprland con dotfiles en `acer-config`. Accede a todos los servicios de Madre via Tailscale.

| Aspecto | Estado |
|---|---|
| OS | Arch Linux + Hyprland |
| Tailscale | ✅ Conectado |
| dotfiles | `acer-config` |
| SSH a Madre | ✅ Funcional |

---

## 🗺️ Relaciones con el ecosistema

```
Infra
  ├── Madre aloja      → todos los servicios Docker (Batcueva)
  ├── Madre aloja      → IA Local (Ollama + local-brain)
  ├── Madre aloja      → Agentes (THDORA)
  ├── Madre monitoriza → Grafana/Prometheus
  ├── Madre protege    → Wazuh + Suricata + nftables
  ├── Acer accede a    → Madre via Tailscale
  └── iPhone accede a  → Madre via Tailscale
```

---

## 🔗 DEW — Issues activos

| Issue | Título | Prioridad |
|---|---|---|
| [#75](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/75) | yggdrasil-mcp caído (puerto 3000) | 🔴 Crítico |
| [#74](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/74) | Token THDORA caducado | 🔴 Crítico |
| [#71](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/71) | Qdrant healthcheck (falso positivo) | 🟡 Verificar |
| [#31](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/31) | HDD 28k+ horas — riesgo fallo | ⚠️ Hardware |
| [#15](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/15) | Puerto 21 FTP router | 🔴 Crítico |

### ADRs relevantes

| ADR | Decisión | Estado |
|---|---|---|
| — | Arch Linux Omarchy como OS base | ✅ Vigente |
| — | Docker para todos los servicios productivos | ✅ Vigente |
| — | Tailscale como red privada del ecosistema | ✅ Vigente |

---

## 📝 Decisiones pendientes

- [ ] **P0:** Desactivar FTP puerto 21 router Digi (terminal)
- [ ] SSH `PasswordAuthentication no` en Madre y Acer (terminal)
- [ ] dmidecode — documentar CPU y placa (F20, terminal)
- [ ] S.M.A.R.T. HDD 28k+ horas — planificar sustitución — #31
- [ ] Instalar Fail2ban
- [ ] VLANs / macvlan para OSINT
- [ ] Loki + Promtail para logs (F7)

---

> ⚠️ **Fusionada 2026-07-18** — originalmente dos islas: `infra.md` + `madre.md`. Madre integrada como sección principal de infra.

_Actualizado: 2026-07-18 · Perplexity-MCP · F21 fusión_
