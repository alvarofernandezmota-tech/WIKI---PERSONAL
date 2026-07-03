# 🔍 OSINT Agent — Inteligencia de Amenazas

> **Estado:** 🔵 DISEÑADO — implementación sprint 3  
> **Modelo:** `qwen2.5:14b Q4` (máximo contexto para síntesis)  
> **Puerto:** `8003`  
> **Trigger:** Cron diario 03:00 (mínimo impacto en recursos)

---

## Rol

El OSINT Agent es el **servicio de inteligencia** del ecosistema.
Investiga el exterior para proteger el interior.
NO ejecuta ataques. Solo recopila inteligencia pasiva y semi-pasiva.

---

## Tools disponibles

| Tool | Fuente | Tipo | Output |
|---|---|---|---|
| `spiderfoot_scan(target)` | Spiderfoot local | semi-pasiva | JSON con hallazgos |
| `nmap_scan(host, ports)` | nmap | activa local | puertos + servicios |
| `check_shodan(ip)` | Shodan API | pasiva | exposición pública |
| `dns_recon(domain)` | dig + whois | pasiva | registros DNS |
| `check_exposed_services()` | curl + nmap | local | servicios expuestos |
| `create_security_issue(title, body)` | GitHub API | acción | issue de seguridad |

---

## Ciclo de ejecución

```
1. n8n trigger (cron 03:00)
2. osint-agent recibe: {targets: [ip_madre, dominio_tailscale]}
3. Para cada target:
   a. spiderfoot_scan (si está disponible)
   b. check_exposed_services
   c. dns_recon (si hay dominio)
4. LLM sintetiza hallazgos
5. Clasifica: LIMPIO / ATENCION / ALERTA
6. Si ATENCION+: crea issue en yggdrasil-secops
7. Notifica guardianbot si ALERTA
8. Log en logs/osint-agent/YYYY-MM-DD.md
```

---

## Scope y límites

**Dentro del scope:**
- Escanear Madre (IP interna Tailscale)
- Escanear el propio dominio si existe
- Verificar qué puertos están expuestos al exterior
- Buscar fugas de información en páginas públicas

**Fuera del scope:**
- Escanear IPs de terceros sin permiso
- Explotar vulnerabilidades
- Fuerza bruta
- Cualquier acción ofensiva

---

## Integración con SOC homelab

El OSINT Agent es la capa de inteligencia del SOC descrito en
`/seguridad/pentest/soc-homelab-stack.md`.
Trabajará junto al security-agent:

```
osint-agent (inteligencia externa)
    +
security-agent (vigilancia interna)
    =
SOC homelab completo
```

---

## Prompt del agente

Ver: `agentes/prompts/RESEARCH-AGENT-PROMPT.md` (comparte base,
añadir sección de OSINT específica en v2 del prompt).

---

*OSINT Agent v1.0 design — 2026-07-03*
