---
tags: [ssh, config, varopc, madre, acceso, fix]
fecha: 2026-06-25
estado: fix-pendiente
---

# SSH Config varopc → Madre

## Estado actual (25 jun 13:21)

| Elemento | Estado | Notas |
|---|---|---|
| Clave en Madre | ✅ instalada | ssh-copy-id ejecutado |
| ~/.ssh/config | ❌ CORRUPTO | línea `eofcat` inválida en línea 16 |
| SSH sin contraseña | ❌ bloqueado | por config corrupto |
| nano disponible | ❌ no instalado | usar vi o cat |

## Fix — reescribir config con cat (sin heredoc)

```bash
cat > ~/.ssh/config << 'SSHEOF'
Host madre
  HostName 100.91.112.32
  User varopc
  IdentityFile ~/.ssh/id_ed25519_github
SSHEOF
chmod 600 ~/.ssh/config
ssh madre "echo ok"
```

> ⚠️ Usar `SSHEOF` como delimitador, no `EOF` — evita el bug de `eofcat`

## Alternativa con vi

```bash
vi ~/.ssh/config
# i para insertar, pegar el bloque, ESC :wq para guardar
```

## Config correcto

```
Host madre
  HostName 100.91.112.32
  User varopc
  IdentityFile ~/.ssh/id_ed25519_github
```

## Por qué sudo necesita -t

```bash
# FALLA — sin terminal interactivo
ssh madre "sudo mkdir ..."

# FUNCIONA — pseudo-terminal
ssh -t madre "sudo mkdir -p /opt/batcueva && sudo chown -R varopc:varopc /opt/batcueva"
```

## IMPORTANTE: /opt/batcueva NO hace falta para Fase 3

Headscale usa volúmenes Docker nombrados (`headscale_config`, `headscale_data`).
El mkdir de /opt era innecesario. **Fase 3 arranca sin tocar /opt.**

## Datos conexión

| Parámetro | Valor |
|---|---|
| IP Tailscale Madre | 100.91.112.32 |
| Usuario | varopc |
| Clave | ~/.ssh/id_ed25519_github |
| Puerto | 22 |

---
_Actualizado: 25 jun 2026 13:21 CEST_
