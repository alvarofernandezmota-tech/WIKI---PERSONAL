---
tipo: relacion
author: Alvaro Fernandez Mota
creado: 2026-07-05
actualizado: 2026-07-05 21:18 CEST
ruta: wiki/relaciones/servicios-madre.md
tags: [relacion, madre, servicios, docker, infra, dew, secops]
status: vigente
islas: [infra, ia-local, thdora, seguridad, cerebro]
---

# 🖥️ Servicios de Madre — Mapa de relaciones

> Qué servicios viven en Madre, dónde se documentan y dónde se auditan.
> Madre es el servidor físico. Esta wiki es el mapa conceptual — no el manual técnico.

---

## Servicios activos en Madre

| Servicio | Puerto | Estado | Documentado en | Auditado en |
|---|---|---|---|---|
| SSH | 22 | ✅ solo Tailscale | `madre-config` | SecOps |
| Ollama | 11434 | ✅ | `ollama-stack` | — |
| Open WebUI | 3000 | ✅ | `ollama-stack` | — |
| Qdrant | 6333 | ✅ | `local-brain` | — |
| THDORA bot | 8000 | ✅ | `THDORA-PERSONAL` | SecOps |
| Portainer | — | ✅ | `madre-config` | SecOps |
| Grafana + Prometheus | — | ✅ | `madre-config` | — |
| Nextcloud | — | ✅ | `madre-config` | SecOps |
| Vaultwarden | — | ✅ | `madre-config` | SecOps ⚠️ |
| Pi-hole + Unbound | — | ✅ | `madre-config` | — |
| log_guardian_bot | — | ⚠️ unhealthy | `madre-config` | Dew (backlog) |
| yggdrasil_watchdog | — | ⚠️ unhealthy | `madre-config` | Dew (backlog) |
| UFW | — | ✅ | `madre-config` | SecOps |
| fail2ban | — | ✅ | `madre-config` | SecOps |

---

## Cómo se distribuye el conocimiento de cada servicio

### Lo que vive en cada capa

**WIKI (aquí):**
- Qué hace cada servicio y para qué existe en el ecosistema
- Relaciones entre servicios
- Estado conceptual (activo, unhealthy, pendiente)

**`madre-config`:**
- Docker compose de cada servicio
- Variables de entorno
- Scripts de arranque y shutdown
- Procedimientos operativos

**`yggdrasil-dew`:**
- Decisiones de arquitectura sobre servicios
- Backlog de servicios unhealthy
- Diarios de cambios de configuración

**`yggdrasil-secops`:**
- Auditorías de puertos
- Credenciales expuestas
- Planes de remediación

---

## Servicios prioritarios a sanear

1. **log_guardian_bot** — unhealthy. Bloquea la observabilidad del sistema.
2. **yggdrasil_watchdog** — unhealthy. Bloquea la detección automática de fallos.
3. **Vaultwarden** — gestor de contraseñas expuesto → requiere auditoría SecOps urgente.
4. **Disco HDD WD 1TB** — 28k horas. Riesgo crítico de fallo → plan de backup obligatorio.

---

## Conexiones

- → [[infra]] (el hardware donde corren los servicios)
- → [[ia-local]] (Ollama + Qdrant + Open WebUI)
- → [[thdora]] (bot corriendo en Madre)
- → [[seguridad]] (auditorías de servicios expuestos)
- → [[cerebro]] (Dew documenta decisiones de arquitectura)

---
_Actualizado: 2026-07-05 21:18 CEST · Perplexity-MCP_
