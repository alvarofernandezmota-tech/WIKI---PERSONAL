#!/usr/bin/env node
/**
 * YGGDRASIL-DEW MCP SERVER
 * Expone el ecosistema completo como toolbox MCP para cualquier IA.
 * Compatible con: Claude Desktop, GitHub Copilot, VS Code, Cursor, Continue.dev
 *
 * Uso local:   node server.js
 * Uso Docker:  docker run -e YGGDRASIL_ROOT=/srv/yggdrasil-dew yggdrasil-mcp
 * Uso remoto:  npx @modelcontextprotocol/inspector node server.js
 */

import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";
import { execSync } from "child_process";
import { readFileSync, existsSync } from "fs";
import { join } from "path";

const ROOT = process.env.YGGDRASIL_ROOT || "/srv/yggdrasil-dew";
const VERSION = "1.0.0";

// ──────────────────────────────────────────────
// Helper: ejecuta script bash de forma segura
// ──────────────────────────────────────────────
function runScript(scriptName, args = "") {
  const scriptPath = join(ROOT, "scripts", scriptName);
  if (!existsSync(scriptPath)) {
    return `❌ Script no encontrado: ${scriptPath}\nAsegúrate de que YGGDRASIL_ROOT=${ROOT} es correcto.`;
  }
  try {
    const out = execSync(`bash "${scriptPath}" ${args}`, {
      encoding: "utf8",
      timeout: 60000,
      cwd: ROOT,
    });
    return out || "✅ Ejecutado sin salida.";
  } catch (err) {
    return `❌ Error ejecutando ${scriptName}:\n${err.stderr || err.message}`;
  }
}

// ──────────────────────────────────────────────
// Helper: lee un fichero markdown del repo
// ──────────────────────────────────────────────
function readDoc(filename) {
  const filePath = join(ROOT, filename);
  if (!existsSync(filePath)) {
    return `❌ Fichero no encontrado: ${filePath}`;
  }
  return readFileSync(filePath, "utf8");
}

// ──────────────────────────────────────────────
// Definición de todas las tools
// ──────────────────────────────────────────────
const TOOLS = [
  {
    name: "orquestador_supremo",
    description:
      "Ejecuta el orquestador maestro del ecosistema. Coordina todos los agentes en orden correcto. Usar cuando se quiere lanzar el ciclo completo.",
    inputSchema: { type: "object", properties: {}, required: [] },
  },
  {
    name: "watchdog_monitor",
    description:
      "Monitoriza que todos los scripts y agentes se hayan ejecutado correctamente. Devuelve estado de salud del ecosistema.",
    inputSchema: { type: "object", properties: {}, required: [] },
  },
  {
    name: "clasificador_maestro",
    description:
      "Clasifica automáticamente el contenido del inbox/ en las islas correspondientes según las reglas de CONVENCIONES.md.",
    inputSchema: { type: "object", properties: {}, required: [] },
  },
  {
    name: "struct_auditor",
    description:
      "Auditoría estructural completa del repo. Detecta carpetas duplicadas (ej: diary/ vs diarios/, osint/ vs osint-stack/), carpetas vacías, y desviaciones del mapa oficial.",
    inputSchema: { type: "object", properties: {}, required: [] },
  },
  {
    name: "ghost_file_detector",
    description:
      "Detecta archivos fantasma: ficheros vacíos, huérfanos sin referencia, o documentos que referencian rutas inexistentes. Nivel ingeniero: cero archivos muertos.",
    inputSchema: { type: "object", properties: {}, required: [] },
  },
  {
    name: "isla_sync_validator",
    description:
      "Valida que MAPA-ISLAS.md refleja la estructura real del repo. Si hay discrepancias, las lista y propone el fix.",
    inputSchema: { type: "object", properties: {}, required: [] },
  },
  {
    name: "tool_inventory_auditor",
    description:
      "Verifica que cada script en scripts/ tiene cabecera con ## FUNCIÓN declarada y que no hay duplicidades funcionales entre tools.",
    inputSchema: { type: "object", properties: {}, required: [] },
  },
  {
    name: "agent_docs",
    description:
      "Sincroniza la documentación del ecosistema. Actualiza HERRAMIENTAS-ECOSISTEMA.md, ESTADO-SISTEMA.md y el índice de agentes.",
    inputSchema: { type: "object", properties: {}, required: [] },
  },
  {
    name: "agent_islas",
    description:
      "Orquestador de islas. Gestiona el estado de todas las islas del ecosistema (proyectos, hardware, formación, osint).",
    inputSchema: { type: "object", properties: {}, required: [] },
  },
  {
    name: "agent_tareas",
    description:
      "Gestiona el backlog de tareas. Lee MASTER-PENDIENTES.md, prioriza, y actualiza el estado de cada tarea.",
    inputSchema: { type: "object", properties: {}, required: [] },
  },
  {
    name: "agent_investigacion",
    description:
      "Sincroniza y organiza la isla de investigación/OSINT. Consolida osint/ y osint-stack/ y genera informe.",
    inputSchema: { type: "object", properties: {}, required: [] },
  },
  {
    name: "agent_ecosistema",
    description:
      "Auditoría global del ecosistema. Ejecuta todos los validadores y genera un informe consolidado de estado.",
    inputSchema: { type: "object", properties: {}, required: [] },
  },
  {
    name: "core_estado",
    description:
      "LEE ECOSISTEMA.md y ESTADO-SISTEMA.md y los compara con la realidad del disco. Devuelve: ✅ coherente / ⚠️ discrepancia con detalle. Cierra el círculo CORE ↔ realidad.",
    inputSchema: { type: "object", properties: {}, required: [] },
  },
  {
    name: "leer_doc",
    description:
      "Lee cualquier documento del repo. Útil para que la IA tenga contexto antes de actuar.",
    inputSchema: {
      type: "object",
      properties: {
        fichero: {
          type: "string",
          description:
            "Ruta relativa al root del repo. Ej: ECOSISTEMA.md, docs/CORE-ECOSISTEMA.md, MAPA-ISLAS.md",
        },
      },
      required: ["fichero"],
    },
  },
  {
    name: "estado_completo",
    description:
      "Snapshot rápido de todo el ecosistema: lee ESTADO-SISTEMA.md + MASTER-PENDIENTES.md + MAPA-ISLAS.md y los devuelve concatenados para contexto inmediato.",
    inputSchema: { type: "object", properties: {}, required: [] },
  },
];

