/*
 * mcp_client.c — Cliente MCP stdio JSON-RPC 2.0 en C
 * Uso: ./mcp_client <tool_name> '<json_params>'
 * Ejemplo: ./mcp_client inbox_status '{}'
 * Compila: gcc -o mcp_client mcp_client.c
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define MAX_BUF   65536
#define MAX_LINE  4096

typedef struct {
    int  to_server[2];   /* pipe: padre escribe, hijo lee  */
    int  from_server[2]; /* pipe: hijo escribe, padre lee  */
    pid_t pid;
} MCPConn;

/* Lanza el servidor MCP como proceso hijo conectado por pipes */
static int mcp_connect(MCPConn *c, const char *server_cmd) {
    if (pipe(c->to_server)   == -1) return -1;
    if (pipe(c->from_server) == -1) return -1;

    c->pid = fork();
    if (c->pid < 0) return -1;

    if (c->pid == 0) {
        /* Hijo: redirigir stdin/stdout a los pipes */
        dup2(c->to_server[0],   STDIN_FILENO);
        dup2(c->from_server[1], STDOUT_FILENO);
        close(c->to_server[1]);
        close(c->from_server[0]);
        execlp("/bin/sh", "sh", "-c", server_cmd, NULL);
        exit(1);
    }

    close(c->to_server[0]);
    close(c->from_server[1]);
    return 0;
}

/* Envía una petición JSON-RPC 2.0 y devuelve la respuesta en buf */
static int mcp_call(MCPConn *c, const char *method, const char *params,
                    char *buf, size_t bufsz) {
    char req[MAX_LINE];
    int id = (int)(getpid() % 9999);

    /* Construir el mensaje JSON-RPC */
    snprintf(req, sizeof(req),
        "{\"jsonrpc\":\"2.0\",\"id\":%d,"
        "\"method\":\"tools/call\","
        "\"params\":{\"name\":\"%s\",\"arguments\":%s}}\n",
        id, method, params ? params : "{}");

    /* Escribir al servidor */
    ssize_t w = write(c->to_server[1], req, strlen(req));
    if (w <= 0) return -1;

    /* Leer respuesta (esperamos una línea JSON completa) */
    ssize_t r = read(c->from_server[0], buf, bufsz - 1);
    if (r <= 0) return -1;
    buf[r] = '\0';
    return 0;
}

static void mcp_disconnect(MCPConn *c) {
    close(c->to_server[1]);
    close(c->from_server[0]);
}

/* ── Helpers de parsing mínimo ──────────────────────────────────────── */

/* Extrae el valor de una clave string simple en JSON plano */
static const char *json_get(const char *json, const char *key,
                            char *val, size_t valsz) {
    char pat[128];
    snprintf(pat, sizeof(pat), "\\"%s\\":", key);
    const char *p = strstr(json, pat);
    if (!p) return NULL;
    p += strlen(pat);
    while (*p == ' ') p++;
    if (*p == '"') {
        p++;
        size_t i = 0;
        while (*p && *p != '"' && i < valsz - 1) val[i++] = *p++;
        val[i] = '\0';
        return val;
    }
    return NULL;
}

/* ── main ────────────────────────────────────────────────────────────── */

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s <tool_name> [json_params]\n", argv[0]);
        fprintf(stderr, "Ej.: %s inbox_status '{}'\n", argv[0]);
        return 1;
    }

    const char *tool   = argv[1];
    const char *params = (argc >= 3) ? argv[2] : "{}";

    /* Ruta al servidor MCP — ajustar si es diferente */
    const char *server_cmd = "python3 mcp/server.py --stdio";

    MCPConn conn;
    if (mcp_connect(&conn, server_cmd) != 0) {
        fprintf(stderr, "ERROR: no se pudo arrancar el servidor MCP\n");
        return 2;
    }

    char response[MAX_BUF];
    if (mcp_call(&conn, tool, params, response, sizeof(response)) != 0) {
        fprintf(stderr, "ERROR: la llamada MCP falló\n");
        mcp_disconnect(&conn);
        return 3;
    }

    /* Imprimir respuesta cruda — el llamador puede parsearlo */
    printf("%s\n", response);

    /* Detectar error en respuesta */
    if (strstr(response, "\"error\":")) {
        char errmsg[512] = "(sin detalle)";
        json_get(response, "message", errmsg, sizeof(errmsg));
        fprintf(stderr, "MCP error: %s\n", errmsg);
        mcp_disconnect(&conn);
        return 4;
    }

    mcp_disconnect(&conn);
    return 0;
}
