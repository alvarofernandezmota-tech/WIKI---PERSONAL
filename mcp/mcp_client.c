// mcp/mcp_client.c
// Compilar: gcc -O2 -o mcp_client mcp_client.c
// Protocolo MCP stdio: envía JSON a stdout y lee respuesta de stdin

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv) {
    char buf[8192];
    const char *tool = argc > 1 ? argv[1] : "orquestador_total";
    const char *args = argc > 2 ? argv[2] : "{}";

    snprintf(buf, sizeof(buf),
        "{\"type\":\"call_tool\",\"tool\":\"%s\",\"arguments\":%s}\n",
        tool, args);

    printf("%s", buf);
    fflush(stdout);

    while (fgets(buf, sizeof(buf), stdin)) {
        printf("%s", buf);
    }

    return 0;
}
