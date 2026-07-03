# health_agent_core.py
# Agente de salud del ecosistema — esqueleto FastAPI
# Estado: ESQUELETO — no desplegado
# Sesión: 2026-07-03
# Docs: agentes/health-agent/DISEÑO.md

from fastapi import FastAPI
from pydantic import BaseModel
from datetime import datetime
import requests
import json
from pathlib import Path

# ─── Config ───────────────────────────────────────────────
OLLAMA_URL = "http://localhost:11434/api/generate"
LLM_MODEL = "phi3:mini"  # o mistral/qwen según VRAM disponible
LOG_ROOT = Path("/srv/yggdrasil-dew/logs/health-agent")

app = FastAPI(
    title="Health Agent Core",
    description="Agente de salud del ecosistema Madre",
    version="0.1.0"
)


# ─── Modelos de entrada ────────────────────────────────────
class ContainerStatus(BaseModel):
    name: str
    status: str  # "running" | "stopped" | "crash-loop"
    last_restart: str | None = None


class ServiceStatus(BaseModel):
    name: str
    reachable: bool
    latency_ms: float | None = None


class WorkflowStatus(BaseModel):
    name: str
    last_run: str
    status: str  # "success" | "failed" | "skipped"


class EcosystemSnapshot(BaseModel):
    timestamp: str
    containers: list[ContainerStatus]
    services: list[ServiceStatus]
    workflows: list[WorkflowStatus]
    notes: str | None = None


# ─── LLM call ─────────────────────────────────────────────
def call_llm(prompt: str) -> str:
    resp = requests.post(OLLAMA_URL, json={
        "model": LLM_MODEL,
        "prompt": prompt,
        "stream": False
    }, timeout=60)
    resp.raise_for_status()
    return resp.json()["response"]


# ─── Log en Markdown ───────────────────────────────────────
def log_decision(snapshot: EcosystemSnapshot, analysis: str, actions: list[dict]):
    LOG_ROOT.mkdir(parents=True, exist_ok=True)
    date_str = datetime.utcnow().strftime("%Y-%m-%d")
    log_file = LOG_ROOT / f"{date_str}.md"

    with log_file.open("a", encoding="utf-8") as f:
        f.write(f"## Health Check — {snapshot.timestamp}\n\n")
        f.write(f"- Containers: {len(snapshot.containers)}\n")
        f.write(f"- Services: {len(snapshot.services)}\n")
        f.write(f"- Workflows: {len(snapshot.workflows)}\n\n")
        f.write("### Analysis\n\n")
        f.write(analysis + "\n\n")
        f.write("### Proposed Actions\n\n")
        for a in actions:
            safe_marker = "✅" if a.get("safe") else "⚠️"
            f.write(f"- {safe_marker} [{a.get('severity', '?')}] "
                    f"{a.get('description', '?')} → {a.get('target', '?')}\n")
        f.write("\n---\n\n")


# ─── Endpoint principal ────────────────────────────────────
@app.post("/health/evaluate")
def evaluate(snapshot: EcosystemSnapshot):
    """Recibe snapshot del ecosistema, evalúa estado y propone acciones safe."""

    containers_txt = "\n".join(
        f"  {c.name}: {c.status}" + (f" (last_restart={c.last_restart})" if c.last_restart else "")
        for c in snapshot.containers
    )
    services_txt = "\n".join(
        f"  {s.name}: {'OK' if s.reachable else 'DOWN'}"
        + (f" lat={s.latency_ms}ms" if s.latency_ms else "")
        for s in snapshot.services
    )
    workflows_txt = "\n".join(
        f"  {w.name}: {w.status} (last_run={w.last_run})"
        for w in snapshot.workflows
    )

    prompt = f"""Eres un agente de salud del ecosistema homelab.
Solo puedes proponer acciones con safe=true.
Nunca proponer: borrar datos, tocar producción, hacer merge, abrir puertos.

Estado actual del ecosistema:

[CONTAINERS]
{containers_txt}

[SERVICES]
{services_txt}

[WORKFLOWS]
{workflows_txt}

Notas: {snapshot.notes or 'N/A'}

Responde SOLO con JSON válido, sin markdown, sin texto extra:
{{
  "global_status": "OK|WARN|CRITICAL",
  "analysis": "resumen breve",
  "actions": [
    {{
      "severity": "low|medium|high",
      "description": "acción concreta",
      "target": "docker|github|n8n|telegram",
      "safe": true
    }}
  ]
}}
"""

    raw = call_llm(prompt)

    # Parseo defensivo
    try:
        data = json.loads(raw)
    except json.JSONDecodeError:
        # Fallback si LLM no devuelve JSON puro
        data = {
            "global_status": "WARN",
            "analysis": "LLM response parse error — revisar logs",
            "actions": []
        }

    # Filtrar solo acciones safe=true (guardrail)
    safe_actions = [a for a in data.get("actions", []) if a.get("safe", False)]
    data["actions"] = safe_actions

    # Log inmutable de la decisión
    log_decision(snapshot, data.get("analysis", ""), safe_actions)

    return data


@app.get("/health/status")
def agent_status():
    """Estado del propio agente."""
    return {
        "agent": "health-agent-core",
        "version": "0.1.0",
        "model": LLM_MODEL,
        "log_root": str(LOG_ROOT),
        "status": "running"
    }
