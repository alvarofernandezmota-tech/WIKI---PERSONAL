# Plan Maestro — Torre Madre + Portátil Acer

> Documento de referencia inviolable. Cualquier IA o sesión nueva debe leer esto primero.
> Última actualización: 12 junio 2026, 21:09 CEST

---

## Entorno base

| Dato | Valor |
|---|---|
| OS / WM | Arch Linux / Hyprland (Wayland) — ambos equipos |
| Protocolo input sharing | `input-leap-git` ✅ instalado desde AUR |
| VPN mesh | Tailscale (`100.91.112.32` Madre, `100.86.119.102` Acer) |
| Pantallas Madre | 2 monitores externos |
| Pantalla Acer | 1 pantalla integrada |
| Gestor AUR | `yay` ✅ `/usr/bin/yay` |

---

## Fase 1 — Limpieza ✅ COMPLETADA

- Sistema limpio: servicio detenido, `/tmp` purgado, procesos residuales eliminados
- Error documentado con versión estable: `No such interface org.freedesktop.portal.InputCapture`

---

## Fase 2 — Instalación y configuración ✅ COMPLETADA

- `input-leap-git` compilado e instalado desde AUR
- `~/.config/input-leap/input-leap.conf` creado en Madre
- `~/.config/systemd/user/input-leap.service` habilitado en Madre
- `exec-once = /usr/lib/xdg-desktop-portal-hyprland` en `hyprland.conf`
- Ambos equipos reiniciados limpio

---

## Fase 3 — Desbloq. portales Wayland ⚡ EN CURSO

### 3 bloqueos identificados

| # | Problema | Causa |
|---|---|---|
| 1 | GUI genera `/tmp/` volátiles, ignora conf estática | Wrapper `input-leap` sobreescribe config |
| 2 | `input-leapc` en Acer se autotermina | `org.freedesktop.portal.RemoteDesktop` no activo |
| 3 | Portal `InputCapture` no expuesto | `xdg-desktop-portal-hyprland` no negocia la interfaz |

### Intento actual — GUI + env -u

```bash
# MADRE: usar GUI, no CLI
# Abrir input-leap GUI → configurar pantallas → Apply → esperar "Server is running"

# ACER: cliente sin portales Wayland
env -u XDG_SESSION_TYPE -u XDG_CURRENT_DESKTOP -u WAYLAND_DISPLAY \
    /usr/bin/input-leapc -f -n acer 100.91.112.32:24800
```

### Criterio de éxito
> El ratón salta entre los 2 monitores de Madre y la pantalla de Acer, sin errores en los logs.

### Si sigue fallando — Opción B
- Evaluar **barrier-git** como alternativa (fork más maduro para Wayland)
- Evaluar **lan-mouse** (implementación nativa libei, sin dependencias de portal)

---

## Fase 4 — Validación física ⏳ Pendiente

Test físico del ratón saltando Madre ↔ Acer.

---

## Fases siguientes

### Fase 5 — SSH seguro
- [ ] Claves Ed25519 Madre ↔ Acer
- [ ] Deshabilitar auth por password
- [ ] Test acceso remoto fuera de LAN

### Fase 6 — Servicios
- [ ] Auditoría Docker Acer
- [ ] PostgreSQL + THDORA + Ollama + Pi-hole

### Fase 7 — Sincronización
- [ ] dotfiles / omarchy Madre ↔ Acer
- [ ] Headscale self-hosted
- [ ] MacBook tercer nodo

---

## Regla de oro

> **No improvisar.** Si algo falla → documentar el error exacto y no saltar pasos.

---

_Ver detalles técnicos: `setup/servidor/README_CONNECT.md`_
