# Arquitectura Swarm Intelligence — Yggdrasil Ecosystem

> Documentado: 2026-07-03 04:40 CEST
> Fuente: sesión de diseño iPhone → Madre

## Visión: "Que todos seamos 1"

Lo que describes no es una metáfora: es un **Ecosistema de Agentes Autónomos Conectados por Contexto Compartido**.
En la literatura de IA avanzada esto se llama **Swarm Intelligence** o **Multi-Agent Systems (MAS)**.

Tu implementación es 100% local, 100% open source, corriendo sobre hardware que ya tienes.

---

## Los 4 Agentes del Laboratorio

```
┌──────────────────────────────────────────────────────────────┐
│  EXPLORADOR      │  SYSADMIN         │  TESTER           │  AUDITOR  │
│                  │                  │                  │          │
│  Escanea HF      │  Ollama pull      │  Benchmarks       │  Juez    │
│  Filtra VRAM     │  Docker deploy    │  TPS + score      │  Config  │
│  ≤84GB VRAM      │  Tailscale-only   │  Contexto SQLite  │  Router  │
└──────────────────────────────────────────────────────────────┘
         ↓                 ↓                 ↓              ↓
         └──────────────────────────────────────────┘
                              Shared Context
                         config/router_llm.json
                         logs/bitacora_modelos.json
                         inbox/ (Obsidian vault)
```

## Hardware Constraints (GTX 1060 6GB VRAM)

| Regla | Valor | Motivo |
|---|---|---|
| Máx parámetros | 8B | Cabe en 6GB con Q4_K_M |
| Cuantizaciones objetivo | q4_K_M, q5_K_M, q4_0 | Equilibrio calidad/VRAM |
| Mín tokens/segundo | 18 t/s | Usabilidad en tiempo real |
| Mín score lógico | 75% | Precisión mínima aceptable |

## Memoria Unificada (Sistema Nervioso Central)

1. **Obsidian vault = Dataset de contexto** — los agentes leen y escriben `.md`
2. **SQLite FTS5** — indexación full-text en disco 1TB (con `chattr +C` en Btrfs)
3. **config/router_llm.json** — el Auditor escribe aquí el modelo activo
4. **logs/bitacora_modelos.json** — historial de benchmarks, trazable

## Principio de Emergencia

Cada agente solo conoce su tarea atómica.
La interacción coordinada produce comportamiento inteligente.
Nadie tiene el mapa completo — el mapa emerge de la colaboración.
Eso es Swarm Intelligence.

## Bucle Completo (Closed-Loop)

```
EXPLORADOR descubre candidato
    ↓
SYSADMIN despliega en Ollama (Tailscale, 100.91.112.32)
    ↓
TESTER ejecuta benchmarks (TPS, lógica, contexto local)
    ↓
AUDITOR compara con umbrales
    ↓ (si pasa)
ECOSISTEMA actualiza router → Thdora usa nuevo modelo
    ↓
HUMANO supervisa el dashboard — nunca el detalle
```

## Fichero principal

```bash
# Activar el laboratorio
source thdora/.venv/bin/activate
python3 core/lab/laboratorio_agentes.py
```

## Issues relacionados

- #1 Thdora base
- #11 GitHub Actions
- #25 Verificar modelos Ollama

_Perplexity MCP — 03-jul-2026 04:40 CEST_
