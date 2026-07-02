---
tags: [estado, sistema, real-time]
fecha-actualizacion: 2026-07-02T21:05
---

# 📊 ESTADO-SISTEMA.md — Estado real 02-jul-2026 21:05

> ⚠️ Este fichero se actualiza manualmente cada sesión.
> Para automatizarlo: ver Fase 5 (GitHub Actions) y Fase 6 (Thdora Guardián).

---

## Madre (servidor principal)

| Servicio | Estado | Notas |
|---|---|---|
| Sistema operativo | ✅ Arch Linux | Operativo |
| UFW | ✅ Activo | Reglas configuradas |
| fail2ban | ✅ Activo | Jail sshd |
| Tailscale | ✅ Autoarranque | VPN activa |
| SSH | ⚠️ Parcial | Hardening pendiente (solo clave pública) |
| Docker | ✅ Instalado | Compose disponible |
| n8n | ⚠️ Corriendo | Escuchando 0.0.0.0 — hardening urgente |
| Thdora (FastAPI) | ✅ Corriendo | Base funcional, handlers pendientes |
| Batcueva stack | ❌ Detenido | start-batcueva.sh no ejecutado |
| Wazuh | ❌ Bloqueado | vm.max_map_count no configurado |
| Suricata | ❌ No instalado | Fase 4 |
| Kali KasmWeb | ❌ No instalado | Fase 4 |
| Pihole | ❌ No instalado | Fase 4 |
| SearXNG | ❌ No instalado | Fase 4 |
| Ollama | ✅ Instalado | qwen2.5:7b + qwen2.5:3b listos |
| llama3.1:8b | ❌ No descargado | Fase 7 |
| bge-m3 | ❌ No descargado | Fase 7 |
| Qdrant | ❌ No instalado | Fase 7 |

---

## Thdora (workstation / varpc)

| Servicio | Estado | Notas |
|---|---|---|
| Sistema operativo | ✅ Arch Linux | Operativo |
| Tailscale | ✅ Activo | |
| Cursor IDE | ❌ No instalado | Pendiente + MCP config |
| Obsidian | ✅ Instalado | Vault sincronizado |
| GitHub CLI | ✅ Disponible | |
| Docker | ✅ Disponible | |
| Workflows Actions | ❌ Sin desplegar | 5 drafts en inbox/ |
| inbox/ pendiente migrar | ⚠️ 32 ficheros | Script listo en inbox/ |

---

## Móviles

| Dispositivo | Tailscale | SSH a Madre | Estado |
|---|---|---|---|
| iPhone | ✅ Activo | ❌ Termius pendiente | Issue #8 |
| Redmi A5 | ❌ Pendiente | ❌ | Fase 9 |

---

## GitHub repo

| Área | Estado | Notas |
|---|---|---|
| Issues abiertos | 9 (#2,3,5,6,8,9,10,11,12) | |
| Issues por crear | 3 (#13,14,15) | Fases 6d, 7, 8MCP |
| CONVENCIONES.md | ✅ Nivel senior | Actualizado 02-jul |
| AGENT.md | ✅ Actualizado | 02-jul |
| CONTRIBUTING.md | ✅ Creado | 02-jul |
| Issue templates | ✅ Activos | .github/ISSUE_TEMPLATE/ |
| PR template | ❌ Pendiente | |
| Labels personalizados | ❌ Pendiente | |
| Milestones | ❌ Pendiente | |
| CODEOWNERS | ❌ Pendiente | |
| Branch protection | ❌ Pendiente | |
| GitHub Actions | ❌ Sin desplegar | 5 drafts |
| Profile README | ❌ Sin crear | |
| Archivos basura en raíz | ⚠️ 2 | `tailscale-full.apk` + `ly` (git rm pendiente) |
| `filosofia.md` en raíz | ⚠️ Duplicado | Ya en docs/, borrar de raíz (needs-terminal) |
| `.obsidian/` en repo | ⚠️ Trackeado | `git rm -r --cached .obsidian/` pendiente |

---

## Hallazgos seguridad activos

| Hallazgo | Severidad | Estado |
|---|---|---|
| Puerto FTP 21 abierto | 🔴 Alta | Documentado, fix pendiente |
| n8n escuchando 0.0.0.0 | 🔴 Alta | Fix urgente (bind Tailscale) |
| SSH sin hardening completo | 🟡 Media | Fase 1 pendiente |
| .obsidian/ en git | 🟡 Media | Privacidad, git rm pendiente |

---

_Actualizado: 02-jul-2026 21:05 CEST — Perplexity vía MCP_
