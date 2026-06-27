# Informe de Incidencia — Disco Duro No Detectado (HP)
#incidencia #hardware #hdd #hp #diagnostico

**Equipo:** HP (modelo a confirmar)
**Fecha incidencia:** 2026-06
**Estado:** Diagnóstico completado — pendiente de revisión física

---

## 1. Descripción del problema

El equipo no arranca. Entra en bucle de "Preparando reparación automática" de Windows sin éxito.  
Al acceder a BIOS/boot menu, experimenta congelamientos severos.

---

## 2. Pruebas realizadas

| Síntoma | Diagnóstico |
|---|---|
| Bucle reparación automática Windows | SO detecta arranque incorrecto o archivos de boot corruptos |
| Congelamiento en "Entering Setup..." | Timeout crítico al intentar comunicar con componentes internos |
| Bloqueo en "Loading Boot Menu..." | Mismo timeout de hardware al listar dispositivos |

---

## 3. Estado del hardware (pantalla Select Boot Device)

| Componente | Identificador | Detección |
|---|---|---|
| Unidad óptica CD/DVD | hp CDDVDW TS-T633P | ✅ Correcto |
| Tarjeta de red (PXE) | Realtek Boot Agent | ✅ Correcto |
| Disco duro principal (HDD/SSD) | *Ninguno / Ausente* | ❌ No detectado |

**Conclusión:** Fallo de hardware. El disco no figura en la lista de boot devices.  
Causas probables: cable SATA/M.2 desconectado, o fallo físico definitivo de la unidad.

---

## 4. Próximos pasos

1. Apagar y desconectar de la corriente.
2. Abrir el equipo y verificar conexiones internas del disco (SATA data + alimentación, o ranura M.2).
3. Si conexiones firmes → probar disco en otro equipo o conectar por USB con caja SATA.
4. Si fallo físico confirmado → sustituir unidad y reinstalar SO.

---

*Archivo generado desde informe de incidencia previo. Ver también: `docs/infra/backup-restic.md` para evitar pérdida de datos futura.*
