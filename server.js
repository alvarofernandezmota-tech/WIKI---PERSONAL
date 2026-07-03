#!/usr/bin/env node
/**
 * YGGDRASIL-DEW MCP SERVER — Universal
 * Expone el ecosistema completo como toolbox MCP para cualquier IA.
 * Incluye llm_router: enruta a cualquier modelo (Ollama, OpenAI, Anthropic, Groq, LM Studio, local)
 *
 * Compatible con: Claude Desktop, GitHub Copilot, VS Code, Cursor, Continue.dev, IA en C
 *
 * Arranque:
 *   node server.js
 *   YGGDRASIL_ROOT=. node server.js   (dev local)
 *   npm run inspect                    (debug tools)
 */

import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from '@modelcontextprotocol/sdk/types.js';
import { execSync } from 'child_process';
import { readFileSync, existsSync } from 'fs';
import { join } from 'path';
import { routeLLM, listOllamaModels } from './mcp/llm-router.js';

const ROOT = process.env.YGGDRASIL_ROOT || '/srv/yggdrasil-dew';
const VERSION = '2.0.0';

// ────────────────────────────────────────────────────────────
// Helpers
// ────────────────────────────────────────────────────────────
function runScript(scriptName, args = '') {
  const scriptPath = join(ROOT, 'scripts', scriptName);
  if (!existsSync(scriptPath)) {
    return `❌ Script no encontrado: ${scriptPath}\nAsegúrate de que YGGDRASIL_ROOT=${ROOT} es correcto.`;
  }
  try {
    return execSync(`bash "${scriptPath}" ${args}`, {
      encoding: 'utf8',
      timeout: 60000,
      cwd: ROOT,
    }) || '✅ Ejecutado sin salida.';
  } catch (err) {
    return `❌ Error ejecutando ${scriptName}:\n${err.stderr || err.message}`;
  }
}

function readDoc(filename) {
  const filePath = join(ROOT, filename);
  if (!existsSync(filePath)) return `❌ Fichero no encontrado: ${filePath}`;
  return readFileSync(filePath, 'utf8');
}

// ────────────────────────────────────────────────────────────
// Definición de tools
// ────────────────────────────────────────────────────────────
const TOOLS = [
  // ── Ecosistema ──────────────────────────────────────────
  {
    name: 'orquestador_supremo',
    description: 'Ejecuta el orquestador maestro del ecosistema. Coordina todos los agentes en orden correcto.',
    inputSchema: { type: 'object', properties: {}, required: [] },
  },
  {
    name: 'watchdog_monitor',
    description: 'Monitoriza que todos los scripts y agentes se hayan ejecutado correctamente.',
    inputSchema: { type: 'object', properties: {}, required: [] },
  },
  {
    name: 'clasificador_maestro',
    description: 'Clasifica automáticamente el contenido del inbox/ en las islas correspondientes.',
    inputSchema: { type: 'object', properties: {}, required: [] },
  },
  {
    name: 'struct_auditor',
    description: 'Auditoría estructural. Detecta carpetas duplicadas (diary/diarios, osint/osint-stack), vacías y desviaciones del mapa oficial.',
    inputSchema: { type: 'object', properties: {}, required: [] },
  },
  {
    name: 'ghost_file_detector',
    description: 'Detecta archivos fantasma: ficheros vacíos, huérfanos, o documentos con rutas inexistentes.',
    inputSchema: { type: 'object', properties: {}, required: [] },
  },
  {
    name: 'isla_sync_validator',
    description: 'Valida que MAPA-ISLAS.md refleja la estructura real del repo.',
    inputSchema: { type: 'object', properties: {}, required: [] },
  },
  {
    name: 'tool_inventory_auditor',
    description: 'Verifica que cada script en scripts/ tiene cabecera ## FUNCIÓN declarada.',
    inputSchema: { type: 'object', properties: {}, required: [] },
  },
  {
    name: 'agent_docs',
    description: 'Sincroniza la documentación del ecosistema.',
    inputSchema: { type: 'object', properties: {}, required: [] },
  },
  {
    name: 'agent_islas',
    description: 'Orquestador de islas del ecosistema.',
    inputSchema: { type: 'object', properties: {}, required: [] },
  },
  {
    name: 'agent_tareas',
    description: 'Gestiona el backlog de tareas. Lee y actualiza MASTER-PENDIENTES.md.',
    inputSchema: { type: 'object', properties: {}, required: [] },
  },
  {
    name: 'agent_investigacion',
    description: 'Sincroniza la isla de investigación/OSINT. Consolida osint/ y osint-stack/.',
    inputSchema: { type: 'object', properties: {}, required: [] },
  },
  {
    name: 'agent_ecosistema',
    description: 'Auditoría global del ecosistema. Genera informe consolidado.',
    inputSchema: { type: 'object', properties: {}, required: [] },
  },
  // ── CORE ────────────────────────────────────────────────
  {
    name: 'core_estado',
    description: 'Lee ECOSISTEMA.md + ESTADO-SISTEMA.md + MAPA-ISLAS.md y los compara con la realidad del disco. Cierra el círculo CORE ↔ realidad.',
    inputSchema: { type: 'object', properties: {}, required: [] },
  },
  {
    name: 'leer_doc',
    description: 'Lee cualquier documento del repo para que la IA tenga contexto antes de actuar.',
    inputSchema: {
      type: 'object',
      properties: {
        fichero: {
          type: 'string',
          description: 'Ruta relativa al root. Ej: ECOSISTEMA.md, docs/CORE-ECOSISTEMA.md',
        },
      },
      required: ['fichero'],
    },
  },
  {
    name: 'estado_completo',
    description: 'Snapshot rápido: ESTADO-SISTEMA.md + MASTER-PENDIENTES.md + MAPA-ISLAS.md concatenados.',
    inputSchema: { type: 'object', properties: {}, required: [] },
  },
  // ── LLM Router ──────────────────────────────────────────
  {
    name: 'llm_router',
    description:
      'Llama a cualquier modelo LLM (local o remoto). ' +
      'Prefijos: ollama:MODELO, lmstudio:MODELO, openai:MODELO, anthropic:MODELO, groq:MODELO, local:BINARIO. ' +
      'Ejemplos: "ollama:llama3", "openai:gpt-4.1", "groq:llama3-70b-8192", "anthropic:claude-opus-4-5"',
    inputSchema: {
      type: 'object',
      properties: {
        model: {
          type: 'string',
          description: 'Prefijo:nombre del modelo. Ej: ollama:llama3',
        },
        prompt: {
          type: 'string',
          description: 'El prompt a enviar al modelo',
        },
        systemPrompt: {
          type: 'string',
          description: 'System prompt opcional',
        },
        maxTokens: {
          type: 'number',
          description: 'Máximo de tokens en la respuesta (default: 2048)',
        },
        temperature: {
          type: 'number',
          description: 'Temperatura del modelo 0-1 (default: 0.7)',
        },
      },
      required: ['model', 'prompt'],
    },
  },
  {
    name: 'llm_list_models',
    description: 'Lista los modelos disponibles en Ollama local.',
    inputSchema: { type: 'object', properties: {}, required: [] },
  },
];

