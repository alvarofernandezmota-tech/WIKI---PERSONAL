---
tags: [fix, qdrant, docker]
fecha: 2026-06-25
---

# FIX — Qdrant unhealthy

## Síntoma
```
qdrant   Up 3 hours (unhealthy)   :6333
```

## Diagnóstico
```bash
docker logs qdrant --tail 20
docker exec qdrant curl -s http://localhost:6333/healthz
```

## Causas comunes
1. El healthcheck hace curl a `/healthz` pero Qdrant usa `/health`
2. Falta de memoria RAM para colecciones grandes
3. Permisos en el volumen

## Fix — corregir healthcheck en docker-compose.yml

Buscar el servicio qdrant y cambiar:
```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost:6333/health"]
  interval: 30s
  timeout: 10s
  retries: 3
  start_period: 20s
```

## Verificar que responde
```bash
curl http://localhost:6333/health
# Respuesta esperada: {"title":"qdrant - vector search engine","version":"..."}
```

## Estado
- [ ] Healthcheck corregido
- [ ] Qdrant respondiendo en :6333
