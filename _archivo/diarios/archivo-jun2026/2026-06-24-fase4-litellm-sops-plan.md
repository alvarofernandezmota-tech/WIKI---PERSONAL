# Fase 4 — LiteLLM + SOPS + Mejoras Ecosistema
**Fecha:** 2026-06-24  
**Fuente:** GitLab LiteLLM docs, antlatt.com SOPS guide, revold.us LiteLLM docker  
**Estado:** PLAN COMPLETO listo para ejecutar en Madre

---

## Por qué LiteLLM es crítico

LiteLLM es un **proxy OpenAI-compatible** que unifica todos los LLMs bajo un único endpoint.
En lugar de configurar Ollama, Claude, Gemini por separado en n8n, usas `http://litellm:4000` para todo.

```
Sin LiteLLM:
  n8n → Ollama (http://ollama:11434)
  n8n → Claude API (api.anthropic.com)
  n8n → Gemini API (api.google.com)
  → 3 configuraciones distintas, cambiar modelo = reconfigurar todo

Con LiteLLM:
  n8n → LiteLLM (http://litellm:4000)
  LiteLLM → Ollama (local)
  LiteLLM → Claude (API externa)
  LiteLLM → Gemini (API externa)
  → 1 endpoint, cambiar modelo = cambiar 1 parámetro
```

---

## Docker Compose — LiteLLM

```yaml
# Añadir a docker-compose fase4
  litellm:
    image: ghcr.io/berriai/litellm:main-latest
    container_name: litellm
    restart: unless-stopped
    ports:
      - "4000:4000"
    volumes:
      - ./litellm/config.yaml:/app/config.yaml
    environment:
      - LITELLM_MASTER_KEY=${LITELLM_MASTER_KEY}
      - DATABASE_URL=${LITELLM_DATABASE_URL}
      - STORE_MODEL_IN_DB=True
    command: ["--config", "/app/config.yaml", "--port", "4000", "--detailed_debug"]
    networks:
      - batcueva-net
    depends_on:
      - litellm-db

  litellm-db:
    image: postgres:16-alpine
    container_name: litellm-db
    restart: unless-stopped
    environment:
      - POSTGRES_USER=litellm
      - POSTGRES_PASSWORD=${LITELLM_DB_PASSWORD}
      - POSTGRES_DB=litellm
    volumes:
      - litellm_db_data:/var/lib/postgresql/data
    networks:
      - batcueva-net
```

## Fichero config.yaml LiteLLM

```yaml
# /opt/batcueva/litellm/config.yaml
model_list:
  # Modelos locales Ollama
  - model_name: qwen2.5:3b
    litellm_params:
      model: ollama/qwen2.5:3b
      api_base: http://ollama:11434

  - model_name: qwen2.5:7b
    litellm_params:
      model: ollama/qwen2.5:7b
      api_base: http://ollama:11434

  - model_name: erika
    litellm_params:
      model: ollama/erika
      api_base: http://ollama:11434

  # APIs externas (opcionales, solo si hay key)
  - model_name: claude-sonnet
    litellm_params:
      model: claude-sonnet-4-5
      api_key: os.environ/ANTHROPIC_API_KEY

  - model_name: gemini-flash
    litellm_params:
      model: gemini/gemini-2.0-flash
      api_key: os.environ/GEMINI_API_KEY

litellm_settings:
  drop_params: true
  set_verbose: false

general_settings:
  master_key: os.environ/LITELLM_MASTER_KEY
```

---

## Por qué SOPS es crítico

Actualmente los `.env` tienen API keys en texto plano. Si el repo se hace público accidentalmente o se sube a Gitea sin querer = todas las keys expuestas.

SOPS cifra los valores de los secretos con `age` (criptografía moderna) pero deja las CLAVES visibles. Es Git-friendly.

```yaml
# Sin SOPS (PELIGROSO en Git):
ANTHROPIC_API_KEY=sk-ant-xxxxxxxxxxxxx
LITELLM_MASTER_KEY=sk-12345

# Con SOPS (seguro en Git):
ANTHROPIC_API_KEY: ENC[AES256_GCM,data:xyz...,type:str]
LITELLM_MASTER_KEY: ENC[AES256_GCM,data:abc...,type:str]
```

