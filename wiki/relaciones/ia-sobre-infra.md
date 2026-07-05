---
tipo: relacion
nombre: IA sobre Infraestructura
islas: [ia-local, infra]
obsidian_link: "[[ia-sobre-infra]]"
estado: activo
---

# 🔗 Relación: IA Local depende de Infraestructura

La IA local **no puede funcionar sin Madre**. Esta relación documenta exactamente qué necesita la capa de IA de la capa de infraestructura.

## Dependencias concretas

| IA necesita | Lo da | Cómo verificar |
|---|---|---|
| GPU GTX 1060 6GB | Madre (hardware) | `nvidia-smi` |
| Driver NVIDIA 580 + CUDA 13 | Madre (OS) | `nvidia-smi \| head -3` |
| Ollama activo en :11434 | `madre-config` | `systemctl is-active ollama` |
| Puerto 11434 abierto en Tailscale | UFW Madre | `ufw status \| grep 11434` |
| Docker funcionando | Madre | `docker ps` |

## Flujo de activación

```
1. Madre arranca
2. Driver NVIDIA carga → GPU disponible
3. systemctl start ollama → API en :11434
4. Ollama detecta GTX 1060 → modelos corren en GPU
5. THDORA puede llamar a http://localhost:11434
6. Acer puede llamar a http://100.91.112.32:11434 vía Tailscale
```

## Si la IA falla, revisar en este orden

```bash
# 1. GPU
nvidia-smi
# 2. Ollama
systemctl status ollama
# 3. Modelos
ollama list
# 4. Red
curl http://localhost:11434/api/tags
```

---
_Actualizado: 2026-07-05 · Perplexity-MCP_
