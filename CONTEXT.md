---
tags: [contexto, sistema, estado, agente]
fecha-actualizacion: 2026-06-23
---

# CONTEXT.md — Estado HOY

> ⚠️ Actualizar SIEMPRE al inicio y al final de cada sesión.
> Este fichero es el "resumen ejecutivo" del ecosistema — lo primero que lee cualquier agente.
> Última actualización: **23 junio 2026 — 16:30 CEST**

---

## 📍 Dónde estamos ahora mismo

### Sesión 23 jun 2026 — parque + casa
- Sesión muy productiva: avance masivo en batcueva Docker + OSINT
- 3 scripts maestros investigados (Grok + Gemini x2), validados y documentados
- Diary completo del día en `diarios/2026-06-23.md`
- Inbox limpiado y reorganizado ✅

---

## 🟢 Stack Docker Madre — estado real 23/06/2026

| Servicio | Puerto | Estado |
|---|---|---|
| thdora API | :8000 | ✅ healthy |
| thdora-bot | — | ✅ healthy |
| Grafana | :3000 | ✅ |
| Prometheus | :9090 | ✅ |
| Portainer | :9000 | ✅ nuevo hoy |
| Uptime Kuma | :3002 | ✅ nuevo hoy |
| Open WebUI | :3001 | ⏬ descargando |
| SpiderFoot | :5001 | 🔨 build local en curso |
| Ollama | :11434 | ⏬ descargando |

### ⏳ Fase 2 — pendiente instalar
| Servicio | Puerto | Script |
|---|---|---|
| tar1090 (aviones) | :8085 | `inbox/setup/batcueva-fase2.yml` |
| Kismet (WiFi audit) | :2501 | ídem |
| IVRE (Shodan clon) | :8089 | ídem |
| Recon-ng | CLI | ídem |
| Qdrant (vectorial) | :6333 | ídem |
| Caddy (proxy) | :80/:443 | nativo Arch |

### ⚠️ Prereqs Fase 2
- [ ] Antena USB WiFi externa para Kismet (modo monitor)
- [ ] Tailscale MagicDNS activo en Madre
- [ ] Para tar1090 datos reales → RTL-SDR (~25€) o ADS-B Exchange feed (gratis)

---

## 🟡 Hardware Madre

- IP Tailscale: `100.91.112.32`
- Hardware: i5-8400 · 16GB RAM · GTX 1060 6GB VRAM
- OS: Arch Linux headless
- Docker ✅ · Tailscale ✅ · UFW + fail2ban ✅
- Netdata: ✅ multi-nodo (Madre + Acer) en `:19999`
- tmux: ⏳ pendiente instalar

## 🟡 varopc (Acer — terminal trabajo)

- IP Tailscale: `100.86.119.102`
- OS: Arch Linux + Hyprland
- Obsidian: ✅ · git pull pendiente
- Monitor Sony TV (DP-1): cable DP con mal contacto — fix: desconectar/reconectar
- Maltego CE: ⏳ instalar aquí (no en Madre)

---

## 🟠 Urgente — próxima sesión

1. **Terminar instalación** Open WebUI + SpiderFoot + Ollama (descargas en curso)
2. **Ejecutar Fase 2** → `cd /home/alvaro/docker/batcueva-fase2 && docker compose up -d`
3. **Descargar modelos Ollama** → `ollama pull llama3:latest && ollama pull nomic-embed-text:latest`
4. **Instalar Caddy nativo** en Madre → `sudo pacman -S caddy`
5. **Verificar imágenes Docker** → `docker pull ivre/web:latest kismet/kismet:latest`
6. **git pull** en varopc → sincronizar Obsidian

---

## 🟡 Esta semana

- Ejecutar pipeline RAG: IVRE → Qdrant → Ollama → Obsidian
- Investigar RTL-SDR + ADS-B Exchange para tar1090 con datos reales
- Instalar Maltego CE en varopc
- Ronda 2 LLM: 7 fichas nuevas en `agentes/`
- Thdora: auditoría código → definir MVP real
- Módulo 05 Python

---

## 📊 Stack OSINT completo objetivo

```
Capa 1 — Escaneo activo:    SpiderFoot + IVRE + Recon-ng + Amass
Capa 2 — Vigilancia pasiva: Kismet (WiFi) + tar1090 (aviones)
Capa 3 — Análisis IA:       Ollama llama3 + nomic-embed-text
Capa 4 — Memoria vectorial: Qdrant
Capa 5 — Segundo cerebro:   yggdrasil-dew (Obsidian + GitHub)
Capa 6 — Proxy unificado:   Caddy + Tailscale MagicDNS
```

---

## 🤖 Agentes activos

| Agente | Acceso GitHub | Cuándo usarlo |
|---|---|---|
| **Perplexity** | ✅ MCP directo | Principal — escribe en repos, documenta |
| **Grok** | ❌ usar [[agentes/AGENT-SCRIPT]] | Investigación · datos frescos |
| **Claude** | ❌ usar [[agentes/AGENT-SCRIPT]] | Código largo · razonamiento |
| **Gemini** | ❌ usar [[agentes/AGENT-SCRIPT]] | Deep Research · contexto largo |
| **OpenCode** | ✅ local | Terminal · archivos locales |
| **TOKI** | ⏳ en desarrollo | Control móvil desde Telegram |

---

## 📁 Scripts listos para ejecutar

| Script | Ubicación | Estado |
|---|---|---|
| Fase 2 completo (Ollama+tar1090+Kismet) | `setup/servidor/batcueva-fase2.yml` | ✅ listo |
| OSINT expansion (IVRE+Recon-ng+Qdrant) | `setup/servidor/batcueva-osint.yml` | ✅ listo |
| RAG orchestrator Python | `tools/rag_osint_engine.py` | ✅ listo |
| Caddyfile maestro | `setup/servidor/Caddyfile` | ✅ listo |

---

## 📝 Diarios

- `diarios/2026-06-23.md` — sesión parque + casa, avance batcueva
- `diarios/2026-06-22.md` — sesión noche, agentes LLM + Netdata

---

_Mantenido por Perplexity vía MCP GitHub_
_23 junio 2026 · 16:30 CEST_
_Ver: [[HOME]] · [[AGENT]] · [[filosofia]]_
