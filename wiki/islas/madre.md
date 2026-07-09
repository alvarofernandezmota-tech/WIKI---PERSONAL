---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-09
actualizado: 2026-07-10
ruta: wiki/islas/madre.md
tags: [isla, madre, infra, docker, servidor, homelab, hal]
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
| CPU | Intel i5-8400 |
| RAM | 16 GB |
| GPU | GTX 1060 (Ollama) |
| Red local | WiFi `wlan0` |
| VPN | Tailscale |
| SSH | Puerto 22, solo clave pública |
| Acceso móvil | Blink Shell / Shellfish (iPhone) |

---

## Stack IA principal — docker-compose.yml raíz

Documentado 2026-07-10. Validado 2026-06-25. Limitaciones RAM i5-8400:

| Servicio | Imagen | RAM límite | Estado |
|----------|--------|------------|--------|
| ollama (chat) | ollama/ollama:latest | 7 GB | ▶ running |
| ollama-embeddings | ollama/ollama:latest | 2 GB | ▶ running |
| qdrant | qdrant/qdrant:latest | 2 GB | ▶ running |
| open-webui | ghcr.io/open-webui | 1 GB | ▶ running |

**RAM total estimada: ~11.5 GB / 16 GB ✅**
⚠️ NO cargar qwen2.5:14b con stack activo — OOM Killer.

---

## Inventario IaC — 28 compose files detectados

Descubiertos en `/home/varopc/` y `/srv/`:

| Ruta | Stack | Versionado |
|------|-------|------------|
| `/home/varopc/docker-compose.yml` | IA principal | ❌ No |
| `/home/varopc/Projects/thdora/` | THDORA | ❌ No |
| `/home/varopc/spiderfoot/` | SpiderFoot | ❌ No |
| `/home/varopc/yggdrasil-secops/blue_team/` | Blue team (7) | ⚠️ En secops |
| `/srv/yggdrasil-dew/docker/madre/` | Fases 1-3 | ✅ En DEW |

❌ **Problema:** Los compose operativos en `/home/varopc/` no están versionados en `madre-config`.

---

## Estado salud (2026-07-10)

### HDD — SMART ✅ estable, antiguo

| Atributo | Valor | Estado |
|----------|-------|--------|
| Power_On_Hours | 28.811 h | 🟡 Antigüedad alta |
| Reallocated_Sector_Ct | 0 | ✅ |
| Current_Pending_Sector | 0 | ✅ |
| Offline_Uncorrectable | 0 | ✅ |
| Temperatura | 45°C | ✅ Normal |

Plan: monitorizar mensualmente. Sustitución preventiva Q4 2026.

### Puerto 21 FTP — filtered 🟡

Confirmado con `nmap -Pn -p 21 100.91.112.32`: resultado `filtered`.
El filtro bloquea sondas. No aparece como `open`. Pendiente confirmar desde red externa real.

---

## ⚠️ Incidencias abiertas (2026-07-10)

| HAL | Issue DEW | Descripción | Prioridad |
|-----|-----------|-------------|----------|
| HAL-007 | [#44](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/44) | .env raíz malformado | 🔴 CRÍTICO |
| HAL-008 | [#45](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/45) | Secretos expuestos en chat | 🔴 CRÍTICO |
| HAL-009 | [#46](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/46) | log_guardian_bot crash loop #971 | 🟡 ALTA |
| — | [#43](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/43) | IaC — versionar 16 docker-compose | 🔴 CRÍTICO |
| — | [#31](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/31) | HDD 28k horas — monitorizar | 🟡 MONITORIZAR |
| — | [#15](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues/15) | Puerto 21 FTP — confirmar externo | 🟡 PARCIAL |

---

## Links

→ [madre-config repo](https://github.com/alvarofernandezmota-tech/madre-config)
→ [hdd-salud.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/infra/madre/hdd-salud.md)
→ [env-malformado-hal007.md](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/blob/main/docs/infra/madre/env-malformado-hal007.md)
→ [Issues DEW Madre](https://github.com/alvarofernandezmota-tech/yggdrasil-dew/issues)

_Actualizado: 2026-07-10 · Perplexity-MCP_
