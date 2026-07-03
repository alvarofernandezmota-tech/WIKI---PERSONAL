#!/usr/bin/env node
// FUNCIÓN:   MCP server — expone herramientas del ecosistema yggdrasil-dew a cualquier IA
// TRIGGER:   Arranque manual o docker-compose
// AGENTE:    mcp-server
// RUTAS:     scripts/, reports/
// Uso: node mcp/server.js
// Requisitos: npm install @modelcontextprotocol/sdk

import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { execSync } from "child_process";
import { readFileSync } from "fs";
import { z } from "zod";

const ROOT = process.env.YGGDRASIL_ROOT || "/srv/yggdrasil-dew";
const server = new McpServer({
  name: "yggdrasil-ecosistema",
  version: "1.0.0",
  description: "Ecosistema yggdrasil-dew como herramienta MCP para cualquier IA"
});

// Helper: ejecutar script bash
const runScript = (script) => {
  try {
    return execSync(`bash ${ROOT}/scripts/${script}`, {
      encoding: "utf8",
      timeout: 60000,
      env: { ...process.env, YGGDRASIL_ROOT: ROOT }
    });
  } catch (e) {
    return `ERROR: ${e.message}\n${e.stdout || ""}\n${e.stderr || ""}`;
  }
};

// ─── TOOLS ────────────────────────────────────────────────────────────────────

server.tool("orquestador_supremo",
  "Ejecuta el orquestador completo del ecosistema en orden (todos los agentes)",
  {},
  async () => ({ content: [{ type: "text", text: runScript("orquestador-supremo.sh") }] })
);

server.tool("watchdog_monitor",
  "Monitoriza que todos los agentes se hayan ejecutado correctamente",
  {},
  async () => ({ content: [{ type: "text", text: runScript("watchdog-monitor.sh") }] })
);

server.tool("clasificador_maestro",
  "Clasifica los archivos del inbox/ automáticamente",
  {},
  async () => ({ content: [{ type: "text", text: runScript("clasificador-maestro.sh") }] })
);

server.tool("struct_auditor",
  "Auditoría estructural: detecta carpetas duplicadas y abre issues",
  {},
  async () => ({ content: [{ type: "text", text: runScript("struct-auditor.sh") }] })
);

server.tool("ghost_file_detector",
  "Detecta archivos vacíos y referencias rotas en docs/",
  {},
  async () => ({ content: [{ type: "text", text: runScript("ghost-file-detector.sh") }] })
);

server.tool("agent_docs",
  "Sincroniza y actualiza la documentación del ecosistema",
  {},
  async () => ({ content: [{ type: "text", text: runScript("agent-docs-sync.sh") }] })
);

server.tool("agent_islas",
  "Orquesta el estado de todas las islas del ecosistema",
  {},
  async () => ({ content: [{ type: "text", text: runScript("agent-islas-orquestador.sh") }] })
);

server.tool("agent_tareas",
  "Gestiona y prioriza las tareas activas",
  {},
  async () => ({ content: [{ type: "text", text: runScript("agent-tareas-manager.sh") }] })
);

server.tool("agent_investigacion",
  "Sincroniza y ordena la investigación y OSINT",
  {},
  async () => ({ content: [{ type: "text", text: runScript("agent-investigacion-sync.sh") }] })
);

server.tool("agent_ecosistema",
  "Auditoría global del ecosistema completo",
  {},
  async () => ({ content: [{ type: "text", text: runScript("agent-ecosistema-audit.sh") }] })
);

server.tool("cross_ref_checker",
  "Verifica que no hay links internos rotos entre documentos",
  {},
  async () => ({ content: [{ type: "text", text: runScript("cross-ref-checker.sh") }] })
);

server.tool("isla_sync_validator",
  "Valida que MAPA-ISLAS.md refleja la estructura real del repo",
  {},
  async () => ({ content: [{ type: "text", text: runScript("isla-sync-validator.sh") }] })
);

server.tool("tool_inventory_auditor",
  "Audita que todos los scripts tienen cabecera estándar",
  {},
  async () => ({ content: [{ type: "text", text: runScript("tool-inventory-auditor.sh") }] })
);

server.tool("core_estado",
  "Lee CORE-ECOSISTEMA.md y compara el estado definido vs la realidad del repo",
  {},
  async () => {
    try {
      const core = readFileSync(`${ROOT}/docs/CORE-ECOSISTEMA.md`, "utf8");
      const scripts = execSync(`ls ${ROOT}/scripts/*.sh 2>/dev/null | xargs -I{} basename {}`, { encoding: "utf8" }).trim();
      const workflows = execSync(`ls ${ROOT}/.github/workflows/*.yml 2>/dev/null | xargs -I{} basename {}`, { encoding: "utf8" }).trim();
      const result = `# Estado CORE vs Realidad\n\n## CORE cargado\n${core.substring(0, 500)}...\n\n## Scripts presentes\n${scripts}\n\n## Workflows presentes\n${workflows}`;
      return { content: [{ type: "text", text: result }] };
    } catch (e) {
      return { content: [{ type: "text", text: `ERROR leyendo CORE: ${e.message}` }] };
    }
  }
);

server.tool("run_between_sessions",
  "Ejecuta el ciclo nocturno autónomo entre sesiones",
  {},
  async () => ({ content: [{ type: "text", text: runScript("between-sessions.sh") }] })
);

// ─── ARRANQUE ─────────────────────────────────────────────────────────────────
const transport = new StdioServerTransport();
await server.connect(transport);
console.error("[MCP] yggdrasil-ecosistema server arrancado");
