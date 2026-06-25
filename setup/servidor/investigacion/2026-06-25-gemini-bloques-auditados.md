---
tags: [investigacion, gemini, auditoria, fase3, fase4, thdora, adb]
fecha: 2026-06-25
estado: auditado-con-correcciones
---

# 🔬 Respuesta Gemini — Auditada y Corregida

> Respuesta recibida: 2026-06-25 12:43 CEST  
> Auditada por: Perplexity vía MCP  
> Estado: usar versiones corregidas, NO las originales de Gemini

---

## ⚠️ ERRORES DETECTADOS EN LA RESPUESTA DE GEMINI

| Error | Dónde | Impacto |
|---|---|---|
| Dice "Arch Linux (Omarchy)" para Madre | Bloque A | **FALSO** — Madre es Ubuntu. varopc es Arch |
| Dice "32GB RAM" para Madre | Bloque A | **FALSO** — Madre tiene **16GB RAM** |
| litellm usa `ollama/qwen` y `ollama/llama3` | Bloque B | Incorrecto — modelos reales: `qwen2.5:3b`, `llama3.1:8b` |
| litellm usa `host.docker.internal` | Bloque B | Incorrecto — usar nombre contenedor `ollama` |
| Un solo Ollama en :11434 | Bloque B | **FALSO** — hay dos: `ollama:11434` (chat) + `ollama-embeddings:11435` (RAG) |
| headscale metrics en `127.0.0.1:9090` | Bloque B | Rompe el mapeo de puertos del YML — debe ser `0.0.0.0:9090` |
| handler /inbox escribe en `Inbox/` mayúscula | Bloque C | Carpeta real es `inbox/` minúscula |
| THDORA corre con virtualenv | Bloque E | THDORA corre como contenedor Docker |
| Red Docker `batcueva_net` | Bloque E | Se llama `batcueva` (sin `_net`) |
| `sudo systemctl start ollama` | Bloque E | Ollama corre EN Docker, no como servicio nativo |

---

## ✅ BLOQUE A — Corregido

**Madre = Ubuntu** → usar `apt`  
**varopc = Arch** → usar `pacman`

```bash
# En MADRE (Ubuntu) — antes de Fase 3
sudo apt update && sudo apt install -y curl jq git sqlite3
# Docker ya instalado ✅ — python ya instalado ✅

# En VAROPC (Arch) — para ADB
sudo pacman -S android-tools
```

---

## ✅ BLOQUE B — Archivos corregidos

### litellm-config.yaml → ver `setup/servidor/litellm-config.yaml`

Dos instancias Ollama en la red batcueva:
- Chat → `http://ollama:11434`
- Embeddings → `http://ollama-embeddings:11435`

### headscale config.yaml mínimo

Ruta en Madre: `/opt/batcueva/headscale/config.yaml`

```yaml
server_url: http://100.91.112.32:8085
listen_addr: 0.0.0.0:8080
metrics_listen_addr: 0.0.0.0:9090   # 0.0.0.0 obligatorio para mapeo de puertos
private_key_path: /var/lib/headscale/private.key
noise:
  private_key_path: /var/lib/headscale/noise_private.key
ip_prefixes:
  - 100.64.0.0/10
derp:
  server:
    enabled: false
  urls:
    - https://controlplane.tailscale.com/derpmap/default
database:
  type: sqlite3
  path: /var/lib/headscale/db.sqlite
```

### .env Fase 3 — variables necesarias

Ruta: `~/.env` en Madre (NO commitear)

```env
N8N_ENCRYPTION_KEY=       # openssl rand -hex 32
CODE_SERVER_PASSWORD=     # elegir
CODE_SERVER_SUDO=         # elegir
TELEGRAM_BOT_TOKEN=
TELEGRAM_USER_ID=         # tu ID numérico de Telegram
LITELLM_MASTER_KEY=       # openssl rand -hex 32
```

---

## ✅ BLOQUE C — Handlers THDORA corregidos

### /estado handler

```python
import os, subprocess
from telegram import Update
from telegram.ext import ContextTypes

async def estado_handler(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if str(update.effective_user.id) != os.getenv("TELEGRAM_USER_ID"):
        await update.message.reply_text("⛔ Acceso denegado.")
        return
    try:
        docker_ps = subprocess.check_output(
            ["docker", "ps", "--format", "{{.Names}}: {{.Status}}"], timeout=10
        ).decode().strip()
        ram = subprocess.check_output(["free", "-h", "--si"], timeout=5).decode().strip()
        msg = f"🖥️ *Batcueva — Estado*\n\n*Contenedores:*\n```\n{docker_ps}\n```\n\n*RAM:*\n```\n{ram}\n```"
        await update.message.reply_text(msg, parse_mode='Markdown')
    except Exception as e:
        await update.message.reply_text(f"❌ Error: {e}")
```

