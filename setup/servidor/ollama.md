# Ollama — LLM Local

> Última actualización: 12 junio 2026

---

## Qué es

**Ollama** permite correr modelos de lenguaje (LLMs) **en local**, sin internet, sin coste por token. La IA corre en tu hardware.

**Open WebUI** es la interfaz web para hablar con Ollama desde el navegador (como ChatGPT pero local).

---

## Por qué en el Ordenador Madre

- GTX 1060 6GB — suficiente para modelos de 7B cuantizados
- i5-8400 + 16GB RAM — sólido para inferencia
- Es la máquina encendida durante el trabajo

---

## Instalación

```bash
# Instalar Ollama
curl -fsSL https://ollama.com/install.sh | sh

# O desde AUR
yay -S ollama

# Habilitar como servicio
sudo systemctl enable --now ollama
```

---

## Modelos recomendados para el hardware actual

| Modelo | Tamaño | RAM GPU | Uso |
|---|---|---|---|
| llama3.2:3b | ~2GB | ~3GB VRAM | Rápido, respuestas cortas |
| llama3.1:8b-q4 | ~5GB | ~5GB VRAM | Balance calidad/velocidad |
| codellama:7b | ~4GB | ~4GB VRAM | Código Python/SQL/Bash |
| mistral:7b-q4 | ~4GB | ~4GB VRAM | General, muy bueno |

```bash
# Descargar modelo
ollama pull llama3.2:3b
ollama pull codellama:7b

# Usar desde terminal
ollama run codellama:7b
```

---

## Open WebUI (interfaz web)

```bash
# Con Docker
docker run -d \
  -p 8080:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  --name open-webui \
  ghcr.io/open-webui/open-webui:main

# Acceso: http://localhost:8080
# O desde Acer: http://IP_MADRE:8080
```

---

## Integración con personal-v2 (futuro)

```
Ollama local
   └── AGENT.md + CONTEXT.md como system prompt
   └── diarios/ como memoria RAG
   └── THDORA llama a Ollama para razonar
```

---

## TODO

- [ ] Instalar Ollama en Ordenador Madre
- [ ] Descargar llama3.2:3b y codellama:7b
- [ ] Instalar Open WebUI
- [ ] Configurar acceso desde red local
- [ ] Probar AGENT.md como system prompt

---

_Ver también: `setup/servidor/README.md` | `agentes/gemini.md` | `AGENT.md`_
