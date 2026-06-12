# Equipos — Inventario de Hardware

> Inventario completo de máquinas y sus roles en el ecosistema.
> **Frecuencia de actualización: al cambiar hardware o rol de una máquina.**
> Última actualización: 12 junio 2026

---

## Resumen de roles (decisión fijada 12 jun 2026)

| Máquina | Rol | Acceso |
|---|---|---|
| **Madre** | Cerebro — workstation + GPU | Solo presencial |
| **Acer** | Soporte 24/7 — servicios permanentes | LAN + exterior vía Tailscale |
| **MacBook** | Cliente puro — consume, no aloja | Solo cliente |
| **HP TouchSmart** | Monitor secundario / dashboards | Pendiente OS |

---

## 🖥️ Ordenador Madre — Cerebro

| Campo | Valor |
|---|---|
| **Rol** | Workstation principal + servidor Input Leap + Ollama GPU |
| **OS** | Omarchy (Arch Linux + Hyprland + Wayland) |
| **CPU** | Intel i5-8400 (6 núcleos) |
| **RAM** | 16 GB |
| **GPU** | NVIDIA GTX 1060 6GB — para Ollama LLM local |
| **IP LAN** | Pendiente fijar (DHCP ahora) |
| **IP Tailscale** | Pendiente instalar |
| **Servicios** | Input Leap server · Ollama · Open WebUI |
| **Uso** | Todo lo que requiere GPU o intervención manual |

---

## 🗄️ Acer Aspire — Soporte 24/7

| Campo | Valor |
|---|---|
| **Rol** | Servidor 24/7 — servicios permanentes + puerta exterior |
| **OS** | Arch Linux |
| **CPU** | AMD Ryzen 5 5500U |
| **RAM** | 8 GB |
| **GPU** | Integrada (no usada para IA) |
| **IP LAN** | 10.176.119.171 (DHCP — fijar con Tailscale) |
| **IP Tailscale** | Pendiente instalar |
| **Servicios** | THDORA · PostgreSQL · Pi-hole · fail2ban · Input Leap client |
| **Uso** | Todo lo que corre sin presencia humana + acceso remoto exterior |

---

## 💻 MacBook — Cliente puro

| Campo | Valor |
|---|---|
| **Rol** | Portátil cliente — consume servicios, no aloja nada |
| **OS** | macOS |
| **IP LAN** | 10.176.119.229 (DHCP) |
| **IP Tailscale** | Opcional (si se necesita acceso remoto) |
| **Servicios** | Input Leap client |
| **Uso** | Trabajo móvil · cuando se está fuera de casa se accede al Acer |

---

## 🖥️ HP TouchSmart 23" — Monitor secundario

| Campo | Valor |
|---|---|
| **Rol** | Monitor secundario / panel de dashboards |
| **OS** | Pendiente — candidato: Linux Mint o Arch mínimo |
| **Estado** | Sin configurar |

---

_Ver arquitectura completa y servicios en `servidor/README.md`_