// ──────────────────────────────────────────────
// Mapeo tool → script/acción
// ──────────────────────────────────────────────
const TOOL_SCRIPT_MAP = {
  orquestador_supremo: "orquestador-supremo.sh",
  watchdog_monitor: "watchdog-monitor.sh",
  clasificador_maestro: "clasificador-maestro.sh",
  struct_auditor: "struct-auditor.sh",
  ghost_file_detector: "ghost-file-detector.sh",
  isla_sync_validator: "isla-sync-validator.sh",
  tool_inventory_auditor: "tool-inventory-auditor.sh",
  agent_docs: "agent-docs-sync.sh",
  agent_islas: "agent-islas-orquestador.sh",
  agent_tareas: "agent-tareas-manager.sh",
  agent_investigacion: "agent-investigacion-sync.sh",
  agent_ecosistema: "agent-ecosistema-audit.sh",
};

// ──────────────────────────────────────────────
// Inicializar servidor MCP
// ──────────────────────────────────────────────
const server = new Server(
  {
    name: "yggdrasil-ecosistema",
    version: VERSION,
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

// Handler: listar tools
server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: TOOLS,
}));

// Handler: ejecutar tool
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;

  // Tools especiales (no bash)
  if (name === "core_estado") {
    const ecosistema = readDoc("ECOSISTEMA.md");
    const estado = readDoc("ESTADO-SISTEMA.md");
    const mapaIslas = readDoc("MAPA-ISLAS.md");
    // Ejecuta struct_auditor para comparar con realidad
    const auditResult = runScript("struct-auditor.sh");
    const result = [
      "# CORE ESTADO — Snapshot comparativo",
      `**Fecha:** ${new Date().toISOString()}`,
      `**ROOT:** ${ROOT}`,
      "",
      "## ECOSISTEMA.md",
      ecosistema.slice(0, 2000),
      "---",
      "## ESTADO-SISTEMA.md",
      estado,
      "---",
      "## MAPA-ISLAS.md",
      mapaIslas,
      "---",
      "## Auditoría estructural (struct-auditor)",
      auditResult,
    ].join("\n");
    return { content: [{ type: "text", text: result }] };
  }

  if (name === "leer_doc") {
    const fichero = args?.fichero;
    if (!fichero) {
      return {
        content: [{ type: "text", text: "❌ Debes especificar el parámetro 'fichero'." }],
      };
    }
    return { content: [{ type: "text", text: readDoc(fichero) }] };
  }

  if (name === "estado_completo") {
    const docs = ["ESTADO-SISTEMA.md", "MASTER-PENDIENTES.md", "MAPA-ISLAS.md"];
    const content = docs
      .map((d) => `# ${d}\n\n${readDoc(d)}`)
      .join("\n\n---\n\n");
    return { content: [{ type: "text", text: content }] };
  }

  // Tools bash
  const script = TOOL_SCRIPT_MAP[name];
  if (!script) {
    return {
      content: [{ type: "text", text: `❌ Tool desconocida: ${name}` }],
    };
  }

  const output = runScript(script);
  return { content: [{ type: "text", text: output }] };
});

// ──────────────────────────────────────────────
// Arrancar
// ──────────────────────────────────────────────
async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  console.error(`✅ Yggdrasil MCP Server v${VERSION} arrancado. ROOT=${ROOT}`);
}

main().catch((err) => {
  console.error("❌ Error fatal MCP server:", err);
  process.exit(1);
});
