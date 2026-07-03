# iPhone SSH via Blink Shell

> Estado: ✅ OPERATIVO — 03-jul-2026

## Resumen

Acceso SSH completo desde iPhone 11 a Madre via Tailscale usando Blink Shell.
Doble capa de seguridad: Tailscale VPN + autenticación por clave ed25519.

## Arquitectura

```
iPhone (Blink Shell)
    ↓ Tailscale VPN
Madre (100.91.112.32)
    ↓ SSH ed25519
shell varopc
```

## Dispositivos en la tailnet

| Dispositivo | IP Tailscale | OS |
|---|---|---|
| Madre (varpc) | 100.91.112.32 | Linux |
| iPhone 11 | 100.81.187.99 | iOS |
| Acer (varo12f) | 100.86.119.102 | Linux |
| Xiaomi | 100.106.133.70 | Android |

## Apps instaladas en iPhone

- **Blink Shell** — terminal SSH/mosh principal
- **Tailscale** — VPN mesh para acceso a Madre

## Claves SSH en Madre (~/.ssh/authorized_keys)

| Clave | Dispositivo | Fingerprint |
|---|---|---|
| id_ed25519_github | Acer (varo12f) | SHA256:SCaxT9LH38VtS/bJLX583o9YDQX++65ORxMnrgE1llQ |
| blink-madre | iPhone 11 (Blink) | SHA256:xGUWaZiKesrnY8Lt4tsLp+V6O52WEFU7HXk79uJRSk8 |

## Configuración Blink Shell

### Host madre
```
Host alias:  madre
HostName:    100.91.112.32
User:        varopc
Key:         blink-madre
Port:        22
```

### Conectar
```
ssh madre
```

## Configuración SSH Acer (~/.ssh/config)

```
Host madre
  HostName 100.91.112.32
  User varopc
  IdentityFile ~/.ssh/id_ed25519_github
  IdentitiesOnly yes
```

## SSH Hardening aplicado en Madre (03-jul-2026)

Comandos ejecutados via `bootstrap-madre.sh`:

```bash
# Backup sshd_config
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak.FECHA

# Habilitar autenticación por clave pública
PubkeyAuthentication yes

# Deshabilitar login por contraseña
PasswordAuthentication no

# Deshabilitar root login por SSH
PermitRootLogin no

# Validar y reiniciar
sudo sshd -t && sudo systemctl restart sshd
```

### Resultado verificado
- ✅ `PubkeyAuthentication yes`
- ✅ `PasswordAuthentication no`
- ✅ `PermitRootLogin no`
- ✅ sshd activo y sin errores de config

## Seguridad

- La IP `100.91.112.32` es privada a Tailscale — no expuesta a internet
- Solo dispositivos del tailnet de `alvarofernandezmota@` pueden alcanzar Madre
- Encima de Tailscale va SSH con ed25519 — doble capa
- UFW activo en Madre con reglas Tailscale
- Acceso por contraseña deshabilitado — solo claves

## Comandos útiles desde iPhone (Blink)

```bash
# Conectar a Madre
ssh madre

# Ver estado del sistema
uptime && df -h && free -h

# Ver logs recientes
journalctl -n 50 --no-pager

# Ver estado Docker
docker ps

# Ver estado Tailscale
tailscale status

# Snapshot rápido
cat ~/audits/$(ls -t ~/audits/ | head -1)
```

## Troubleshooting

### authFailed(methods: [SSH.AuthAgent])
Blink está usando el agente en vez de la clave.
→ `config` → Hosts → madre → Key → seleccionar `blink-madre`

### No such file or directory
El host `madre` no está creado en Blink.
→ `config` → Hosts → + → rellenar campos

### Connection refused
Tailscale no está activo en iPhone o Madre.
→ Abrir app Tailscale en iPhone → verificar que Madre aparece como `active`

---

_Documentado por Perplexity MCP — 03-jul-2026_
_Issue relacionado: #23_
