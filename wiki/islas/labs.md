---
tipo: isla
author: Alvaro Fernandez Mota
creado: 2026-07-10
actualizado: 2026-07-13
ruta: wiki/islas/labs.md
tags: [isla, labs, experimentos, prototipos, investigacion]
status: auditada
---

# Isla: Labs (Experimentos y Prototipos)

> Sandbox del ecosistema. Aquí se prueban ideas antes de promoverlas a isla propia.
> Lo que sobrevive en Labs se convierte en isla. Lo que no, se archiva.

---

## Propósito

| Qué es | Qué NO es |
|--------|----------|
| Zona de experimentos sin presión de producción | Repo de código en producción |
| Pruebas de integración entre islas | Documentación definitiva |
| Investigación de nuevas herramientas | Canon del ecosistema |
| Prototipos rápidos (PoC) | Código mantenido a largo plazo |

---

## Relación con otras islas

```
Labs
  ├── consume → IA Local (Ollama, LiteLLM para probar prompts)
  ├── consume → Orquestador (n8n para automatizar experimentos)
  ├── puede promover a → isla propia (si el experimento madura)
  └── puede archivar → _archivo/ (si el experimento muere)
```

---

## Tipos de experimentos habituales

- **IA / LLM**: pruebas de prompts, agentes, RAG con Qdrant
- **SecOps**: scripts de auditoría, herramientas OSINT puntuales
- **Automatización**: flujos n8n experimentales antes de ponerlos en producción
- **Infra**: pruebas de Docker, configs, scripts de Madre
- **Dev**: prototipos de código antes de crear repo propio

---

## Convención

> Todo experimento en Labs debe tener:
> 1. Un `README.md` mínimo con: qué es, por qué existe, fecha de inicio
> 2. Una fecha de revisión (máx. 30 días)
> 3. Decisión: **promover** → isla / **archivar** → `_archivo/`

---

## Estado real — 2026-07-13

🟡 **Labs no tiene repo propio** — los experimentos viven dispersos o en repos temporales sin catalogar.

Pendiente:
- [ ] Inventariar qué experimentos activos existen ahora mismo
- [ ] Decidir si Labs necesita repo propio o vive en subcarpetas de DEW
- [ ] Conectar con isla IA Local para experimentos LLM

---

_Actualizado: 2026-07-13 · Perplexity-MCP_
