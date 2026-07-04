# Error spiderfoot + estado descarga — 24 jun 2026 03:19

---

## Error encontrado

`smicallef/spiderfoot` y `spiderfoot/spiderfoot` — **ninguno existe en Docker Hub**.
El script `pre-descarga-todo.sh` se quedó atascado reintentando en bucle infinito.

```
Error response from daemon: pull access denied for smicallef/spiderfoot
Error response from daemon: pull access denied for spiderfoot/spiderfoot
```

## Imagen correcta de Spiderfoot

```bash
# Verificar cuál existe realmente:
docker search spiderfoot
# O usar la imagen oficial del repo:
# https://github.com/smicallef/spiderfoot
# imagen: smicallef/spiderfoot (privada/eliminada)
# alternativa: construir desde Dockerfile del repo
```

## Estado descarga al pararse

```
✅ ollama/ollama:latest          — descargado
✅ ghcr.io/open-webui/open-webui  — descargado
⏳ qdrant/qdrant:latest           — estaba descargando cuando se paró
❌ smicallef/spiderfoot           — FALLA, no existe
❓ resto de fases 2 y 3           — no se llegaron a descargar
```

## Fix pendiente — 3 acciones

- [ ] 1. Ver qué se descargó: `strings /tmp/pre-descarga.log | grep "✅"`
- [ ] 2. Quitar spiderfoot del script o sustituir por imagen correcta
- [ ] 3. Relanzar descarga solo para lo que falta

```bash
# Matar proceso atascado
kill $(pgrep -f pre-descarga-todo) 2>/dev/null

# Ver qué se descargó
strings /tmp/pre-descarga.log | grep "✅"

# Fix en el script (quitar spiderfoot)
sed -i '/spiderfoot/d' ~/Projects/yggdrasil-dew/setup/servidor/scripts/pre-descarga-todo.sh

# Relanzar
nohup bash ~/Projects/yggdrasil-dew/setup/servidor/scripts/pre-descarga-todo.sh > /tmp/pre-descarga2.log 2>&1 &
echo "PID: $!"
```

## Nota para el script

Spiderfoot es herramienta OSINT — no es Fase 1/2/3 del stack IA.
No bloquear el resto de descargas por una imagen OSINT opcional.
Solución: mover spiderfoot a script separado `descarga-osint.sh` o construir desde Dockerfile.

---
_Ver: [MASTER-PENDIENTES.md](../MASTER-PENDIENTES.md) · [pre-descarga-todo.sh](../setup/servidor/scripts/pre-descarga-todo.sh)_
