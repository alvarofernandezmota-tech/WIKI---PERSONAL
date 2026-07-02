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
| Estado | ⚠️ ABIERTO — sin resolver |
| Fecha hallazgo | 2026-07-01 |
| IP afectada | `79.116.247.44` (IP pública madre) |
| Puerto | 21/TCP (FTP) |
| Fuente | nmap desde pentest local |

## Descripción

El router Digi tiene el puerto 21 (FTP) expuesto a internet.
FTP es un protocolo inseguro (credenciales en texto plano, sin cifrado).
Cualquier actor externo puede intentar conectar o hacer fuerza bruta.

## Impacto potencial

- Acceso no autorizado al router si las credenciales FTP son débiles
- Exposición de configuración del router
- Vector de entrada a la red local

## Solución

```
Panel router Digi → http://192.168.72.1
Ajustes → Servidor FTP → Deshabilitar
```

O alternativamente: bloquear el puerto 21 en el firewall del router.

## Estado de resolución

- [ ] Acceder al panel del router Digi (`192.168.72.1`)
- [ ] Deshabilitar el servidor FTP
- [ ] Verificar con nmap que el puerto 21 ya no responde
- [ ] Actualizar estado a CERRADO

```bash
# Verificación post-fix
nmap -p 21 79.116.247.44
# Resultado esperado: 21/tcp closed ftp
```

## Ver también
- [[proyectos/pentest/fases]]
- [[docs/infra/ssh-hardening]]

---
_Documentado por Perplexity vía MCP — 01 jul 2026_
