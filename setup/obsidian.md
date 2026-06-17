# 🔮 Obsidian — Instalación y Setup

> Vault apunta a `yggdrasil-dew/` directamente.
> Última actualización: **17 junio 2026**
> Estado: ⏳ **PENDIENTE INSTALAR HOY**

---

## Objetivo

Obsidian es la interfaz visual local para editar yggdrasil-dew sin tocar GitHub manualmente.
El vault = la raíz del repo clonado en varopc.

```
varopc (Arch Linux)
    └── ~/repos/yggdrasil-dew/   ← vault Obsidian
            └── plugin Git          ← sync automático con GitHub
```

---

## Checklist instalación (varopc — Arch Linux)

### 1. Clonar el repo si no está en local
```bash
mkdir -p ~/repos
cd ~/repos
git clone git@github.com:alvarofernandezmota-tech/yggdrasil-dew.git
```

### 2. Instalar Obsidian
```bash
# Opción A — AUR (recomendado Arch)
yay -S obsidian

# Opción B — AppImage manual
wget https://github.com/obsidianmd/obsidian-releases/releases/latest/download/Obsidian-$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep '"tag_name"' | cut -d'"' -f4 | tr -d 'v').AppImage -O ~/Apps/Obsidian.AppImage
chmod +x ~/Apps/Obsidian.AppImage
~/Apps/Obsidian.AppImage
```

### 3. Abrir vault
- Lanzar Obsidian
- → "Open folder as vault"
- → Seleccionar `~/repos/yggdrasil-dew`

### 4. Instalar plugin Git
- Settings → Community plugins → Disable safe mode
- Browse → buscar **"Git"** (autor: Vinzent03)
- Install → Enable

### 5. Configurar plugin Git
```
Settings → Git:
  - Auto pull interval: 10 (minutos)
  - Auto push interval: 0 (manual o al guardar)
  - Commit message: "vault: auto-sync {{date}}"
  - Pull on startup: ✅
```

### 6. Verificar que funciona
```bash
# En terminal, dentro del repo
cd ~/repos/yggdrasil-dew
git log --oneline -5
# Deberías ver los commits recientes
```

---

## Plugins recomendados (instalar después)

| Plugin | Para qué |
|---|---|
| **Git** | Sync automático con GitHub ← instalar primero |
| **Dataview** | Queries sobre tus notas (tipo SQL) |
| **Calendar** | Vista calendario del diario |
| **Templater** | Plantillas automáticas para diarios |
| **Smart Connections** | RAG local con Ollama |

> ⚠️ Solo instalar Git hoy. El resto en próximas sesiones.

---

## Estructura vault (ya existe en el repo)

```
yggdrasil-dew/          ← raíz del vault
├── AGENT.md
├── CONTEXT.md
├── ECOSISTEMA.md
├── diarios/
│   ├── 2026-06-17.md   ← hoy
│   └── _plantilla.md   ← plantilla base
├── proyectos/
├── setup/
├── formacion/
└── yo/
```

---

## Estado

- [ ] Repo clonado en varopc
- [ ] Obsidian instalado
- [ ] Vault abierto apuntando a `~/repos/yggdrasil-dew`
- [ ] Plugin Git instalado y configurado
- [ ] Primer commit desde Obsidian verificado

---

## Relación con el ecosistema

```
Obsidian (varopc) ↔ GitHub (yggdrasil-dew) ↔ thdora (escribe via API)
                                            ↔ Open WebUI (RAG planificado)
```

> Ver roadmap completo: [CONTEXT.md](../CONTEXT.md)
> Ver setup servidor: [servidor/README.md](servidor/README.md)

---

_Parte de [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) · 17 junio 2026_
