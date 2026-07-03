# 📊 Estado del Sistema — Yggdrasil

> Fichero maestro de estado. Actualizar al inicio y cierre de cada sesión.

**Última actualización:** 03-Jul-2026 13:05 CEST  
**Sesión activa:** S20260703  
**Operador:** alvarofernandezmota-tech

---

## 🟢 Infraestructura

| Componente | Estado | Nota |
|---|---|---|
| madre (servidor) | ✅ Online | IP Tailscale: 100.91.112.32 |
| SSH madre | ✅ Funciona | clave id_ed25519_github |
| git pull ygg | ⚠️ Passphrase | Ejecutar ssh-add |
| GitHub Actions | ✅ Activas | repo-audit + repo-health |
| Labels Actions | ❌ Pendiente | Crear audit/health/needs-attention |
| Tailscale | ✅ Activo | Conecta Blink↔madre |
| GROQ_API_KEY | ❌ Pendiente | Añadir en GitHub Secrets |

---

## 🏝️ Islas del ecosistema

| Isla | Repo | README | Estado |
|---|---|---|---|
| yggdrasil-dew | [link](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) | ✅ | 🟢 Activa |
| thdora | [link](https://github.com/alvarofernandezmota-tech/thdora) | ❓ | 🟡 Deuda técnica |
| secops | pendiente | ❌ | 🟡 3 bots rotos |
| local-brain | en ygg/ollama | ❌ | 🟡 Sin documentar |
| osint | en ygg/osint | ❌ | ⚪ Duplicado |
| batcueva | no existe | ❌ | ❌ Sin crear |
| theodora | dotfiles | ❌ | 🟡 Sin repo |

---

## 🔧 Acciones pendientes (ordenadas)

1. `ssh-add ~/.ssh/id_ed25519_github` — en madre
2. Crear labels GitHub: `audit`, `health`, `needs-attention`
3. Verificar `~/yggdrasil-dew/alvarofernandezmota-tech/`
4. Deduplicar osint/ + osint-stack/
5. Deduplicar tools/ + cli-tools/
6. Añadir GROQ_API_KEY en GitHub Secrets
7. thdora issue #12 — código zombie
8. thdora issue #10 — fix /config timeout

---

## 🛡️ Normas activas

- **Conventional Commits:** `feat:` `fix:` `docs:` `chore:` `ci:` `refactor:`
- **Regla SINE:** documentada en repo
- **Plantilla isla:** `templates/isla-README.md`
- **Plantilla diario:** `templates/diario-daily.md`
- **Inbox first:** toda idea va a `inbox/` antes de ejecutarse

---

*Ver `inbox/SIGUIENTE-PASO.md` para la tarea activa ahora mismo.*  
*Ver `ROADMAP-MASTER.md` para el plan completo F0→F5.*
