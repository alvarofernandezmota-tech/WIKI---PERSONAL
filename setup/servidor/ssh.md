# SSH — Acceso remoto seguro

> Última actualización: 13 junio 2026

---

## Estado actual

| Nodo | sshd | Clave Ed25519 | Acceso sin contraseña |
|---|---|---|---|
| Madre (`varopc`) | ✅ Activo y persistente | ✅ Creada | ⚠️ Pendiente verificar permisos |
| Acer (`varo`) | — | ✅ Creada | ✅ Origen |

---

## Flujo completo: Acer → Madre

### Paso 1 — Activar sshd en Madre (físico, una sola vez)
```bash
# En Madre
sudo systemctl enable --now sshd
ss -tlnp | grep 22  # verificar: debe mostrar 0.0.0.0:22
```

### Paso 2 — Crear clave en Acer y copiarla a Madre
```bash
# En Acer
ssh-keygen -t ed25519 -C "acer" -f ~/.ssh/id_ed25519 -N ""
ssh-copy-id -i ~/.ssh/id_ed25519.pub varopc@100.91.112.32
# Pide contraseña de varopc una única vez
```

### Paso 3 — Corregir permisos en Madre (crítico)
```bash
# En Madre
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```
> SSH rechaza la clave si los permisos son demasiado abiertos.

### Paso 4 — Verificar acceso sin contraseña
```bash
# En Acer
ssh varopc@100.91.112.32
# Debe entrar directamente sin pedir contraseña
```

### Paso 5 — Atajo permanente (opcional)
```bash
# En Acer: añadir a ~/.ssh/config
Host madre
    HostName 100.91.112.32
    User varopc
    IdentityFile ~/.ssh/id_ed25519
```
Despues de esto: `ssh madre` en lugar de `ssh varopc@100.91.112.32`

---

## Diagnóstico si sigue pidiendo contraseña

```bash
# En Madre — ver logs SSH en tiempo real
sudo journalctl -u sshd -f
# (en otra terminal, intentar conectar desde Acer)

# Verificar que la clave está en authorized_keys
cat ~/.ssh/authorized_keys

# Verificar configuración sshd
sudo sshd -T | grep -E 'pubkeyauthentication|passwordauthentication'
```

---

## Hardening (tras confirmar acceso sin contraseña)

```bash
# En Madre: editar /etc/ssh/sshd_config
sudo nano /etc/ssh/sshd_config
```

Cambiar o añadir:
```
PubkeyAuthentication yes
PasswordAuthentication no
PermitRootLogin no
AuthorizedKeysFile .ssh/authorized_keys
```

Reiniciar sshd:
```bash
sudo systemctl restart sshd
```

> ⚠️ NO deshabilitar PasswordAuthentication hasta confirmar que la clave funciona.

---

## Prompt de terminal — saber en qué máquina estás

Añadir al final de `~/.zshrc` en **cada máquina**:

```bash
# En Acer (~/.zshrc)
export MACHINE_NAME="💻 Acer"

# En Madre (~/.zshrc)
export MACHINE_NAME="🖥️ Madre"
```

Si usas omarchy/starship, el hostname ya aparece. Verificar con:
```bash
echo $PROMPT  # zsh nativo
# o
starship config  # si usas starship
```

Alternativa rápida — ver siempre en qué máquina estás:
```bash
hostname  # muestra el nombre del equipo
whoami    # muestra el usuario
```

---

## Credenciales

| Nodo | Usuario | IP Tailscale | Puerto |
|---|---|---|---|
| Madre | `varopc` | `100.91.112.32` | `22` |
| Acer | `varo` | `100.86.119.102` | `22` |

---

_Ver: [rescate.md](rescate.md) · [tailscale.md](tailscale.md) · [fail2ban.md](fail2ban.md)_
