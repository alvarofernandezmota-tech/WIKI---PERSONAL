# VSCode — Editor con Remote SSH

> Última actualización: 13 junio 2026
> Host: Acer — ejecuta en Madre por SSH

---

## Estado

| Item | Estado |
|---|---|
| VSCode en Acer | ✅ Instalado |
| Remote - SSH extension | ⏳ Pendiente configurar |
| Conexión a Madre | ⏳ Pendiente (requiere sshd activo) |

---

## Instalar extensión Remote SSH

```bash
code --install-extension ms-vscode-remote.remote-ssh
```

---

## Configurar host Madre

Editar `~/.ssh/config` en Acer:

```
Host madre
    HostName 100.91.112.32
    User varo
    IdentityFile ~/.ssh/id_ed25519
```

Conectar: `Ctrl+Shift+P` → `Remote-SSH: Connect to Host` → `madre`

---

## Extensiones recomendadas para instalar en Madre

```bash
# Python
code --install-extension ms-python.python
# Docker
code --install-extension ms-azuretools.vscode-docker
# PostgreSQL
code --install-extension cweijan.vscode-postgresql-client2
# GitLens
code --install-extension eamodio.gitlens
```

---

_Ver también: [ssh.md](ssh.md) · [dbeaver.md](dbeaver.md)_
_Volver al índice: [README.md](README.md)_
