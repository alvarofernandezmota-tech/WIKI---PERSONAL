import subprocess
import os
from datetime import datetime

VAULT_ROOT = os.path.expanduser("~/yggdrasil-dew")

def handle_estado(update, context):
    cmd = "docker ps --format '{{.Names}}' && free -h && df -h"
    res = subprocess.check_output(cmd, shell=True).decode()
    update.message.reply_text(f"```\n{res}\n```", parse_mode="Markdown")

def handle_inbox(update, context):
    inbox_path = os.path.join(VAULT_ROOT, "inbox")
    files = [f for f in os.listdir(inbox_path) if f != ".gitkeep"]
    update.message.reply_text("\n".join(files) if files else "Inbox vacío.")

def handle_diario(update, context):
    msg = update.message.text.split(' ', 1)
    text = msg[1] if len(msg) > 1 else "Sin nota"
    today = datetime.now().strftime("%Y-%m-%d")
    path = os.path.join(VAULT_ROOT, "diarios", f"{today}.md")
    
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "a") as f:
        f.write(f"\n- {datetime.now().strftime('%H:%M')} - {text}\n")
        
    subprocess.run(["git", "add", path], cwd=VAULT_ROOT)
    subprocess.run(["git", "commit", "-m", f"diario: {today}"], cwd=VAULT_ROOT)
    update.message.reply_text("Entrada guardada.")

def handle_pull(update, context):
    if context.args:
        modelo = context.args[0]
        subprocess.Popen(["docker", "exec", "ollama", "ollama", "pull", modelo])
        update.message.reply_text(f"Descargando {modelo}...")
