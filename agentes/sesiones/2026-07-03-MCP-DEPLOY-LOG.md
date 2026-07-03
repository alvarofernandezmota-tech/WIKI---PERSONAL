# MCP Server — Log de Despliegue 2026-07-03

> **Hora:** ~17:30 CEST  
> **Estado:** Docker build ✅ — MCP socket ❌ pendiente fix  
> **Próximo paso:** ver sección 4

---

## 1. Resultado del dry-run previo

```
[WARN]  DRY_RUN completado. Para desplegar de verdad: bash scripts/deploy.sh --apply
[OK]    Docker OK
[OK]    gh CLI OK
[OK]    Python3 OK
[WARN]  Ollama no responde en :11434 — health-agent necesitará Ollama
```

**Nota Ollama:** El health-agent necesita Ollama para clasificar estado. Sin Ollama, el agente puede arrancar pero el endpoint `/health/evaluate` fallará en la llamada al LLM. Solución: arrancar Ollama antes, o hacer el LLM opcional con fallback rule-based.

---

## 2. Docker build — completado con éxito ✅

```
Building 978.9s (11/11) FINISHED
  [1/5] FROM python:3.12-slim          ✅ (resolve + pull)
  [2/5] WORKDIR /app                   ✅ (cached)
  [3/5] RUN pip install mcp fastmcp    ✅ (292s)
  [4/5] COPY mcp_server.py             ✅
  [5/5] RUN apt-get + curl + CLI tools ✅ (556s)
  exporting image                      ✅ (69s)
```

Imagen generada: `mcp-server-mcp-server:latest`

**Observación:** El build tardó ~979s (~16 min). Causa: step [5/5] instala curl + gh CLI dentro del contenedor (556s). En próximas builds usar imagen base con gh ya instalado o separar en multi-stage.

**Warning menor (ignorable):**
```
the attribute `version` is obsolete in docker-compose.yml
```
Fix: eliminar la línea `version:` del `docker-compose.yml` en el próximo commit.

---

## 3. Error — Socket MCP no conectado ❌

```
Exception received connError(msg: "Session Exception - Socket error: Socket is not connected")
blink>
```

### Diagnóstico

El contenedor arranó pero el cliente MCP (Cursor/blink) no pudo establecer sesión. Causas probables:

| # | Causa | Cómo verificar |
|---|---|---|
| A | El servidor MCP usa stdio transport, no SSE/HTTP | `cat mcp_server.py \| grep transport` |
| B | Puerto 3000 no expuesto o mal mapeado en docker-compose | `docker ps \| grep mcp` |
| C | Cursor config apunta a URL incorrecta o formato equivocado | Ver `.cursor/mcp.json` |
| D | mcp_server.py usa `run()` sin `transport="sse"` | Revisar código |

### Causa más probable

fastmcp por defecto arranca en modo **stdio** (para integración directa), no en modo HTTP/SSE. Para que Cursor se conecte vía URL necesita **SSE transport** o **Streamable HTTP**.

---

## 4. Fix — próximos pasos concretos

### Paso 4.1 — Verificar qué transport usa el servidor actual

```bash
# En Madre
docker logs $(docker ps -q --filter name=mcp-server) 2>&1 | tail -30

# Ver cómo arranca el servidor
cat /srv/yggdrasil-dew/agentes/mcp-server/mcp_server.py | grep -E 'run|transport|port|host'
```

### Paso 4.2 — Opción A: añadir SSE transport a mcp_server.py

Si el código tiene algo como:
```python
mcp.run()  # stdio por defecto
```

Cambiar a:
```python
# SSE transport — Cursor puede conectar vía URL
mcp.run(transport="sse", host="0.0.0.0", port=3000)
```

O con fastmcp:
```python
if __name__ == "__main__":
    mcp.run(transport="sse")  # expone en http://0.0.0.0:3000/sse
```

### Paso 4.3 — Opción B: usar stdio localmente sin Docker

Si Cursor y el servidor están en la misma máquina (o con SSH tunnel), stdio es más simple:

```json
// .cursor/mcp.json
{
  "mcpServers": {
    "madre": {
      "command": "ssh",
      "args": [
        "madre",
        "cd /srv/yggdrasil-dew/agentes/mcp-server && source .venv/bin/activate && python mcp_server.py"
      ]
    }
  }
}
```

Esto es más fiable que SSE sobre Docker para empezar.

### Paso 4.4 — Verificar puerto expuesto

```bash
# En Madre
docker ps --format 'table {{.Names}}\t{{.Ports}}' | grep mcp

# Si el puerto no aparece, el contenedor no expone 3000
# Añadir en docker-compose.yml:
# ports:
#   - "3000:3000"
```

### Paso 4.5 — Test manual del endpoint MCP

```bash
# Si usa SSE
curl -N http://localhost:3000/sse

# Si usa HTTP streamable (fastmcp >= 2.0)
curl http://localhost:3000/
curl http://localhost:3000/tools

# Ver si responde algo
curl -v http://localhost:3000/health 2>&1 | head -30
```

---

## 5. Fix rápido del warning docker-compose

```bash
# En Madre — eliminar la línea version del compose
sed -i '/^version:/d' /srv/yggdrasil-dew/agentes/mcp-server/docker-compose.yml

# Verificar
head -5 /srv/yggdrasil-dew/agentes/mcp-server/docker-compose.yml
```

---

## 6. Estado actual del Sprint 1

```
[x] Imagen Docker construida correctamente
[x] Contenedor arranca (proceso MCP iniciado)
[ ] Cliente MCP puede conectar (socket error — fix pendiente)
[ ] Cursor conectado a Madre vía MCP
[ ] Test de tools funcionando
```

---

## 7. Orden de acción ahora mismo

```
1. docker logs <mcp-container>          ← ver qué dice el servidor al arrancar
2. cat mcp_server.py | grep run         ← ver transport mode
3. Elegir: SSE (remoto) vs stdio+SSH (local)
4. Aplicar fix en mcp_server.py
5. docker compose up -d                 ← TERMINAL SEPARADA
6. curl http://localhost:3000/sse       ← test
7. Añadir en .cursor/mcp.json
8. Reiniciar Cursor → ver si aparece "madre" en MCP panel
```

---

*Log generado automáticamente tras sesión de despliegue — 2026-07-03*
