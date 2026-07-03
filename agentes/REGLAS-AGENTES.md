# 📜 Reglas de Agentes — Ecosistema

> **Estas reglas son ley.** Todo agente debe cumplirlas sin excepción.  
> Actualizar solo en sesión con revisar humana.  
> Última revisión: 2026-07-03

---

## Principio razón

```
El agente es el cerebro. Los bots son sus manos.
El humano es el árbitro final.
Nada irreversible sin confirmación humana.
```

---

## Reglas NUNCA (hard limits — en código, no solo en docs)

| # | Regla | Consecuencia si viola |
|---|---|---|
| N1 | **Nunca tocar código de producción directamente** | Agente pausado, issue creado |
| N2 | **Nunca borrar datos, ficheros, DB** | Agente pausado, alerta CRITICAL |
| N3 | **Nunca hacer merge sin aprobación humana** | PR abierto, no merged |
| N4 | **Nunca abrir puertos ni modificar UFW** | Bloqueado a nivel OS |
| N5 | **Nunca ejecutar scripts con `safe=false` en modo autónomo** | Requiere dry_run primero |
| N6 | **Nunca llamar una tool más de 10 veces por ciclo** | Circuit breaker activa |
| N7 | **Nunca usar credenciales del humano** | Credenciales de agente separadas |
| N8 | **Nunca procesar datos personales sin anonimizar** | Bloqueado antes de LLM |

---

## Reglas SIEMPRE (obligaciones — en código)

| # | Regla |
|---|---|
| S1 | **Siempre loguear cada decisión** en Markdown (logs/agente/YYYY-MM-DD.md) |
| S2 | **Siempre dry_run=true** por defecto en tools destructivas |
| S3 | **Siempre filtrar safe=true** antes de ejecutar acciones |
| S4 | **Siempre crear issue** antes de cualquier cambio en repo |
| S5 | **Siempre notificar vía guardianbot** si global_status != OK |
| S6 | **Siempre registrar en audit.log** (append-only) cada llamada a tool |
| S7 | **Siempre respetar el registro** — si no está en REGISTRO-AGENTES.md, no existe |

---

## Clasificación de acciones

### 🟢 Safe — automáticas
- Leer ficheros, logs, estado
- Ping a servicios
- Query RAG
- Crear issue (sin assignee, sin label critical)
- Notificar por Telegram
- Escribir en logs Markdown

### 🟡 Requieren dry_run previo
- Reiniciar contenedor
- Ejecutar script
- Commit en repo
- Actualizar docs automáticamente

### 🔴 Requieren aprobación humana SIEMPRE
- Merge de PR
- Deploy a producción
- Cambios en docker-compose.yml
- Cambios en configuración de red
- Borrar cualquier cosa
- Credenciales o secrets

---

## Identidad de agentes

Cada agente tiene:
- **Nombre único** declarado en REGISTRO-AGENTES.md
- **Credenciales propias** (GitHub token de agente, no del humano)
- **Permisos mínimos** (principio de mínimo privilegio)
- **Audit log propio**: `logs/{agente-name}/audit.log`

---

## Guardrails en código (patrón estándar)

```python
# Todo tool del agente sigue este patrón
def tool_name(args: dict, dry_run: bool = True) -> dict:
    # 1. Audit
    audit_log("tool_name", args)
    
    # 2. Validar safe
    if not is_safe(args):
        return {"executed": False, "reason": "action_not_safe"}
    
    # 3. Dry run check
    if dry_run:
        return {"executed": False, "dry_run": True, "would_do": describe(args)}
    
    # 4. Ejecución real
    result = execute(args)
    audit_log("tool_name", args, result=result)
    return {"executed": True, "result": result}
```

---

## Circuit breakers

```python
# Protección contra bucles infinitos del agente
MAX_TOOL_CALLS_PER_CYCLE = 10
MAX_SAME_TOOL_CALLS = 3
MIN_SECONDS_BETWEEN_CYCLES = 60

# Si el agente llama a la misma tool 3 veces seguidas → PAUSA
# Si el agente hace 10 llamadas en un ciclo → PAUSA
# Pausa = notificar a humano vía guardianbot
```

---

## Escalado a humano

El agente escala **siempre** cuando:
- `global_status == CRITICAL`
- Cualquier acción con `safe=false` detectada
- Circuit breaker activado
- Error de parse del LLM más de 3 veces
- Cualquier acción marcada `[HUMAN]` en el ROADMAP

Escalado = Telegram a guardianbot + issue en repo + pausa del agente

---

*Reglas versión 1.0 — 2026-07-03*  
*Próxima revisión: cuando se despliegue el primer agente en producción*
