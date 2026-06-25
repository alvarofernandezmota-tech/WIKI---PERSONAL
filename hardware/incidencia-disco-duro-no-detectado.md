---
tags: [hardware, incidencia, disco-duro, HP, diagnostico]
fecha: 2026-06-25
author: alvarofernandezmota-tech
equipo: HP
estado: diagnosticado
---

# Informe de Incidencia: Disco Duro No Detectado

## 1. Descripción del Problema

Equipo HP no arranca. Bucle de reparación automática Windows sin éxito. Congelamiento en BIOS y Boot Menu.

## 2. Historial de Pruebas

- **Bucle de Reparación Automática:** "Preparando reparación automática" sin resolución.
- **Congelamiento en Setup:** "Entering Setup..." bloqueado por timeout.
- **Bloqueo en Boot Menu:** "Loading Boot Menu..." congelado.

## 3. Estado del Hardware

| Componente | Identificador | Estado |
|---|---|---|
| Unidad Óptica CD/DVD | hp CDDVDW TS-T633P | ✅ Detectado |
| Tarjeta de Red | Realtek Boot Agent | ✅ Detectado |
| Disco Duro Principal | — | ❌ No Detectado |

**Conclusión:** Fallo de hardware — cable SATA/alimentación desconectado o fallo físico de la unidad.

## 4. Próximos Pasos

1. Apagar y desconectar de la corriente.
2. Verificar conexiones internas del disco (SATA o M.2).
3. Si persiste, probar el disco en otro equipo.
4. Si falla en otro equipo → sustituir unidad y reinstalar SO.