---

## Script descarga Fase 4

```bash
#!/bin/bash
# descarga-fase4.sh
set -e

echo "=== FASE 4: LiteLLM + SOPS + Paperless ==="

# 1. SOPS + age
pacman -S --noconfirm age sops

# 2. Generar clave age para el usuario
mkdir -p ~/.config/sops/age
if [ ! -f ~/.config/sops/age/keys.txt ]; then
    age-keygen -o ~/.config/sops/age/keys.txt
    echo "Clave age generada:"
    cat ~/.config/sops/age/keys.txt | grep 'public key'
fi

# 3. Crear .sops.yaml en /opt/batcueva
PUBKEY=$(cat ~/.config/sops/age/keys.txt | grep 'public key' | awk '{print $NF}')
cat > /opt/batcueva/.sops.yaml << EOF
creation_rules:
  - path_regex: secrets/.*\.yaml$
    age: $PUBKEY
  - path_regex: \.env.*
    age: $PUBKEY
EOF

# 4. Directorios Fase 4
mkdir -p /opt/batcueva/{litellm,paperless,secrets}

# 5. Descargar imagen LiteLLM
docker pull ghcr.io/berriai/litellm:main-latest
docker pull paperlessngx/paperless-ngx:latest
docker pull postgres:16-alpine

echo "=== FASE 4 descargada. Ejecutar configuracion-fase4.sh ==="
```

---

## Script configuracion Fase 4

```bash
#!/bin/bash
# configuracion-fase4.sh
set -e

echo "=== CONFIGURACION FASE 4 ==="

BASE=/opt/batcueva

# 1. Crear secrets cifrados con SOPS
mkdir -p $BASE/secrets

# Crear fichero de secretos (se cifrará con sops)
cat > /tmp/secrets-fase4.yaml << 'EOF'
litellm:
  master_key: "sk-batcueva-cambiar-esto"
  db_password: "litellm-db-pass-cambiar"
paperless:
  admin_password: "paperless-admin-cambiar"
  secret_key: "paperless-secret-cambiar"
apis:
  anthropic: ""
  gemini: ""
  shodan: ""
EOF

# Cifrar con SOPS
cd $BASE
sops --encrypt /tmp/secrets-fase4.yaml > secrets/fase4.yaml
rm /tmp/secrets-fase4.yaml
echo "Secretos cifrados en secrets/fase4.yaml"

# 2. Config LiteLLM
mkdir -p $BASE/litellm
cp ~/yggdrasil-dew/inbox/config-litellm.yaml $BASE/litellm/config.yaml 2>/dev/null || \
cat > $BASE/litellm/config.yaml << 'EOF'
model_list:
  - model_name: qwen2.5:3b
    litellm_params:
      model: ollama/qwen2.5:3b
      api_base: http://ollama:11434
  - model_name: qwen2.5:7b
    litellm_params:
      model: ollama/qwen2.5:7b
      api_base: http://ollama:11434
  - model_name: erika
    litellm_params:
      model: ollama/erika
      api_base: http://ollama:11434
litellm_settings:
  drop_params: true
general_settings:
  master_key: os.environ/LITELLM_MASTER_KEY
EOF

# 3. Levantar servicios Fase 4
cd $BASE
docker compose -f docker-compose-fase4.yml up -d

echo ""
echo "=== FASE 4 LEVANTADA ==="
echo "LiteLLM: http://localhost:4000"
echo "LiteLLM UI: http://localhost:4000/ui"
echo "Paperless: http://localhost:8010"
```

---

## Docker Compose Fase 4 completo

