# Estado del Sistema — Yggdrasil Ecosystem

> Última actualización: 2026-07-03 04:29 CEST
> Actualizado por: Perplexity MCP (sesión iPhone madrugada)

## 🟢 Infraestructura Activa

| Nodo | IP Tailscale | Estado | Rol |
|---|---|---|---|
| Madre (varpc) | 100.91.112.32 | ✅ ONLINE | Servidor principal |
| iPhone 11 | 100.81.187.99 | ✅ ONLINE | Operación móvil |
| Acer (varo12f) | 100.86.119.102 | ✅ ONLINE | Workstation |
| Xiaomi | 100.106.133.70 | ✅ ONLINE | Backup móvil |

## 🔒 Seguridad

| Servicio | Estado | Notas |
|---|---|---|
| SSH Madre | ✅ Hardened | No password, no root, pubkey only |
| Tailscale | ✅ Activo | 4 nodos en tailnet |
| Puerto 21 FTP | ⚠️ PENDIENTE | Cerrar en router — issue #14 |
| Blink SSH iPhone | ✅ Operativo | ed25519 blink-madre |

## 🤖 IA Local (Madre)

| Herramienta | Estado | Notas |
|---|---|---|
| Ollama | ✅ Instalado | v0.x — descargando modelos |
| llama3.1:8b | ⏳ Descargando | tmux sesión `trabajo` |
| mistral:7b | ⏳ Pendiente | en cola pull-modelos.sh |
| codellama:7b | ⏳ Pendiente | en cola pull-modelos.sh |
| Thdora | ⚠️ En desarrollo | issue #1 |

## 📁 Repo

| Ítem | Estado |
|---|---|
| Git configurado en Madre | ✅ |
| GitHub SSH funcionando | ✅ |
| Inbox limpio | ✅ |
| Scripts mantenimiento | ✅ morning-check.sh, health-check.sh, audit-repo.sh |
| Diario 2026-07-03 | ✅ |

## 📋 Issues Abiertos Prioritarios

| # | Título | Prioridad |
|---|---|---|
| #25 | Verificar modelos Ollama descargados | P1 — mañana |
| #22 | Labels personalizados | P1 |
| #14 | Cerrar puerto 21 FTP router | P1 seguridad |
| #16 | Limpieza git BFG historial | P2 |
| #17 | Migrar inbox/ → docs/ | P2 |
| #11 | GitHub Actions agentes IA | P2 |
| #9 | Docker stack Wazuh+Suricata+Pihole | P3 |

## ✅ Completado Esta Sesión (03-jul-2026)

- iPhone SSH via Blink Shell (issue #23)
- SSH Hardening Madre (issue #13)
- Bootstrap Madre
- Git + GitHub en Madre
- Inbox limpiado (7 archivos → procesado/)
- Ollama instalado + modelos en descarga background
- Tmux configurado con sesión persistente
- Scripts: morning-check.sh, pull-modelos.sh
- Docs: iphone-ssh-blink.md, ssh-hardening.md, tmux-background-jobs.md
- Diario 2026-07-03.md

---
_Próxima sesión: ejecutar `bash scripts/maintenance/morning-check.sh` para ver estado completo_
