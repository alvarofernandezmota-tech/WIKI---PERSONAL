# tools/prometheus_exporter.py — Métricas Prometheus para el ecosistema
from prometheus_client import start_http_server, Counter, Gauge, Histogram
import time
import os

PORT = int(os.getenv("PROMETHEUS_PORT", "9100"))

# Métricas
EXEC_COUNTER = Counter(
    'yggdrasil_tool_executions_total',
    'Total de ejecuciones de herramientas',
    ['tool', 'status']
)
LATENCY = Histogram(
    'yggdrasil_tool_latency_seconds',
    'Latencia de herramientas en segundos',
    ['tool'],
    buckets=[0.1, 0.5, 1.0, 5.0, 10.0, 30.0, 60.0]
)
ACTIVE_AGENTS = Gauge(
    'yggdrasil_active_agents',
    'Agentes activos en el ecosistema'
)
OCR_QUEUE = Gauge(
    'yggdrasil_ocr_queue_size',
    'Archivos pendientes en inbox/ocr/raw'
)
LLM_ERRORS = Counter(
    'yggdrasil_llm_errors_total',
    'Errores del router LLM',
    ['provider']
)

def record(tool: str, status: str, latency_seconds: float):
    EXEC_COUNTER.labels(tool=tool, status=status).inc()
    LATENCY.labels(tool=tool).observe(latency_seconds)

def update_queue_metrics():
    root = os.getenv("YGGDRASIL_ROOT", ".")
    ocr_raw = os.path.join(root, "inbox", "ocr", "raw")
    if os.path.isdir(ocr_raw):
        count = len([f for f in os.listdir(ocr_raw) if os.path.isfile(os.path.join(ocr_raw, f))])
        OCR_QUEUE.set(count)
    agents_dir = os.path.join(root, "agentes")
    if os.path.isdir(agents_dir):
        count = len([d for d in os.listdir(agents_dir) if os.path.isdir(os.path.join(agents_dir, d))])
        ACTIVE_AGENTS.set(count)

if __name__ == "__main__":
    start_http_server(PORT)
    print(f"[prometheus_exporter] Métricas en http://0.0.0.0:{PORT}/metrics")
    while True:
        update_queue_metrics()
        time.sleep(15)
