#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Yggdrasil-DEW - Health Agent Core
Nodo: Madre (varpc) | Puerto: 8001
Rol: Recibe EcosystemSnapshot, clasifica estado, propone acciones safe.
Runtime: Docker + Ollama local (phi3:mini / mistral / qwen2)
[AUTO] 2026-07-03
"""

import json
import logging
import requests
from datetime import datetime
from pathlib import Path
from typing import Any
from fastapi import FastAPI
from pydantic import BaseModel, Field

logging.basicConfig(
    level=logging.INFO,
    format="[%(asctime)s] [%(levelname)s] [AUTO] %(message)s",
    handlers=[
        logging.FileHandler("/var/log/health-agent.log"),
        logging.StreamHandler(),
    ],
)
logger = logging.getLogger(__name__)

OLLAMA_URL = "http://host.docker.internal:11434/api/generate"
LLM_MODEL = "phi3:mini"  # Cabe en GTX 1060 6GB sin problema
LOG_ROOT = Path("/srv/yggdrasil-dew/logs/health-agent")

app = FastAPI(title="Yggdrasil Health Agent", version="1.0.0")


# ── Schemas ───────────────────────────────────────────────────────────────────

class ContainerStatus(BaseModel):
    name: str
    status: str  # running | stopped | crash-loop
    last_restart: str | None = None


class ServiceStatus(BaseModel):
    name: str
    reachable: bool
    latency_ms: float | None = None


class WorkflowStatus(BaseModel):
    name: str
    last_run: str
    status: str  # success | failed | skipped


class EcosystemSnapshot(BaseModel):
    timestamp: str
    containers: list[ContainerStatus]
    services: list[ServiceStatus]
    workflows: list[WorkflowStatus]
    notes: str | None = None


# ── Helpers ───────────────────────────────────────────────────────────────────

def call_llm(prompt: str) -> str:
    """Llama a Ollama local. Timeout 90s para GTX 1060."""
    try:
        resp = requests.post(
            OLLAMA_URL,
            json={"model": LLM_MODEL, "prompt": prompt, "stream": False},
            timeout=90,
        )
        resp.raise_for_status()
        return resp.json()["response"]
    except Exception as e:
        logger.error(f"Ollama error: {e}")
        # Fallback: análisis estático sin LLM
        return json.dumps({
            "global_status": "WARN",
            "analysis": f"LLM no disponible: {e}. Análisis estático aplicado.",
            "actions": []
        })


def log_decision(snapshot: EcosystemSnapshot, analysis: str, actions: list[dict[str, Any]]) -> None:
    """Persiste decisión en Markdown → ingesta RAG posterior."""
    LOG_ROOT.mkdir(parents=True, exist_ok=True)
    date_str = datetime.utcnow().strftime("%Y-%m-%d")
    log_file = LOG_ROOT / f"{date_str}.md"

    with log_file.open("a", encoding="utf-8") as f:
        f.write(f"## Health Agent — {snapshot.timestamp}\n\n")
        f.write(f"- Containers: {len(snapshot.containers)}\n")
        f.write(f"- Services: {len(snapshot.services)}\n")
        f.write(f"- Workflows: {len(snapshot.workflows)}\n\n")
        f.write(f"### Análisis\n\n{analysis}\n\n")
        f.write("### Acciones propuestas\n\n")
        for a in actions:
            safe = "✅" if a.get("safe") else "⚠️"
            f.write(f"- {safe} [{a.get('severity','?')}] {a.get('description','?')} → {a.get('target','?')}\n")
        f.write("\n---\n\n")
    logger.info(f"Decisión logueada en {log_file}")


# ── Endpoints ─────────────────────────────────────────────────────────────────

@app.get("/health")
async def health() -> dict[str, Any]:
    return {"status": "online", "model": LLM_MODEL, "node": "Madre"}


@app.post("/health/evaluate")
async def evaluate(snapshot: EcosystemSnapshot) -> dict[str, Any]:
    """Punto de entrada principal. Recibe snapshot → LLM → acciones safe."""
    containers_txt = "\n".join(f"  {c.name}: {c.status}" for c in snapshot.containers)
    services_txt = "\n".join(
        f"  {s.name}: {'OK' if s.reachable else 'DOWN'} (lat={s.latency_ms}ms)"
        for s in snapshot.services
    )
    workflows_txt = "\n".join(
        f"  {w.name}: {w.status} (last={w.last_run})"
        for w in snapshot.workflows
    )

    prompt = f"""Eres el agente de salud del ecosistema Yggdrasil.
Nunca propones acciones que toquen código de producción ni merges.
Solo acciones safe=true.

Estado actual:

[CONTAINERS]
{containers_txt}

[SERVICES]
{services_txt}

[WORKFLOWS]
{workflows_txt}

Notas: {snapshot.notes or 'N/A'}

Responde SOLO con JSON válido:
{{
  "global_status": "OK|WARN|CRITICAL",
  "analysis": "texto corto",
  "actions": [
    {{"severity": "low|medium|high", "description": "texto", "target": "docker|github|n8n|telegram", "safe": true}}
  ]
}}"""

    raw = call_llm(prompt)

    # Extrae JSON aunque el LLM añada texto extra
    try:
        start = raw.index("{")
        end = raw.rindex("}") + 1
        data = json.loads(raw[start:end])
    except (ValueError, json.JSONDecodeError):
        logger.warning("LLM no devolvió JSON limpio — usando fallback")
        data = {"global_status": "WARN", "analysis": raw[:500], "actions": []}

    analysis = data.get("analysis", "")
    actions = data.get("actions", [])

    log_decision(snapshot, analysis, actions)
    logger.info(f"Estado global: {data.get('global_status')} | Acciones: {len(actions)}")

    return data


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8001, log_level="info")
