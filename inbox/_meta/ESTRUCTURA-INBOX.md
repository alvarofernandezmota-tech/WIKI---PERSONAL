# ESTRUCTURA INBOX

## Principio

La inbox usa la **misma estructura lógica** que la repo principal y las islas.
No copia código: copia taxonomía.
Así cualquier entrada puede clasificarse en el ecosistema correcto sin ambigüedad.

## Mapa de carpetas

```
inbox/
├── _meta/           ← Meta: reglas, workflow, roadmap, reportes del orquestador
├── agentes/         ← Agentes, scripts, workflows, Actions, auditorías
│   ├── agente-filtro-info/
│   ├── agente-investigador/
│   ├── agente-sync-reglas/
│   ├── agente-vigilante/
│   ├── agente-self-heal/
│   └── agente-roadmap-master/
├── sesiones/        ← Contexto de sesiones: decisiones, bloqueos, próximo paso
├── infra/           ← Docker, Ollama, MCP, Tailscale, Madre, red
├── proyectos/       ← Roadmaps, planes, sprints, objetivos
├── formacion/       ← Python, cursos, aprendizaje técnico
├── hardware/        ← Routers, drivers, USB, WiFi, dispositivos
├── osint/           ← Inteligencia, investigación, vigilancia
├── thdora/          ← Bots Telegram, automatización personal
├── yo/              ← Contexto personal, notas propias
├── clasificados/    ← Sin ecosistema claro (temporal, vaciar cada sesión)
├── descartados/     ← Entradas descartadas definitivamente
└── archive/         ← Histórico de entradas procesadas
```

## Regla de espejo

Cada isla que exista en la repo debe tener su carpeta espejo en inbox.
El `agente-sync-reglas` es responsable de mantener esta sincronía.