// ────────────────────────────────────────────────────────────
// Mapeo tool → script
// ────────────────────────────────────────────────────────────
const TOOL_SCRIPT_MAP = {
  orquestador_supremo:    'orquestador-supremo.sh',
  watchdog_monitor:       'watchdog-monitor.sh',
  clasificador_maestro:   'clasificador-maestro.sh',
  struct_auditor:         'struct-auditor.sh',
  ghost_file_detector:    'ghost-file-detector.sh',
  isla_sync_validator:    'isla-sync-validator.sh',
  tool_inventory_auditor: 'tool-inventory-auditor.sh',
  agent_docs:             'agent-docs-sync.sh',
  agent_islas:            'agent-islas-orquestador.sh',
  agent_tareas:           'agent-tareas-manager.sh',
  agent_investigacion:    'agent-investigacion-sync.sh',
  agent_ecosistema:       'agent-ecosistema-audit.sh',
};

// ────────────────────────────────────────────────────────────
// Servidor MCP
// ────────────────────────────────────────────────────────────
const server = new Server(
  { name: 'yggdrasil-ecosistema', version: VERSION },
  { capabilities: { tools: {} } }
);

server.setRequestHandler(ListToolsRequestSchema, async () => ({ tools: TOOLS }));

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;

  // ── LLM Router ────────────────────────────────────────
  if (name === 'llm_router') {
    const { model, prompt, systemPrompt, maxTokens, temperature } = args;
    if (!model || !prompt) {
      return { content: [{ type: 'text', text: '❌ Parámetros requeridos: model, prompt' }] };
    }
    try {
      const result = await routeLLM(model, prompt, { systemPrompt, maxTokens, temperature });
      return { content: [{ type: 'text', text: result }] };
    } catch (err) {
      return { content: [{ type: 'text', text: `❌ llm_router error: ${err.message}` }] };
    }
  }

  if (name === 'llm_list_models') {
    const models = await listOllamaModels();
    const text = models.length > 0
      ? `Modelos Ollama disponibles:\n${models.join('\n')}`
      : 'No hay modelos Ollama disponibles o el servicio no está corriendo.';
    return { content: [{ type: 'text', text: text }] };
  }

  // ── CORE estado ───────────────────────────────────────
  if (name === 'core_estado') {
    const result = [
      `# CORE ESTADO — ${new Date().toISOString()}`,
      `ROOT: ${ROOT}`,
      '',
      '## ECOSISTEMA.md',
      readDoc('ECOSISTEMA.md').slice(0, 2000),
      '---',
      '## ESTADO-SISTEMA.md',
      readDoc('ESTADO-SISTEMA.md'),
      '---',
      '## MAPA-ISLAS.md',
      readDoc('MAPA-ISLAS.md'),
      '---',
      '## Auditoría estructural (struct-auditor)',
      runScript('struct-auditor.sh'),
    ].join('\n');
    return { content: [{ type: 'text', text: result }] };
  }

  // ── Leer documento ────────────────────────────────────
  if (name === 'leer_doc') {
    const fichero = args?.fichero;
    if (!fichero) {
      return { content: [{ type: 'text', text: "❌ Falta parámetro 'fichero'." }] };
    }
    return { content: [{ type: 'text', text: readDoc(fichero) }] };
  }

  // ── Estado completo ───────────────────────────────────
  if (name === 'estado_completo') {
    const docs = ['ESTADO-SISTEMA.md', 'MASTER-PENDIENTES.md', 'MAPA-ISLAS.md'];
    const content = docs.map((d) => `# ${d}\n\n${readDoc(d)}`).join('\n\n---\n\n');
    return { content: [{ type: 'text', text: content }] };
  }

  // ── Scripts bash ──────────────────────────────────────
  const script = TOOL_SCRIPT_MAP[name];
  if (!script) {
    return { content: [{ type: 'text', text: `❌ Tool desconocida: ${name}` }] };
  }
  return { content: [{ type: 'text', text: runScript(script) }] };
});

// ────────────────────────────────────────────────────────────
// Arrancar
// ────────────────────────────────────────────────────────────
async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  console.error(`✅ Yggdrasil MCP Server v${VERSION} arrancado. ROOT=${ROOT}`);
}

main().catch((err) => {
  console.error('❌ Error fatal MCP server:', err);
  process.exit(1);
});
