""""""Tema 2.2: Interfaces Formales e Informales

Este archivo demuestra la diferencia entre interfaces formales (con ABC)
e interfaces informales (duck typing).
""""""

from abc import ABC, abstractmethod


# =============================================================================
# INTERFAZ FORMAL (con ABC)
# =============================================================================

class InterfazFormal(ABC):
    """"""Interfaz formal que OBLIGA a implementar métodos.""""""
    
    @abstractmethod
    def metodo_obligatorio(self):
        """"""Este método DEBE ser implementado.""""""
        pass
    
    @abstractmethod
    def otro_metodo(self):
        """"""Otro método obligatorio.""""""
        pass


class ImplementacionFormal(InterfazFormal):
    """"""Clase que implementa la interfaz formal.""""""
    
    def metodo_obligatorio(self):
        return "Método obligatorio implementado"
    
    def otro_metodo(self):
        return "Otro método implementado"


# =============================================================================
# INTERFAZ INFORMAL (Duck Typing)
# =============================================================================

class InterfazInformal:
    """"""Interfaz informal - solo define la estructura.
    
    No obliga a implementar, pero documenta qué métodos se esperan.
    """"""
    
    def metodo_esperado(self):
        """"""Este método se espera pero no es obligatorio.""""""
        raise NotImplementedError("Subclases deben implementar este método")
    
    def otro_metodo_esperado(self):
        """"""Otro método esperado.""""""
        raise NotImplementedError("Subclases deben implementar este método")


class ImplementacionInformal(InterfazInformal):
    """"""Implementación de interfaz informal.""""""
    
    def metodo_esperado(self):
        return "Método esperado implementado"
    
    def otro_metodo_esperado(self):
        return "Otro método esperado implementado"


# =============================================================================
# EJEMPLO PRÁCTICO: Sistema de Pago
# =============================================================================

class MetodoPago(ABC):
    """"""Interfaz formal para métodos de pago.""""""
    
    @abstractmethod
    def procesar_pago(self, cantidad: float) -> bool:
        """"""Procesar un pago.""""""
        pass
    
    @abstractmethod
    def verificar_fondos(self, cantidad: float) -> bool:
        """"""Verificar si hay fondos suficientes.""""""
        pass
    
    @abstractmethod
    def obtener_nombre(self) -> str:
        """"""Obtener el nombre del método de pago.""""""
        pass


class TarjetaCredito(MetodoPago):
    """"""Implementación para tarjeta de crédito.""""""
    
    def __init__(self, numero, limite):
        self.numero = numero
        self.limite = limite
        self.saldo_usado = 0
    
    def procesar_pago(self, cantidad: float) -> bool:
        if self.verificar_fondos(cantidad):
            self.saldo_usado += cantidad
            print(f"✅ Pago de {cantidad}€ procesado con tarjeta ****{self.numero[-4:]}")
            return True
        print(f"❌ Fondos insuficientes en tarjeta")
        return False
    
    def verificar_fondos(self, cantidad: float) -> bool:
        return (self.limite - self.saldo_usado) >= cantidad
    
    def obtener_nombre(self) -> str:
        return "Tarjeta de Crédito"


class PayPal(MetodoPago):
    """"""Implementación para PayPal.""""""
    
    def __init__(self, email, saldo):
        self.email = email
        self.saldo = saldo
    
    def procesar_pago(self, cantidad: float) -> bool:
        if self.verificar_fondos(cantidad):
            self.saldo -= cantidad
            print(f"✅ Pago de {cantidad}€ procesado vía PayPal ({self.email})")
            return True
        print(f"❌ Saldo insuficiente en PayPal")
        return False
    
    def verificar_fondos(self, cantidad: float) -> bool:
        return self.saldo >= cantidad
    
    def obtener_nombre(self) -> str:
        return "PayPal"


class Efectivo(MetodoPago):
    """"""Implementación para pago en efectivo.""""""
    
    def __init__(self, monto_disponible):
        self.monto = monto_disponible
    
    def procesar_pago(self, cantidad: float) -> bool:
        if self.verificar_fondos(cantidad):
            self.monto -= cantidad
            print(f"✅ Pago de {cantidad}€ en efectivo")
            return True
        print(f"❌ Efectivo insuficiente")
        return False
    
    def verificar_fondos(self, cantidad: float) -> bool:
        return self.monto >= cantidad
    
    def obtener_nombre(self) -> str:
        return "Efectivo"


# =============================================================================
# DEMOSTRACIÓN
# =============================================================================

if __name__ == "__main__":
    print("=" * 60)
    print("EJEMPLO 1: Interfaz Formal vs Informal")
    print("=" * 60)
    
    # Interfaz formal
    print("\n🔹 Interfaz FORMAL (con ABC):")
    formal = ImplementacionFormal()
    print(formal.metodo_obligatorio())
    print(formal.otro_metodo())
    
    # Interfaz informal
    print("\n🔹 Interfaz INFORMAL (duck typing):")
    informal = ImplementacionInformal()
    print(informal.metodo_esperado())
    print(informal.otro_metodo_esperado())
    
    # Diferencia clave
    print("\n" + "=" * 60)
    print("⚠️  DIFERENCIA CLAVE:")
    print("=" * 60)
    print("✅ Formal: Python impide crear instancia sin implementar")
    print("⚠️  Informal: Permite crear pero falla en tiempo de ejecución")
    
    print("\n" + "=" * 60)
    print("EJEMPLO 2: Sistema de Pago con Interfaz Formal")
    print("=" * 60)
    
    # Crear diferentes métodos de pago
    tarjeta = TarjetaCredito("1234567890123456", limite=1000)
    paypal = PayPal("usuario@example.com", saldo=500)
    efectivo = Efectivo(monto_disponible=200)
    
    # Lista de métodos de pago (polimorfismo)
    metodos_pago = [tarjeta, paypal, efectivo]
    
    # Procesar compra con cada método
    monto_compra = 150.0
    
    print(f"\n🛍️  Compra de {monto_compra}€\n")
    
    for metodo in metodos_pago:
        print(f"\nProbando {metodo.obtener_nombre()}:")
        if metodo.verificar_fondos(monto_compra):
            print(f"✅ Fondos disponibles")
            metodo.procesar_pago(monto_compra)
        else:
            print(f"❌ Fondos insuficientes en {metodo.obtener_nombre()}")
    
    print("\n" + "=" * 60)
    print("✅ Las interfaces permiten trabajar con diferentes implementaciones")
    print("✅ Polimorfismo: mismo método, diferente comportamiento")
    print("=" * 60)
