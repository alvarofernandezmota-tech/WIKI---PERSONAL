# Workspace — Estructura de trabajo en Madre

> Organización de carpetas, repos y entorno de desarrollo local.
> **Frecuencia de actualización: al reorganizar carpetas o añadir repos.**
> Última actualización: 14 junio 2026

---

## Estructura de `~/`

```
~/
├── dev/                  # Todos los repositorios git clonados
│   └── personal-v2/      # Repo principal — documentación, setup, vida digital
├── Projects/             # Proyectos no versionados / experimentos
├── Work/                 # Trabajo profesional
├── Documents/            # Documentos personales
├── Downloads/            # Descargas temporales
├── Pictures/             # Imágenes
├── Music/                # Música
├── Videos/               # Vídeos
└── yay/                  # Código fuente de yay (AUR helper)
```

---

## Repos en `~/dev/`

| Repo | Descripción | Estado |
|---|---|---|
| `personal-v2` | Documentación personal, setup, vida digital | ✅ Clonado |

---

## SSH — Autenticación GitHub

| Campo | Valor |
|---|---|
| **Key** | `~/.ssh/id_ed25519_github` |
| **Fingerprint** | `SHA256:SCaxT9LH38VtS/bJLX583o9YDQX++65ORxMnrgE1llQ` |
| **Registro** | GitHub → Settings → SSH Keys → `Madre` (Authentication Key) |
| **Config** | `~/.ssh/config` → `IdentityFile ~/.ssh/id_ed25519_github` |
| **Agent** | `ssh-agent` + `ssh-add` en `~/.zshrc` — sin passphrase en cada sesión |

---

## Editor

- **VSCodium** — abrir workspace completo con `codium ~/dev/`
- Permite acceso local a todos los repos para herramientas IA (OpenCode, Claude, etc.)

---

_Ver software completo en [`setup/software.md`](software.md)_
_Ver hardware en [`setup/equipos.md`](equipos.md)_
