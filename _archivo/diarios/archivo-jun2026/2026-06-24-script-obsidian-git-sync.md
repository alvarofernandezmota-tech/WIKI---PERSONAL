---
tags: [inbox, obsidian, git, sync, varopc, automatizacion]
fecha: 2026-06-24
estado: pendiente-varopc
destino: setup/varopc/obsidian-git-sync.md
---

# Obsidian Git Sync — Setup varopc

> Configurar en varopc (theodora) para auto-commit desde Obsidian.
> Ejecutar cuando estes en varopc con Obsidian abierto.

---

## Prerequisitos

```bash
# En varopc, clonar el repo si no esta
git clone git@github.com:alvarofernandezmota-tech/yggdrasil-dew.git ~/yggdrasil-dew
cd ~/yggdrasil-dew && git pull
```

## Plugins Obsidian a instalar

1. **Obsidian Git** — auto-commit y push
2. **Dataview** — queries sobre notas
3. **Templater** — plantillas automaticas
4. **Calendar** — vista diarios

## Configuracion Obsidian Git

```
Settings > Community Plugins > Obsidian Git:
- Vault backup interval: 10 (minutos)
- Auto pull interval: 10
- Commit message: "vault: auto-commit {{date}}"
- Pull updates on startup: ON
- Push on backup: ON
- Carpeta inbox como default nuevas notas
```

## Abrir vault en Obsidian

```
Obsidian > Open folder as vault > ~/yggdrasil-dew
```

## Configurar inbox como default

```
Settings > Files & Links:
- Default location for new notes: In the folder specified below
- Folder: inbox
```

---
_Destino: setup/varopc/obsidian-git-sync.md_
