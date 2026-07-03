# Catálogo de Scripts — Yggdrasil Ecosystem

> Todo lo que puedes ejecutar. Actó al día de hoy: 03-jul-2026

## Mantenimiento (`scripts/maintenance/`)

| Script | Uso | Cuándo |
|---|---|---|
| `session-close.sh` | Cierre de sesión: inbox, git, push, procesos | **Siempre al cerrar** |
| `morning-check.sh` | Estado completo al despertar | Al levantarte |
| `audit-full.sh` | Auditoría profunda del ecosistema | Semanal o cuando hay dudas |
| `ecosystem-map.sh` | Árbol del repo con estado | Para orientarte |
| `obsidian-vault-check.sh` | Verifica vault y links rotos | Semanal |
| `migrate-inbox.sh` | Mueve inbox/procesado/ → docs/ | Tras procesar inbox |
| `sync-repo.sh` | Pull + push automático | En cualquier momento |
| `clean-root.sh` | Elimina archivos vacíos en raíz | Cuando haya basura |
| `setup-permissions.sh` | chmod +x a todos los scripts | Tras git pull en nuevo nodo |

## Cómo ejecutar en Madre

```bash
# Primero, dar permisos (solo primera vez en cada máquina)
cd ~/yggdrasil-dew && bash scripts/maintenance/setup-permissions.sh

# Cierre de sesión
bash scripts/maintenance/session-close.sh

# Morning check
bash scripts/maintenance/morning-check.sh

# Auditoría completa
bash scripts/maintenance/audit-full.sh

# Ver mapa del ecosistema
bash scripts/maintenance/ecosystem-map.sh
```

## Scripts pendientes de crear (próximas sesiones)

| Script | Descripción | Prioridad |
|---|---|---|
| `backup-repo.sh` | Backup completo del repo a disco local | P1 |
| `cron-setup.sh` | Configura cron jobs automáticos en Madre | P1 |
| `thdora-start.sh` | Levanta el agente Thdora | P2 |
| `osint-run.sh` | Ejecuta stack OSINT y guarda resultados | P2 |
| `docker-up.sh` | Levanta stack Docker (Wazuh, Suricata, Pihole) | P3 |
| `git-bfg-clean.sh` | Limpieza historial git con BFG | P2 (issue #16) |
| `labels-setup.sh` | Crea labels personalizados en GitHub | P1 (issue #22) |

_Actualizado: 03-jul-2026 — Perplexity MCP_
