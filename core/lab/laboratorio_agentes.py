#!/usr/bin/env python3
"""
Ecosistema Yggdrasil-DEW -- Laboratorio Auto-Evolutivo Multi-Agente
File: core/lab/laboratorio_agentes.py
Autor: Alvaro (Homelab Batcueva)

ARQUITECTURA SWARM -- 4 agentes, 1 objetivo:
  Explorador  → descubre modelos compatibles con GTX 1060 (6GB VRAM)
  Sysadmin    → despliega en Ollama via Tailscale
  Tester      → benchmarks: velocidad, lógica, contexto
  Auditor     → juez supremo, reescribe config si hay ganador
"""

import os
import time
import json
import requests

# === CONFIGURACIÓN ===
OLLAMA_HOST = "100.91.112.32"   # Tailscale IP Madre
OLLAMA_PORT = "11434"
OLLAMA_API_URL = f"http://{OLLAMA_HOST}:{OLLAMA_PORT}/api"

# Límites hardware GTX 1060 6GB VRAM
MAX_PARAMS_BILLIONS = 8.0
TARGET_QUANTIZATIONS = ["q4_K_M", "q5_K_M", "q4_0"]

# Umbral de producción
MIN_TPS = 18.0           # tokens/segundo mínimo
MIN_SCORE = 0.75         # precisión lógica mínima

TESTS_LABORATORIO = [
    {
        "id": "codigo_luks_btrfs",
        "prompt": "Escribe una función de Python que use subprocess para verificar el estado de un volumen cifrado LUKS sobre un file system Btrfs. Devuelve solo código limpio.",
        "keywords_esperadas": ["subprocess", "btrfs", "luks", "def "]
    },
    {
        "id": "comprension_contexto",
        "prompt": "Explica conceptualmente cómo el protocolo MCP unifica el acceso a herramientas locales como GitHub y Docker para múltiples LLMs en caliente.",
        "keywords_esperadas": ["MCP", "contexto", "herramientas", "host"]
    },
    {
        "id": "seguridad_ssh",
        "prompt": "Dame un script bash que audite la configuración SSH de un servidor Linux y devuelva un informe de vulnerabilidades críticas.",
        "keywords_esperadas": ["PasswordAuthentication", "PermitRootLogin", "sshd_config", "bash"]
    }
]


class AgenteExplorador:
    """Descubre y filtra modelos compatibles con el hardware local."""

    def buscar_candidatos(self) -> list:
        print("[Explorador] Escaneando candidatos compatibles con GTX 1060 6GB...")
        # Fuente: Hugging Face API + listas curadas
        candidatos = [
            {"name": "qwen2.5-coder:7b",           "params": 7.0, "quant": "q4_K_M"},
            {"name": "llama3.1:8b-instruct-q4_K_M", "params": 8.0, "quant": "q4_K_M"},
            {"name": "mistral:7b-instruct-q5_K_M",  "params": 7.0, "quant": "q5_K_M"},
            {"name": "codellama:7b-code-q4_K_M",    "params": 7.0, "quant": "q4_K_M"},
            {"name": "deepseek-coder:6.7b",          "params": 6.7, "quant": "q4_K_M"},
        ]
        filtrados = [
            c for c in candidatos
            if c["params"] <= MAX_PARAMS_BILLIONS
            and c["quant"] in TARGET_QUANTIZATIONS
        ]
        print(f"[Explorador] {len(filtrados)}/{len(candidatos)} modelos pasan filtro VRAM.")
        return filtrados


class AgenteSysadmin:
    """Orquesta despliegue en Ollama/Docker via Tailscale."""

    def desplegar_modelo(self, modelo_name: str) -> bool:
        print(f"[Sysadmin] Pull '{modelo_name}' → Madre ({OLLAMA_HOST})...")
        try:
            r = requests.post(
                f"{OLLAMA_API_URL}/pull",
                json={"name": modelo_name, "stream": False},
                timeout=600
            )
            if r.status_code == 200:
                print(f"[Sysadmin] ✅ '{modelo_name}' desplegado.")
                return True
            else:
                print(f"[Sysadmin] ❌ HTTP {r.status_code}")
        except Exception as e:
            print(f"[Sysadmin] ❌ Error: {e}")
        return False

    def verificar_modelo_activo(self, modelo_name: str) -> bool:
        try:
            r = requests.get(f"{OLLAMA_API_URL}/tags", timeout=10)
            if r.status_code == 200:
                modelos = [m["name"] for m in r.json().get("models", [])]
                return modelo_name in modelos
        except Exception:
            pass
        return False


