---
tags: [fase3, docker, incidencias, errores, soluciones]
fecha: 2026-06-25
estado: en-progreso
---

# Fase 3 — Incidencias y estado 25 jun

## Estado actual

| Servicio | Estado | Notas |
|---|---|---|
| n8n | ⏳ descargando | imagen n8nio/n8n |
| gitea | ⏳ descargando | imagen gitea/gitea |
| code-server | ⏳ descargando | imagen linuxserver/code-server |
| headscale | ❌ falló | TLS bad record MAC durante pull |
| Red batcueva | ✅ creada | ID: 9a4000a8... |

## Incidencias encontradas

### 1. Permission denied en /opt/batcueva
**Error:**
```
mkdir: cannot create directory '/opt/batcueva': Permission denied
```
**Causa:** varopc no tiene permisos en /opt sin sudo.

**Fix:**
```bash
ssh -t madre "sudo mkdir -p /opt/batcueva/headscale && sudo chown -R varopc:varopc /opt/batcueva"
```

### 2. TLS bad record MAC en headscale pull
**Error:**
```
failed to copy: local error: tls: bad record MAC
```
**Causa:** corrupción de paquete de red durante la descarga. Error transitorio.

**Fix:** relanzar el compose — Docker reintenta automáticamente:
```bash
ssh madre "cd ~/yggdrasil-dew && docker compose -f setup/servidor/batcueva-fase3.yml up -d"
```

### 3. sudo por SSH sin -t
**Error:**
```
sudo: a terminal is required to read the password
```
**Fix:** usar `ssh -t` para abrir pseudo-terminal:
```bash
ssh -t madre "sudo <comando>"
```

### 4. SSH config corrupto
**Error:**
```
/home/varopc/.ssh/config: line 16: Bad configuration option: eofcat
```
**Causa:** heredoc mal pegado — `EOF` y `cat` se unieron como `eofcat`.

**Fix:** ver setup/servidor/ssh-config-varopc.md

### 5. SSH sigue pidiendo contraseña
**Causa:** config corrupto → no carga la IdentityFile correcta.
**Fix:** arreglar config primero (punto 4), luego funciona sin password.

## Comando de relanzamiento (una vez arreglado SSH)

```bash
# Paso 1 — carpetas con sudo
ssh -t madre "sudo mkdir -p /opt/batcueva/headscale && sudo chown -R varopc:varopc /opt/batcueva"

# Paso 2 — relanzar fase 3
ssh madre "cd ~/yggdrasil-dew && docker compose -f setup/servidor/batcueva-fase3.yml up -d"

# Paso 3 — verificar
ssh madre "docker ps --filter label=batcueva.fase=3"
```

## Headscale — config necesario antes de arrancar

Archivo a crear en Madre: `/opt/batcueva/headscale/config.yaml`

```yaml
server_url: http://100.91.112.32:8085
listen_addr: 0.0.0.0:8080
metrics_listen_addr: 0.0.0.0:9090
private_key_path: /var/lib/headscale/private.key
noise:
  private_key_path: /var/lib/headscale/noise_private.key
ip_prefixes:
  - 100.64.0.0/10
derp:
  server:
    enabled: false
  urls:
    - https://controlplane.tailscale.com/derpmap/default
database:
  type: sqlite3
  path: /var/lib/headscale/db.sqlite
```

Crearlo:
```bash
ssh madre "cat > /opt/batcueva/headscale/config.yaml" << 'EOF'
server_url: http://100.91.112.32:8085
listen_addr: 0.0.0.0:8080
metrics_listen_addr: 0.0.0.0:9090
private_key_path: /var/lib/headscale/private.key
noise:
  private_key_path: /var/lib/headscale/noise_private.key
ip_prefixes:
  - 100.64.0.0/10
derp:
  server:
    enabled: false
  urls:
    - https://controlplane.tailscale.com/derpmap/default
database:
  type: sqlite3
  path: /var/lib/headscale/db.sqlite
EOF
```

---
_Actualizado: 25 jun 2026 13:19 CEST_
