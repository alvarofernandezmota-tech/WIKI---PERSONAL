# 🔑 Fix SSH — git pull desde Blink/madre

> El problema: `ssh-add` no funciona en Blink porque no hay ssh-agent local.
> La solución: configurar SSH para usar la clave automáticamente.

---

## 🚨 El error que ves

```
ssh-add ~/.ssh/id_ed25519_github
Could not add key KeyIsMissing
```

Esto pasa porque en Blink no corres el comando EN madre — corres el `ssh-add` en el propio teléfono, donde no existe la clave.

---

## ✅ Solución correcta

Conectarte a madre y ejecutar los comandos ALLÍ:

**Paso 1 — conectar a madre:**
```
ssh madre
```

**Paso 2 — ya EN madre, ejecutar:**
```
ssh-add ~/.ssh/id_ed25519_github
```

**Paso 3 — verificar:**
```
ssh -T git@github.com
```
Debe responder: `Hi alvarofernandezmota-tech!`

**Paso 4 — probar git pull:**
```
cd ~/yggdrasil-dew && git pull
```

---

## 🔄 Para que no pida passphrase nunca más

Ejecutar en madre (ya conectado vía SSH):

```
echo 'Host github.com' >> ~/.ssh/config
```
```
echo '  IdentityFile ~/.ssh/id_ed25519_github' >> ~/.ssh/config
```
```
echo '  AddKeysToAgent yes' >> ~/.ssh/config
```

Después añadir al final de `~/.bashrc` o `~/.zshrc` de madre:
```
echo 'eval $(ssh-agent -s) && ssh-add ~/.ssh/id_ed25519_github 2>/dev/null' >> ~/.bashrc
```

O si prefieres con `~/.profile`:
```
echo 'eval $(ssh-agent -s) && ssh-add ~/.ssh/id_ed25519_github 2>/dev/null' >> ~/.profile
```

Con esto, cada vez que abras una sesión SSH en madre, la clave se carga automáticamente.

---

## 📱 Nota Blink

Cuando Blink dice `cd: /private/var/.../home/yggdrasil-dew: no such file or directory`
significa que el comando se ejecutó EN Blink (teléfono) y no en madre.

**Regla:** Siempre `ssh madre` primero. Luego ejecutar los comandos.

---

*Ver también: `docs/BLINK-COMANDOS-SEGUROS.md`*
