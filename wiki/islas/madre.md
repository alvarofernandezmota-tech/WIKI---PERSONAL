# 🖥️ Madre

> Servidor 24/7 en casa. Núcleo físico del ecosistema Yggdrasil. Toda la infraestructura productiva corre aquí.

| Campo | Valor |
|---|---|
| **Repo principal** | [`madre-config`](https://github.com/alvarofernandezmota-tech/madre-config) |
| **Máquina** | Torre de sobremesa · Madrid |
| **OS** | Arch Linux (Omarchy) |
| **IP Tailscale** | `100.91.112.32` |
| **Estado operativo** | ✅ Online · 24/7 |
| **Última auditoría** | 2026-07-16 |
| **Issues abiertas** | 2 críticas en DEW |

---

## 📌 Qué es

Madre es el servidor principal del ecosistema. Corre Docker con más de 20 servicios productivos (Batcueva), la GPU GTX 1060 6GB que alimenta Ollama, y actúa como hub de red con Tailscale, Pi-hole y hostapd WiFi. Todo lo que es infraestructura de producción vive aquí.

---

## 🛠️ Stack y servicios Docker (Batcueva)

| Servicio | Estado | Notas |
|---|---|---|
| Portainer | ✅ Activo | Gestión Docker |
| Grafana + Prometheus + Alertmanager | ✅ Activo | Monitorización |
| Ollama + Open WebUI | ✅ Activo | IA local · GTX 1060 6GB |
| Nextcloud | ✅ Activo | Almacenamiento privado |
| Vaultwarden | ✅ Activo | Gestor contraseñas |
| Nginx + Let’s Encrypt | ✅ Activo | Reverse proxy |
| Pi-hole + Unbound DoT | ✅ Activo | DNS + filtrado |
| hostapd WiFi AP | ✅ Activo | r8852be |
| nftables firewall | ✅ Activo | Reglas activas |
| Wazuh SIEM | 🟡 En progreso | Fase 3 |
| Suricata IDS | 🟡 En progreso | Fase 4 |
| Fail2ban | 🔴 Pendiente | No instalado |

```
Red:
  Tailscale (WireGuard mesh)     — activo
  VLANs / macvlan para OSINT     — en progreso
  SSH: ed25519 only              — hardening parcial
  FTP puerto 21 router Digi      — 🔴 EXPUESTO — p0
```

---

## 📊 Estado actual

| Servicio | Estado | Última verificación |
|---|---|---|
| Online / SSH | ✅ | 2026-07-16 |
| Docker stack | ✅ | 2026-07-16 |
| Tailscale | ✅ | 2026-07-16 |
| SSH `PasswordAuthentication no` | 🔴 Pendiente | — |
| FTP puerto 21 router | 🔴 EXPUESTO | 2026-07-16 |

**Alertas activas:**
- 🔴 FTP puerto 21 expuesto en router Digi `http://192.168.1.1` — ver [DEW #issue-ftp](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues)
- 🔴 SSH `PasswordAuthentication no` pendiente — Fase 2

---

## 🗺️ Relaciones con el ecosistema

```
Madre
  ├── aloja → ollama-stack (IA local)
  ├── aloja → local-brain (RAG)
  ├── aloja → THDORA-PERSONAL (bot)
  ├── monitoriza → Grafana/Prometheus
  ├── protege → Wazuh SIEM + Suricata
  └── accede desde → Acer/iPhone via Tailscale
```

---

## 🔗 DEW — Issues y decisiones

### Issues activas

| Issue | Título | Prioridad |
|---|---|---|
| [#44](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/44) | HAL-007: THDORA `.env` malformado (corre en Madre) | 🔴 Crítico |
| [#45](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/45) | HAL-008: Token Telegram revocado (THDORA en Madre) | 🔴 Crítico |

### Historial de incidentes

| HAL | Descripción | Estado |
|---|---|---|
| HAL-007 | THDORA caída — `.env` malformado | 🔴 Abierto |
| HAL-008 | Token Telegram revocado | 🔴 Abierto |

### ADRs relevantes

| ADR | Decisión | Estado |
|---|---|---|
| — | Arch Linux Omarchy como OS base | ✅ Vigente |
| — | Docker para todos los servicios productivos | ✅ Vigente |
| — | Tailscale como red privada del ecosistema | ✅ Vigente |

---

## 📝 Decisiones pendientes

- [ ] Desactivar FTP puerto 21 en router Digi — **PRIORIDAD MÁXIMA**
- [ ] SSH: `PasswordAuthentication no` — Fase 2
- [ ] Instalar Fail2ban
- [ ] Completar VLANs / macvlan para OSINT

---

_Actualizado: 2026-07-16 · Perplexity-MCP_
