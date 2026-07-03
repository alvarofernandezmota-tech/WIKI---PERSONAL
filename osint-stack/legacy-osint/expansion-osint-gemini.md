---
tags: [osint, inteligencia, iot, camaras, personas, pentesting, formacion, ghost-mode]
fecha-actualizacion: 2026-06-25
fuente: Gemini + Perplexity
relacionado: [[ECOSISTEMA]] [[formacion]] [[wifi-auditoria-handshakes]]
---

# 🧠 Bitácora de Inteligencia Operativa — OSINT & Reconocimiento

## Misión

> Auditoría profunda, detección de vulnerabilidades y mapeo de entornos (cámaras, móviles, IoT) mediante observación pasiva y análisis técnico, manteniendo perfil indetectable (stealth). Éntica: entornos controlados (homelab) y marcos de Security Research.

---

## Suite de Auditoría

| Capa | Herramientas | Función |
|---|---|---|
| Infraestructura | Port Mirroring, pfSense/OPNsense | Captura PCAP pasiva total |
| Red | nmap, masscan, Kismet, p0f | Escaneo y fingerprinting invisible |
| Móvil | ADB, Frida, scrcpy | Auditoría dinámica e inyección de scripts |
| Hardware/IoT | binwalk, Ghidra | Ingeniería inversa de firmware |
| Inteligencia | SpiderFoot, Shodan, Ollama (RAG) | OSINT + correlación con IA local |
| Gestión | Git + Obsidian | Documentación y evidencia forense |

---

## Protocolo Ghost Mode

### Fase A — Reconocimiento Pasivo
- **p0f** sobre tráfico espejado (switch con port mirroring) → fingerprint OS sin enviar un solo paquete
- **Shodan/Censys** para huella digital previa sin tocar el objetivo
- Mapeo de subdominios, certificados SSL y relaciones entre activos

### Fase B — Análisis Técnico
- **binwalk** sobre firmware descargado → buscar credenciales hardcodeadas o backdoors
- **Wireshark/Zeek** → analizar beaconing (latidos) hacia servidores C2 externos
- Validar hallazgos en VM aislada (Kali) sin riesgo de daño real

### Fase C — Documentación SIEM Casero
- Hashes SHA-256 de PCAPs para integridad forense
- Logs ingestados en **Ollama** (RAG local) para detección automática de patrones
- Matriz de criticidad: `Informacional → Vulnerabilidad → Compromiso Crítico`

---

## Deep Intel: Vectores de Búsqueda Real

### 📷 Cámaras IoT

> Las cámaras no son dispositivos aislados, son "cajas de entrada".

- **Shodan filters:** `http.html:"Network Camera"` / `Server: GoAhead-Webs` (80% cámaras baratas)
- **GitHub:** [awesome-iot-hacking](https://github.com/scriptingxss/awesome-iot-hacking) — repositorio curado de herramientas
- **Reddit:** `r/iotsecurity` + `r/homelab` → buscar modelo + "CVE" o "firmware dump"
- **Punto de fuga P2P:** Cámaras con Tuyasmart/XMEYE → analizar IP del servidor P2P → mapear todos los dispositivos de la marca a nivel global
- **exploit-db.com** → buscar por Vendor ID del dispositivo

### 🖥️ Servidores y Ordenadores

- **[Censys](https://search.censys.io/)** → certificados SSL más precisos que Shodan
- **[crt.sh](https://crt.sh/)** → si el certificado tiene Subject Name, encuentra toda la infraestructura del objetivo
- **[VirusTotal IP Search](https://www.virustotal.com/)** → dominios asociados a una IP, historial de análisis
- **SSH Fingerprinting:** clave pública del servidor → buscar fingerprint en Shodan → encontrar otros servidores del mismo admin

### 👤 Personas / OSINT

- **[SpiderFoot](https://github.com/smicallef/spiderfoot)** → email o alias → escanea 100+ fuentes automáticamente
- **[GitHub Dorking](https://github.com/techgaun/github-dorks)** → archivos `.conf`, `.env` con IPs internas o contraseñas expuestas por error
- **Username Consistency:** mismo alias en Reddit + GitHub + foros → perfil completo
- **[Have I Been Pwned](https://haveibeenpwned.com/)** → si el correo fue filtrado, alta probabilidad de reutilización de contraseña en dispositivos IoT

---

## Protocolo Deep Intel (Resumen Ejecutivo)

```
Para Cámaras:
  1. Extraer Vendor ID → buscar en exploit-db.com
  2. Analizar tráfico hacia servidor P2P → mapear ecosistema de marca

Para Servidores:
  1. SSL Fingerprinting → Subject Name → buscar en crt.sh
  2. Encontrar toda la infraestructura del objetivo globalmente

Para Personas:
  1. Alias → SpiderFoot → correlacionar con brechas (HIBP)
  2. GitHub dorking → buscar configs expuestas
```

---

## Hoja de Ruta Inmediata

- [ ] Implementar estructura `/recon`, `/auditoria`, `/stealth_ops`, `/forensics` en el repo
- [ ] Activo #001: `nmap -T4 -A [IP]` → fingerprinting inicial
- [ ] Iniciar `tcpdump` para captura pasiva de comportamiento real
- [ ] Documentar hallazgos en `docs/vulnerabilities.md`
- [ ] Descargar firmware del modelo identificado → pasar `binwalk`
- [ ] Regla firewall: alertar si dispositivo conecta fuera del rango esperado

---

## Axiomas del Operador

> "La mejor forma de analizar un sistema es que el sistema nunca sepa que ha sido analizado."

> "No confíes en lo que dice el dispositivo. Confía en lo que dicen los paquetes que viajan por el cable."

> Todo reconocimiento bajo red enmascarada (Tailscale/VPN) para evitar que la IP de origen quede en logs del objetivo.

---

## Referencias Cruzadas
- [[wifi-auditoria-handshakes]]
- [[2026-06-23-auditoria-osint]]
- [[ECOSISTEMA]]
- [[ollama]]
- [[formacion]]
