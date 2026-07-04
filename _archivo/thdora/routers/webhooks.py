# ==============================================================================
# yggdrasil-dew/thdora/routers/webhooks.py
# Propósito: Endpoint FastAPI para recibir alertas de Uptime Kuma y reenviar a Telegram
# Generado: Sesión Gemini 2026-06-27
# ==============================================================================

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
import httpx
import os

router = APIRouter()

TELEGRAM_BOT_TOKEN = os.getenv("TELEGRAM_BOT_TOKEN")
TELEGRAM_CHAT_ID = os.getenv("TELEGRAM_CHAT_ID")


class UptimeKumaPayload(BaseModel):
    msg: str
    heartbeat: dict = None
    monitor: dict = None


@router.post("/webhook/uptime")
async def uptime_webhook(payload: UptimeKumaPayload):
    """
    Recibe alertas de Uptime Kuma y las formatea para Telegram.
    Uptime Kuma: status 0 = DOWN, 1 = UP
    """
    try:
        status_code = payload.heartbeat.get("status", 0) if payload.heartbeat else 0
        monitor_name = payload.monitor.get("name", "Desconocido") if payload.monitor else "Servicio"

        if status_code == 0:
            emoji = "🔴 [ALERTA CRÍTICA]"
        else:
            emoji = "🟢 [SISTEMA RECUPERADO]"

        mensaje_tg = (
            f"{emoji}\n\n"
            f"📡 *Servicio:* {monitor_name}\n"
            f"📝 *Mensaje:* {payload.msg}\n"
            f"🦇 *Batcueva SOC*"
        )

        telegram_url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/sendMessage"
        async with httpx.AsyncClient() as client:
            response = await client.post(telegram_url, json={
                "chat_id": TELEGRAM_CHAT_ID,
                "text": mensaje_tg,
                "parse_mode": "Markdown"
            })
            if response.status_code != 200:
                raise HTTPException(status_code=500, detail="Fallo al enviar a Telegram")

        return {"status": "ok", "message": "Alerta procesada y enviada a THDORA"}

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
