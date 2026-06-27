# OSINT / SIGINT — Metodología e Investigación Avanzada
#osint #sigint #inteligencia #investigacion #privacidad #etica

> **AVISO ÉTICO Y LEGAL:** Todo lo documentado aquí es para uso defensivo,
> investigación sobre infraestructura propia o con autorización explícita.
> El uso ofensivo contra terceros sin permiso es ilegal en la mayoría de jurisdicciones.

---

## 1. Diferencia OSINT vs SIGINT

| Concepto | Definición | Fuentes |
|---|---|---|
| **OSINT** (Open Source Intelligence) | Inteligencia de fuentes abiertas y públicas | Web, RRSS, registros DNS, Shodan, HaveIBeenPwned, foros, WHOIS |
| **SIGINT** (Signals Intelligence) | Inteligencia de señales electromagnéticas | Tráfico de red, WiFi, RF, escuchas pasivas de protocolos |
| **HUMINT** | Inteligencia humana | Ingeniería social, entrevistas |
| **TECHINT** | Inteligencia técnica | Análisis de malware, firmware, hardware |

En un homelab de ciberseguridad, OSINT y SIGINT son las capas más accesibles y útiles.

---

## 2. OSINT — Metodología Práctica

### 2.1 Marco de trabajo (The Intelligence Cycle)
```
Planificación → Recolección → Procesamiento → Análisis → Difusión
```

### 2.2 Capas de investigación OSINT

**Capa 1 — Identidad digital**
- Emails: HaveIBeenPwned API, Hunter.io, theHarvester
- Handles/usernames: Sherlock, Maigret
- Nombres reales: Maltego CE, LinkedIn scraping (con permiso)

**Capa 2 — Infraestructura / Dominios**
- WHOIS: `whois dominio.com`
- DNS pasivo: SecurityTrails, VirusTotal, Shodan
- Certificados TLS: crt.sh → `curl 'https://crt.sh/?q=dominio.com&output=json'`
- Subdominios: Amass, Subfinder, `theHarvester -d dominio.com -b all`

**Capa 3 — Exposición de servicios (Shodan/Censys)**
```bash
# Buscar tus propios servicios expuestos
shodan search 'org:"Tu ISP" port:22'
shodan host <tu_ip_publica>
```

**Capa 4 — Leaks y credenciales**
- HaveIBeenPwned: `curl https://haveibeenpwned.com/api/v3/breachedaccount/email@tudominio.com`
- Dehashed (pago), IntelligenceX
- Búsqueda en Pastebin: `site:pastebin.com "tu_email"`

**Capa 5 — Redes sociales y metadatos**
- Exiftool en imágenes públicas: `exiftool imagen.jpg`
- Twint (Twitter/X scraping)
- Metadata de documentos PDF/Office: `exiftool documento.pdf`

---

## 3. SIGINT — Metodología Práctica (red propia)

### 3.1 Captura pasiva de tráfico
```bash
# Captura pasiva en interfaz LAN
sudo tcpdump -i eno1 -w captura-lan.pcap

# Filtrar por protocolo
sudo tcpdump -i eno1 port 53           # DNS
sudo tcpdump -i eno1 port 443          # HTTPS
sudo tcpdump -i eno1 not port 22       # Todo excepto SSH
```

### 3.2 Análisis con Wireshark (CLI)
```bash
tshark -r captura-lan.pcap -T fields -e ip.src -e ip.dst -e dns.qry.name \
       -Y 'dns' | sort | uniq -c | sort -rn | head -20
```

### 3.3 Captura WiFi (handshakes) — red propia
Ver: `docs/investigacion/wifi-auditoria-handshakes-v2.md`

### 3.4 Suricata como SIGINT pasivo
- Suricata en `af-packet` mode = escucha pasiva de toda la red
- `eve.json` = telemetría de señales de red en tiempo real
- Ver: `docs/infra/suricata-af-packet-wazuh.md`

---

## 4. Herramientas del Stack OSINT (Batcueva)

| Herramienta | Tipo | Caso de uso |
|---|---|---|
| **SpiderFoot** | OSINT automatizado | Scan de tu propia huella digital |
| **theHarvester** | OSINT | Emails, subdominios, IPs de un dominio |
| **Amass** | OSINT | Enumeración de subdominios avanzada |
| **Shodan CLI** | OSINT | Buscar tus servicios expuestos |
| **Nuclei** | Vuln scan | Detectar CVEs en tus propios servicios |
| **Bettercap** | SIGINT/MITM | Análisis de red LAN propia |
| **Suricata** | SIGINT | IDS pasivo + telemetría de red |
| **Wazuh** | SIEM | Correlación de señales SIGINT |
| **DefectDojo** | Gestión findings | Historial de vulnerabilidades propias |

---

## 5. Pipeline OSINT sobre propia presencia digital

Script objetivo: `scripts/osint/auto-scan-me.sh`

```bash
#!/usr/bin/env bash
# Auto-scan de huella digital propia
EMAIL="tu_email@tudominio.com"
DOMINIO="tudominio.com"
OUTPUT_DIR="osint-reports/$(date +%Y-%m)"
mkdir -p $OUTPUT_DIR

# 1. Subdominios
subfinder -d $DOMINIO -o $OUTPUT_DIR/subdominios.txt

# 2. Emails y metadatos
theHarvester -d $DOMINIO -b all -f $OUTPUT_DIR/harvester

# 3. Shodan (requiere API key)
shodan host $(curl -s ifconfig.me) > $OUTPUT_DIR/shodan-mi-ip.txt

# 4. Certificados TLS públicos
curl -s "https://crt.sh/?q=$DOMINIO&output=json" | \
    jq '.[].name_value' | sort -u > $OUTPUT_DIR/certificados.txt

echo "[+] Reporte OSINT guardado en $OUTPUT_DIR"
```

---

## 6. Integración con IA (Gemini + Ollama)

### Análisis de resultados OSINT con Gemini
```python
import google.generativeai as genai

genai.configure(api_key="GEMINI_API_KEY")
model = genai.GenerativeModel("gemini-1.5-pro")

with open("osint-reports/2026-06/harvester.json") as f:
    report = f.read()

prompt = f"""
Analiza este reporte OSINT sobre mi propia infraestructura.
Identifica:
1. Servicios expuestos no intencionados
2. Subdominios que no reconozco
3. Patrones de exposición de datos
4. Recomendaciones de mitigación

Reporte: {report}
"""

response = model.generate_content(prompt)
print(response.text)
```

---

## 7. Checklist OSINT defensivo mensual

- [ ] Ejecutar `auto-scan-me.sh` y comparar con mes anterior
- [ ] Revisar HaveIBeenPwned para todos mis emails
- [ ] `shodan host <mi_ip_publica>` — verificar servicios expuestos
- [ ] `crt.sh` — certificados TLS que no reconozco
- [ ] Búsqueda manual en Pastebin/GitHub de mis handles y emails
- [ ] Revisar registros DNS de mis dominios — cambios inesperados
- [ ] Exportar reporte a DefectDojo si hay nuevos findings

---

*Ver también: `docs/procesos/CHECKLIST-PRE-PENTEST.md` · `docs/investigacion/wifi-auditoria-handshakes-v2.md` · `MASTER-PENDIENTES.md`*
