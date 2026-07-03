---
tags: [critico, fix, madre, inbox]
fecha: 2026-07-03
estado: pendiente-ejecutar
prioridad: CRITICA
---

# 🚨 FIX CRÍTICO: Configurar Madre correctamente

> Esto explica TODOS los errores de la sesión de hoy.
> Ejecutar en cuanto tengas terminal en Madre.

---

## El problema raíz

```
bash: /home/varopc/yggdrasil-dew/...: No such file or directory
```

**El repo yggdrasil-dew NO está clonado en Madre.**
Por eso todos los scripts fallan: la ruta no existe.

---

## Fix completo (copiar y pegar en Madre)

```bash
# PASO 1: Clonar yggdrasil-dew en Madre
cd ~
git clone https://github.com/alvarofernandezmota-tech/yggdrasil-dew.git

# PASO 2: Dar permisos a todos los scripts
bash ~/yggdrasil-dew/scripts/maintenance/setup-permissions.sh

# PASO 3: Verificar que thdora existe
ls ~/Projects/thdora/  # debe existir

# PASO 4: Levantar Docker de thdora
cd ~/Projects/thdora
docker compose up -d --build

# PASO 5: Verificar que todo funciona
bash ~/yggdrasil-dew/scripts/maintenance/health-check.sh

# PASO 6: Cerrar sesión correctamente
bash ~/yggdrasil-dew/scripts/maintenance/close-session.sh
```

---

## Por qué investigador-maestro falló

```
cd ~/Projects/investigador-maestro# crear main.py...
```

blink estaba pegando el comentario junto al comando `cd`.
El directorio tampoco existe porque no se ha creado.
Eso es un proyecto distinto, pendiente de crear en Madre.

---

_Creado: 2026-07-03 — sesión matutina_
