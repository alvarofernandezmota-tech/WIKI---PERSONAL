# INBOX — Sesión 24 jun 2026 — Stack IA Madre levantado
*Entrada: 24 junio 2026 12:55 CEST — pendiente clasificar*

---

## RESUMEN

Sesión de madrugada. Tailscale cayó, lo rearmamos, y de paso levantamos el stack IA completo en Madre.

---

## HARDWARE MADRE

| Componente | Valor |
|---|---|
| CPU | Intel i5-8400 @ 2.80GHz — 6 núcleos |
| RAM | 16GB total / 7.8GB disponible |
| Disco | 930GB — 87GB usado / 842GB libre |
| GPU | Sin configurar (CPU only) |

---

## PROBLEMA: Tailscale caído

**Síntoma:** `ssh madre` → Connection timed out desde Theodora
**Causa:** tailscaled parado en Madre
**Fix:**
```bash
sudo systemctl restart tailscaled
sudo tailscale up
```
**Resultado:** Reconectó automáticamente sin pedir URL (sesión ya autenticada)
**IP recuperada:** `100.91.112.32` ✅

---

## PROBLEMA: Docker compose fallaba por nvidia

**Síntoma:** `Error: could not select device driver "nvidia"`
**Causa:** compose tenía `deploy.resources.reservations.devices` con `driver: nvidia`
**Madre no tiene GPU NVIDIA configurada** — CPU only
**Fix:** reescribir compose limpio sin ninguna referencia nvidia

### Compose final limpio
```yaml
services:
  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    restart: always
    ports:
      - "11434:11434"
    volumes:
      - ollama_data:/root/.ollama

  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: open-webui
    restart: always
    ports:
      - "3001:8080"
    environment:
      - OLLAMA_BASE_URL=http://ollama:11434
    extra_hosts:
      - "host.docker.internal:host-gateway"
    volumes:
      - open_webui_data:/app/backend/data
    depends_on:
      - ollama

  qdrant:
    image: qdrant/qdrant:latest
    container_name: qdrant
    restart: always
    ports:
      - "6333:6333"
    volumes:
      - qdrant_data:/qdrant/storage

volumes:
  ollama_data:
  open_webui_data:
  qdrant_data:
```

---

## ESTADO FINAL — TODOS LOS CONTENEDORES EN MADRE

| Contenedor | Imagen | Puerto | Estado |
|---|---|---|---|
| ollama | ollama/ollama:latest | 11434 | ✅ Up |
| open-webui | open-webui:main | 3001 | ✅ Up |
| qdrant | qdrant/qdrant:latest | 6333 | ✅ Up |
| uptime-kuma | louislam/uptime-kuma:1 | 3002 | ✅ Up (healthy) |
| portainer | portainer-ce:latest | 9000 | ✅ Up |
| thdora-bot | thdora-bot | — | ✅ Up (healthy) |
| thdora | thdora-thdora | 8000 | ✅ Up (healthy) |
| grafana | grafana:10.4.2 | 3000 | ✅ Up |
| prometheus | prometheus:v2.51.2 | 9090 | ✅ Up |

---

## PENDIENTES TRAS ESTA SESIÓN

- [ ] Configurar autoarranque Tailscale con authkey (ver setup/tailscale.md)
- [ ] Descargar primer modelo en Ollama (recomendado: qwen2.5:3b para CPU)
- [ ] Configurar Open WebUI con Qdrant para RAG
- [ ] Configurar drivers GPU si aplica
- [ ] Borrar duplicados en setup/ias/ creados por error esta noche

---

## LECCIÓN APRENDIDA — PROTOCOLO PERPLEXITY

> Antes de crear cualquier archivo en el repo: auditar primero.
> Todo nuevo va a inbox primero. Nunca directo al sitio definitivo.

---
*Clasificar en: setup/madre.md + setup/tailscale.md + setup/2026-06-24-stack-ia.md*
