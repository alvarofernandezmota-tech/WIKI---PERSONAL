# REGLA DE RUTAS — Convencion Absoluta del Ecosistema

> Esta regla es INMUTABLE. Todo script, doc e issue debe respetarla.

## Usuario y rutas base en Madre

```
Usuario:       varopc
Home:          /home/varopc
Repo:          /home/varopc/yggdrasil-dew
Scripts:       /home/varopc/yggdrasil-dew/scripts/
Logs:          /home/varopc/yggdrasil-dew/logs/
Config:        /home/varopc/yggdrasil-dew/config/
Core:          /home/varopc/yggdrasil-dew/core/
Docs:          /home/varopc/yggdrasil-dew/docs/
Inbox:         /home/varopc/yggdrasil-dew/inbox/
Backups:       /home/varopc/backups/
```

## Regla de escritura de scripts

Cada script DEBE comenzar con estas 3 lineas obligatorias:

```bash
#!/bin/bash
# RUTA ABSOLUTA: /home/varopc/yggdrasil-dew/scripts/<categoria>/<nombre>.sh
# Uso desde Madre: bash /home/varopc/yggdrasil-dew/scripts/<categoria>/<nombre>.sh
REPO=/home/varopc/yggdrasil-dew
cd $REPO || { echo 'ERROR: repo no encontrado en $REPO'; exit 1; }
```

## Secuencia de arranque desde Madre (SIEMPRE)

```bash
# 1. Conectar
ssh madre   # o: ssh varopc@100.91.112.32

# 2. Ir al repo (SIEMPRE con ruta absoluta)
cd /home/varopc/yggdrasil-dew

# 3. Sincronizar con GitHub ANTES de ejecutar cualquier script
git pull origin main

# 4. Dar permisos si es la primera vez o hay scripts nuevos
find /home/varopc/yggdrasil-dew/scripts -name '*.sh' -exec chmod +x {} \;

# 5. Ejecutar
bash /home/varopc/yggdrasil-dew/scripts/maintenance/<script>.sh
```

## Por que zoxide falla

`cd yggdrasil-dew` falla si zoxide no tiene el directorio indexado.
Solucion: SIEMPRE usar ruta absoluta `/home/varopc/yggdrasil-dew`
O anadir alias en ~/.zshrc:
```bash
alias repo='cd /home/varopc/yggdrasil-dew && git pull origin main'
```

## Alias recomendados en ~/.zshrc de Madre

```bash
export REPO=/home/varopc/yggdrasil-dew
alias repo='cd $REPO && git pull origin main'
alias close='bash $REPO/scripts/maintenance/session-close.sh'
alias morning='bash $REPO/scripts/maintenance/morning-check.sh'
alias audit='bash $REPO/scripts/maintenance/audit-full.sh'
alias gitpull='cd $REPO && git pull origin main && find $REPO/scripts -name "*.sh" -exec chmod +x {} \;'
```

_Perplexity MCP — 03-jul-2026_
