---
titulo: ADR-005 — SSH GitHub sin passphrase en Madre
tipo: adr
author: Alvaro Fernandez Mota
creado: 2026-06-23
actualizado: 2026-07-06
status: aceptado
tags: [adr, seguridad, ssh, github]
---

# ADR-005 — SSH GitHub sin passphrase en Madre

> Renumerado desde ADR-003 para resolver colisión. Contenido original preservado íntegramente.

## Contexto

Madre necesita hacer push/pull a GitHub sin intervención manual. Una passphrase en la clave SSH requeriría introducirla en cada operación o usar `ssh-agent`, añadiendo complejidad operativa.

## Decisión

Se acepta clave SSH sin passphrase en Madre para operaciones automatizadas hacia GitHub, asumiendo que el acceso físico y de red a Madre ya está protegido por Tailscale y firewall.

## Consecuencias

- ✅ Push/pull automatizados sin intervención
- ✅ CI y scripts funcionan sin agente SSH
- ⚠️ Si Madre es comprometida, la clave SSH queda expuesta
- Mitigación: rotar clave inmediatamente si se detecta acceso no autorizado (ver HAL-006)

## Alternativas descartadas

- `ssh-agent` con passphrase: más seguro pero requiere sesión activa
- Token PAT de GitHub: válido pero menos estándar para git operations
