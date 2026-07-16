# 🛡️ Seguridad

> Capa defensiva y ofensiva del ecosistema: SIEM, IDS, OSINT y hardening.

| Campo | Valor |
|---|---|
| **Repos principales** | [`yggdrasil-secops`](https://github.com/alvarofernandezmota-tech/yggdrasil-secops) · [`osint-stack`](https://github.com/alvarofernandezmota-tech/osint-stack) |
| **Máquina** | Madre (SIEM/IDS) · Acer (OSINT) |
| **Estado operativo** | 🟡 En progreso · vulnerabilidades activas |
| **Última auditoría** | 2026-07-16 |

---

## 📌 Qué es

Isla que cubre toda la postura de seguridad del ecosistema: seguridad defensiva (Wazuh SIEM, Suricata IDS, nftables, hardening SSH) en `yggdrasil-secops`, y seguridad ofensiva/OSINT en `osint-stack`. Los hallazgos de incidentes se documentan como HAL-XXX en el DEW.

---

## 🛠️ Stack de seguridad

| Herramienta | Estado | Notas |
|---|---|---|
| nftables firewall | ✅ Activo | Reglas en Madre |
| Wazuh SIEM | 🟡 En progreso | Fase 3 — agentes pendientes |
| Suricata IDS | 🟡 En progreso | Fase 4 |
| Fail2ban | 🔴 Pendiente | No instalado |
| SSH hardening | 🟡 Parcial | Falta `PasswordAuthentication no` |
| FTP router | 🔴 EXPUESTO | Puerto 21 — p0 CRÍTICO |

---

## 📊 Estado actual

| Área | Estado | Última verificación |
|---|---|---|
| Firewall nftables | ✅ | 2026-07-16 |
| Wazuh agentes | 🟡 Parcial | 2026-07-16 |
| FTP puerto 21 | 🔴 EXPUESTO | 2026-07-16 |
| SSH passwords off | 🔴 Pendiente | — |

**Alerta activa p0:**
- 🔴 **FTP puerto 21** expuesto en router Digi — desactivar en `http://192.168.1.1` — VER [DEW hallazgos FTP](https://github.com/alvarofernandezmota-tech/yggdrasil-dew)

---

## 🗺️ Relaciones con el ecosistema

```
Seguridad
  ├── protege → Madre + toda la red
  ├── monitoriza → Grafana (métricas seguridad)
  ├── audita → todos los repos (SAST)
  └── OSINT en → Acer/Thdora
```

---

## 🔗 DEW — Issues y decisiones

### Historial de incidentes

| HAL | Descripción | Estado |
|---|---|---|
| HAL-007 | THDORA caída — `.env` malformado | 🔴 Abierto |
| HAL-008 | Token Telegram revocado | 🔴 Abierto |

### ADRs relevantes

| ADR | Decisión | Estado |
|---|---|---|
| — | SSH ed25519 only, sin contraseñas | ⏳ Parcial |
| — | Wazuh como SIEM principal | ✅ Vigente |
| — | Suricata como IDS | ✅ Vigente |

---

## 📝 Decisiones pendientes

- [ ] **P0: Desactivar FTP puerto 21 router Digi** — inmediato
- [ ] SSH `PasswordAuthentication no` en Madre y Acer
- [ ] Instalar Fail2ban
- [ ] Completar agentes Wazuh — Fase 3
- [ ] Completar Suricata — Fase 4

---

_Actualizado: 2026-07-16 · Perplexity-MCP_
