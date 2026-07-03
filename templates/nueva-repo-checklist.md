---
tags: [template, checklist, nueva-repo, ecosistema]
---

# ✅ Checklist: nueva repo del ecosistema

> Copia este fichero cada vez que crees una nueva repo hija del ecosistema.
> Completa los pasos en orden.

## Datos de la nueva repo

- **Nombre:** <!-- ej: andromeda-bot -->
- **Rol:** <!-- ej: bot de productividad personal -->
- **Privada:** <!-- si/no -->
- **Fecha:** <!-- YYYY-MM-DD -->

---

## Pasos

```
[ ] 1. Crear repo en GitHub
       gh repo create alvarofernandezmota-tech/<nombre> --private

[ ] 2. Inicializar con Edison (copia estructura base del ecosistema)
       cd ~/Projects/thdora
       bash scripts/edison.sh migrate ~/Projects/<nombre>

[ ] 3. Actualizar ECOSISTEMA.md en yggdrasil-dew
       - Añadir fila a la tabla de repos
       - Actualizar el diagrama de relaciones

[ ] 4. Actualizar HERRAMIENTAS-ECOSISTEMA.md en yggdrasil-dew
       - Añadir Actions de la nueva repo a la seccion correspondiente

[ ] 5. Crear docs/CONVENCIONES-LOCAL.md en la nueva repo
       Contenido minimo:
       > Esta repo sigue las normas globales del ecosistema.
       > Fuente de verdad: yggdrasil-dew/CONVENCIONES.md
       > Reglas locales adicionales: ...

[ ] 6. Añadir las 4 Actions obligatorias
       - ecosystem-guardian.yml
       - ecosystem-sync.yml
       - lint-commits.yml
       - ci.yml

[ ] 7. Crear PLAN_MANANA.md con las primeras 3-5 tareas

[ ] 8. Primer commit
       git add -A
       git commit -m "feat: inicializar ecosistema desde yggdrasil-dew"
       git push

[ ] 9. Abrir issue #1 en la nueva repo
       Titulo: [META] Estructura inicial del ecosistema
       Body: enlazar a este checklist + descripcion del rol de la repo

[ ] 10. Abrir issue en yggdrasil-dew con la misma info
        para que el orquestador tenga contexto del nuevo nodo
```

---
_Template del ecosistema yggdrasil-dew_
