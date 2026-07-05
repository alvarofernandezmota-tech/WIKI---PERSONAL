---
tags: [vida, rutinas, habitos]
fecha-actualizacion: 2026-07-05
---

# 🔄 Rutinas y hábitos

Sistemas de vida personal vinculados al ecosistema técnico.

## Rutina de inicio de sesión técnica

```bash
# 1. Sincronizar repos
cd ~/repos/WIKI---PERSONAL && git pull

# 2. Ver estado del sistema
cat ~/repos/WIKI---PERSONAL/ESTADO-SISTEMA.md

# 3. Ver pendientes
cat ~/repos/WIKI---PERSONAL/MASTER-PENDIENTES.md
```

## Rutina de cierre de sesión

```bash
# 1. Actualizar diario técnico
nano ~/repos/WIKI---PERSONAL/diarios/2026/$(date +%Y-%m-%d).md

# 2. Sincronizar todo
cd ~/repos/WIKI---PERSONAL && git add . && git commit -m "diario: $(date +%Y-%m-%d)" && git push
```

## Diario personal
→ Ver [VIDAPERSONAL/diarios](https://github.com/alvarofernandezmota-tech/VIDAPERSONAL/tree/main/diarios)
