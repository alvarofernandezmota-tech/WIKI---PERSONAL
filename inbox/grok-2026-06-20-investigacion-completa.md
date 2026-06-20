---
tags: [inbox, grok, thdora, ollama, investigacion, fix, handlers]
fecha: 2026-06-20
fuente: Grok (xAI) via AGENT-SCRIPT
destino-pendiente: proyectos/thdora.md · setup/madre.md · proyectos/thdora-docs.md
---

# 🤖 Grok — Investigación completa 20 jun 2026

> Nota de inbox. Fuente: Grok con contexto del AGENT-SCRIPT.
> Antes de mover contenido a su destino — revisar y validar.
> Destino: [[proyectos/thdora]] + [[setup/madre]] + [[proyectos/thdora-docs]]

---

## 1. thdora — Fix Restart Loop Bot 🔴

### Causas más probables

- Excepción no manejada en startup (LangGraph graph build, env vars missing, DB connection)
- Restart policy `restart: always` o `unless-stopped` + crash del proceso principal
- Problemas con async polling (`Application.run_polling`) en Docker (conflictos event loop)
- Dependencias no ready (PostgreSQL tarda más que el bot en arrancar)

### Plan de resolución en orden

```bash
# 1. Conectar
ssh 100.91.112.32

# 2. Ir al repo
cd <ruta-repo-thdora>  # pendiente: find ~ -name docker-compose.yml

# 3. Ver logs del error exacto
docker compose logs --tail=50 thdora-bot

# 4. Rebuild completo
docker compose down && docker compose up --build
# (sin -d primero para ver logs en tiempo real)

# 5. Verificar
docker compose ps
# Probar /start en Telegram
```

### Acciones de código recomendadas por Grok

1. Añadir `try/except` global + logging en `main.py`
2. Usar `structlog` o `logging` con handler a archivo
3. Verificar `depends_on` en `docker-compose.yml` — bot debe esperar a PostgreSQL
4. Considerar `healthcheck` en PostgreSQL antes de que el bot arranque

---

## 2. Handler `/inbox` — Borrador Python (Grok)

> Copiar a thdora solo cuando se vaya a implementar. No tocar el repo hasta entonces.

```python
# handlers/inbox_handler.py
import logging
from telegram import Update
from telegram.ext import ContextTypes
from datetime import datetime
import httpx

logger = logging.getLogger(__name__)

async def inbox_handler(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Captura texto y lo añade a inbox/ del vault yggdrasil-dew via GitHub API."""
    texto = " ".join(context.args) if context.args else None
    
    if not texto:
        await update.message.reply_text("⚠️ Uso: /inbox <texto>")
        return
    
    fecha = datetime.now().strftime("%Y-%m-%d")
    hora = datetime.now().strftime("%H:%M")
    
    contenido = f"""---
tags: [inbox, toki, captura-movil]
fecha: {fecha}
---

# 📥 Captura TOKI — {hora}

{texto}

---
_Capturado via Telegram bot TOKI · {fecha} {hora}_
"""
    
    # TODO: subir a GitHub via API o escribir en archivo local montado
    logger.info(f"Inbox captura: {texto[:50]}...")
    await update.message.reply_text(f"✅ Guardado en inbox:\n`{texto[:100]}`")
```

---

## 3. Diagnóstico Hardware Madre + Ollama

### Compatibilidad confirmada por Grok

- GTX 1060 6GB + `qwen2.5:7b` (Q4_K_M ~4.7GB) → ✅ cabe bien
- Recomendado: `ollama run qwen2.5:7b`

### Comandos diagnóstico pendientes

```bash
ssh 100.91.112.32

uname -a                    # OS + kernel
nvidia-smi                  # driver CUDA + VRAM disponible
ollama ps                   # modelos cargados ahora
ollama list                 # modelos instalados
docker compose ps           # estado todos los servicios
free -h                     # RAM disponible
df -h                       # espacio disco
```

### Modelo recomendado Grok
```bash
ollama pull qwen2.5:7b
ollama run qwen2.5:7b
```

---

## 4. Recomendaciones adicionales Grok

### thdora/docs/ — crear (en orden)

| Documento | Contenido |
|---|---|
| `TROUBLESHOOTING.md` | Errores conocidos + solución exacta |
| `DEPLOY.md` | Guía deploy desde cero paso a paso |
| `SERVIDOR_MADRE.md` | IP, usuario, rutas, servicios, puertos |

### TROUBLESHOOTING.md — plantilla base (Grok)

```markdown
# TROUBLESHOOTING — thdora

## Bot en restart loop
**Síntoma:** `docker compose ps` muestra bot en Restarting
**Causa:** Excepción en startup o env var faltante
**Fix:**
1. `docker compose logs --tail=50 thdora-bot` → ver error exacto
2. Verificar `.env` tiene todas las vars
3. `docker compose down && docker compose up --build`

## PostgreSQL no conecta
**Síntoma:** Error `connection refused` en logs del bot
**Causa:** Bot arranca antes que PostgreSQL
**Fix:** Añadir `depends_on` con `condition: service_healthy` en docker-compose.yml

## Ollama no responde
**Síntoma:** Timeout en llamadas a LLM
**Fix:** `docker compose restart ollama` o verificar VRAM con `nvidia-smi`
```

---

## 5. Plan HOY recomendado por Grok

```
1. varopc: git pull + Obsidian Git
2. Madre: logs del bot + rebuild
3. Probar TOKI en Telegram
4. Actualizar CONTEXT.md al final
```

---

## ✅ Acciones de esta nota (antes de archivar)

- [ ] Ejecutar diagnóstico hardware Madre → mover resultados a [[setup/madre]]
- [ ] Ver logs bot → pegar error exacto aquí → analizar
- [ ] Decidir si implementar handler `/inbox` → mover borrador a thdora
- [ ] Crear `thdora/docs/TROUBLESHOOTING.md` con plantilla de arriba
- [ ] Crear `thdora/docs/SERVIDOR_MADRE.md` con IPs y rutas reales
- [ ] Cuando todo resuelto → archivar esta nota en [[diarios/2026-06-20]]

---

_Fuente: Grok (xAI) · 20 jun 2026 · vía [[agentes/AGENT-SCRIPT]]_
_Destino: [[proyectos/thdora]] · [[setup/madre]] · [[proyectos/thdora-docs]]_
_Ver también: [[inbox/MASTER-PENDIENTES]] · [[CONTEXT]] · [[HOME]]_
