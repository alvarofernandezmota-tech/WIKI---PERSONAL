#!/usr/bin/env python3
"""
thdora-handlers.py — Handlers completos para el bot THDORA
Comandos disponibles:
  /estado     — estado del sistema (docker + mem + disco)
  /inbox      — lista archivos en inbox/
  /diario     — añade nota al diario de hoy y hace commit
  /pull <modelo> — descarga modelo en ollama
  /backup     — lanza backup restic
  /modelos    — lista modelos ollama disponibles
  /logs <nombre> — muestra últimas 20 líneas de logs de un contenedor
"""
import subprocess
import os
import logging
from datetime import datetime
from functools import wraps

VAULT_ROOT = os.path.expanduser("~/yggdrasil-dew")
BACKUP_SCRIPT = os.path.join(VAULT_ROOT, "scripts/backup/run-backup.sh")
ALLOWED_CHAT_ID = int(os.getenv("TELEGRAM_CHAT_ID", "0"))

logging.basicConfig(level=logging.INFO)
log = logging.getLogger(__name__)


def solo_yo(func):
    """Decorador: solo responde al chat_id autorizado."""
    @wraps(func)
    def wrapper(update, context):
        if ALLOWED_CHAT_ID and update.effective_chat.id != ALLOWED_CHAT_ID:
            update.message.reply_text("❌ No autorizado.")
            return
        return func(update, context)
    return wrapper


def _run(cmd, cwd=None, timeout=10):
    """Ejecuta comando y devuelve stdout+stderr como string."""
    try:
        result = subprocess.check_output(
            cmd, shell=True, cwd=cwd,
            stderr=subprocess.STDOUT, timeout=timeout
        ).decode(errors="replace")
        return result.strip()
    except subprocess.CalledProcessError as e:
        return e.output.decode(errors="replace").strip()
    except subprocess.TimeoutExpired:
        return "[timeout]"


@solo_yo
def handle_estado(update, context):
    """Muestra estado del sistema: docker, memoria y disco."""
    docker = _run("docker ps --format 'table {{.Names}}\\t{{.Status}}'")
    mem = _run("free -h | grep -E 'Mem|Swap'")
    disco = _run("df -h / /mnt/backup 2>/dev/null || df -h /")
    msg = f"🐳 *Docker*\n```\n{docker}\n```\n💾 *Memoria*\n```\n{mem}\n```\n💽 *Disco*\n```\n{disco}\n```"
    update.message.reply_text(msg, parse_mode="Markdown")


@solo_yo
def handle_inbox(update, context):
    """Lista archivos pendientes en inbox/."""
    inbox_path = os.path.join(VAULT_ROOT, "inbox")
    files = sorted([
        f for f in os.listdir(inbox_path)
        if f not in (".gitkeep", "README.md")
    ])
    if files:
        lista = "\n".join(f"• {f}" for f in files)
        update.message.reply_text(f"📥 *Inbox* ({len(files)} items):\n{lista}", parse_mode="Markdown")
    else:
        update.message.reply_text("✅ Inbox vacío.")


@solo_yo
def handle_diario(update, context):
    """Añade una nota al diario de hoy y hace git commit."""
    partes = update.message.text.split(' ', 1)
    texto = partes[1].strip() if len(partes) > 1 else "Sin nota"
    today = datetime.now().strftime("%Y-%m-%d")
    hora = datetime.now().strftime("%H:%M")
    path = os.path.join(VAULT_ROOT, "diarios", f"{today}.md")

    os.makedirs(os.path.dirname(path), exist_ok=True)
    # Crear cabecera si el fichero es nuevo
    if not os.path.exists(path):
        with open(path, "w") as f:
            f.write(f"# Diario {today}\n\n")
    with open(path, "a") as f:
        f.write(f"- {hora} — {texto}\n")

    _run(f"git add diarios/{today}.md && git commit -m 'diario({today}): nota desde THDORA'", cwd=VAULT_ROOT)
    update.message.reply_text(f"✅ Nota guardada ({hora}): _{texto}_", parse_mode="Markdown")


@solo_yo
def handle_pull(update, context):
    """Descarga un modelo en ollama en background."""
    if not context.args:
        update.message.reply_text("❌ Uso: /pull <modelo>  Ej: /pull llama3.1:8b")
        return
    modelo = context.args[0]
    subprocess.Popen(
        ["docker", "exec", "ollama", "ollama", "pull", modelo],
        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
    )
    update.message.reply_text(f"⏳ Descargando `{modelo}` en background...\nComprueba con /modelos en unos minutos.", parse_mode="Markdown")


@solo_yo
def handle_modelos(update, context):
    """Lista los modelos disponibles en ollama."""
    out = _run("docker exec ollama ollama list")
    update.message.reply_text(f"🤖 *Modelos Ollama:*\n```\n{out}\n```", parse_mode="Markdown")


@solo_yo
def handle_backup(update, context):
    """Lanza backup restic en background."""
    destino = context.args[0] if context.args else "local"
    if destino not in ("local", "sftp", "b2", "all"):
        update.message.reply_text("❌ Uso: /backup [local|sftp|b2|all]")
        return
    subprocess.Popen(
        ["bash", BACKUP_SCRIPT, destino],
        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
    )
    update.message.reply_text(f"⏳ Backup `{destino}` iniciado en background.\nLogs en `/var/log/restic/`", parse_mode="Markdown")


@solo_yo
def handle_logs(update, context):
    """Muestra las últimas 20 líneas de logs de un contenedor."""
    if not context.args:
        update.message.reply_text("❌ Uso: /logs <contenedor>  Ej: /logs ollama")
        return
    nombre = context.args[0]
    out = _run(f"docker logs --tail 20 {nombre} 2>&1")
    # Truncar si es muy largo para Telegram
    if len(out) > 3500:
        out = out[-3500:]
    update.message.reply_text(f"📜 *Logs {nombre}:*\n```\n{out}\n```", parse_mode="Markdown")


# =============================================================================
# Registro de handlers (para usar en el bot principal)
# =============================================================================
def register_handlers(dispatcher):
    from telegram.ext import CommandHandler
    dispatcher.add_handler(CommandHandler("estado", handle_estado))
    dispatcher.add_handler(CommandHandler("inbox", handle_inbox))
    dispatcher.add_handler(CommandHandler("diario", handle_diario, pass_args=False))
    dispatcher.add_handler(CommandHandler("pull", handle_pull, pass_args=True))
    dispatcher.add_handler(CommandHandler("modelos", handle_modelos))
    dispatcher.add_handler(CommandHandler("backup", handle_backup, pass_args=True))
    dispatcher.add_handler(CommandHandler("logs", handle_logs, pass_args=True))
