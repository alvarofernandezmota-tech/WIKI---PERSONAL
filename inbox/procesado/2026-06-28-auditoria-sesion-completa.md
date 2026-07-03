---
tags: [inbox, auditoria, sesion, plan, osint, pentest, docker, fases, fase1, seguridad]
fecha: 2026-06-28
hora: 23:11
estado: procesado
---

# 📥 Auditoría sesión completa — 28 jun 2026

> Documentado por Perplexity vía MCP durante sesión nocturna 22:30–23:11 CEST
> Para procesar: mover contenido relevante a `docs/` o `diarios/`

---

## ✅ Completado esta sesión

### Bloque nocturno tardío 23:00–23:11 — **FASE 1 COMPLETADA EN MADRE** 🎉

- **git pull --rebase** en Madre — 16 archivos sincronizados, 33 objetos ✅
- **fail2ban sshd** activo en Madre — `maxretry:5` `bantime:86400` ✅
- **SSH hardening** — `PasswordAuthentication no` · `PubkeyAuthentication yes` ✅
- **UFW completo** — deny incoming · allow outgoing · 15 puertos LAN + Tailscale `100.64.0.0/10` ✅
- **tailscaled** habilitado para autoarranque ✅
- **Suspensión enmascarada** — `sleep.target` + `suspend.target` + `hibernate.target` ✅
- **Madre rebooteada** — sistema arrancando limpio post-Fase 1 ✅
- **dnsmasq DHCP** activo en wlan0 — pool `192.168.72.50-150` · lease 12h ✅
- **Puerto 53 UFW wlan0** abierto — clientes AP pueden resolver DNS ✅

### Bloque previo 22:00–22:45
- **fail2ban jail sshd** activo — Madre + Acer
- **Puerto 53317** cerrado UFW — Madre + Acer
- **Netdata Acer** activo · puerto 19999 restringido a Madre
- Repo yggdrasil-dew auditado y actualizado completo vía MCP

### Scripts creados esta sesión (en `scripts/`)
- `01-fix-driver-rtl8188ftu.sh` — fix driver AP RTL8188FTV
- `02-git-pull-rebase.sh` — sync repo en Madre
- `03-fase1-seguridad.sh` — **YA EJECUTADO ✅**
- `04-fase2-start-batcueva.sh` — próxima sesión
- `05-fase7-ollama-pull.sh` — próxima sesión
- `06-verificacion-post-reboot.sh` — verificación estado sistema

---

## 📍 Estado real del plan — 28 jun 2026 23:11

### Plan completo: `PLAN-SEGURIDAD-Y-DESPLIEGUE.md` — 10 fases

| Fase | Nombre | Estado |
|---|---|---|
| **0** | Repo y docs al día | ✅ 100% — git pull hecho, repo sincronizado |
| **1** | Seguridad de red | ✅ 100% — SSH hardening + UFW + Tailscale + no suspensión |
| **2** | Script `start-batcueva.sh` | 🔴 0% — script preparado en repo, falta ejecutar |
| **3** | Backup Restic | 🔴 0% — bucket cloud + scripts + timer |
| **4** | Monitorización completa | 🟡 50% — Grafana dashboards, Uptime Kuma→THDORA, Wazuh pendiente |
| **5** | Seguridad avanzada contenedores | 🔴 0% — SOPS, Rootless Docker, VLANs |
| **6** | Handlers THDORA | 🔴 0% — `/estado` `/inbox` `/diario` `/pull` |
| **7** | Modelos Ollama + RAG | 🔴 20% — `llama3.1:8b`, `bge-m3`, `nomic-embed-text` pendientes |
| **8** | Seguridad Acer (theodora) | 🔴 0% — Prey, Computrace, número de serie |
| **9** | Pentest + OSINT real | 🔴 0% — desbloqueado ahora que Fase 1 ✅ |

---

## 🔴 Único pendiente crítico — verificación post-reboot

Madre está arrancando ahora mismo. Cuando conecte:

```bash
ssh madre
cd ~/yggdrasil-dew/scripts
bash 06-verificacion-post-reboot.sh
```

**Checks que deben estar todos ✅ tras el reboot:**
- UFW activo
- Tailscale conectado (100.91.112.32)
- hostapd (MadreAP) activo
- dnsmasq activo
- SSH sin password auth
- fail2ban activo
- sleep.target masked
- Driver 8188fu config presente

---

## 🐳 Docker — Qué está levantado vs qué falta

### ✅ 13 contenedores healthy desde 25-jun
```
ollama · ollama-embeddings · open-webui · qdrant
uptime-kuma · thdora · thdora-bot · grafana
prometheus · portainer · code-server · n8n · gitea
```

### ⏳ Pendiente levantar — Fase 5-6 (OSINT/Pentest/Seguridad)
```
Kali Desktop    → puerto 6901   — pentest
SpiderFoot      → puerto 5001   — OSINT automático
Bettercap       → network_mode:host — MITM / análisis WiFi
Wazuh           → SIEM          — prereq vm.max_map_count=262144
Suricata        → IDS pasivo    — monitor wlan0
DefectDojo      → gestión findings
SearXNG         → buscador privado
PiHole          → DNS + bloqueador ads
```

---

## 🗓️ Próximas sesiones — orden de ejecución

```
Sesión siguiente (inmediata):
  1. Verificar 06-verificacion-post-reboot.sh → todos los checks ✅
  2. Ejecutar 04-fase2-start-batcueva.sh → levantar stack Docker completo
  3. Ejecutar 05-fase7-ollama-pull.sh → modelos llama3.1:8b, bge-m3, nomic

Esta semana:
  4. THDORA handlers (/estado /inbox /diario /pull)
  5. Tailscale Redmi A5 → móvil como nodo
  6. Fase 3 Restic backup

Siguiente semana:
  7. Fase 4 Grafana + Wazuh
  8. Fase 9 Kali + SpiderFoot → primer scan OSINT real (ya desbloqueado)
```

---
_Actualizado: 28 jun 2026 23:11 CEST — Perplexity vía MCP_
_Ver: [[PLAN-SEGURIDAD-Y-DESPLIEGUE]] · [[MASTER-PENDIENTES]] · [[ESTADO-SISTEMA]]_
