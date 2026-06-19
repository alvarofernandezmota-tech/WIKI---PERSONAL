# CONTEXT.md — Estado HOY

> Actualizar cada sesión. Este fichero es el "resumen ejecutivo" del ecosistema.
> Última actualización: **20 junio 2026 — 00:36 CEST**

---

## ¿Dónde estamos?

### THDORA
- Versión: **v0.22.1** en rama `main`
- Stack Docker en Madre: **6/6 contenedores arriba** ✅
- API FastAPI (`thdora`): **healthy** en puerto 8000 ✅
- Bot Telegram (`thdora-bot`): **Up pero en restart loop** ⚠️
  - Causa: `langgraph.checkpoint.sqlite` no instalado en imagen vieja
  - Fix: hacer `git pull + docker compose up -d --build` en Madre
  - Pendiente confirmar que arranque limpio
- CI/CD (`deploy.yml`): ✅ correcto, tiene `--build` y notificación Telegram
- Tests CI (`tests.yml`): ✅ vars dummy inyectadas, no necesita credenciales reales

### Yggdrasil-dew
- Carpeta `osint/` creada ✅
- `setup/obsidian.md` documentado ✅
- Obsidian en varopc: ⏳ **PENDIENTE INSTALAR**
- Open WebUI en Madre: ⏳ pendiente

### varopc (Acer Theodora)
- Obsidian: ⏳ **PENDIENTE** (`yay -S obsidian`)
- Repo yggdrasil-dew clonado en varopc: ❓ verificar
- nmap / theHarvester: ⏳ instalar cuando Obsidian esté

### Madre (servidor)
- Docker + docker-compose: ✅
- Tailscale: ✅
- UFW + fail2ban: ⏳ pendiente
- Open WebUI: ⏳ pendiente
- tmux: instalar para builds largos sin perder sesión SSH

---

## Próximos pasos en orden

### 🔴 Urgente (mañana)
1. SSH a Madre → `git pull origin main` → `docker compose up -d --build` → verificar bot
2. `docker compose logs --tail=30 bot` → confirmar que no hay error `langgraph`
3. Probar `/start` en Telegram → ver si TOKI responde

### 🟡 Importante (esta semana)
4. Instalar Obsidian en varopc: `yay -S obsidian`
5. Abrir vault: `~/repos/yggdrasil-dew`
6. Instalar plugin Git en Obsidian
7. Primer commit desde Obsidian → verificar sync con GitHub

### 🟢 Planificado
8. nmap en varopc → primer OSINT real red de casa → guardar en `osint/resultados/`
9. Open WebUI en Madre (Docker)
10. UFW + fail2ban en Madre
11. Handler `/diario` en thdora → escribir en Ygg desde Telegram
12. n8n en Docker (automatización)

---

## Stack tecnológico activo

| Herramienta | Dónde | Estado |
|---|---|---|
| THDORA (API + bot) | Madre | ⚠️ API ok, bot restart loop |
| Prometheus + Grafana | Madre | ✅ corriendo |
| Tailscale | varopc + Madre | ✅ |
| Ollama | varopc + Madre | ✅ |
| Obsidian | varopc | ⏳ instalar |
| Open WebUI | Madre | ⏳ pendiente |
| n8n | Madre | ⏳ pendiente |

---

_Mantenido por Perplexity (Claude Sonnet 4.6) vía MCP GitHub · 20 junio 2026_