### /inbox handler

```python
import os, subprocess
from datetime import datetime
from telegram import Update
from telegram.ext import ContextTypes

REPO_PATH = "/home/varopc/yggdrasil-dew"  # ruta real en Madre

async def inbox_handler(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if str(update.effective_user.id) != os.getenv("TELEGRAM_USER_ID"):
        return
    texto = ' '.join(context.args)
    if not texto:
        await update.message.reply_text("Uso: /inbox <nota>")
        return
    ts = datetime.now().strftime("%Y-%m-%d %H:%M")
    fecha = datetime.now().strftime("%Y-%m-%d")
    ruta = f"{REPO_PATH}/inbox/thdora-{fecha}.md"  # inbox/ en minúscula
    with open(ruta, "a") as f:
        f.write(f"- [ ] {texto} <!-- {ts} -->\n")
    subprocess.run(["git", "-C", REPO_PATH, "add", f"inbox/thdora-{fecha}.md"])
    subprocess.run(["git", "-C", REPO_PATH, "commit", "-m", f"📥 inbox: {texto[:50]}"])
    subprocess.run(["git", "-C", REPO_PATH, "push"])
    await update.message.reply_text("✅ Guardado en inbox y commiteado.")
```

### adb-monitor.sh

```bash
#!/bin/bash
# /usr/local/bin/adb-monitor.sh — cron en varopc: */5 * * * *
IP_MOVIL=""  # rellenar con IP Tailscale del Redmi A5
PORT="5555"
LOG="/var/log/adb-monitor.log"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> $LOG; }
alerta() { curl -s "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
  -d chat_id="$TELEGRAM_USER_ID" -d text="🔴 ADB: $1" > /dev/null; }

[ -z "$IP_MOVIL" ] && { log "IP_MOVIL no configurada"; exit 0; }
adb connect "$IP_MOVIL:$PORT" > /dev/null 2>&1
if adb devices | grep -q "${IP_MOVIL}:${PORT}.*device"; then
    BOOT=$(adb -s "$IP_MOVIL:$PORT" shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')
    BAT=$(adb -s "$IP_MOVIL:$PORT" shell dumpsys battery | grep ' level' | awk '{print $2}')
    [ "$BOOT" = "1" ] && log "AFU ✅ — batería: ${BAT}%" || { log "BFU ⚠️"; alerta "Redmi A5 en BFU — necesita PIN físico"; }
else
    log "ERROR: no accesible en $IP_MOVIL:$PORT"
    alerta "Redmi A5 no responde en $IP_MOVIL:$PORT"
fi
```

---

## ✅ BLOQUE E — Orden de ejecución REAL

```bash
# Todo desde varopc por SSH

# 1. Verificar / crear red batcueva
ssh madre "docker network inspect batcueva >/dev/null 2>&1 || docker network create batcueva"

# 2. Carpetas Fase 3
ssh madre "mkdir -p /opt/batcueva/headscale /opt/batcueva/n8n"

# 3. Headscale config (crear manualmente el yaml en Madre)
ssh madre "nano /opt/batcueva/headscale/config.yaml"  # pegar el yaml de arriba

# 4. Generar keys y crear .env en Madre
ssh madre "openssl rand -hex 32"  # N8N_ENCRYPTION_KEY
ssh madre "openssl rand -hex 32"  # LITELLM_MASTER_KEY
# → crear ~/.env en Madre con los valores

# 5. Levantar Fase 3
ssh madre "cd ~/yggdrasil-dew && docker compose -f setup/servidor/batcueva-fase3.yml up -d"
ssh madre "docker ps --filter label=batcueva.fase=3"

# 6. Levantar Fase 4 (litellm-config.yaml ya está en el repo ✅)
ssh madre "cd ~/yggdrasil-dew && docker compose -f setup/servidor/batcueva-fase4.yml up -d"

# 7. Modelos Ollama en background
ssh madre "nohup bash -c 'for m in qwen2.5:7b llama3.1:8b mistral:7b; do docker exec ollama ollama pull \$m; done' > /tmp/chat-pulls.log 2>&1 &"
ssh madre "nohup bash -c 'for m in bge-m3 nomic-embed-text; do docker exec ollama-embeddings ollama pull \$m; done' > /tmp/embed-pulls.log 2>&1 &"

# 8. THDORA
ssh madre "cd ~/thdora && docker compose up -d"

# 9. Verificar todo
ssh madre "docker ps --format 'table {{.Names}}\t{{.Status}}'"
```

---
_Auditado: 2026-06-25 12:46 CEST — Perplexity vía MCP_  
_Ver: [[ESTADO-SISTEMA]] · [[MASTER-PENDIENTES]] · [[setup/servidor/litellm-config.yaml]]_
