# Inbox — Flujo de Captura

El inbox es la **entrada de todo** al ecosistema Yggdrasil.

## Flujo

```
📱 Idea / nota / tarea rápida
        ↓
   inbox/*.md          ← Captura rápida, sin procesar
        ↓  (procesar)
 inbox/procesado/      ← Revisado, clasificado, pendiente de mover
        ↓  (migrate-inbox.sh)
   docs/               ← Conocimiento permanente del ecosistema
        ↓  (si aplica)
 GitHub Issues          ← Tareas accionables con seguimiento
```

## Reglas

- **Captura rápida**: un archivo = una idea/sesión/tarea
- **Nombre**: `YYYY-MM-DD-descripcion-corta.md`
- **No procesar en el momento**: captura ahora, procesa después
- **El inbox debe estar vacío** al final de cada sesión de trabajo
- **Procesado/** es temporal — migramos a `docs/` con `migrate-inbox.sh`

## Scripts relacionados

```bash
# Ver estado del inbox
ls inbox/

# Migrar procesados a docs/
bash scripts/maintenance/migrate-inbox.sh

# Auditoría completa (incluye inbox)
bash scripts/maintenance/audit-full.sh
```

## Escalado futuro

Cuando llegue el agente IA, el inbox será su entrada principal:
el agente leerá los archivos, los clasificará y los migrará automáticamente.

_Yggdrasil Ecosystem — actualizado 03-jul-2026_
