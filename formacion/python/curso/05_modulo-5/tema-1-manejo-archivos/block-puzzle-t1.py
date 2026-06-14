# Block Puzzle T1 — Manejo de Archivos
# M5 · Escuela Musk · 16 marzo 2026
# 8/8 completados ✅

# ─────────────────────────────────────────
# 1/8 Abre un archivo en modo lectura
# ─────────────────────────────────────────
file = open("Ejemplo.txt", "r")
# → Se ha abierto el archivo Ejemplo.txt en modo lectura


# ─────────────────────────────────────────
# 2/8 Lee todo el contenido de un archivo, después ciérralo
# ─────────────────────────────────────────
contenido = file.read()
file.close()
# → Se ha leido el contenido del archivo. Se ha cerrado el archivo.


# ─────────────────────────────────────────
# 3/8 Abre un archivo y escribe un texto en él
# ─────────────────────────────────────────
file = open("Ejemplo.txt", "w")
file.write("Hola Luna!\n")
# → Archivo Ejemplo.txt abierto en modo escritura. Se ha escrito "Hola Luna"


# ─────────────────────────────────────────
# 4/8 Lee un archivo línea por línea
# ─────────────────────────────────────────
with open("Archivo.txt", "r") as file:
    lineas = file.readlines()
# → Se ha leido el contenido del archivo línea por línea


# ─────────────────────────────────────────
# 5/8 Escribir varias líneas en un archivo
# ─────────────────────────────────────────
with open("Archivo.txt", "w") as file:
    file.writelines(["Hola ", "Luna "])
# → Se ha escrito "Hola Luna" en el archivo "Archivo.txt"


# ─────────────────────────────────────────
# 6/8 Agrega contenido a un archivo existente sin sobreescribirlo
# ─────────────────────────────────────────
with open("Archivo.txt", "a") as file:
    file.write("¡Hola de nuevo!\n")
# → Nuevo contenido agregado correctamente a Archivo.txt


# ─────────────────────────────────────────
# 7/8 Abre "Imagen.jpg" en modo lectura binaria y lee su contenido
# ─────────────────────────────────────────
with open("Imagen.jpg", "rb") as file:
    contenido_binario = file.read()
# → Archivo "Imagen.jpg" abierto en modo binaria


# ─────────────────────────────────────────
# 8/8 Agrega una línea de texto al final del archivo en modo apéndice
# ─────────────────────────────────────────
with open("Archivo.txt", "a") as archivo:
    archivo.write("Esta es una nueva línea.\n")
# → Linea de texto agregada a "Archivo.txt"
