# GitHub — Configuración en Madre

> Última actualización: 13 junio 2026

---

## Estado

| Item | Estado |
|---|---|
| Git en Madre | ⏳ Pendiente configurar |
| Clave SSH Madre → GitHub | ⏳ Pendiente |
| Repos clonados en Madre | ⏳ Pendiente |

---

## Configuración inicial

```bash
# Identidad
git config --global user.name "alvarofernandezmota-tech"
git config --global user.email "alvarofernandezmota@gmail.com"
git config --global core.autocrlf input  # evitar problemas CRLF
git config --global init.defaultBranch main

# Clave SSH para GitHub
ssh-keygen -t ed25519 -C "madre-github"
cat ~/.ssh/id_ed25519.pub
# Copiar y añadir en: github.com → Settings → SSH Keys

# Verificar
ssh -T git@github.com
```

---

## Repos a clonar en Madre

```bash
mkdir -p ~/repos
cd ~/repos

# Repo personal
git clone git@github.com:alvarofernandezmota-tech/personal-v2.git

# THDORA (cuando se migre)
# git clone git@github.com:alvarofernandezmota-tech/thdora.git
```

---

## Flujo de trabajo

```bash
# En Madre — editar con VSCode Remote SSH desde Acer
# Commits y push desde Madre directamente
git add . && git commit -m "feat: descripcion" && git push
```

---

_Ver también: [vscode.md](vscode.md) · [ssh.md](ssh.md)_
_Volver al índice: [README.md](README.md)_
