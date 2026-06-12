# Protocolo de Rescate — Recuperar acceso desde dentro

> Usar cuando no hay acceso remoto y hay que ir físicamente a Madre.

---

## Regla de Oro

> **Nunca dejar un equipo remoto sin `sshd` activo y persistente.**
> Si no puedes entrar por SSH, no puedes entrar desde fuera.

---

## A. Recuperar SSH (prioridad 1)

```bash
# Instalar si no está
sudo pacman -S openssh

# Activar y hacer persistente
sudo systemctl enable --now sshd

# Verificar
sudo systemctl status sshd
```

Desde ese momento, desde cualquier sitio:
```bash
ssh varo@100.91.112.32   # por Tailscale
```

---

## B. Recuperar VNC manual (si SSH no es suficiente)

```bash
# Lanzar wayvnc manualmente (requiere sesión Wayland activa)
/usr/bin/wayvnc --seat=seat0 --output=DP-1 0.0.0.0 5900
```

Desde Acer:
```bash
vncviewer 100.91.112.32:5900   # por Tailscale
vncviewer 10.176.119.171:5900  # por LAN
```

> ⚠️ wayvnc requiere que haya una sesión Wayland/Hyprland activa. No funciona desde TTY.

---

## C. Checklist post-rescate

- [ ] `sshd` activo: `systemctl is-enabled sshd`
- [ ] Tailscale activo: `tailscale status`
- [ ] Clave pública SSH copiada desde Acer:
  ```bash
  ssh-copy-id varo@100.91.112.32
  ```
- [ ] Test final desde Acer: `ssh varo@100.91.112.32`
- [ ] UFW configurado en Madre:
  ```bash
  sudo pacman -S ufw
  sudo ufw default deny incoming
  sudo ufw allow from 100.86.119.102 to any port 22
  sudo ufw allow from 100.86.119.102 to any port 5900
  sudo ufw enable
  sudo systemctl enable ufw
  sudo ufw status verbose
  ```
- [ ] autostart `wayvnc` en Hyprland (`~/.config/hypr/hyprland.conf`):
  ```ini
  exec-once = /usr/bin/wayvnc --seat=seat0 --output=DP-1 0.0.0.0 5900
  ```

---

## D. Señales de que esto volverá a pasar

- Instalaste el servicio pero olvidaste `systemctl enable`
- Reiniciaste Madre sin verificar que sshd arranca solo
- No tienes clave SSH configurada (dependes de contraseña)
- No tienes UFW activo — cualquier puerto abierto es un riesgo

---

_Ver también: [ssh.md](ssh.md) · [tailscale.md](tailscale.md) · [vnc.md](vnc.md) · [ufw.md](ufw.md)_
