---
tags: [tipo/sesion, estado/activo, infra/docker, infra/sops, osint/tools, proyecto/thdora]
fecha: 2026-06-28
hora-inicio: 00:37
hora-fin: 22:45
dispositivo: iPhone (remoto)
agente: Perplexity MCP
---

# 📓 Sesión 28 jun 2026 — Auditoría completa + plan de fases

> Sesión doble: madrugada (00:37–01:00) + noche (22:00–22:45)
> Ejecutada íntegramente desde iPhone — sin acceso a Madre ni Acer

---

## ✅ Completado

### Infraestructura (madrugada)
- **fail2ban jail sshd** activo — Madre + Acer (`maxretry:5` `bantime:86400s`)
- **dnsmasq DHCP** activo en wlan0 — pool `192.168.72.50-150` · 12h lease
- **Puerto 53317** cerrado UFW — Madre + Acer (tcp+udp)
- **Netdata Acer** activo · puerto 19999 restringido a `100.91.112.32`
- **UFW regla DNS wlan0** — clientes MadreAP pueden resolver DNS vía dnsmasq

### Repo yggdrasil-dew (noche — Perplexity MCP)
- `MASTER-PENDIENTES.md` — sesión 28-jun documentada, completados marcados ✅
- `ESTADO-SISTEMA.md` — estado real 28-jun con dnsmasq, fail2ban, UFW, Docker, THDORA ✅
- `ECOSISTEMA.md` — IPs Tailscale corregidas, red AP con dnsmasq, stack Docker completo ✅
- `CHANGELOG.md` — semana 22-28 jun documentada entrada por entrada ✅
- `inbox/2026-06-28-auditoria-sesion-completa.md` — contexto completo para próxima sesión ✅
- Auditoría completa de carpetas y archivos root del repo ✅

---

## 📍 Estado del plan — snapshot 28-jun-2026

| Fase | Nombre | Estado |
|---|---|---|
| 0 | Repo y docs al día | 🟡 95% |
| 1 | Seguridad de red | 🔴 0% — próxima sesión |
| 2 | Script start-batcueva.sh | 🔴 0% |
| 3 | Backup Restic | 🔴 0% |
| 4 | Monitorización completa | 🟡 50% |
| 5 | Seguridad avanzada contenedores | 🔴 0% |
| 6 | Handlers THDORA | 🔴 0% |
| 7 | Modelos Ollama + RAG | 🔴 20% |
| 8 | Seguridad Acer | 🔴 0% |
| 9 | Pentest + OSINT real | 🔴 0% — bloqueado hasta Fase 1 |

---

## 📱 iPhone — SSH y red (pendiente)

### Problema
Estoy fuera — solo tengo el iPhone. No puedo ejecutar nada en Madre ni Acer.

### Solución: meter el iPhone en la red vía Tailscale + SSH

**Paso 1 — Tailscale en iPhone:**
```
App Store → buscar "Tailscale" → instalar → login con misma cuenta
→ iPhone aparecerá como nuevo nodo en la red mesh
```

**Paso 2 — SSH desde iPhone:**
```
App Store → "Termius" o "SSH Files" → instalar
Host: 100.91.112.32
Usuario: varopc  
→ terminal completa en Madre desde el iPhone
```

**Lo que podrás hacer desde iPhone:**
- Terminal completa en Madre → ejecutar cualquier comando
- Ver Grafana / Netdata / Portainer en Safari (`http://100.91.112.32:3000`)
- Controlar THDORA desde Telegram
- Acceder a Kali Desktop en navegador (`http://100.91.112.32:6901`)
- SSH al Acer (`ssh varo@100.86.119.102`)

> ⚠️ **Pendiente:** añadir iPhone como nodo Tailscale + instalar Termius

---

## 🔍 OSINT vs Pentest — aclarado hoy

| | OSINT | Pentest |
|---|---|---|
| **Qué es** | Reconocimiento pasivo — fuentes públicas | Ataque activo controlado |
| **Herramientas** | SpiderFoot, SearXNG | Kali, Bettercap, nmap |
| **Docker listo** | `docker-compose.kali.yml` existe | Kali Desktop puerto 6901 |
| **Estado** | ⏳ Sin levantar — bloqueado hasta Fase 1 | ⏳ Sin levantar |

---

## ⚠️ Problema crítico pendiente

**Driver RTL8188FTV inestable** — AP cae solo (`INTERFACE-DISABLED` en logs hostapd)

Fix preparado para ejecutar en próxima sesión:
```bash
echo "options 8188fu rtw_power_mgnt=0 rtw_enusbss=0" | sudo tee /etc/modprobe.d/8188fu.conf
sudo modprobe -r 8188fu 2>/dev/null && sudo modprobe 8188fu
sudo systemctl restart hostapd && systemctl is-active hostapd
```

---

## 🔎 Commits de esta sesión

| Commit | Qué cambió |
|---|---|
| `a4e9f18` | MASTER-PENDIENTES.md — sesión 28-jun |
| `455d6b0` | ESTADO-SISTEMA + ECOSISTEMA + CHANGELOG (push multiple) |
| `a3fc2a0` | inbox/2026-06-28-auditoria-sesion-completa.md |
| este commit | diarios/2026-06-28-sesion-auditoria-completa.md |

---

## 🗓️ Próxima sesión — orden de ejecución

1. Instalar Tailscale + Termius en iPhone → terminal remota
2. Fix driver RTL8188FTV → AP estable
3. `git pull --rebase` en Madre → cerrar Fase 0
4. **Fase 1**: SSH hardening + UFW completo + `systemctl enable tailscaled` + mask suspend
5. **Fase 2**: script `scripts/start-batcueva.sh`
6. Modelos Ollama: `llama3.1:8b` + `bge-m3` + `nomic-embed-text`

---
_Creado: 28 jun 2026 22:45 CEST — Perplexity vía MCP — desde iPhone_
_Ver: [[PLAN-SEGURIDAD-Y-DESPLIEGUE]] · [[MASTER-PENDIENTES]] · [[ESTADO-SISTEMA]] · [[inbox/2026-06-28-auditoria-sesion-completa]]_
