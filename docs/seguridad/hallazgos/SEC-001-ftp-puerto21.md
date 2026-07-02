---
tags: [seguridad, hallazgo, ftp, pentest, router, digi]
fecha-hallazgo: 2026-07-01
id: SEC-001
gravedad: CRITICA
estado: ABIERTO
---

# 🔴 SEC-001 — Puerto 21 FTP expuesto en router Digi

## Resumen

| Campo | Valor |
|---|---|
| ID | SEC-001 |
| Gravedad | 🔴 CRÍTICA |
| Estado | ⚠️ ABIERTO |
| Fecha hallazgo | 2026-07-01 |
| IP afectada | `79.116.247.44` (IP pública madre) |
| Puerto | 21/TCP (FTP) |
| Fuente | nmap desde pentest local |

## Descripción

Router Digi con puerto 21 (FTP) expuesto a internet.
FTP = credenciales en texto plano, sin cifrado.
Vector de entrada potencial a la red local.

## Solución

```
Panel router Digi → http://192.168.72.1
Ajustes → Servidor FTP → Deshabilitar
```

## Checklist resolución

- [ ] Acceder panel router Digi (`192.168.72.1`)
- [ ] Deshabilitar servidor FTP
- [ ] Verificar con nmap: `nmap -p 21 79.116.247.44`
- [ ] Actualizar estado a CERRADO

---
_Documentado por Perplexity vía MCP — 01-jul-2026_
