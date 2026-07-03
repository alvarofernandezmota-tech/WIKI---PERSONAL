# 📥 Pendientes S21 — Próxima sesión

> Procesar antes de empezar cualquier tarea nueva.

---

## 🔴 Bloqueantes (hacer primero)

### 1. SSH passphrase automática en madre
Para que `git pull` no pida passphrase cada vez:
```
ssh-add ~/.ssh/id_ed25519_github
```
O editar `~/.ssh/config` en madre (una sola línea por vez en Blink):
```
echo 'Host github.com' >> ~/.ssh/config
echo '  IdentityFile ~/.ssh/id_ed25519_github' >> ~/.ssh/config  
echo '  AddKeysToAgent yes' >> ~/.ssh/config
```

### 2. Crear labels en GitHub
Necesarios para que repo-audit.yml y repo-health.yml creen issues:
- Label `audit` (color: #e4e669)
- Label `health` (color: #0075ca)
- Label `needs-attention` (color: #d93f0b)

Crear en: https://github.com/alvarofernandezmota-tech/yggdrasil-dew/labels

### 3. Verificar y borrar carpeta artefacto
```
ls ~/yggdrasil-dew/alvarofernandezmota-tech/
```

---

## 🟡 Tareas F0 (hoy)

### 4. Deduplicar osint
```
cp -r ~/yggdrasil-dew/osint-stack/* ~/yggdrasil-dew/osint/ 2>/dev/null; rm -rf ~/yggdrasil-dew/osint-stack
```

### 5. Deduplicar tools
```
cp -r ~/yggdrasil-dew/cli-tools/* ~/yggdrasil-dew/tools/ 2>/dev/null; rm -rf ~/yggdrasil-dew/cli-tools
```

### 6. GROQ_API_KEY en GitHub Secrets
URL directa: https://github.com/alvarofernandezmota-tech/yggdrasil-dew/settings/secrets/actions

---

## 🟢 Tareas F1 (después de F0)

### 7. thdora issue #12 — eliminar código zombie
```
cd ~/Projects/thdora && git checkout -b fix/issue-12-zombie-code
```

### 8. thdora issue #10 — fix /config timeout 3 líneas
```
cd ~/Projects/thdora && git checkout -b fix/issue-10-config-timeout
```

---

*Generado automáticamente al cierre de S20260703*
