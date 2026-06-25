---
tags: [fase3, docker, incidencias, errores, soluciones]
fecha: 2026-06-25
estado: en-progreso
---

# Fase 3 — Incidencias y estado

## Estado servicios (25 jun 13:21)

| Servicio | Estado | Notas |
|---|---|---|
| Red batcueva | ✅ creada | ID: 9a4000a8... |
| n8n | ⏳ imagen descargada | pendiente arrancar |
| gitea | ⏳ imagen descargada | pendiente arrancar |
| code-server | ⏳ imagen descargada | pendiente arrancar |
| headscale | ⚠️ TLS error | relanzar — error transitorio de red |

## Incidencias resueltas

### 1. /opt/batcueva Permission denied
**Error:** `mkdir: cannot create directory '/opt/batcueva': Permission denied`
**Causa:** varopc no tiene permisos en /opt sin sudo.
**Resolución:** ❌ **No hace falta** — headscale usa volúmenes Docker nombrados, no /opt.

### 2. TLS bad record MAC en headscale pull
**Error:** `failed to copy: local error: tls: bad record MAC`
**Causa:** corrupción transitoria de red durante descarga.
**Fix:** relanzar el compose — Docker reintenta desde donde quedó:
```bash
ssh madre "cd ~/yggdrasil-dew && docker compose -f setup/servidor/batcueva-fase3.yml up -d"
```

### 3. sudo por SSH sin -t
**Error:** `sudo: a terminal is required to read the password`
**Fix:** `ssh -t madre "sudo <comando>"`

### 4. ~/.ssh/config corrupto (eofcat)
**Error:** `Bad configuration option: eofcat`
**Causa:** heredoc mal pegado en terminal — `EOF` y `cat` del siguiente comando se unieron.
**Fix:** ver ssh-config-varopc.md — usar `SSHEOF` como delimitador.

### 5. code-server montaba ~ en vez de ruta absoluta
**Error:** en Docker `~` apunta al usuario del demonio, no a varopc.
**Fix aplicado en YML:** `~/yggdrasil-dew` → `/home/varopc/yggdrasil-dew`

### 6. git pull fallaba con rebase (unstaged changes)
**Error:** `error: cannot pull with rebase: You have unstaged changes`
**Fix:** `git stash && git pull`

### 7. git@github.com Permission denied
**Error:** `Permission denied (publickey)` al hacer git push/pull en Madre
**Causa:** Madre no tiene clave SSH configurada para GitHub.
**Fix:** cambiar remote a HTTPS:
```bash
git remote set-url origin https://github.com/alvarofernandezmota-tech/yggdrasil-dew.git
```

## Comando final para levantar Fase 3

```bash
# Arreglar SSH config primero (ver ssh-config-varopc.md)
# Luego:
ssh madre "cd ~/yggdrasil-dew && \
  set -a && source ~/.env && set +a && \
  docker compose -f setup/servidor/batcueva-fase3.yml up -d && \
  docker ps --filter label=batcueva.fase=3"
```

---
_Actualizado: 25 jun 2026 13:21 CEST_
