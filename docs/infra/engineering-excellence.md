---
tags: [infra, arquitectura, roadmap, seguridad, mlops]
fecha-actualizacion: 2026-07-02
---

# 🏗️ Engineering Excellence — Auditoría 4 Pilares

> Auditoría desde perspectiva de ingeniero senior. Riesgos reales en producción del stack Batcueva.
> Fecha auditoría: 25-jun-2026

---

## 1. Reproducibilidad e Infraestructura Inmutable

**Riesgo:** Si Madre muere, no hay recuperación rápida documentada.

| Fix | Herramienta | Estado |
|---|---|---|
| IaC completo | Ansible Playbooks (stack desde cero en <15 min) | 🔴 Sin implementar |
| Backup 3-2-1 | Restic → Cloudflare R2 o Backblaze B2 | 🔴 Sin implementar |

### Script Restic base
```bash
#!/bin/bash
# scripts/backup/run-backup.sh
export $(grep -v '^#' $(dirname "$0")/.env | xargs)
BACKUP_PATHS="/home/alvaro/yggdrasil-dew /var/lib/docker/volumes"
restic backup $BACKUP_PATHS --tag homelab-auto
restic forget --keep-daily 7 --keep-weekly 4 --keep-monthly 6 --prune
restic check
```

---

## 2. Seguridad — Privilege Explosion

**Riesgo:** Contenedores corriendo como root + acceso al socket Docker.

| Fix | Estado |
|---|---|
| Rootless Docker | 🔴 Sin implementar |
| Secrets con SOPS o Vault (nunca `.env` en git) | 🔴 Sin implementar |
| VLANs pentest separadas de LAN doméstica | 🟡 En proceso (VLAN 66) |

---

## 3. Integridad de Datos RAG

**Riesgo:** Vectores corruptos o modelo actualizado sin tracking → alucinaciones sin baseline.

| Fix | Estado |
|---|---|
| Pipeline validación antes de ingest Qdrant | 🔴 Sin implementar |
| Versionar Modelfile exacto en ADRs | 🟡 Parcial |

---

## 4. Observabilidad

**Stack actual:** Grafana + Prometheus + Uptime Kuma ✅ (corriendo)

| Fix | Estado |
|---|---|
| Uptime Kuma → THDORA → alertas Telegram | 🔴 Sin implementar |
| Dashboard CPU temp + latencia Ollama | 🔴 Sin implementar |

---

## Roadmap por pilares

| Pilar | Objetivo | Herramienta | Prioridad |
|---|---|---|---|
| IaC | 0% config manual | Ansible Playbooks | 🔴 Alta |
| SecOps | Zero Trust | Tailscale ACLs + UFW | 🔴 Alta |
| CI/CD | 0 errores en push | GitHub Actions + yamllint + hadolint | 🟡 Media |
| MLOps | RAG reproducible | LangChain + evaluación precisión | 🟡 Media |

## Estado Docker — 25-jun-2026

| Contenedor | Estado | Puerto |
|---|---|---|
| qdrant | ✅ healthy | 6333 |
| ollama | ✅ healthy | 11434 |
| uptime-kuma | ✅ healthy | 3002 |
| portainer | ✅ up | 9000 |
| thdora-bot | ✅ healthy | — |
| thdora | ✅ healthy | 8000 |
| grafana | ✅ up | 3000 |
| prometheus | ✅ up | 9090 |

---
_Documentado: 25-jun-2026 / Actualizado: 02-jul-2026 — Perplexity vía MCP_
