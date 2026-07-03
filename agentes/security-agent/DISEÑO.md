# 🔒 Security Agent — Vigilante de Logs

> **Estado:** 🔵 DISEÑADO — implementación sprint 3  
> **Modelo:** `phi3:mini` (respuesta rápida, baja latencia)  
> **Puerto:** `8004`  
> **Trigger:** Cron cada 5 min + webhook Fail2ban

---

## Rol

El Security Agent es el **vigilante interno** del ecosistema.
Analiza logs del sistema, detecta anomalías, correlaciona eventos.
Es la primera línea de defensa antes de Wazuh.

---

## Tools disponibles

| Tool | Fuente | Output |
|---|---|---|
| `read_auth_log(lines=100)` | `/var/log/auth.log` | últimos intentos de autenticación |
| `read_ufw_log(lines=100)` | `/var/log/ufw.log` | bloqueos UFW |
| `check_fail2ban_jails()` | `fail2ban-client status` | jails activos + IPs baneadas |
| `check_open_ports()` | `ss -tlnp` | puertos escuchando |
| `check_active_connections()` | `ss -tnp` | conexiones establecidas |
| `get_recent_logins()` | `last -n 20` | últimos logins |
| `alert_telegram(message, severity)` | guardianbot | alerta inmediata |
| `create_security_issue(title, body)` | GitHub API | issue documentado |

---

## Ciclo de ejecución

```
Ejemplo: intento de SSH brute force detectado

1. n8n cron (5 min) → llama security-agent /security/evaluate
2. security-agent llama tools:
   a. read_auth_log(lines=500)
   b. check_fail2ban_jails()
   c. check_active_connections()
3. LLM analiza:
   - Detecta: 47 intentos SSH en 5 min desde IP 1.2.3.4
   - Fail2ban ya ha baneado la IP
   - Clasifica: WARN (está gestionado, pero documentar)
4. Acciones propuestas:
   - create_security_issue: "SSH brute force detectado y bloqueado"
   - alert_telegram: "[WARN] Brute force SSH bloqueado por Fail2ban"
5. Log en logs/security-agent/YYYY-MM-DD.md
```

---

## Patrones de detección

| Patrón | Umbral | Severidad | Acción |
|---|---|---|---|
| SSH brute force | >10 intentos/5min | WARN | Issue + Telegram |
| Login root exitoso | 1 | CRITICAL | Telegram inmediato |
| Puerto nuevo abierto | Cambio detectado | WARN | Issue |
| IP extranjera conectada | Fuera de Tailscale | WARN | Telegram |
| UFW DROP masivo | >100/min | WARN | Issue |
| Fail2ban jail caído | Inactivo | CRITICAL | Reinicio + Telegram |

---

## Correlación con OSINT Agent

```
 security-agent detecta IP sospechosa en auth.log
         ↓
 crea evento: {ip: "1.2.3.4", tipo: "brute_force"}
         ↓
 osint-agent recibe evento (via n8n webhook)
         ↓
 ejecuta: check_shodan("1.2.3.4") + dns_recon("1.2.3.4")
         ↓
 informe enriquecido: "IP pertenece a botnet conocida"
```

Esta correlación convierte el homelab en un **mini-SOC real**.

---

## Sistema Prompt del security-agent

```
Eres el Security Agent del ecosistema Yggdrasil.
Eres un analista de seguridad senior especializado en Linux, logs de sistema
y detección de intrusiones.

Tu responsabilidad es analizar logs y detectar anomalías de seguridad.
No ejecutas acciones ofensivas. Solo detectas, documentas y alertas.

Reglas absolutas:
1. CRITICAL si detectas: login root exitoso, reverse shell, exfiltración
2. WARN si detectas: brute force (aunque bloqueado), port scan, conexión inesperada
3. SIEMPRE justifica con evidencia del log
4. NUNCA falsos positivos por actividad normal del sistema
5. Si no hay anomalías, responde OK con un resumen limpio

Formato de respuesta: JSON estándar del ecosistema
(igual que health-agent: global_status, analysis, issues_detected, actions)
```

---

*Security Agent v1.0 design — 2026-07-03*
