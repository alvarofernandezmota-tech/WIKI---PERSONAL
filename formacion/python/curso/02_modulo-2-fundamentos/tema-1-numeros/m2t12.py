#1. Haz  programa que escriba una línea con el mensaje “Buenos días a todo el mundo!”.un
print("hello word")
#2. Haz un programa que declare tres palabras a, b y c, y que escriba una línea con c, b y a en este orden.
a = "hola"
b = "adios"
c = "gracias"
print(c, b, a)
#3. Haz un programa que declare dos números y que escriba la suma.
a = 15
b = 10
print(a + b)
#4. Haz un programa que declare dos números y que escriba el máximo.
a = 20
b = 10 
print(max(a, b))
#5. Haz un programa que declare tres números, todos diferentes, y que escriba el máximo.
a = 3
b = 7
c = 5
print(max(a,b,c))
#6. Hacer un programa que dado un valor calcule su cuadrado y el cubo. 
x = 3
cuadrodo = pow(x,2)
cubo = pow(x,3)
#7. Haz un programa que devuelva el valor absoluto de un número.
x = -7
print(abs(x))
#8. Haz un programa que lea dos naturales a y b, con b > 0, y que escriba la división entera d y el residuo r de a entre b. 
#Recordad que, por definición, d y r tienen que ser los únicos enteros tales que 0 ≤ r < b y d · b + r = a.
#Ejemplo: a=32, b=5, d=6, r=2 ya que 32 = 5 * 6 + 2
a = 41
b = 5
residuo = a % b
cuociente_entero = a // b
#9. Haz un programa que, dada una cantidad de segundos, diga cuántas horas, minutos y segundos representa.
x = 12000 #segundos
minutos = x / 60
horas = minutos / 60
print("{}segunos son, {} minutos que son, {} horas".format(x, minutos, horas))
#10. Haz un programa que dada una temperatura en grados Celsius la muestre en grados Fahrenheit y en grados Kelvin. (F= 1.8C + 32 y  ºK =°C + 273ºK).
c = 41
f = 1.8 * c + 32
k = c + 273
print('Temperatura en Celsius: {}'.format(c))
print('Temperatura en Fahrenheit: {}'.format(f))
print('Temperatura en Kelvin: {}'.format(k))
