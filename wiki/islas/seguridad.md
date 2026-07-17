---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-13
actualizado: 2026-07-18
ruta: wiki/islas/seguridad.md
tags: [seguridad, osint, siem, ids, hardening, wazuh, suricata, spiderfoot]
status: auditado
repos: [yggdrasil-secops, osint-stack]
---

# 🛡️ Seguridad y OSINT

> Capa defensiva, ofensiva e investigativa del ecosistema.
> Cubre SIEM, IDS, hardening, y reconocimiento OSINT.

| Campo | Valor |
|---|---|
| **Repos** | [`yggdrasil-secops`](https://github.com/alvarofernandezmota-tech/yggdrasil-secops) · [`osint-stack`](https://github.com/alvarofernandezmota-tech/osint-stack) |
| **Máquina** | Madre (SIEM/IDS) · Acer (OSINT) |
| **Estado operativo** | 🔴 Vulnerabilidades activas — ver alertas |
| **Última auditoría** | 2026-07-18 |

---

## 📌 Qué es

Dos capas de seguridad unificadas en esta isla:

- **Blue team / defensiva** (`yggdrasil-secops`) — Wazuh SIEM, Suricata IDS, nftables firewall, hardening SSH. Incidentes documentados como HAL-XXX en DEW.
- **OSINT / ofensiva-investigativa** (`osint-stack`) — Spiderfoot para reconocimiento automatizado, pipelines de investigación (self-OSINT, targets externos), herramientas CLI. Corre en Docker en Madre/Acer.

---

## 🛠️ Stack defensivo

| Herramienta | Estado | Notas |
|---|---|---|
| nftables firewall | ✅ Activo | Reglas en Madre |
| Wazuh SIEM | 🟡 En progreso | Fase 3 — agentes pendientes |
| Suricata IDS | 🟡 En progreso | Fase 4 |
| Fail2ban | 🔴 Pendiente | No instalado |
| SSH hardening | 🟡 Parcial | Falta `PasswordAuthentication no` |
| FTP router Digi | 🔴 EXPUESTO | Puerto 21 — **P0 CRÍTICO** |

## 🔭 Stack OSINT

| Herramienta | Estado | Notas |
|---|---|---|
| Spiderfoot | 🟡 Sin verificar | Docker en Madre |
| Pipelines OSINT | 🟡 Sin documentar | Pendiente auditoría |
| Integración secops | 🟡 Sin verificar | Cross-análisis IA |

> ⚠️ Verificar que Spiderfoot NO está expuesto a internet sin auth.
> Verificar que resultados de escaneos NO están en el repo (datos sensibles).

---

## 🔴 Alertas activas

| Alerta | Descripción | Acción |
|---|---|---|
| **P0** | FTP puerto 21 expuesto en router Digi | `http://192.168.1.1` → desactivar — DEW [#15](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/15) |
| **P1** | SSH `PasswordAuthentication no` pendiente | Fix en Madre y Acer |

---

## 📊 Estado actual

| Área | Estado | Última verificación |
|---|---|---|
| Firewall nftables | ✅ | 2026-07-16 |
| Wazuh agentes | 🟡 Parcial | 2026-07-16 |
| FTP puerto 21 | 🔴 EXPUESTO | 2026-07-16 |
| SSH passwords off | 🔴 Pendiente | — |
| Spiderfoot | 🟡 Sin verificar | — |

---

## 🗺️ Relaciones con el ecosistema

```
Seguridad
  ├── protege    → Madre + red completa
  ├── monitoriza → Grafana (métricas seguridad)
  ├── audita     → todos los repos (gitleaks CI)
  ├── OSINT      → Acer/Madre (Spiderfoot)
  └── cruza con  → investigacion-ia (análisis IA sobre datos OSINT)
```

---

## 🔗 DEW — Issues e incidentes

| Issue/HAL | Descripción | Estado |
|---|---|---|
| [#15](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/15) | Puerto 21 FTP router | 🔴 Crítico |
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

- [ ] **P0: Desactivar FTP puerto 21 router Digi** — inmediato (terminal)
- [ ] SSH `PasswordAuthentication no` en Madre y Acer (terminal)
- [ ] Instalar Fail2ban (terminal)
- [ ] Completar agentes Wazuh — Fase 3 (terminal)
- [ ] Completar Suricata — Fase 4 (terminal)
- [ ] Auditar Spiderfoot: auth, resultados no en repo, pipelines (terminal)
- [ ] Crear issue auditoría OSINT en DEW

---

> ⚠️ **Fusionada 2026-07-18** — originalmente dos islas: `seguridad.md` + `osint.md`. OSINT integrado como sección.

_Actualizado: 2026-07-18 · Perplexity-MCP · F21 fusión_
