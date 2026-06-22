---
repo: yggdrasil-dew
ruta: proyectos/heimdall.md
fecha-creacion: 2026-06-22
tipo: proyecto
estado: en-construccion
tags: [osint, pentest, vigilancia, heimdall, blackarch, spiderfoot, shodan, arkime, tailscale, ollama, red, linux]
---

# Heimdall — Plataforma de Vigilancia e Inteligencia OSINT

> Heimdall es el vigilante de Yggdrasil. Todo lo ve, todo lo registra.

## Objetivo

Plataforma personal de OSINT e inteligencia que corre en la madre y es accesible desde el Acer y desde fuera de casa via VPN. Cubre:

- Reconocimiento de redes e infraestructura
- Inteligencia sobre personas, empresas y dominios
- Monitorización de dispositivos expuestos (cámaras, IoT)
- Seguimiento de vuelos y barcos
- Análisis automatizado con IA local (Ollama)

---

## Arquitectura

```
MADRE (servidor 24/7)
├── BlackArch repos     → 200+ herramientas pentest/OSINT
├── SpiderFoot :5001    → personas, empresas, dominios
├── Shodan CLI          → cámaras, IoT, infraestructura global
├── Arkime :8005        → captura y análisis de red local
├── Recon-ng            → framework modular reconocimiento
├── theHarvester        → emails, hosts, IPs fuentes públicas
├── Amass               → subdominios, DNS, ASN
├── nmap + masscan      → escaneo activo de puertos
├── Ollama              → IA local analiza resultados
└── Tailscale VPN       → acceso seguro desde fuera de casa

ACER (terminal en casa)
├── Browser → http://madre-ip:5001  (SpiderFoot)
├── Browser → http://madre-ip:8005  (Arkime)
├── Browser → http://madre-ip:9090  (Cockpit)
├── SSH + tmux → control total terminal
└── nmap + masscan → recon rápido local

MÓVIL / FUERA DE CASA
└── Tailscale VPN → acceso idéntico al de casa
```

---

## Stack de herramientas

### Capa 1 — Reconocimiento de red
| Herramienta | Función | Repo |
|---|---|---|
| nmap | Escaneo puertos y servicios | `sudo pacman -S nmap` |
| masscan | Escaneo masivo ultrarrápido | `sudo pacman -S masscan` |
| Amass | Subdominios, DNS, ASN | `sudo pacman -S amass` |
| Arkime | Captura completa de paquetes, UI web | BlackArch / Docker |

### Capa 2 — Inteligencia OSINT
| Herramienta | Función | Repo |
|---|---|---|
| SpiderFoot | 200+ módulos, UI web, automatización total | GitHub clone |
| Recon-ng | Framework modular tipo Metasploit para OSINT | BlackArch |
| theHarvester | Emails, hosts, IPs de fuentes públicas | BlackArch |
| Shodan CLI | Cámaras, IoT, servidores expuestos globalmente | pip |
| Maltego CE | Grafos de relaciones entre entidades | AUR |

### Capa 3 — Tracking en tiempo real
| Herramienta | Función | Repo |
|---|---|---|
| ADS-B Exchange | Vuelos en tiempo real, API gratuita | web + API |
| MarineTraffic | Posición barcos en tiempo real | web + API |
| Wigle.net | Redes WiFi geolocalizadas | web + API |
| Skytrack | Tracking vuelos Python | GitHub |

### Capa 4 — IA y análisis
| Herramienta | Función | Repo |
|---|---|---|
| Ollama | Modelos LLM locales, analiza informes | `sudo pacman -S ollama` |
| Agente Python Heimdall | Orquesta todo el stack | ai-toolkit/agentes/ |

### Capa 5 — Acceso remoto
| Herramienta | Función | Repo |
|---|---|---|
| Tailscale | VPN mesh, acceso desde cualquier sitio | `sudo pacman -S tailscale` |
| Cockpit | Dashboard web gestión del sistema | `sudo pacman -S cockpit` |
| tmux | Terminal multiplexada, sesiones persistentes | `sudo pacman -S tmux` |

---

## Orden de instalación

### Fase 1 — HOY (base)
```bash
# En la madre
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
sudo ./strap.sh

sudo pacman -S tailscale
sudo systemctl enable --now tailscaled
sudo tailscale up

sudo pacman -S cockpit
sudo systemctl enable --now cockpit.socket
```

### Fase 2 — MAÑANA (OSINT core)
```bash
# SpiderFoot desde GitHub (pip no soporta Python 3.14 aún)
git clone https://github.com/smicallef/spiderfoot.git
cd spiderfoot
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python3 sf.py -l 0.0.0.0:5001

# Shodan
sudo pacman -S blackarch-osint  # instala todo el grupo OSINT
shodan init TU-API-KEY
```

### Fase 3 — PRÓXIMA SEMANA (avanzado)
```bash
sudo pacman -S blackarch-recon
sudo pacman -S blackarch-networking
# Arkime (Docker)
# Agente Python Heimdall en ai-toolkit
```

---

## Acceso desde el Acer

```bash
# En casa
ssh varopc@madre-ip
http://madre-ip:5001   # SpiderFoot
http://madre-ip:9090   # Cockpit

# Fuera de casa (con Tailscale activo)
http://madre-tailscale-ip:5001
ssh varopc@madre-tailscale-ip
```

---

## Estado actual

- [x] Arquitectura definida
- [x] Stack de herramientas elegido
- [ ] BlackArch repos instalado en madre
- [ ] Tailscale configurado madre + acer
- [ ] SpiderFoot operativo
- [ ] Shodan CLI configurado con API key
- [ ] Cockpit activo
- [ ] Arkime instalado
- [ ] Agente Python Heimdall

---

## Repos relacionados

- `yggdrasil-dew/osint/` — resultados e informes de investigaciones
- `ai-toolkit/agentes/heimdall-agent.py` — agente orquestador
- `yggdrasil-dew/setup/madre.md` — configuración del servidor
