---
tags: [sysadmin, limpieza, repos, duplicados, pendiente-ejecutar]
fecha: 2026-06-23
estado: pendiente-ejecutar
ruta-obsidian: setup/servidor/limpieza-repos-madre.md
---

# Plan limpieza repos Madre

## Problema

Hay repos duplicados en `~/dev/` y `~/Projects/`. La ruta canónica es `~/Projects/`.

## Estado actual

| Ruta | Estado | Acción |
|---|---|---|
| `~/Projects/yggdrasil-dew` | ✅ activo / vault Obsidian | NO TOCAR |
| `~/Projects/thdora` | ✅ activo | NO TOCAR |
| `~/Projects/personal` | ⚠️ legacy (viejo cerebro) | Revisar y archivar |
| `~/dev/personal` | 🗑️ duplicado de Projects/personal | Borrar |
| `~/dev/personal-v2` | ❓ posible contenido útil | Revisar antes de borrar |
| `~/dev/thdora` | 🗑️ duplicado de Projects/thdora | Borrar |
| `~/spiderfoot` | ✅ activo (OSINT local) | Mantener o mover a Projects/ |
| `~/sfd_tool` | ❓ pendiente documentar | Mover a Projects/ |

## Comandos de limpieza (ejecutar en orden)

```bash
# 1. Revisar personal-v2 antes de borrar
ls ~/dev/personal-v2/
git -C ~/dev/personal-v2 log --oneline -10

# 2. Si no tiene nada útil, borrar duplicados
rm -rf ~/dev/personal
rm -rf ~/dev/personal-v2
rm -rf ~/dev/thdora
rmdir ~/dev  # si queda vacía

# 3. Mover sfd_tool a Projects si es un proyecto activo
mv ~/sfd_tool ~/Projects/sfd_tool

# 4. Opcional: mover spiderfoot a Projects
mv ~/spiderfoot ~/Projects/spiderfoot
```

## Estado descargas Docker

| Imagen | Tamaño | Estado | Problema |
|---|---|---|---|
| `ollama/ollama:latest` | 3.4 GB | ❌ cortando | TLS bad record MAC (hotspot inestable) |
| `open-webui:main` | 1.7 GB | ❌ cortando | idem |

### Solución definitiva para descargas

```bash
# Lanzar en tmux para que sobreviva cortes
tmux new -s ollama
cd ~/docker/batcueva-nueva
docker pull ollama/ollama:latest
# Ctrl+B D → desconectar (sigue en background)
# tmux attach -t ollama → reconectar
```

Las capas ya descargadas NO se vuelven a bajar. Cada reintento avanza.

## Post-limpieza

Estructura objetivo:
```
~/Projects/
├── yggdrasil-dew/   ← segundo cerebro
├── thdora/          ← bot telegram
├── sfd_tool/        ← (mover desde ~/)
└── spiderfoot/      ← (mover desde ~/)

~/docker/
└── batcueva-nueva/  ← ollama + open-webui
```