```yaml
# docker-compose-fase4.yml
version: '3.8'

services:
  litellm:
    image: ghcr.io/berriai/litellm:main-latest
    container_name: litellm
    restart: unless-stopped
    ports:
      - "4000:4000"
    volumes:
      - ./litellm/config.yaml:/app/config.yaml:ro
    environment:
      - LITELLM_MASTER_KEY=${LITELLM_MASTER_KEY:-sk-batcueva}
      - DATABASE_URL=postgresql://litellm:${LITELLM_DB_PASSWORD:-litellmpass}@litellm-db:5432/litellm
      - STORE_MODEL_IN_DB=True
      - ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY:-}
      - GEMINI_API_KEY=${GEMINI_API_KEY:-}
    depends_on:
      - litellm-db
    networks:
      - batcueva-net

  litellm-db:
    image: postgres:16-alpine
    container_name: litellm-db
    restart: unless-stopped
    environment:
      - POSTGRES_USER=litellm
      - POSTGRES_PASSWORD=${LITELLM_DB_PASSWORD:-litellmpass}
      - POSTGRES_DB=litellm
    volumes:
      - litellm_db:/var/lib/postgresql/data
    networks:
      - batcueva-net

  paperless:
    image: paperlessngx/paperless-ngx:latest
    container_name: paperless
    restart: unless-stopped
    ports:
      - "8010:8000"
    volumes:
      - paperless_data:/usr/src/paperless/data
      - paperless_media:/usr/src/paperless/media
      - ./paperless/consume:/usr/src/paperless/consume
      - ./paperless/export:/usr/src/paperless/export
    environment:
      - PAPERLESS_REDIS=redis://paperless-redis:6379
      - PAPERLESS_DBHOST=paperless-db
      - PAPERLESS_DBUSER=paperless
      - PAPERLESS_DBPASS=${PAPERLESS_DB_PASSWORD:-paperlesspass}
      - PAPERLESS_SECRET_KEY=${PAPERLESS_SECRET_KEY:-paperless-secret}
      - PAPERLESS_ADMIN_USER=admin
      - PAPERLESS_ADMIN_PASSWORD=${PAPERLESS_ADMIN_PASSWORD:-admin}
      - PAPERLESS_OCR_LANGUAGE=spa+eng
      - PAPERLESS_TIME_ZONE=Europe/Madrid
    depends_on:
      - paperless-db
      - paperless-redis
    networks:
      - batcueva-net

  paperless-db:
    image: postgres:16-alpine
    container_name: paperless-db
    restart: unless-stopped
    environment:
      - POSTGRES_USER=paperless
      - POSTGRES_PASSWORD=${PAPERLESS_DB_PASSWORD:-paperlesspass}
      - POSTGRES_DB=paperless
    volumes:
      - paperless_db:/var/lib/postgresql/data
    networks:
      - batcueva-net

  paperless-redis:
    image: redis:7-alpine
    container_name: paperless-redis
    restart: unless-stopped
    networks:
      - batcueva-net

volumes:
  litellm_db:
  paperless_data:
  paperless_media:
  paperless_db:

networks:
  batcueva-net:
    external: true
```

---

## Puertos completos ecosistema post-Fase4

| Puerto | Servicio | Fase |
|---|---|---|
| 3000 | Gitea | 3 |
| 3001 | Uptime Kuma | 2 |
| 4000 | **LiteLLM** | **4** 🔥 |
| 6333 | Qdrant | 1 |
| 8080 | Open WebUI | 1 |
| 8090 | Code Server | 3 |
| 8010 | **Paperless-NGX** | **4** 🔥 |
| 9000 | Portainer | 2 |
| 9080 | Nginx Proxy Mgr | 3 |
| 5678 | n8n | 3 |
| 8222 | SpiderFoot | 2 |
| 11434 | Ollama API | 1 |
| 8200 | Vaultwarden | 3 |

---

## Checklist Fase 4

- [ ] Ejecutar `descarga-fase4.sh`
- [ ] Generar clave age + .sops.yaml
- [ ] Cifrar secretos con SOPS
- [ ] Levantar LiteLLM + PostgreSQL
- [ ] Configurar n8n para usar LiteLLM en vez de Ollama directo
- [ ] Levantar Paperless-NGX
- [ ] Probar LiteLLM: `curl http://localhost:4000/v1/models`
- [ ] Añadir LiteLLM a Nginx Proxy Manager
- [ ] Añadir LiteLLM a Uptime Kuma monitoring
