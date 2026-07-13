---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-09
actualizado: 2026-07-13T10:17:00+02:00
ruta: wiki/islas/madre.md
tags: [isla, madre, infra, docker, servidor, homelab, hal, ollama, ia]
status: vigente
repo_principal: madre-config
---

# Isla: Madre

> Servidor HP Ubuntu — núcleo físico del ecosistema Yggdrasil.
> Todo el stack Docker corre aquí. Acceso remoto vía Tailscale.
> **Madre es el único servidor de producción del ecosistema.**

---

## Identidad del servidor

| Campo | Valor |
|-------|-------|
| Hostname | `varpc` |
| Usuario | `varopc` |
| OS | Ubuntu Server |
| Cifrado | LUKS + Btrfs |
| CPU | Intel i5-8400 |
| RAM | 16 GB |
| GPU | GTX 1060 — usada por **Ollama** para inferencia LLM |
| Red local | WiFi `wlan0` |
| VPN | Tailscale |
| SSH | Puerto 22, solo clave pública |
| Acceso móvil | Blink Shell / Shellfish (iPhone Thea) |

---

## Mapa de dependencias — qué coge Madre de quién

```
Madre (hardware)
├── GTX 1060 ────────────────► ollama-stack (Ollama usa GPU para inferencia)
├── Docker daemon ────────► madre-config (IaC — todos los docker-compose)
├── /home/varopc/.env ───► THDORA-PERSONAL + yggdrasil-secops (consumen variables)
├── Puerto 22 SSH ───────► Acer + Thea (acceso remoto vía Tailscale)
└── Disco HDD ──────────► Todos los datos del ecosistema
```

### Flujo completo de petición de IA en Madre

```
Usuario / THDORA / n8n
    │
    ▼
LiteLLM (puerto 4000) — router unificado
    │
    ▼
Ollama (puerto 11434) — GTX 1060 hace inferencia
    │
    ▼
Modelo (llama3 / mistral / phi / qwen)

(Para RAG:)
Local-brain → Qdrant (puerto 6333) → embeddings → contexto → Ollama
```

---

## Stack completo de servicios en Madre (16)

### IA (ollama-stack)
| Servicio | Puerto | RAM límite | GPU | Depende de |
|---------|--------|------------|-----|------------|
| Ollama (chat) | 11434 | 7 GB | ✅ GTX 1060 | — |
| Ollama (embeddings) | 11435 | 2 GB | ✅ GTX 1060 | — |
| Open WebUI | 3000 | 1 GB | No | Ollama |
| LiteLLM | 4000 | 0.5 GB | No | Ollama |
| Qdrant | 6333 | 2 GB | No | — |

**GPU GTX 1060:** Ollama la usa directamente para inferencia. Sin GPU, los modelos corren en CPU (~5x más lentos).
⚠️ **NO cargar qwen2.5:14b con stack activo** — OOM Killer. RAM total IA: ~12.5 GB / 16 GB.

### Dev (THDORA-PERSONAL + n8n)
| Servicio | Puerto | Depende de |
|---------|--------|------------|
| THDORA API (FastAPI) | 8000 | .env, Ollama vía LiteLLM |
| THDORA Bot (Telegram) | — | .env (TELEGRAM_BOT_TOKEN) |
| n8n (orquestador flujos) | 5678 | .env |
| Code-server | 8080 | .env |

### Monitoring
| Servicio | Puerto | Depende de |
|---------|--------|------------|
| Grafana | 3001 | Prometheus |
| Prometheus | 9090 | — |
| Watchtower | — | Docker daemon |

### Secops (yggdrasil-secops)
| Servicio | Puerto | Depende de |
|---------|--------|------------|
| log_guardian_bot | — | .env (Telegram) ⚠️ Caído #46 |
| local_tripwire | — | — ⚠️ Caído #46 |
| Watchdog | — | Docker daemon |
| SpiderFoot (OSINT) | 5001 | — |

---

## IaC — compose files (problema activo)

| Ruta en Madre | Stack | Versionado en repo |
|--------------|-------|--------------------|
| `/home/varopc/docker-compose.yml` | IA principal | ❌ No (#43) |
| `/home/varopc/Projects/thdora/` | THDORA | ❌ No (#43) |
| `/home/varopc/spiderfoot/` | SpiderFoot | ❌ No (#43) |
| `/home/varopc/yggdrasil-secops/blue_team/` | Blue team | ⚠️ Parcial |

**Objetivo #43:** mover todo a `madre-config/docker/{ia,dev,monitoring,secops}/`

---

## Estado de salud (2026-07-10)

| Atributo | Valor | Estado |
|----------|-------|--------|
| HDD Power_On_Hours | 28.811 h | 🟡 Vigilar |
| Reallocated_Sector_Ct | 0 | ✅ |
| Temperatura | 45°C | ✅ |
| Puerto 21 FTP | filtered | 🟡 Verificar externo |
| RAM usada | ~12.5/16 GB | ✅ |

---

## ⚠️ Incidencias abiertas

| HAL | Issue | Descripción | Prioridad |
|-----|-------|-------------|----------|
| HAL-007 | [#44](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/44) | .env malformado — bloquea todo | 🔴 CRÍTICO |
| HAL-008 | [#45](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/45) | Rotar token Telegram + LITELLM_KEY | 🔴 CRÍTICO |
| HAL-009 | [#46](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/46) | log_guardian crash loop | 🟡 ALTA |
| — | [#43](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/43) | IaC — versionar 16 compose files | 🔴 CRÍTICO |
| — | [#31](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/31) | HDD 28k horas | 🟡 VIGILAR |

---

## 🔗 Conexiones con otras islas

| Isla | Relación |
|------|----------|
| [ollama-stack.md](ollama-stack.md) | Madre provee GPU + Docker para el stack IA |
| [ia-local.md](ia-local.md) | Detalle de la capa IA que corre en Madre |
| [thdora.md](thdora.md) | THDORA corre en Madre, consume Ollama vía LiteLLM |
| [orquestador.md](orquestador.md) | n8n corre en Madre como orquestador de flujos |
| [seguridad.md](seguridad.md) | Blue team (secops) corre en Madre |
| [infra.md](infra.md) | Vista técnica ampliada de la infraestructura |
| [scripts.md](scripts.md) | Scripts de mantenimiento se ejecutan en Madre |

---

_Actualizado: 2026-07-13 10:17 CEST · Perplexity-MCP · Cierre sesión matinal_
