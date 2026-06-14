#1. Haz un programa que lea un número decimal por pantalla,
 #lo convierta a entero y lo imprima.
x = float(input('Introduce un número decimal: '))
print(int(x))
#2. Haz un programa que lea un número decimal por pantalla e imprima su
# tipo y su valor redondeado en la misma línea.
x = float(input('Introduce un número decimal: '))

print('Tipo: {}, redondeo: {}'.format(type(x), round(x)))
#3. Haz un programa que lea dos números por pantalla e imprima su diferencia en valor absoluto.
x = float(input('Introduce un número: '))
y = float(input("introduce numero: "))
diff = abs(x - y)
print("diferencia entre {} y {} es {}".format(x, y , diff))
