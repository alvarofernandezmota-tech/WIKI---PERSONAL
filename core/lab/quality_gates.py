#!/usr/bin/env python3
"""
Quality Gates — Validación inter-agente con Pydantic
File: core/lab/quality_gates.py

Filtros obligatorios entre agentes. Inspirado en arquitecturas
de enjambre militar: ningún dato corrupto se propaga.
"""
from pydantic import BaseModel, validator
from typing import Optional
import time

# === HARDWARE CONSTRAINTS ===
MAX_PARAMS_BILLIONS = 8.0
VALID_QUANTIZATIONS = ["q4_K_M", "q5_K_M", "q4_0", "q4_1"]
MIN_TPS = 18.0
MIN_SCORE = 0.75


class ModeloCandidato(BaseModel):
    """Validación: Explorador → Sysadmin"""
    name: str
    params: float
    quant: str

    @validator('params')
    def check_vram(cls, v):
        if v > MAX_PARAMS_BILLIONS:
            raise ValueError(f'Modelo {v}B excede límite VRAM GTX 1060 ({MAX_PARAMS_BILLIONS}B max)')
        return v

    @validator('quant')
    def check_quant(cls, v):
        if v not in VALID_QUANTIZATIONS:
            raise ValueError(f'Cuantización {v!r} no está en lista validada: {VALID_QUANTIZATIONS}')
        return v

    @validator('name')
    def check_name(cls, v):
        if not v or len(v) < 3:
            raise ValueError('Nombre de modelo inválido')
        return v.strip()


class ResultadoBenchmark(BaseModel):
    """Validación: Tester → Auditor"""
    test_id: str
    tps: float
    score_logico: float
    duracion_s: float
    modelo: Optional[str] = None

    @validator('tps')
    def check_tps(cls, v):
        if v < 0 or v > 200:
            raise ValueError(f'TPS {v} fuera de rango realista (0-200)')
        return v

    @validator('score_logico')
    def check_score(cls, v):
        if not 0.0 <= v <= 1.0:
            raise ValueError(f'Score {v} debe estar entre 0.0 y 1.0')
        return v


class DecisionAuditor(BaseModel):
    """Validación: Auditor → Config/Router"""
    modelo: str
    tps_medio: float
    score_medio: float
    aprobado: bool
    timestamp: Optional[str] = None

    def __init__(self, **data):
        data.setdefault('timestamp', time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()))
        super().__init__(**data)


class CircuitBreaker:
    """
    Anti-bucle infinito.
    Uso:
        cb = CircuitBreaker(max_iter=5, label='Tester-Sysadmin')
        while condition:
            cb.tick()  # lanza RuntimeError si supera el límite
    """
    def __init__(self, max_iter: int = 5, label: str = 'agente'):
        self.count = 0
        self.max = max_iter
        self.label = label

    def tick(self):
        self.count += 1
        if self.count > self.max:
            raise RuntimeError(
                f'[CircuitBreaker] Límite alcanzado en {self.label!r}: '
                f'{self.count}/{self.max} iteraciones. Abortando.'
            )

    def reset(self):
        self.count = 0


def comprimir_contexto(historial: list, max_chars: int = 3000) -> list:
    """
    Compresor de contexto: evita VRAM overflow en GTX 1060.
    Si el historial supera max_chars, conserva solo los últimos 5 elementos.
    Además prepara un prompt de resumen para un modelo 3B local.
    """
    total = sum(len(str(m)) for m in historial)
    if total <= max_chars:
        return historial

    print(f"[Context Compressor] Historial {total} chars > {max_chars}. Comprimiendo...")
    # Conservar los últimos 5 y añadir aviso
    comprimido = [{"role": "system", "content": "[Contexto anterior comprimido para liberar VRAM]"}]
    comprimido += historial[-5:]
    return comprimido


# Test rápido
if __name__ == "__main__":
    try:
        m = ModeloCandidato(name="llama3.1:8b-q4_K_M", params=8.0, quant="q4_K_M")
        print(f"[OK] {m.name} validado")
    except Exception as e:
        print(f"[ERROR] {e}")

    try:
        m_fail = ModeloCandidato(name="llama3:70b", params=70.0, quant="q4_K_M")
    except Exception as e:
        print(f"[BLOQUEADO correctamente] {e}")

    cb = CircuitBreaker(max_iter=3, label='test')
    try:
        for _ in range(5):
            cb.tick()
    except RuntimeError as e:
        print(f"[CircuitBreaker OK] {e}")
