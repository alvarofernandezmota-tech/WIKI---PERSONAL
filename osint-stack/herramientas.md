---
tags: [osint, pentest, herramientas, seguridad, docker]
fecha: 2026-06-25
estado: activo
---

# Herramientas OSINT + Pentest + Seguridad

> Ecosistema de seguridad ofensiva y defensiva en Madre.
> Todo corre en Docker en la red `batcueva`.
> Actualizado: 25 jun 2026

---

## Stack actual por fase

| YML | Herramienta | Puerto | Estado | Uso |
|---|---|---|---|---|
| batcueva-osint.yml | SpiderFoot | :5001 | ⏳ pendiente | OSINT automático |
| batcueva-osint.yml | IVRE | :7000 | ⏳ pendiente | Análisis tráfico red |
| batcueva-seguridad.yml | Trivy | :4954 | ⏳ pendiente | CVEs imágenes Docker |
| batcueva-seguridad.yml | Semgrep | — | ⏳ pendiente | SAST código malicioso |
| batcueva-seguridad.yml | ClamAV | :3310 | ⏳ pendiente | Antivirus archivos |
| nativo varopc | nmap | — | ❌ instalar | Reconocimiento red |
| nativo varopc | aircrack-ng | — | ❌ instalar | Auditía WiFi |

---

## Análisis de código malicioso

### Trivy — CVE scanner
Escanea imágenes Docker, repos y archivos buscando vulnerabilidades conocidas y secretos expuestos.

```bash
# Escanear imagen
docker run --rm aquasec/trivy image ollama/ollama:latest

# Escanear repo completo (secretos + CVEs)
docker run --rm -v /home/varopc/yggdrasil-dew:/repo aquasec/trivy fs /repo

# Buscar solo secretos
docker run --rm -v /home/varopc/yggdrasil-dew:/repo aquasec/trivy fs --scanners secret /repo
```

### Semgrep — SAST (análisis estático)
Detecta patrones de código peligroso: SQLi, XSS, hardcoded credentials, backdoors.

```bash
# Con Docker directo
docker run --rm -v /home/varopc/yggdrasil-dew:/src returntocorp/semgrep \
  semgrep scan --config=auto /src

# Via compose (guarda JSON en osint/resultados/)
docker compose -f setup/servidor/batcueva-seguridad.yml run --rm semgrep
```

### ClamAV — antivirus archivos
Escaneo tradicional de archivos y directorios.

```bash
# Escanear repo
docker exec clamav clamdscan /scan/repo --recursive

# Actualizar firmas
docker exec clamav freshclam
```

---

## OSINT activo

### SpiderFoot
Automatiza recolección de info sobre un objetivo: IPs, dominios, emails, redes sociales, brechas.

```bash
# Levantar
docker compose -f setup/servidor/batcueva-osint.yml up -d spiderfoot
# UI: http://100.91.112.32:5001

# Primer target legal: tu propia IP pública
curl ifconfig.me
# O tu dominio si tienes uno
```

### nmap — reconocimiento de red

```bash
# Instalar en Madre (Ubuntu)
ssh madre "sudo apt install -y nmap"

# Descubrir dispositivos en LAN
nmap -sn 192.168.1.0/24

# Scan completo con detección OS y versiones
nmap -O -sV -p- 192.168.1.1

# Buscar vulnerabilidades conocidas
nmap --script vuln 192.168.1.1
```

### Integración con Qdrant (pipeline IA)

Resultados de scans → Qdrant via REST → consultables desde Open WebUI:

```bash
# Ejemplo: indexar resultado nmap
curl -X PUT http://localhost:6333/collections/pentest-scans \
  -H 'Content-Type: application/json' \
  -d '{"vectors": {"size": 768, "distance": "Cosine"}}'
```

---

## Auditía WiFi

Ver: `[[osint/wifi-auditoria-handshakes.md]]`

Requisito: tarjeta WiFi con modo monitor. Verificar:
```bash
iw list | grep -A 10 'Supported interface modes'
# Buscar: * monitor
```

---

## Orden de instalación recomendado

```
1. nmap           → sudo apt install -y nmap        (base, todo lo demás depende)
2. Trivy          → docker compose -f batcueva-seguridad.yml up -d trivy-server
3. SpiderFoot     → docker compose -f batcueva-osint.yml up -d spiderfoot
4. ClamAV         → docker compose -f batcueva-seguridad.yml up -d clamav
5. Semgrep        → docker compose ... run --rm semgrep  (on-demand)
6. aircrack-ng    → sudo apt install -y aircrack-ng  (si WiFi soporta monitor)
```

---
_Ver: [[setup/servidor/batcueva-seguridad.yml]] · [[setup/servidor/batcueva-osint.yml]] · [[osint/spiderfoot-setup.md]]_
_Actualizado: 25 jun 2026 13:25 CEST_
