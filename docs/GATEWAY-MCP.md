# Gateway MCP — Políticas y Autorización

## Propósito

Centralizar authN/Z para todas las llamadas MCP al ecosistema.
Exigir aprobación humana en acciones de alto impacto.
Audit trail completo de cada tool call.

## Scopes y roles

| Rol | Scopes permitidos | Requiere aprobación |
|---|---|---|
| `readonly` | `health_check`, `core_estado`, `struct_auditor` (sin fix) | No |
| `operator` | Todos los agentes de lectura + `orquestador_total` (rapido) | No |
| `admin` | Todo | Para acciones destructivas |
| `llm-local` | `llm_router` solo con `ollama:*` | No |
| `llm-remote` | `llm_router` con `openai:*` o `anthropic:*` | Sí (datos sensibles) |

## Acciones de alto impacto (requieren aprobación)

- `struct_auditor` con `fix: true`
- `galatea_fabrica_agente` en producción
- `llm_router` con proveedores remotos y datos PII
- Cualquier tool que modifique `docs/CORE-ECOSISTEMA.md`

## Política de datos sensibles

1. **Preferir Ollama local** para cualquier prompt con datos del ecosistema
2. **Filtrar antes de enviar a APIs remotas**: eliminar rutas absolutas, IPs, tokens
3. **Máximo de tokens** en prompt remoto: 2000 (evitar fuga de contexto completo)

## Implementación (fase 1 — manual)

Hasta tener gateway automático, seguir estas reglas en cada llamada MCP:

```bash
# Variable de entorno para controlar acceso
export MCP_ROLE=operator  # readonly | operator | admin

# El server.js respeta MCP_ROLE para limitar tools disponibles
```

## Audit trail

Cada llamada MCP se registra en `inbox/mcp-audit-YYYY-MM-DD.log`:
```
[HH:MM:SS] TOOL=orquestador_total ARGS={modo:completo} ROLE=operator STATUS=OK DURATION=12s
```

## Roadmap gateway

- [ ] Fase 1: Variables de entorno + log manual (actual)
- [ ] Fase 2: Middleware en server.js que valida MCP_ROLE por tool
- [ ] Fase 3: Gateway HTTP separado con JWT + rate limiting
- [ ] Fase 4: Prometheus metrics por tool + Grafana dashboard
