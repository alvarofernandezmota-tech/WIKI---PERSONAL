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
| Dice "Arch Linux (Omarchy)" para Madre | Bloque A | **FALSO** — Madre es Ubuntu, no Arch. varopc es Arch |
| litellm-config.yaml usa `ollama/qwen` y `ollama/llama3` | Bloque B | **INCORRECTO** — los modelos reales son `qwen2.5:3b`, `llama3.1:8b` |
| litellm usa `host.docker.internal` | Bloque B | **INCORRECTO** — en la red batcueva el host es `ollama` (nombre del contenedor) |
| headscale expone metrics en `127.0.0.1:9090` | Bloque B | Incompatible con el YML que mapea `9090:9090` al host |
| handler /inbox escribe en `Inbox/capturas.md` con I mayúscula | Bloque C | La carpeta real es `inbox/` en minúscula |
| THDORA corre con `source ~/thdora_env/bin/activate` | Bloque E | THDORA corre como contenedor Docker, no virtualenv |
| Bloque E dice `sudo systemctl start ollama` fuera de Docker | Bloque E | Ollama corre EN Docker en nuestro stack, no como servicio nativo |
| Red Docker se llama `batcueva_net` | Bloque E | **INCORRECTO** — se llama `batcueva` (sin `_net`) |

---

## ✅ BLOQUE A — Corregido

**Madre es Ubuntu.** Usar apt, no pacman.

```bash
# En Madre (Ubuntu) — antes de Fase 3
sudo apt update && sudo apt install -y \
  curl jq git sqlite3 \
  android-tools-adb    # solo si vas a usar ADB desde Madre

# Docker y docker-compose ya están instalados ✅
# python ya está instalado ✅
```

**varopc es Arch.** Para ADB en varopc:
```bash
sudo pacman -S android-tools
```

---

## ✅ BLOQUE B — Archivos corregidos

### litellm-config.yaml CORRECTO

Ruta: `setup/servidor/litellm-config.yaml`

```yaml
model_list:
  - model_name: qwen2.5-3b
    litellm_params:
      model: ollama/qwen2.5:3b
      api_base: http://ollama:11434   # nombre del contenedor en red batcueva

  - model_name: qwen2.5-7b
    litellm_params:
      model: ollama/qwen2.5:7b
      api_base: http://ollama:11434

  - model_name: llama3.1-8b
    litellm_params:
      model: ollama/llama3.1:8b
      api_base: http://ollama:11434

  - model_name: mistral-7b
    litellm_params:
      model: ollama/mistral:7b
      api_base: http://ollama:11434

  - model_name: bge-m3
    litellm_params:
      model: ollama/bge-m3
      api_base: http://ollama:11434

  - model_name: nomic-embed
    litellm_params:
      model: ollama/nomic-embed-text
      api_base: http://ollama:11434

litellm_settings:
  drop_params: true
  set_verbose: false
```

### headscale config.yaml CORRECTO

Ruta: `/opt/batcueva/headscale/config.yaml`

```yaml
server_url: http://100.91.112.32:8085
listen_addr: 0.0.0.0:8080
metrics_listen_addr: 0.0.0.0:9090   # 0.0.0.0 para que el mapeo :9090:9090 funcione
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

### .env Fase 3 CORRECTO

Ruta: `setup/servidor/.env` (NO commitear — está en .gitignore)

```env
# Madre
HOST_MADRE_IP=100.91.112.32

# n8n
N8N_ENCRYPTION_KEY=  # generar: openssl rand -hex 32

# code-server
CODE_SERVER_PASSWORD=  # elegir contraseña segura
CODE_SERVER_SUDO=      # elegir contraseña segura

# THDORA
TELEGRAM_BOT_TOKEN=
TELEGRAM_USER_ID=      # tu ID de Telegram — bloquea acceso a otros

# LiteLLM
LITELLM_MASTER_KEY=    # generar: openssl rand -hex 32
```

Generar claves:
```bash
openssl rand -hex 32  # para N8N_ENCRYPTION_KEY
openssl rand -hex 32  # para LITELLM_MASTER_KEY
```

---

## ✅ BLOQUE C — Handlers THDORA corregidos

### /estado handler

```python
import os
import subprocess
from telegram import Update
from telegram.ext import ContextTypes

