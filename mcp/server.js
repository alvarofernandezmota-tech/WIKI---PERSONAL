#!/usr/bin/env node
/**
 * MCP Server — Yggdrasil-dew
 * FUNCIÓN: Exponer todas las herramientas del ecosistema como tools MCP
 *          (orquestador, watchdog, Galatea, llm_router, agentes, inbox, auditoría)
 * VERSIÓN: 1.0.0
 * AUTOR: alvarofernandezmota-tech
 * REPO: yggdrasil-dew
 * USO: node mcp/server.js
 * REQUISITOS: Node 18+, @modelcontextprotocol/sdk
 *             npm install @modelcontextprotocol/sdk
 */

import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";
import { execSync } from "child_process";
import { readFileSync } from "fs";
import path from "path";

const ROOT = process.env.YGGDRASIL_ROOT || "/srv/yggdrasil-dew";

function runShell(cmd) {
  try {
    return execSync(cmd, { encoding: "utf8", stdio: ["pipe", "pipe", "pipe"], timeout: 120000 });
  } catch (e) {
    return `ERROR: ${e.stderr || e.message}`;
  }
}

// -------------------------------------------------------
// Definición de tools (nombre, descripción, handler)
// -------------------------------------------------------
const TOOLS = [
  {
    name: "orquestador_supremo",
    description: "Ejecuta el orquestador supremo que coordina agentes y auditorías principales",
    fn: () => runShell(`bash ${ROOT}/scripts/orquestador-supremo.sh`),
  },
  {
    name: "orquestador_total",
    description: "Ejecuta el orquestador total — lanza todos los agentes y genera reporte maestro",
    fn: () => runShell(`bash ${ROOT}/scripts/orquestador-total.sh`),
  },
  {
    name: "watchdog_monitor",
    description: "Monitoriza que los agentes y el orquestador hayan generado reportes. Detecta cuelgues.",
    fn: () => runShell(`bash ${ROOT}/scripts/watchdog-monitor.sh`),
  },
  {
    name: "agent_monitor",
    description: "Monitor secundario de agentes del ecosistema",
    fn: () => runShell(`bash ${ROOT}/scripts/agent-monitor.sh`),
  },
  {
    name: "clasificador_maestro",
    description: "Clasifica archivos del inbox y los mueve a destinos adecuados según tipo y contexto",
    fn: () => runShell(`bash ${ROOT}/scripts/clasificador-maestro.sh`),
  },
  {
    name: "gestor_estados_inbox",
    description: "Gestiona estados del inbox: NUEVO → EN-PROCESO → PROCESADO",
    fn: () => runShell(`bash ${ROOT}/scripts/gestor-estados-inbox.sh`),
  },
  {
    name: "procesar_inbox_masivo",
    description: "Procesa en lote todos los archivos pendientes del inbox",
    fn: () => runShell(`bash ${ROOT}/scripts/procesar-inbox-masivo.sh`),
  },
  {
    name: "inbox_watcher",
    description: "Activa el watcher de inbox para clasificación en tiempo real",
    fn: () => runShell(`bash ${ROOT}/scripts/inbox-watcher.sh`),
  },
  {
    name: "struct_auditor",
    description: "Auditoría estructural del repo: detecta carpetas duplicadas, huérfanas y desviaciones",
    fn: () => runShell(`bash ${ROOT}/scripts/struct-auditor.sh`),
  },
  {
    name: "ghost_file_detector",
    description: "Detecta archivos fantasma: vacíos, huérfanos o referenciados pero inexistentes",
    fn: () => runShell(`bash ${ROOT}/scripts/ghost-file-detector.sh`),
  },
  {
    name: "cross_ref_checker",
    description: "Comprueba referencias cruzadas entre docs y scripts — detecta links internos rotos",
    fn: () => runShell(`bash ${ROOT}/scripts/cross-ref-checker.sh`),
  },
  {
    name: "tool_inventory_auditor",
    description: "Audita que cada script y agente tenga declarada su FUNCIÓN única en la cabecera",
    fn: () => runShell(`bash ${ROOT}/scripts/tool-inventory-auditor.sh`),
  },
  {
    name: "isla_sync_validator",
    description: "Valida que MAPA-ISLAS.md refleja la estructura real del repo",
    fn: () => runShell(`bash ${ROOT}/scripts/isla-sync-validator.sh`),
  },
  {
    name: "ecosystem_snapshot",
    description: "Genera snapshot completo del estado del ecosistema en un momento dado",
    fn: () => runShell(`bash ${ROOT}/scripts/ecosystem-snapshot.sh`),
  },
  {
    name: "audit_and_migrate",
    description: "Audita y migra estructuras obsoletas del repo a la arquitectura actual",
    fn: () => runShell(`bash ${ROOT}/scripts/audit-and-migrate.sh`),
  },
  {
    name: "code_drift_detector",
    description: "Detecta deriva de código: scripts que se han desalineado de sus plantillas base",
    fn: () => runShell(`bash ${ROOT}/scripts/code-drift-detector.sh`),
  },
  {
    name: "repo_research",
    description: "Investigación profunda del repo: mapea dependencias, scripts y workflows",
    fn: () => runShell(`bash ${ROOT}/scripts/repo-research.sh`),
  },
  {
    name: "task_analyzer",
    description: "Analiza tareas pendientes e in-progress del ecosistema",
    fn: () => runShell(`bash ${ROOT}/scripts/task-analyzer.sh`),
  },
  {
    name: "issue_creator",
    description: "Crea issues en GitHub para deuda técnica, bloqueos o anomalías detectadas",
    fn: () => runShell(`bash ${ROOT}/scripts/issue-creator.sh`),
  },
  {
    name: "create_issues",
    description: "Crea batch de issues en GitHub desde plantilla o listado",
    fn: () => runShell(`bash ${ROOT}/scripts/create-issues.sh`),
  },
  {
    name: "setup_labels",
    description: "Configura labels de GitHub para el ecosistema (auditoría, islas, deuda, etc.)",
    fn: () => runShell(`bash ${ROOT}/scripts/setup-labels.sh`),
  },
  {
    name: "apertura_sesion",
    description: "Ritual de apertura de sesión: carga contexto, estado y pendientes",
    fn: () => runShell(`bash ${ROOT}/scripts/apertura-sesion.sh`),
  },
  {
    name: "inicio_sesion",
    description: "Inicio de sesión rápido: carga mínima necesaria para trabajar",
    fn: () => runShell(`bash ${ROOT}/scripts/inicio-sesion.sh`),
  },
  {
    name: "cierre_sesion",
    description: "Ritual de cierre de sesión: documenta estado, deuda, diary y sincroniza",
    fn: () => runShell(`bash ${ROOT}/scripts/cierre-sesion.sh`),
  },
  {
    name: "between_sessions",
    description: "Tareas automáticas entre sesiones: health-check, limpieza, sincronización",
    fn: () => runShell(`bash ${ROOT}/scripts/between-sessions.sh`),
  },
  {
    name: "deploy",
    description: "Despliega el ecosistema o servicios específicos",
    fn: () => runShell(`bash ${ROOT}/scripts/deploy.sh`),
  },
  {
    name: "deploy_madre",
    description: "Despliega cambios específicos en Madre (servidor principal)",
    fn: () => runShell(`bash ${ROOT}/scripts/deploy-madre.sh`),
  },
  {
    name: "batcueva_control",
    description: "Control del entorno Batcueva: servicios, contenedores y estado",
    fn: () => runShell(`bash ${ROOT}/scripts/batcueva-control.sh`),
  },
  {
    name: "galatea_fabrica_agente",
    description: "Crea un nuevo agente con DISEÑO.md, PROFILE.md y script base usando la plantilla estándar",
    inputSchema: {
      type: "object",
      properties: {
        nombre: { type: "string", description: "Nombre del agente (ej: agent-docs-enhancer)" },
        rol: { type: "string", description: "Rol / misión del agente" },
        scope: { type: "string", description: "Ámbito: docs, islas, tareas, osint, infra..." },
        tags: { type: "string", description: "Tags separados por coma" },
      },
      required: ["nombre", "rol"],
    },
    fn: ({ nombre = "", rol = "", scope = "general", tags = "" } = {}) =>
      runShell(`bash ${ROOT}/scripts/galatea-fabrica-agentes.sh "${nombre}" "${rol}" "${scope}" "${tags}"`),
  },
  {
    name: "galatea_isla_bot",
    description: "Crea una isla o bot Galatea con estructura base",
    inputSchema: {
      type: "object",
      properties: {
        tipo: { type: "string", description: "isla | bot | servicio" },
        nombre: { type: "string" },
        descripcion: { type: "string" },
      },
      required: ["tipo", "nombre"],
    },
    fn: ({ tipo = "isla", nombre = "", descripcion = "" } = {}) =>
      runShell(`bash ${ROOT}/scripts/galatea-islas-bots.sh "${tipo}" "${nombre}" "${descripcion}"`),
  },
  {
    name: "galatea_scan",
    description: "Escanea el repo en busca de agentes y estructuras para que Galatea los catalogue",
    fn: () => runShell(`bash ${ROOT}/scripts/galatea-scan.sh`),
  },
  {
    name: "llm_router",
    description: "Router de modelos LLM. Soporta: ollama:<model>, openai:<model>, anthropic:<model>, http:<url>",
    inputSchema: {
      type: "object",
      properties: {
        model: {
          type: "string",
          description: "Prefijo + modelo: 'ollama:llama3', 'openai:gpt-4o', 'anthropic:claude-3-5-sonnet-20241022', 'http://localhost:1234/v1/chat/completions'",
        },
        prompt: { type: "string", description: "Prompt a enviar al modelo" },
        system: { type: "string", description: "System prompt opcional" },
      },
      required: ["model", "prompt"],
    },
    fn: ({ model = "", prompt = "", system = "" } = {}) => {
      const safePrompt = prompt.replace(/"/g, '\\"').replace(/\n/g, " ");
      const safeSystem = system.replace(/"/g, '\\"').replace(/\n/g, " ");

      if (model.startsWith("ollama:")) {
        const name = model.replace("ollama:", "");
        return runShell(
          `curl -s http://localhost:11434/api/chat -d '${JSON.stringify({
            model: name,
            messages: [
              ...(system ? [{ role: "system", content: system }] : []),
              { role: "user", content: prompt },
            ],
            stream: false,
          })}'`
        );
      }

      if (model.startsWith("openai:")) {
        const name = model.replace("openai:", "");
        const payload = JSON.stringify({
          model: name,
          messages: [
            ...(system ? [{ role: "system", content: system }] : []),
            { role: "user", content: prompt },
          ],
        });
        return runShell(
          `curl -s -X POST https://api.openai.com/v1/chat/completions \
            -H "Authorization: Bearer ${process.env.OPENAI_API_KEY}" \
            -H "Content-Type: application/json" \
            -d '${payload.replace(/'/g, "'\\''")}'
          `
        );
      }

      if (model.startsWith("anthropic:")) {
        const name = model.replace("anthropic:", "");
        const payload = JSON.stringify({
          model: name,
          max_tokens: 4096,
          ...(system ? { system } : {}),
          messages: [{ role: "user", content: prompt }],
        });
        return runShell(
          `curl -s -X POST https://api.anthropic.com/v1/messages \
            -H "x-api-key: ${process.env.ANTHROPIC_API_KEY}" \
            -H "anthropic-version: 2023-06-01" \
            -H "Content-Type: application/json" \
            -d '${payload.replace(/'/g, "'\\''")}'
          `
        );
      }

      if (model.startsWith("http")) {
        const payload = JSON.stringify({ prompt, ...(system ? { system } : {}) });
        return runShell(
          `curl -s -X POST ${model} -H "Content-Type: application/json" -d '${payload.replace(/'/g, "'\\''")}'
          `
        );
      }

      return `Modelo no soportado: ${model}. Prefijos válidos: ollama: | openai: | anthropic: | http:`;
    },
  },
  {
    name: "core_estado",
    description: "Devuelve el contenido de CORE-ECOSISTEMA.md — fuente de verdad del sistema",
    fn: () => {
      try {
        return readFileSync(path.join(ROOT, "docs", "CORE-ECOSISTEMA.md"), "utf8");
      } catch {
        try {
          return readFileSync(path.join(ROOT, "CORE-ECOSISTEMA.md"), "utf8");
        } catch {
          return "CORE-ECOSISTEMA.md no encontrado en docs/ ni en raíz";
        }
      }
    },
  },
  {
    name: "inbox_cleanup",
    description: "Limpieza profunda del inbox: elimina duplicados, mueve procesados, normaliza nombres",
    fn: () => runShell(`bash ${ROOT}/scripts/inbox-cleanup-jun2026.sh`),
  },
  {
    name: "inbox_migrate",
    description: "Migra archivos del inbox a su destino definitivo según clasificación",
    fn: () => runShell(`bash ${ROOT}/scripts/inbox-migrate.sh`),
  },
  {
    name: "fix_permisos",
    description: "Corrige permisos de ejecución en todos los scripts del ecosistema",
    fn: () => runShell(`bash ${ROOT}/scripts/fix-permisos.sh`),
  },
];

// -------------------------------------------------------
// Servidor MCP con transporte stdio (compatible Claude Desktop,
// Copilot MCP, y cualquier cliente MCP estándar)
// -------------------------------------------------------
const server = new Server(
  { name: "yggdrasil-ecosistema", version: "1.0.0" },
  { capabilities: { tools: {} } }
);

server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: TOOLS.map(({ name, description, inputSchema }) => ({
    name,
    description,
    inputSchema: inputSchema ?? { type: "object", properties: {} },
  })),
}));

server.setRequestHandler(CallToolRequestSchema, async (req) => {
  const tool = TOOLS.find((t) => t.name === req.params.name);
  if (!tool) {
    return {
      content: [{ type: "text", text: `Tool no encontrada: ${req.params.name}` }],
      isError: true,
    };
  }
  const result = await tool.fn(req.params.arguments ?? {});
  return { content: [{ type: "text", text: String(result) }] };
});

const transport = new StdioServerTransport();
await server.connect(transport);
