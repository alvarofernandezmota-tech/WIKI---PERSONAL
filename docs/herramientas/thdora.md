# Thdora — Arquitectura de roles

> Última actualización: 2026-07-02

Thdora es el sistema de automatización e inteligencia local del ecosistema. Existen **tres instancias con roles separados**, cada una con su propio token GitHub y superficie de acceso.

---

## Thdora Personal

**Repo:** [`thdora`](https://github.com/alvarofernandezmota-tech/thdora)  
**Token GitHub:** solo lectura (agenda, notas personales)  
**Stack:** Bot Telegram + FastAPI + Ollama local

### Funciones
- Gestión de citas y agenda
- Asistente conversacional personal
- Recordatorios y tareas del día a día
- **No toca repos de código ni GitHub**

---

## Thdora Dev

**Instancia:** proceso en Madre (`scripts/thdora-dev/`)  
**Token GitHub:** read/write sobre repos de código activo  
**Fallback:** GitHub Actions cron si Madre está apagada

### Repos bajo gestión

| Repo | Función automatizada |
|---|---|
| `yggdrasil-dew` | Migración inbox diaria → docs estructurados |
| `ollama-stack` | Monitorizar stack, alertar si cae |
| `local-brain` | Indexar docs nuevos en pgvector/RAG |
| `ai-toolkit` | PRs automáticos de actualización herramientas |
| `thdora` | Autogestión — releases y changelog |
| `impresion-3d` | Diarios de sesión → docs automáticos |
| `personal` | Backups estructurados (sin tocar contenido) |

### Script principal

```
scripts/thdora-dev/inbox_migrate.py
```

Ejecución: cron diario a las 06:00 en Madre.  
Fallback: `.github/workflows/inbox-migrate.yml` (GitHub Actions, cron `0 6 * * *`).

### Lógica de clasificación inbox

El script lee el nombre de cada fichero en `inbox/` y lo mapea a su destino:

| Patrón en nombre | Destino |
|---|---|
| `sesion`, `cierre`, `tarde`, `madrugada`, `volcado`, `diario` | `docs/diarios/YYYY-MM-DD.md` (merge) |
| `auditoria-infra`, `compose`, `docker`, `fase`, `thdora` | `docs/infra/` |
| `pentest`, `hallazgo`, `ssh`, `ftp`, `hardening`, `secops` | `docs/seguridad/` |
| `ollama`, `modelos`, `chromium`, `herramienta` | `docs/herramientas/` |
| `bots`, `telegram`, `roadmap`, `arquitectura` | `docs/arquitectura/` |
| `prompt-gemini`, `prompt-` | `inbox/procesado/` (prompts, no docs) |
| Nombre en MAYÚSCULAS | Renombrar a lowercase primero, luego clasificar |

---

## Thdora Guardián

**Repos:** [`yggdrasil-secops`](https://github.com/alvarofernandezmota-tech/yggdrasil-secops) + [`osint-stack`](https://github.com/alvarofernandezmota-tech/osint-stack)  
**Token GitHub:** acceso exclusivo a repos de seguridad  
**Aislamiento:** token separado de Dev y Personal

### Funciones
- Canary tokens y tripwires activos
- Self-OSINT periódico
- Alertas de seguridad vía Telegram (canal separado)
- **No tiene acceso a repos de desarrollo ni personales**

---

## Separación de tokens — superficie de ataque

```
Thdora Personal  →  Token: solo lectura (agenda/notas)
Thdora Dev       →  Token: read/write repos código
Thdora Guardián  →  Token: solo yggdrasil-secops + osint-stack
```

Si Guardián se compromete, no puede tocar Dev ni Personal.  
Si Dev se compromete, no puede tocar Guardián ni datos personales sensibles.

---

## Estado actual

- [x] Thdora Personal — operativa (Bot Telegram + FastAPI + Ollama)
- [ ] Thdora Dev — en construcción (script inbox_migrate.py listo, pendiente cron en Madre)
- [ ] Thdora Guardián — planificada (repo yggdrasil-secops creada, pendiente automatización)
