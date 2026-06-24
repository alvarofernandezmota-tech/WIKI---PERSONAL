# Fase 1 Revisada — ¿Hay que rehacerla con LiteLLM?
**Fecha:** 2026-06-24  
**Conclusión:** NO hay que rehacer Fase 1. El orden de fases es correcto.

---

## Por qué LiteLLM va en Fase 4 y no en Fase 1

```
Fase 1: Base mínima funcional
  └─ Ollama (el motor)
  └─ Open WebUI (interfaz)
  └─ Qdrant (memoria vectorial)
  └─ Tailscale + UFW + SSH (red segura)

Fase 4: Capa de abstracción encima de lo que ya funciona
  └─ LiteLLM (proxy que envuelve Ollama)
  └─ Requiere que Ollama esté corriendo primero
  └─ Requiere PostgreSQL (nueva dependencia)
  └─ Requiere SOPS (nueva dependencia)
```

**Instalar LiteLLM antes que Ollama = error de dependencias.**

---

## Lo que SÍ es diferente ahora vs la Fase 1 original

La Fase 1 original no sabía que iba a haber LiteLLM.
Ahora que lo sabemos, hay que añadir esto al script de Fase 1:

### Añadir a script-descarga-completa.sh (Fase 1)
```bash
# Al final, descargar imagen PostgreSQL
# (se necesitará en Fase 4 para LiteLLM y Paperless)
docker pull postgres:16-alpine
docker pull redis:7-alpine
echo "PostgreSQL y Redis descargados para Fase 4"
```

### Añadir al .env de Fase 1 (plantilla)
```bash
# Reservar estas variables para Fase 4
LITELLM_MASTER_KEY=sk-batcueva-cambiar
LITELLM_DB_PASSWORD=cambiar-esto
ANTHROPIC_API_KEY=
GEMINI_API_KEY=
SHODAN_API_KEY=
```

---

## Mapa de dependencias completo del ecosistema

```
Fase 1 (base)
  ├─ Ollama ───────────────┐
  ├─ Open WebUI ─── depende de Ollama
  ├─ Qdrant ───────────┐
  └─ Tailscale/UFW/SSH      |
Fase 1b (seguridad)          |
  └─ fail2ban               |
  └─ sysctl hardening       |
Fase 2 (monitoreo)           |
  ├─ Portainer              |
  ├─ Uptime Kuma            |
  └─ SpiderFoot OSINT       |
Fase 3 (servicios)           |
  ├─ Nginx Proxy Mgr        |
  ├─ Vaultwarden            |
  ├─ Watchtower             |
  ├─ n8n ──────────────┐  |
  ├─ Gitea                 |  |
  └─ Code Server           |  |
Fase 4 (abstracción IA)     |  |
  ├─ LiteLLM ─────────┘  |
  ├─   └── PostgreSQL         |
  ├─ Paperless-NGX          |
  └─ SOPS/age               |
Fase 5 (agentes, futura)     |
  ├─ LangChain batcueva-ai ┘
  ├─ Erika agent (API)
  └─ TOKI v2 (n8n+LiteLLM)
```

---

## Conclusión

El orden de fases actual es correcto y no hay que rehacerlo.
Lo único que hay que añadir a Fase 1 es:
1. Descargar `postgres:16-alpine` y `redis:7-alpine` mientras se descarga todo (Fase 1)
2. Reservar las variables de entorno de Fase 4 en el `.env` plantilla

El macro script de Fase 1 ya funciona. Solo se le añade el `docker pull` de postgres/redis al final.
