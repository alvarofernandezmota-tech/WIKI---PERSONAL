# SIGUIENTE PASO — 2026-07-03

> Actualizado tras síntesis maestra de sesión

## 🎯 Acción inmediata elegida: MCP server de Madre

**Justificación:** Es la pieza de mayor ROI — multiplica la capacidad de Cursor, Claude y cualquier IA compatible para interactuar con el ecosistema real.

### Plan de ejecución

```bash
# 1. Crear repo (o directorio en yggdrasil-madre)
mkdir madre-mcp-server && cd madre-mcp-server

# 2. Instalar dependencias
pip install mcp uvicorn fastapi docker requests

# 3. Implementar server con 5 tools básicas:
#    - get_containers_status()
#    - get_services_health()
#    - get_ecosystem_snapshot()
#    - create_github_issue(title, body)
#    - query_rag(question)

# 4. Docker-compose con puerto 3100 (solo red interna)
# 5. Configurar en Cursor → Settings → MCP Servers
# 6. Test: "¿qué contenedores están caídos?"
```

### Paralelo posible
Mientras el MCP server se construye, el workflow n8n del ecosystem-snapshot se puede hacer en la UI sin tocar código.

---

## ⏭ Después del MCP server

1. Deploy health-agent en Madre (docker-compose)
2. Workflow ecosystem-snapshot en n8n
3. Cerrar el bucle: n8n → health-agent → acciones safe
4. OTel Collector + Loki

---

*Actualizado: 2026-07-03 17:18 CEST*
