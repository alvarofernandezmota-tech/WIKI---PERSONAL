# 📱 Blink Shell — Comandos seguros

> Guía para usar Blink sin que los comentarios se ejecuten como comandos.

---

## ⚠️ El problema

Cuando pegas un bloque de código con comentarios (`# texto`) en Blink,
cada línea se ejecuta como un comando separado. Los `#` se interpretan
como comandos y da error:
```
#: command not found
```

## ✅ Solución: comandos de una sola línea

Nunca pegues bloques. Usa **comandos encadenados con `;` o `&&`**.

---

## 📋 Comandos de uso diario (seguros para pegar en Blink)

### Iniciar sesión
```
ssh madre
```
Después, ya en madre:
```
cd ~/yggdrasil-dew && git pull && bash scripts/maintenance/new-session.sh
```

### Fix SSH (ejecutar en madre, línea por línea)
```
cat ~/.ssh/id_ed25519.pub
```
Copiar el output → ir a https://github.com/settings/keys → New SSH key → pegar
```
ssh -T git@github.com
```
Debe responder: `Hi alvarofernandezmota-tech!`
```
gh auth login
```

### Guardar cambios en ygg
```
cd ~/yggdrasil-dew && git add -A && git commit -m "docs: descripcion" && git push
```

### Ver issues abiertos
```
gh issue list --repo alvarofernandezmota-tech/yggdrasil-dew --state open
```

### Verificar carpeta artefacto
```
ls ~/yggdrasil-dew/alvarofernandezmota-tech/
```

### Borrar carpeta artefacto (si está vacía)
```
rm -rf ~/yggdrasil-dew/alvarofernandezmota-tech/ && cd ~/yggdrasil-dew && git add -A && git commit -m "chore: borrar artefacto carpeta" && git push
```

### Fix keepalive Blink (ejecutar en Blink, no en madre)
```
micro ~/.ssh/config
```
Añadir:
```
Host madre
  HostName 100.91.112.32
  ServerAliveInterval 60
  ServerAliveCountMax 3
  TCPKeepAlive yes
```

---

## 🔴 Comandos que NUNCA hay que pegar en Blink

- Bloques con `# comentarios` al principio de línea
- Scripts multi-línea con saltos de línea
- Cualquier cosa que empiece por `# ---`

## ✅ Alternativa: ejecutar scripts desde madre

En vez de pegar comandos, guarda el script en la repo y ejecútalo:
```
ssh madre "bash ~/yggdrasil-dew/scripts/maintenance/new-session.sh"
```

---

*Ver también: [FIX-SSH-MADRE.md](FIX-SSH-MADRE.md)*
