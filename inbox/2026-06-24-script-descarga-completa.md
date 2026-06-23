---
tags: [inbox, script, descarga, docker, ollama, batcueva, madre]
fecha: 2026-06-24
estado: listo-para-ejecutar
destino: setup/servidor/scripts/descarga-completa.sh
---

# Script Descarga Completa — Todo el Ecosistema Madre

> Un solo bloque. Pegar en Madre y dejar corriendo.
> Descarga TODO: imagenes Docker Fase 1 + Fase 2 + modelos Ollama.

---

## BLOQUE 1 — Imagenes Docker (Fase 1 ya descargada, retry seguro)

```bash
echo "== DESCARGANDO IMAGENES DOCKER =="

# Fase 1 — Stack IA (ya descargadas, no hace nada si estan)
until docker pull ollama/ollama:latest; do echo "retry ollama..."; sleep 5; done
until docker pull ghcr.io/open-webui/open-webui:main; do echo "retry webui..."; sleep 5; done
until docker pull qdrant/qdrant:latest; do echo "retry qdrant..."; sleep 5; done

# Fase 2 — Gestion y OSINT
until docker pull portainer/portainer-ce:latest; do echo "retry portainer..."; sleep 5; done
until docker pull louislam/uptime-kuma:latest; do echo "retry uptime-kuma..."; sleep 5; done
until docker pull smicallef/spiderfoot:latest; do echo "retry spiderfoot..."; sleep 5; done

echo "== IMAGENES DOCKER OK =="
docker images
```

---

## BLOQUE 2 — Modelos Ollama

```bash
echo "== DESCARGANDO MODELOS OLLAMA =="

# Esperar que Ollama este levantado
until curl -s http://localhost:11434/api/tags > /dev/null; do
  echo "esperando ollama..."; sleep 5
done

# Modelos
docker exec ollama ollama pull qwen2.5:3b
docker exec ollama ollama pull nomic-embed-text
docker exec ollama ollama pull gemma2:2b

echo "== MODELOS OK =="
docker exec ollama ollama list
```

---

## BLOQUE 3 — Paquetes sistema Arch

```bash
echo "== PAQUETES SISTEMA =="

sudo pacman -S --noconfirm \
  nmap \
  tmux \
  htop \
  ufw \
  curl \
  wget \
  git \
  fail2ban

echo "== PAQUETES OK =="
```

---

## BLOQUE TODO EN UNO (pegar y olvidarse)

```bash
# Docker imagenes
for img in ollama/ollama:latest ghcr.io/open-webui/open-webui:main qdrant/qdrant:latest portainer/portainer-ce:latest louislam/uptime-kuma:latest smicallef/spiderfoot:latest; do
  until docker pull $img; do echo "retry $img"; sleep 5; done
  echo "OK: $img"
done

# Paquetes
sudo pacman -S --noconfirm nmap tmux htop ufw curl wget git fail2ban

# Modelos Ollama (necesita stack levantado)
until curl -s http://localhost:11434/api/tags > /dev/null; do sleep 5; done
for model in qwen2.5:3b nomic-embed-text gemma2:2b; do
  docker exec ollama ollama pull $model
done

echo "TODO DESCARGADO"
```

---
_Destino final: setup/servidor/scripts/descarga-completa.sh_
