# Playbook de Despliegue — Yggdrasil-Dew

Guía de referencia rápida para arrancar el ecosistema completo desde cero o retomar una sesión.

---

## Prerrequisitos

```bash
# Python 3.11+
python3 --version

# gh CLI (para Galatea PR)
gh --version

# jq (para parseo de logs)
jq --version

# Ollama (para LLM local)
curl -fsSL https://ollama.com/install.sh | sh
```

---

## 1. Arranque de sesión

```bash
# 1. Sincronizar repo
git pull origin main

# 2. Revisar estado del ecosistema
bash scripts/apertura-sesion.sh
```

---

## 2. Arrancar Ollama + modelo base

```bash
# Arrancar servidor Ollama en segundo plano
ollama serve &
sleep 3

# Descargar modelo si no está (sólo la primera vez)
ollama pull llama3

# Verificar que responde
curl -s http://localhost:11434/api/generate \
  -d '{"model":"llama3","prompt":"ping","stream":false}' \
  | python3 -c "import json,sys; print(json.load(sys.stdin)['response'])"
```

---

## 3. Arrancar MCP server

```bash
export YGGDRASIL_ROOT="$(pwd)"

# Modo HTTP (para clientes externos / Perplexity / Claude)
python3 mcp/server.py --port 8080 &
echo "MCP server arrancado en http://localhost:8080"

# Verificar
curl -s http://localhost:8080/health | python3 -m json.tool
```

### Modo stdio (para mcp_client en C)
```bash
# Compilar cliente C
gcc -Wall -o /usr/local/bin/mcp_client mcp/mcp_client.c

# Probar
mcp_client inbox_status '{}'
mcp_client llm_query '{"prompt": "hola", "provider": "ollama"}'
```

---

## 4. Probar el router LLM

```bash
# Test rápido con Ollama
bash scripts/agentes/llm-router.sh "Resume el último reporte maestro" ollama

# Con fallback automático (Ollama → OpenAI → Anthropic)
bash scripts/agentes/llm-router.sh "¿Qué tareas están pendientes en inbox?" auto

# Revisar logs del router
tail -f inbox/_meta/llm-router-$(date +%Y%m%d).jsonl | python3 -m json.tool
```

---

## 5. Ejecutar orquestador total

```bash
# Modo rápido (auditoría + inbox, sin LLM)
bash scripts/orquestador-total.sh rapido

# Modo completo (con agentes LLM)
bash scripts/orquestador-total.sh

# Solo auditoría de estructura
bash scripts/orquestador-unico.sh audit

# Revisar reporte generado
ls -lt inbox/_meta/orquestador-*.md | head -3
```

---

## 6. Flujo inbox → clasificación → diarios

```bash
# Depositar archivo en la zona de aterrizaje
cp /tmp/mi-nota.md inbox/drop/

# Commitear y pushear (dispara GitHub Actions)
bash scripts/inbox-commit.sh "nota sesión $(date +%Y-%m-%d)"

# O clasificar manualmente sin esperar Actions
bash scripts/inbox-clasificador.sh
git add -A && git commit -m "inbox: clasificación manual" && git push
```

---

## 7. Galatea — crear PR automático

```bash
export GITHUB_TOKEN="ghp_tu_token_aquí"

# Generar propuesta en archivo temporal
cat > /tmp/propuesta.md << 'EOF'
## Propuesta de cambio
Descripción del cambio propuesto por Galatea.

### Tests
- [ ] Tests de agente pasan en CI
- [ ] Revisión manual en staging
EOF

# Crear PR automáticamente
bash scripts/agentes/galatea-create-pr.sh \
  "feat(galatea): propuesta de mejora YYYY-MM-DD" \
  /tmp/propuesta.md main
```

---

## 8. Cierre de sesión

```bash
# 1. Ejecutar auditoría final
bash scripts/orquestador-unico.sh audit

# 2. Generar documento de cierre
bash scripts/cierre-sesion.sh "descripción breve de la sesión"

# 3. Push final
git add -A
git commit -m "docs(sesion): cierre $(date +%Y-%m-%d) — descripción"
git push origin main

# 4. Parar servicios
kill $(pgrep -f 'mcp/server.py') 2>/dev/null || true
kill $(pgrep -f 'ollama serve')   2>/dev/null || true
echo "Sesión cerrada."
```

---

## 9. Variables de entorno útiles

| Variable           | Descripción                          | Defecto                     |
|--------------------|--------------------------------------|-----------------------------|
| `YGGDRASIL_ROOT`   | Raíz del repositorio                 | `git rev-parse --show-toplevel` |
| `OLLAMA_HOST`      | URL del servidor Ollama              | `http://localhost:11434`    |
| `OLLAMA_MODEL`     | Modelo Ollama a usar                 | `llama3`                    |
| `LLM_TIMEOUT`      | Timeout en segundos para llamadas LLM| `60`                        |
| `LLM_MAX_TOKENS`   | Límite de tokens por respuesta       | `2048`                      |
| `OPENAI_API_KEY`   | Clave para fallback a OpenAI         | *(vacío)*                   |
| `ANTHROPIC_API_KEY`| Clave para fallback a Anthropic      | *(vacío)*                   |
| `GITHUB_TOKEN`     | Token para gh CLI (Galatea PR)       | *(vacío)*                   |

---

## 10. Diagnóstico rápido

```bash
# ¿Está Ollama vivo?
curl -s http://localhost:11434/ | head -1

# ¿Está el MCP server vivo?
curl -s http://localhost:8080/health

# ¿Cuántas llamadas LLM fallaron hoy?
jq -r 'select(.success == false) | .error' \
  inbox/_meta/llm-router-$(date +%Y%m%d).jsonl 2>/dev/null | wc -l

# ¿Hay archivos bloqueados en inbox/drop/?
ls inbox/drop/ 2>/dev/null

# Estado del circuit breaker
cat /tmp/yggdrasil-llm-cb 2>/dev/null && echo " (fallos:segundos)" || echo "Circuit breaker: cerrado (OK)"
```
