# PLANTILLA DE AGENTE — Yggdrasil-Dew

> Copia este archivo como `agentes/<nombre-agente>/PROFILE.md` y rellena cada sección.
> Las secciones marcadas con `[REQUERIDO]` son obligatorias antes de activar el agente.

---

## 1. Identidad [REQUERIDO]

```yaml
nombre:       "<NombreAgente>"           # Único en el ecosistema
codigo:       "<CODIGO>"                 # Ej: GALATEA, THDORA, ATLAS
version:      "0.1.0"
estado:       "draft"                    # draft | activo | deprecated
creado:       "YYYY-MM-DD"
author:       "alvarofernandezmota-tech"
```

### Descripción en una línea
<!-- Qué hace este agente en ≤ 20 palabras -->

### Rol en el ecosistema
<!-- De qué fase del orquestador es responsable -->

---

## 2. Personalidad y tono [REQUERIDO]

| Dimensión       | Valor                          |
|-----------------|--------------------------------|
| Tono            | formal / técnico / empático    |
| Verbosidad      | conciso / detallado / variable |
| Lenguaje        | ES / EN / mixto                |
| Estilo respuesta| bullets / prose / JSON         |

### Rasgos de personalidad
<!-- 3-5 rasgos que definen cómo interactúa y toma decisiones -->

---

## 3. Capacidades [REQUERIDO]

### Inputs que acepta
```
- Tipo 1: descripción + formato esperado
- Tipo 2: ...
```

### Outputs que genera
```
- Tipo 1: descripción + ruta destino
- Tipo 2: ...
```

### Dependencias
```yaml
scripts:
  - scripts/agentes/llm-router.sh
  - scripts/clasificador-maestro.sh  # si aplica
python:
  - mcp/llm_adapters.py
binarios:
  - jq
  - git
```

---

## 4. Prompts de ejemplo [REQUERIDO]

### Prompt de sistema (system prompt)
```
Eres <NombreAgente>, un agente especializado en <dominio>.
Tu misión: <misión>.
Reglas:
1. Siempre responde en español.
2. Limita tu respuesta a <límite> tokens.
3. Si no tienes información suficiente, indica claramente qué falta.
```

### Ejemplos de invocación
```bash
# Ejemplo 1 — caso de uso principal
bash scripts/agentes/llm-router.sh "<prompt de ejemplo>" auto

# Ejemplo 2 — caso de uso secundario
bash scripts/agentes/llm-router.sh "<prompt alternativo>" ollama
```

---

## 5. Tests unitarios [REQUERIDO]

> Estos tests corren en CI (`.github/workflows/ci-agentes.yml`).

```bash
#!/usr/bin/env bash
# tests/agentes/test-<nombre>.sh
set -euo pipefail

PASS=0; FAIL=0

_assert() {
  local desc="$1" expected="$2" actual="$3"
  if [[ "$actual" == *"$expected"* ]]; then
    echo "  PASS: $desc"; ((PASS++))
  else
    echo "  FAIL: $desc | esperado='$expected' actual='$actual'"; ((FAIL++))
  fi
}

# Test 1: el agente genera un output no vacío
OUT=$(bash scripts/agentes/llm-router.sh "ping" ollama 2>/dev/null || echo "")
_assert "output no vacío" "" "${OUT:+nonempty}"

# Test 2: el output contiene el marcador de formato esperado
_assert "marcador de formato" "##" "$OUT"

echo "\nResultado: $PASS passed, $FAIL failed"
[[ $FAIL -eq 0 ]]
```

---

## 6. Métricas [REQUERIDO]

| Métrica              | Objetivo       | Alerta si...      |
|----------------------|----------------|-------------------|
| Latencia p50         | < 5s           | > 15s             |
| Tasa de éxito        | > 95%          | < 80%             |
| Tokens por respuesta | < 1024         | > 2048            |
| Frecuencia de uso    | ≥ 1/semana     | 0 en 14 días      |

Los logs JSON del router viven en `inbox/_meta/llm-router-YYYYMMDD.jsonl`.
Script de reporte rápido:
```bash
jq -s 'group_by(.provider)[] | {provider: .[0].provider, calls: length, avg_ms: (map(.latency_ms) | add / length)}' \
  inbox/_meta/llm-router-$(date +%Y%m%d).jsonl
```

---

## 7. Checklist de seguridad [REQUERIDO]

- [ ] El agente **nunca** escribe directamente en `main` — genera PR o archivo en `inbox/drop/`
- [ ] Las acciones destructivas requieren flag `--confirm`
- [ ] Los prompts pasan por `sanitize_prompt()` antes de ir al LLM
- [ ] El agente no almacena credenciales en texto plano
- [ ] Los outputs se validan contra el esquema esperado antes de commitear
- [ ] El agente tiene tests que corren en CI antes de activarse

---

## 8. Historial de versiones

| Versión | Fecha      | Cambios                  |
|---------|------------|--------------------------|
| 0.1.0   | YYYY-MM-DD | Versión inicial          |
