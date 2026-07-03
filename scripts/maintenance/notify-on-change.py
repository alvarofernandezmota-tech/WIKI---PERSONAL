#!/usr/bin/env python3
"""
NOTIFY-ON-CHANGE WATCHDOG
Monitoriza containers Docker y notifica Telegram SOLO cuando cambia el estado.
Regla: si está igual que antes → silencio. Si cambia → alerta.

Uso: python3 scripts/maintenance/notify-on-change.py
Requiere: TELEGRAM_TOKEN y TELEGRAM_CHAT_ID en el entorno o .env
"""
import subprocess
import json
import time
import os
import sys
from datetime import datetime
from pathlib import Path

# --- CONFIG ---
STATE_FILE = Path("/tmp/yggdrasil-watchdog-state.json")
CHECK_INTERVAL = 30  # segundos
TELEGRAM_TOKEN = os.getenv("TELEGRAM_TOKEN", "")
TELEGRAM_CHAT_ID = os.getenv("TELEGRAM_CHAT_ID", "")
LOG_FILE = Path("/tmp/watchdog.log")

# Emojis por estado
STATUS_EMOJI = {
    "healthy": "✅",
    "unhealthy": "🚨",
    "starting": "⏳",
    "none": "ℹ️",
    "exited": "🔴",
    "running": "🟢",
    "unknown": "❓",
}


def log(msg: str):
    ts = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    line = f"[{ts}] {msg}"
    print(line)
    with open(LOG_FILE, "a") as f:
        f.write(line + "\n")


def get_docker_states() -> dict:
    """Obtiene estado actual de todos los containers."""
    try:
        result = subprocess.run(
            ["docker", "ps", "--format", "{{.Names}}\t{{.Status}}"],
            capture_output=True, text=True, timeout=10
        )
        states = {}
        for line in result.stdout.strip().split("\n"):
            if "\t" in line:
                name, status = line.split("\t", 1)
                # Normalizar estado
                if "(healthy)" in status:
                    health = "healthy"
                elif "(unhealthy)" in status:
                    health = "unhealthy"
                elif "(health: starting)" in status:
                    health = "starting"
                elif "Up" in status:
                    health = "running"
                elif "Exited" in status:
                    health = "exited"
                else:
                    health = "unknown"
                states[name.strip()] = health
        return states
    except Exception as e:
        log(f"ERROR obteniendo estados Docker: {e}")
        return {}


def load_previous_states() -> dict:
    if STATE_FILE.exists():
        try:
            return json.loads(STATE_FILE.read_text())
        except Exception:
            return {}
    return {}


def save_states(states: dict):
    STATE_FILE.write_text(json.dumps(states, indent=2))


def send_telegram(msg: str):
    if not TELEGRAM_TOKEN or not TELEGRAM_CHAT_ID:
        log(f"[TELEGRAM DESACTIVADO] {msg}")
        return
    try:
        import urllib.request
        import urllib.parse
        url = f"https://api.telegram.org/bot{TELEGRAM_TOKEN}/sendMessage"
        data = urllib.parse.urlencode({
            "chat_id": TELEGRAM_CHAT_ID,
            "text": msg,
            "parse_mode": "Markdown"
        }).encode()
        urllib.request.urlopen(url, data, timeout=10)
    except Exception as e:
        log(f"ERROR enviando Telegram: {e}")


def check_and_notify():
    current = get_docker_states()
    previous = load_previous_states()

    if not current:
        log("Sin containers detectados")
        return

    changes = []

    for name, state in current.items():
        prev_state = previous.get(name, "unknown")
        if state != prev_state:
            emoji_now = STATUS_EMOJI.get(state, "❓")
            emoji_prev = STATUS_EMOJI.get(prev_state, "❓")
            change = f"{emoji_now} *{name}*: {prev_state} → {state}"
            changes.append(change)
            log(f"CAMBIO: {name}: {prev_state} → {state}")
        else:
            log(f"OK: {name}: {state} (sin cambio)")

    # Containers que desaparecieron
    for name in previous:
        if name not in current:
            changes.append(f"🔴 *{name}*: desaparecido")
            log(f"DESAPARECIDO: {name}")

    if changes:
        msg = "🌳 *Yggdrasil Watchdog*\n\n" + "\n".join(changes)
        send_telegram(msg)
    else:
        log(f"Todo sin cambios ({len(current)} containers OK)")

    save_states(current)


if __name__ == "__main__":
    log("Notify-on-change watchdog arrancado")
    log(f"Intervalo: {CHECK_INTERVAL}s — Telegram: {'ON' if TELEGRAM_TOKEN else 'OFF'}")
    while True:
        try:
            check_and_notify()
        except KeyboardInterrupt:
            log("Watchdog detenido por el usuario")
            sys.exit(0)
        except Exception as e:
            log(f"ERROR en ciclo: {e}")
        time.sleep(CHECK_INTERVAL)
