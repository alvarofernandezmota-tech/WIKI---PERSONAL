# Auditoría Infraestructura — Engineering Excellence
#infra #seguridad #backups #roadmap #mlops #pendiente

**Fecha:** 2026-06-25
**Estado:** 🔴 Pendiente de implementar
**Origen:** Sesión de arquitectura de sistemas

---

## Resumen

Auditoría completa de los 4 pilares críticos del stack Batcueva desde perspectiva de ingeniero senior. Todos son riesgos reales en producción.

---

## 1. Reproducibilidad e Infraestructura Inmutable
#infra #ansible

- **Riesgo:** Si Madre muere, no hay recuperación rápida documentada
- **Fix:** Ansible Playbooks para levantar todo el stack desde cero en <15 min
- **Fix:** Script Restic con regla 3-2-1 (3 copias, 2 medios, 1 offsite)
- **Destino backup sugerido:** Cloudflare R2 o Backblaze B2
- **Estado:** 🔴 Sin implementar

### Script Restic base (pendiente de añadir a scripts/backup/)

```bash
#!/bin/bash
export $(grep -v '^#' $(dirname "$0")/.env | xargs)
BACKUP_PATHS="/home/alvaro/yggdrasil-dew /var/lib/docker/volumes"
restic backup $BACKUP_PATHS --tag homelab-auto
restic forget --keep-daily 7 --keep-weekly 4 --keep-monthly 6 --prune
restic check
```

---

## 2. Seguridad — Privilege Explosion
#seguridad #docker #secrets

- **Riesgo:** Contenedores corriendo como root + acceso al socket Docker
- **Fix 1:** Rootless Docker
- **Fix 2:** Mozilla SOPS o HashiCorp Vault para secrets (nunca en `.env` en git)
- **Fix 3:** VLANs para separar red pentest de red doméstica/cámaras
- **Estado:** 🔴 Sin implementar

---

## 3. Integridad de Datos RAG
#mlops #qdrant #ollama

- **Riesgo:** Vectores corruptos o modelo actualizado sin tracking = alucinaciones sin baseline
- **Fix 1:** Pipeline de validación antes de ingest a Qdrant (chunking + schema check)
- **Fix 2:** Versionar Modelfile exacto (ej: `qwen2.5:3b-v1.0`) en ADRs
- **Estado:** 🟡 Parcial (modelo no versionado)

---

## 4. Observabilidad
#grafana #prometheus #thdora

- **Stack actual:** Grafana + Prometheus + Uptime Kuma ✅ (ya corriendo)
- **Falta:** Integrar Uptime Kuma con THDORA-bot para alertas Telegram
- **Falta:** Dashboard de temperatura CPU + latencia Ollama en Grafana
- **Estado:** 🟡 Infraestructura lista, alertas sin configurar

---

## Roadmap 2027 — 4 Pilares

| Pilar | Objetivo | Herramienta | Prioridad |
|---|---|---|---|
| Automatización (IaC) | 0% config manual | Ansible Playbooks | 🔴 Alta |
| Seguridad (SecOps) | Zero Trust | Tailscale ACLs + UFW | 🔴 Alta |
| Calidad (CI/CD) | 0 errores sintaxis en push | GitHub Actions + yamllint + hadolint | 🟡 Media |
| IA Engineering (MLOps) | RAG reproducible | LangChain/LlamaIndex + evaluación precisión | 🟡 Media |

---

## Estado Docker actual (25/06/2026 15:19)

| Contenedor | Estado | Puerto |
|---|---|---|
| qdrant | ✅ healthy | 6333 |
| ollama | ✅ healthy (13min) | 11434 |
| uptime-kuma | ✅ healthy | 3002 |
| portainer | ✅ up | 9000 |
| thdora-bot | ✅ healthy | — |
| thdora | ✅ healthy | 8000 |
| grafana | ✅ up | 3000 |
| prometheus | ✅ up | 9090 |

---

## Próximos pasos inmediatos

- [ ] Configurar almacenamiento externo (R2/B2) para Restic
- [ ] Escribir script `scripts/backup/run-backup.sh`
- [ ] Crear systemd timer `batcueva-backup.timer`
- [ ] **Probar restore** (lo que separa usuario de SysAdmin)
- [ ] Integrar Uptime Kuma → THDORA alertas Telegram
- [ ] Reintentar pull modelo atascado (f5074b1221da ~58%)
