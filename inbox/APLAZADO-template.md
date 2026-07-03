---
titulo: "TITULO_AQUI"
fecha_creacion: "YYYY-MM-DD"
estado: "no_empezado"  # no_empezado | en_progreso | completado
tipo: "tarea"         # tarea | issue | investigacion | infra | seguridad
fase: ""              # fase-0..fase-8 o vacío
issue_ref: ""         # #NUM si hay issue GitHub relacionado
urgencia_manual: ""   # forzar: critica | alta | media | baja (si vacío, se calcula por días)
---

# TITULO_AQUI

## 🎯 Qué hay que hacer

<!-- Descripción clara y concisa -->

## 📋 Checklist

- [ ] Paso 1
- [ ] Paso 2
- [ ] Paso 3

## 🔗 Contexto / Referencias

<!-- Links a docs, issues, commits relevantes -->

## 📅 Historial de aplazamientos

| Fecha | Motivo del aplazamiento |
|---|---|
| YYYY-MM-DD | Primer registro |

---
<!-- INSTRUCCIONES:
  1. Renombrar: APLAZADO-descripcion-corta.md
  2. Rellenar frontmatter (fecha_creacion = hoy)
  3. Cuando esté completado: cambiar estado a 'completado' y ejecutar migrate-inbox.sh
  4. morning-check.sh calculará días aplazado y urgencia automáticamente
-->
