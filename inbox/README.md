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

## Bloque Bots & RAG (2026-07-03)

Notas relevantes:

- `2026-07-03-arquitectura-bots-ecosistema.md` — flota de bots, roles y normas de enjambre.
- `2026-07-03-enjambre-rag-llm-filosofia.md` — filosofía de enjambre, RAG en producción, cuantización LLM.
- `2026-07-03-bots-telegram-ollama-rag-local.md` — FastAPI + Docker + Ollama, stack self-hosted y RAG local.

Estas notas alimentan el diseño de:

- Bot 2: **Investigador Maestro / Mimir** (RAG local sobre Yggdrasil-dew)
- Bot 1: **Centinela** (alertas de red, backups, SSH)
- Bot 3: **Intendente** (n8n, automatización general)

Pendiente:

- Mover estas notas a `docs/bots/` y `docs/infra/` cuando se concrete el diseño.
- Crear issues en GitHub para implementar cada bot como servicio Docker independiente.

## Escalado futuro

Cuando llegue el agente IA, el inbox será su entrada principal:
el agente leerá los archivos, los clasificará y los migrará automáticamente.

_Yggdrasil Ecosystem — actualizado 03-jul-2026_
