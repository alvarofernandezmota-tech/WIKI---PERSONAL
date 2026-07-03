"""
Health Agent - Yggdrasil SecOps
FastAPI + Ollama local | SIEMPRE dry_run para acciones destructivas
"""
from fastapi import FastAPI
from pydantic import BaseModel
from datetime import datetime
import requests, json
from pathlib import Path

OLLAMA_URL = "http://localhost:11434/api/generate"
LLM_MODEL  = "phi3:mini"
LOG_ROOT   = Path("/srv/yggdrasil-dew/logs/health-agent")

app = FastAPI(title="Health Agent", version="1.0")

class ContainerStatus(BaseModel):
    name: str
    status: str
    last_restart: str | None = None

class ServiceStatus(BaseModel):
    name: str
    reachable: bool
    latency_ms: float | None = None

class WorkflowStatus(BaseModel):
    name: str
    last_run: str
    status: str

class EcosystemSnapshot(BaseModel):
    timestamp: str
    containers: list[ContainerStatus]
    services: list[ServiceStatus]
    workflows: list[WorkflowStatus]
    notes: str | None = None

def call_llm(prompt: str) -> str:
    resp = requests.post(OLLAMA_URL, json={
        "model": LLM_MODEL, "prompt": prompt, "stream": False
    }, timeout=60)
    resp.raise_for_status()
    return resp.json()["response"]

def log_decision(snapshot, analysis, actions):
    LOG_ROOT.mkdir(parents=True, exist_ok=True)
    date_str = datetime.utcnow().strftime("%Y-%m-%d")
    log_file = LOG_ROOT / f"{date_str}.md"
    with log_file.open("a", encoding="utf-8") as f:
        f.write(f"# Health Log {snapshot.timestamp}\n\n")
        f.write(f"- Containers: {len(snapshot.containers)}\n")
        f.write(f"- Services: {len(snapshot.services)}\n")
        f.write(f"- Workflows: {len(snapshot.workflows)}\n\n")
        f.write(f"## Analysis\n\n{analysis}\n\n")
        f.write("## Actions\n\n")
        for a in actions:
            f.write(f"- [{a.get('severity','?')}] {a.get('description','?')} → {a.get('target','?')}\n")
        f.write("\n---\n\n")

@app.post("/health/evaluate")
def evaluate(snapshot: EcosystemSnapshot):
    containers_txt = "\n".join(f"{c.name}: {c.status}" for c in snapshot.containers)
    services_txt   = "\n".join(f"{s.name}: {'OK' if s.reachable else 'DOWN'} (lat={s.latency_ms})" for s in snapshot.services)
    workflows_txt  = "\n".join(f"{w.name}: {w.status} (last={w.last_run})" for w in snapshot.workflows)

    prompt = f"""
Eres el health-agent del ecosistema Yggdrasil. NUNCA propongas acciones sobre producción.
SIEMPRE dry_run=true. Solo acciones safe.

[CONTAINERS]
{containers_txt}

[SERVICES]
{services_txt}

[WORKFLOWS]
{workflows_txt}

Notas: {snapshot.notes or 'N/A'}

Responde SOLO JSON:
{{
  "global_status": "OK|WARN|CRITICAL",
  "analysis": "texto breve",
  "actions": [
    {{"severity":"low|medium|high","description":"...","target":"docker|github|n8n|telegram","safe":true}}
  ]
}}
"""
    raw    = call_llm(prompt)
    data   = json.loads(raw)
    log_decision(snapshot, data.get("analysis",""), data.get("actions",[]))
    return data

@app.get("/health/ping")
def ping():
    return {"status": "ok", "agent": "health-agent", "ts": datetime.utcnow().isoformat()}
