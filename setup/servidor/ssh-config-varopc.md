---
tags: [ssh, config, varopc, madre, acceso]
fecha: 2026-06-25
estado: problema-activo
---

# SSH Config varopc → Madre

## Estado actual (25 jun 13:19)

| Elemento | Estado |
|---|---|
| Clave instalada en Madre | ✅ (ssh-copy-id ejecutado, WARNING: already exists) |
| ~/.ssh/config | ⚠️ CORRUPTO — arreglar ahora |
| SSH sin contraseña | ❌ sigue pidiendo password |
| Causa | config con línea `eofcat` inválida |

## Fix inmediato — editar config a mano

```bash
nano ~/.ssh/config
```

Borrar todo y dejar EXACTAMENTE esto (sin líneas extra):

```
Host madre
  HostName 100.91.112.32
  User varopc
  IdentityFile ~/.ssh/id_ed25519_github
```

Guardar: `Ctrl+O` → `Enter` → `Ctrl+X`

Verificar:
```bash
ssh madre "echo ok"
```

## Alternativa sin nano

```bash
cat > ~/.ssh/config << 'SSHEOF'
Host madre
  HostName 100.91.112.32
  User varopc
  IdentityFile ~/.ssh/id_ed25519_github
SSHEOF
chmod 600 ~/.ssh/config
```

## Por qué no funciona sudo por SSH sin -t

```bash
# INCORRECTO — falla sin terminal
ssh madre "sudo mkdir ..."

# CORRECTO — abre pseudo-terminal
ssh -t madre "sudo mkdir -p /opt/batcueva/headscale && sudo chown -R varopc:varopc /opt/batcueva"
```

## Datos de acceso

| Parámetro | Valor |
|---|---|
| IP Tailscale Madre | 100.91.112.32 |
| Usuario | varopc |
| Clave privada | ~/.ssh/id_ed25519_github |
| Puerto | 22 (estándar) |

---
_Actualizado: 25 jun 2026 13:19 CEST_
