# Ollama — Modelos en Madre
#ollama #ia #modelos #fase7 #madre

**Fecha actualización:** 2026-07-01  
**Estado:** modelos descargados, servicio activo

---

## Modelos disponibles en Madre

| Modelo | Uso principal | Tamaño estimado |
|---|---|---|
| `llama3.2` | Razonamiento general, respuestas | ~2GB |
| `nomic-embed-text` | Embeddings para RAG | ~274MB |
| `codellama` | Código y scripts | ~3.8GB |

---

## Comandos útiles

```bash
# Ver modelos instalados
ollama list

# Probar modelo
ollama run llama3.2 "Hola, estado del sistema"

# Servicio
sudo systemctl status ollama
sudo systemctl restart ollama

# API
curl http://localhost:11434/api/generate -d '{"model":"llama3.2","prompt":"test"}'
```

---

## Próximos pasos (Fase 7)

- [ ] RAG sobre repo yggdrasil-dew con nomic-embed-text
- [ ] Integración TOKI-DEW con Ollama local
- [ ] Open WebUI instalado y accesible por Tailscale
