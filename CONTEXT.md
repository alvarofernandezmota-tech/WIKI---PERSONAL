# CONTEXT — Estado actual del sistema

> **Última actualización:** 12 junio 2026, 22:35 CEST

---

## 📍 Dónde estamos ahora

**VNC operativo en LAN. whisrs instalado en Acer (base.en offline).**
Repo estructurado al 100% con 5 sesiones documentadas.

---

## ✅ Completado hoy

| Bloque | Estado |
|---|---|
| `personal-v2` estructurado al completo | ✅ |
| Sistema de agentes Perplexity + Gemini | ✅ |
| Tailscale Madre + Acer | ✅ |
| SSH Madre → Acer | ✅ |
| UFW Zero Trust Acer | ✅ |
| Input Leap — diagnosticado y abandonado | ✅ |
| VNC operativo (wayvnc + tigervnc, LAN) | ✅ |
| `setup/omarchy/` creado | ✅ |
| whisrs instalado en Acer (`base.en`) | ✅ |

---

## 🚧 Pendiente — próxima sesión

### Urgente
- [ ] Hotkey whisrs: `bind = SUPER, V, exec, whisrs toggle` en `hyprland.conf`
- [ ] `sudo systemctl enable --now sshd` en Madre
- [ ] Túmel VNC exterior: `ssh -L 5900:localhost:5900 varo@100.91.112.32`

### Omarchy
- [ ] whisrs en Madre (`small.en` + GPU)
- [ ] VS Code + GitHub CLI + DBeaver

### Repo
- [ ] Migrar `yo/`, `formacion/`, `proyectos/`
- [ ] Crear `tracking/`

---

## 🖥️ Infraestructura

| Máquina | IP Tailscale | Estado |
|---|---|---|
| **Madre** | `100.91.112.32` | ✅ wayvnc · ⚠️ sshd sin verificar |
| **Acer** | `100.86.119.102` | ✅ Tailscale · UFW · VNC · whisrs |
| **VNC** | IP LAN Madre | ✅ LAN · ⏳ exterior pendiente |

---

## 🤖 Agentes

| Agente | Rol |
|---|---|
| **Perplexity** | Documenta, estructura, sube al repo |
| **Gemini** | Troubleshooting técnico, voz, visual |

---

## 🎯 Objetivo 2026

**Conseguir trabajo antes de que acabe el año.**

---

_Diario: `diarios/2026/2026-06-12.md`_
