# ▶️ Siguiente paso ahora mismo

> Fichero de paso único. Siempre refleja LO QUE HAY QUE HACER AHORA.
> Al completarlo, actualizar este fichero con el siguiente.

---

## 🟥 PASO ACTIVO: F0.1 — ssh-add

**Objetivo:** Que `git pull` en madre no pida passphrase.

**Ejecutar en madre (una línea, segura en Blink):**
```
ssh-add ~/.ssh/id_ed25519_github
```

**Qué esperar:** Te pedirá la passphrase UNA vez. Después de eso, git funciona solo.

**Verificar:**
```
cd ~/yggdrasil-dew && git pull
```

**Resultado esperado:**
```
Already up to date.
```
o bien que baje los commits nuevos. Sin pedir passphrase.

---

## ⏭️ Después de este paso

1. **F0.2** — Crear labels en GitHub (2 min en web)
2. **F0.3** — Verificar carpeta artefacto en madre
3. **F0.4** — Deduplicar osint/ + osint-stack/
4. **F0.5** — Deduplicar tools/ + cli-tools/
5. **F0.6** — Commit de limpieza
6. **F0.7** — GROQ_API_KEY en GitHub Secrets
7. → **F1** — thdora #12 y #10

---

## 📊 Estado del ecosistema ahora

```
yggdrasil-dew:  ✅ Repo accesible, Actions activas, docs al día
thdora:         ⏳ Esperando F0 para deuda técnica
ssh madre:      ✅ Clave existe y autentica
git pull:       ⚠️ Pide passphrase — resolver con ssh-add
Actions:        ⚠️ Labels no creados aún — no crean issues hasta tenerlos
```

---

*Actualizado: 03-Jul-2026 13:05 CEST*