class AgenteTester:
    """Ejecuta benchmarks: velocidad, lógica, adherencia al prompt."""

    def ejecutar_benchmarks(self, modelo_name: str) -> list:
        print(f"[Tester] Batería de pruebas sobre '{modelo_name}'...")
        resultados = []

        for test in TESTS_LABORATORIO:
            payload = {
                "model": modelo_name,
                "prompt": test["prompt"],
                "stream": False,
                "options": {"temperature": 0.1, "num_predict": 256}
            }
            t0 = time.time()
            try:
                r = requests.post(f"{OLLAMA_API_URL}/generate", json=payload, timeout=120)
                duracion = time.time() - t0
                if r.status_code == 200:
                    data = r.json()
                    tokens = data.get("eval_count", 1)
                    tps = tokens / duracion
                    respuesta = data.get("response", "")
                    score = sum(
                        1 for kw in test["keywords_esperadas"]
                        if kw.lower() in respuesta.lower()
                    ) / len(test["keywords_esperadas"])
                    resultados.append({
                        "test_id": test["id"],
                        "tps": round(tps, 2),
                        "score_logico": round(score, 2),
                        "duracion_s": round(duracion, 2)
                    })
                    print(f"[Tester]   {test['id']}: {tps:.1f} t/s | score {score*100:.0f}%")
            except Exception as e:
                print(f"[Tester]   ❌ {test['id']}: {e}")

        return resultados


class AgenteAuditor:
    """Juez supremo. Reescribe config del ecosistema si hay ganador."""

    CONFIG_PATH = os.path.expanduser("~/yggdrasil-dew/config/router_llm.json")
    LOG_PATH    = os.path.expanduser("~/yggdrasil-dew/logs/bitacora_modelos.json")

    def auditar_y_escalar(self, modelo_name: str, resultados: list) -> bool:
        if not resultados:
            print(f"[Auditor] Sin resultados para '{modelo_name}'. Saltando.")
            return False

        tps_medio   = sum(r["tps"]          for r in resultados) / len(resultados)
        score_medio = sum(r["score_logico"] for r in resultados) / len(resultados)

        print(f"[Auditor] {modelo_name}: {tps_medio:.1f} t/s | {score_medio*100:.0f}% precisión")
        self._guardar_log(modelo_name, tps_medio, score_medio, resultados)

        if tps_medio >= MIN_TPS and score_medio >= MIN_SCORE:
            print(f"[Auditor] 🥇 GANADOR: '{modelo_name}' pasa controles de producción.")
            self._actualizar_router(modelo_name, tps_medio, score_medio)
            return True
        else:
            print(f"[Auditor] ❌ '{modelo_name}' no supera umbrales. Aislado.")
            return False

    def _actualizar_router(self, modelo: str, tps: float, score: float):
        os.makedirs(os.path.dirname(self.CONFIG_PATH), exist_ok=True)
        config = {
            "MODELO_DEFAULT_LOCAL": modelo,
            "tps_benchmark": tps,
            "score_benchmark": score,
            "last_update": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())
        }
        with open(self.CONFIG_PATH, "w") as f:
            json.dump(config, f, indent=4)
        print(f"[Auditor] Config actualizada: {self.CONFIG_PATH}")

    def _guardar_log(self, modelo: str, tps: float, score: float, resultados: list):
        os.makedirs(os.path.dirname(self.LOG_PATH), exist_ok=True)
        historial = []
        if os.path.exists(self.LOG_PATH):
            try:
                with open(self.LOG_PATH) as f:
                    historial = json.load(f)
            except Exception:
                pass
        historial.append({
            "modelo": modelo,
            "fecha": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
            "tps_medio": round(tps, 2),
            "score_medio": round(score, 2),
            "tests": resultados
        })
        with open(self.LOG_PATH, "w") as f:
            json.dump(historial, f, indent=2)


def main():
    print("\n" + "="*60)
    print(" YGGDRASIL — LABORATORIO AUTO-EVOLUTIVO MULTI-AGENTE")
    print(" Homelab Batcueva — Nodo Madre — GTX 1060 6GB")
    print("="*60 + "\n")

    explorador = AgenteExplorador()
    sysadmin   = AgenteSysadmin()
    tester     = AgenteTester()
    auditor    = AgenteAuditor()

    candidatos = explorador.buscar_candidatos()
    ganadores  = []

    for modelo in candidatos:
        nombre = modelo["name"]
        print(f"\n{'='*60}")
        print(f" Procesando: {nombre}")
        print(f"{'='*60}")

        if not sysadmin.desplegar_modelo(nombre):
            continue

        resultados = tester.ejecutar_benchmarks(nombre)
        if auditor.auditar_y_escalar(nombre, resultados):
            ganadores.append(nombre)

    print(f"\n{'='*60}")
    print(f" RESUMEN FINAL: {len(ganadores)}/{len(candidatos)} modelos en producción")
    for g in ganadores:
        print(f"  🥇 {g}")
    print(f"{'='*60}\n")


if __name__ == "__main__":
    main()
