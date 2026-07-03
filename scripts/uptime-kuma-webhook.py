#!/usr/bin/env python3
"""
uptime-kuma-webhook.py — Recibe webhooks de Uptime Kuma y los envía a Telegram vía THDORA

Despliegue: levantar como servicio systemd o con docker en el puerto 8001
Uptime Kuma: Settings > Notifications > Webhook > http://localhost:8001/webhook

Payload esperado de Uptime Kuma (formato por defecto):
{
  "heartbeat": {"status": 0/1, "msg": "...", "time": "..."},
  "monitor": {"name": "...", "url": "..."},
  "msg": "..."
}
"""
import os
import json
import logging
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.request import urlopen, Request
from urllib.parse import urlencode
from urllib.error import URLError

BOT_TOKEN = os.getenv("TELEGRAM_BOT_TOKEN", "")
CHAT_ID = os.getenv("TELEGRAM_CHAT_ID", "")
PORT = int(os.getenv("WEBHOOK_PORT", "8001"))

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")
log = logging.getLogger(__name__)


def send_telegram(text: str):
    """Envía mensaje a Telegram."""
    if not BOT_TOKEN or not CHAT_ID:
        log.warning("TELEGRAM_BOT_TOKEN o TELEGRAM_CHAT_ID no configurados")
        return
    url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
    data = urlencode({"chat_id": CHAT_ID, "text": text, "parse_mode": "Markdown"}).encode()
    try:
        req = Request(url, data=data, method="POST")
        urlopen(req, timeout=10)
        log.info("Telegram OK: %s", text[:80])
    except URLError as e:
        log.error("Error Telegram: %s", e)


class WebhookHandler(BaseHTTPRequestHandler):
    def log_message(self, fmt, *args):  # silenciar logs HTTP por defecto
        log.debug(fmt, *args)

    def do_POST(self):
        if self.path != "/webhook":
            self.send_response(404)
            self.end_headers()
            return

        length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(length)
        self.send_response(200)
        self.end_headers()

        try:
            payload = json.loads(body)
        except json.JSONDecodeError:
            log.error("Payload inválido: %s", body[:200])
            return

        hb = payload.get("heartbeat", {})
        monitor = payload.get("monitor", {})
        status = hb.get("status", -1)
        nombre = monitor.get("name", "desconocido")
        url = monitor.get("url", "")
        msg = hb.get("msg", payload.get("msg", ""))
        tiempo = hb.get("time", "")

        if status == 0:
            emoji = "🔴"
            estado = "CAÍDO"
        elif status == 1:
            emoji = "🟢"
            estado = "RECUPERADO"
        else:
            emoji = "⚠️"
            estado = "DESCONOCIDO"

        texto = (
            f"{emoji} *Batcueva — {estado}*\n"
            f"• Servicio: `{nombre}`\n"
            f"• URL: {url}\n"
            f"• Mensaje: {msg}\n"
            f"• Hora: {tiempo}"
        )
        send_telegram(texto)
        log.info("Alerta enviada: %s %s", estado, nombre)


if __name__ == "__main__":
    log.info("Webhook server escuchando en :%d/webhook", PORT)
    HTTPServer(("", PORT), WebhookHandler).serve_forever()
