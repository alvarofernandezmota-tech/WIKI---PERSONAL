# 🔑 Fix: SSH key de madre en GitHub

**Prioridad:** 🔴 BLOQUEANTE  
**Tiempo estimado:** 5 minutos

---

## Síntoma

```
git@github.com: Permission denied (publickey)
fatal: Could not read from remote repository.
```

## Pasos (ejecutar en madre)

```bash
# 1. Ver si ya existe una clave
ls ~/.ssh/id_*.pub

# 2a. Si existe — copiar la clave pública
cat ~/.ssh/id_ed25519.pub
# o
cat ~/.ssh/id_rsa.pub

# 2b. Si NO existe — generar una nueva
ssh-keygen -t ed25519 -C "madre-yggdrasil" -f ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub

# 3. Copiar el output (empieza por ssh-ed25519 o ssh-rsa)
# Ir a: https://github.com/settings/keys
# → New SSH key → pegar → Save

# 4. Verificar
ssh -T git@github.com
# Debe responder: Hi alvarofernandezmota-tech! You've successfully authenticated

# 5. Autenticar gh CLI
gh auth login
# Elegir: GitHub.com → SSH → usar la misma clave

# 6. Verificar git pull
cd ~/yggdrasil-dew && git pull
```

## Fix Blink SSH timeout (en iPhone)

Editar `~/.ssh/config` en el iPhone (desde Blink):

```
Host madre
  HostName 100.91.112.32
  User alvaro
  ServerAliveInterval 60
  ServerAliveCountMax 3
  TCPKeepAlive yes
```

```bash
# Aplicar desde Blink:
micro ~/.ssh/config
# o
nano ~/.ssh/config
```

---

*Cerrar este doc cuando esté resuelto — mover a docs/RESUELTO/*
