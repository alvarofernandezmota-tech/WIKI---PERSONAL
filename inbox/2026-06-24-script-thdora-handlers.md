---
tags: [inbox, thdora, telegram, python, handlers, script]
fecha: 2026-06-24
estado: borrador-tecnico
destino: proyectos/thdora/handlers/
---

# thdora — Handlers TOKI (Python)

> Scripts para los handlers del bot Telegram.
> Ejecutar en el servidor donde corre thdora.

---

## Handler /estado — muestra docker ps en Madre

```python
import subprocess
from telegram import Update
from telegram.ext import ContextTypes

async def estado_handler(update: Update, context: ContextTypes.DEFAULT_TYPE):
    try:
        result = subprocess.run(
            ["ssh", "varpc", "docker compose -f ~/yggdrasil-dew/docker-compose.yml ps"],
            capture_output=True, text=True, timeout=15
        )
        respuesta = f"Estado Madre:\n```\n{result.stdout}\n```"
    except Exception as e:
        respuesta = f"Error conectando con Madre: {e}"
    await update.message.reply_text(respuesta, parse_mode="Markdown")
```

---

## Handler /inbox — crea nota en inbox/

```python
import os
from datetime import datetime

async def inbox_handler(update: Update, context: ContextTypes.DEFAULT_TYPE):
    texto = " ".join(context.args)
    if not texto:
        await update.message.reply_text("Uso: /inbox <texto>")
        return

    fecha = datetime.now().strftime("%Y-%m-%d")
    hora = datetime.now().strftime("%H-%M")
    filename = f"/root/yggdrasil-dew/inbox/{fecha}-toki-{hora}.md"

    contenido = f"---\ntags: [inbox, toki, telegram]\nfecha: {fecha}\n---\n\n{texto}\n"

    with open(filename, "w") as f:
        f.write(contenido)

    os.system(f"cd /root/yggdrasil-dew && git add -A && git commit -m 'inbox: toki {fecha} {hora}' && git push")
    await update.message.reply_text(f"Nota guardada en inbox: {fecha}-toki-{hora}.md")
```

---

## Handler /diario — escribe en diarios/

```python
async def diario_handler(update: Update, context: ContextTypes.DEFAULT_TYPE):
    texto = " ".join(context.args)
    if not texto:
        await update.message.reply_text("Uso: /diario <texto>")
        return

    fecha = datetime.now().strftime("%Y-%m-%d")
    filename = f"/root/yggdrasil-dew/diarios/{fecha}-diario.md"

    entrada = f"\n\n## {datetime.now().strftime('%H:%M')} (toki)\n\n{texto}\n"

    with open(filename, "a") as f:
        f.write(entrada)

    os.system(f"cd /root/yggdrasil-dew && git add -A && git commit -m 'diario: toki {fecha}' && git push")
    await update.message.reply_text(f"Anadido al diario de hoy.")
```

---

## Registrar handlers en bot principal

```python
from telegram.ext import CommandHandler

# En tu Application setup:
app.add_handler(CommandHandler("estado", estado_handler))
app.add_handler(CommandHandler("inbox", inbox_handler))
app.add_handler(CommandHandler("diario", diario_handler))
```

---
_Destino: proyectos/thdora/handlers/toki_handlers.py_
