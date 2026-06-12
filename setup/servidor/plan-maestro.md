# Plan Maestro — Torre Madre + Portátil Acer

> Última actualización: 12 junio 2026, 23:15 CEST

---

## Entorno base

| Dato | Valor |
|---|---|
| OS / WM | Arch Linux / Hyprland (Wayland) — ambos |
| VPN | Tailscale ✅ (`100.91.112.32` Madre, `100.86.119.102` Acer) |
| KVM / Escritorio remoto | wayvnc + tigervnc ✅ instalado, pendiente estabilizar |
| Repo documentación | [`personal-v2`](https://github.com/alvarofernandezmota-tech/personal-v2) ✅ |

---

## Tareas — Por estado

### 🔴 Sin empezar

| Prioridad | Tarea | Notas |
|---|---|---|
| P1 | Activar `sshd` en Madre + `systemctl enable` | Ir físicamente. Ver [ssh.md](ssh.md) § Rescate |
| P1 | Configurar autostart `wayvnc` en Hyprland | `exec-once` en hyprland.conf. Ver [vnc.md](vnc.md) |
| P1 | Copiar clave SSH Ed25519 Acer → Madre | Después de activar sshd |
| P2 | Deshabilitar auth por password en sshd | Después de tener clave Ed25519 |
| P2 | Auditoría Docker en Acer | Qué contenedores hay, cuáles migrar a Madre |
| P2 | PostgreSQL en Madre | Para THDORA |
| P2 | Ollama en Madre | Ver [ollama.md](ollama.md) |
| P2 | Pi-hole en Madre | DNS local |
| P3 | Headscale self-hosted | Sustituir Tailscale cloud por servidor propio |
| P3 | MacBook como tercer nodo Tailscale | |
| P3 | Sincronizar dotfiles / omarchy | |

### 🟡 En progreso

| Prioridad | Tarea | Notas |
|---|---|---|
| P1 | Estabilizar acceso remoto Madre | SSH bloqueado, VNC timeout. Resolución: mañana físico |
| P2 | `whisrs` — STT offline en Acer | Instalado hoy, pendiente configurar flujo de uso |

### ✅ Finalizadas

| Tarea | Fecha |
|---|---|
| Tailscale instalado y operativo en Madre y Acer | 12 jun 2026 |
| wayvnc + tigervnc instalados | 12 jun 2026 |
| Input Leap descartado (bloqueo definitivo) | 12 jun 2026 |
| Limpieza sistema Madre | 12 jun 2026 |
| `rescate.md`, `ssh.md`, `vnc.md`, `tailscale.md` documentados | 12 jun 2026 |
| Repo `personal-v2` estructurado con `setup/servidor/` | 12 jun 2026 |

---

## Sesiones

### Sesión 12 junio 2026
- Tailscale operativo en ambos equipos
- wayvnc instalado pero sin acceso activo (VNC timeout, SSH refused)
- Diagnóstico: `sshd` y `wayvnc` no corren en Madre al arrancar
- **Bloqueante**: hay que ir físicamente a Madre para activar servicios
- Documentación completa creada: rescate, ssh, vnc, tailscale
- `whisrs` instalado en Acer con modelo `base.en` en español
- Repo `personal-v2` estructurado y actualizado con todos los protocolos

---

## Regla de Oro

> **Nunca dejar un equipo remoto sin `sshd` activo y persistente.**
> No improvisar. Si algo falla → documentar, pivotar, buscar alternativa.

---

_Ver: [rescate.md](rescate.md) · [ssh.md](ssh.md) · [vnc.md](vnc.md) · [tailscale.md](tailscale.md)_