async def estado_handler(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if str(update.effective_user.id) != os.getenv("TELEGRAM_USER_ID"):
        await update.message.reply_text("⛔ Acceso denegado.")
        return
    try:
        docker_ps = subprocess.check_output(
            ["docker", "ps", "--format", "{{.Names}}: {{.Status}}"],
            timeout=10
        ).decode().strip()
        ram = subprocess.check_output(
            ["free", "-h", "--si"],
            timeout=5
        ).decode().strip()
        msg = f"🖥️ *Batcueva — Estado*\n\n*Contenedores:*\n```\n{docker_ps}\n```\n\n*RAM:*\n```\n{ram}\n```"
        await update.message.reply_text(msg, parse_mode='Markdown')
    except Exception as e:
        await update.message.reply_text(f"❌ Error: {e}")
```

### /inbox handler

```python
import os
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
    # carpeta inbox en minúscula — norma del repo
    ruta = f"{REPO_PATH}/inbox/thdora-{fecha}.md"
    linea = f"- [ ] {texto} <!-- {ts} -->"
    with open(ruta, "a") as f:
        f.write(linea + "\n")
    # commit automático
    import subprocess
    subprocess.run(["git", "-C", REPO_PATH, "add", f"inbox/thdora-{fecha}.md"])
    subprocess.run(["git", "-C", REPO_PATH, "commit", "-m", f"📥 inbox: {texto[:50]}"])
    subprocess.run(["git", "-C", REPO_PATH, "push"])
    await update.message.reply_text(f"✅ Guardado en inbox y commiteado.")
```

### adb-monitor.sh CORRECTO

```bash
#!/bin/bash
# /usr/local/bin/adb-monitor.sh
# Cron en varopc: */5 * * * * /usr/local/bin/adb-monitor.sh

IP_MOVIL=""  # IP Tailscale del Redmi A5 (rellenar cuando esté instalado)
PORT="5555"
LOG="/var/log/adb-monitor.log"
BOT_TOKEN="${TELEGRAM_BOT_TOKEN}"
CHAT_ID="${TELEGRAM_USER_ID}"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> $LOG; }
alerta() { curl -s "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -d chat_id="$CHAT_ID" -d text="🔴 ADB-Monitor: $1" > /dev/null; }

if [ -z "$IP_MOVIL" ]; then
  log "IP_MOVIL no configurada — skipping"
  exit 0
fi

adb connect "$IP_MOVIL:$PORT" > /dev/null 2>&1

if adb devices | grep -q "${IP_MOVIL}:${PORT}.*device"; then
  BOOT=$(adb -s "$IP_MOVIL:$PORT" shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')
  BATERIA=$(adb -s "$IP_MOVIL:$PORT" shell dumpsys battery | grep ' level' | awk '{print $2}')
  if [ "$BOOT" = "1" ]; then
    log "AFU ✅ — batería: ${BATERIA}%"
  else
    log "BFU ⚠️ — dispositivo esperando PIN físico"
    alerta "Redmi A5 en estado BFU. Necesita PIN físico."
  fi
else
  log "ERROR: dispositivo no accesible en $IP_MOVIL:$PORT"
  alerta "Redmi A5 no responde en $IP_MOVIL:$PORT"
fi
```

---

## ✅ BLOQUE E — Orden de ejecución REAL y CORRECTO

```bash
# === DESDE varopc, todo por SSH a Madre ===

# 1. Verificar red batcueva
ssh madre "docker network inspect batcueva >/dev/null 2>&1 || docker network create batcueva"

# 2. Crear carpetas Fase 3
ssh madre "mkdir -p /opt/batcueva/headscale && mkdir -p /opt/batcueva/n8n"

# 3. Subir headscale config (desde el repo)
ssh madre "cat > /opt/batcueva/headscale/config.yaml" < setup/servidor/headscale-config.yaml

# 4. Generar .env si no existe
# (rellenar manualmente con openssl rand -hex 32 para las keys)

# 5. Levantar Fase 3
ssh madre "cd ~/yggdrasil-dew && docker compose -f setup/servidor/batcueva-fase3.yml up -d"
ssh madre "docker ps --filter label=batcueva.fase=3"

# 6. Crear litellm-config.yaml (ya está en el repo)
# (ya generado en setup/servidor/litellm-config.yaml)

# 7. Levantar Fase 4
ssh madre "cd ~/yggdrasil-dew && docker compose -f setup/servidor/batcueva-fase4.yml up -d"

# 8. Tirar modelos Ollama en background
ssh madre "nohup bash -c 'for m in qwen2.5:7b llama3.1:8b mistral:7b bge-m3 nomic-embed-text; \
  do docker exec ollama ollama pull \$m; done' > /tmp/ollama-pulls.log 2>&1 &"

# 9. Desplegar THDORA (contenedor, no virtualenv)
ssh madre "cd ~/thdora && docker compose up -d"

# 10. Verificar todo
ssh madre "docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"
```

---
_Auditado: 2026-06-25 12:43 CEST — Perplexity vía MCP_
