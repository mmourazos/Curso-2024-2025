# Ejemplo de clases y objetos en Python.
from datetime import date

class Persona:
    def __init__(self, nombre: str, fecha_nacimiento: date):
        self.nombre = nombre
        self.fecha_nacimiento = fecha_nacimiento

    def edad(self) -> int:
        return date.today().year - self.fecha_nacimiento.year

    # __str__ = lambda self: f"{self.nombre} ({self.edad()} años)"
    def __str__(self) -> str:
        return f"{self.nombre} ({self.edad()} años)"

class Profesor(Persona):
    def __init__(self, nombre: str, fecha_nacimiento: date, asignatura: str):
        super().__init__(nombre, fecha_nacimiento)
        self.asignatura = asignatura

    def __str__(self) -> str:
        return f"{super().__str__()}- {self.asignatura}"


# Para ejecutar código si este es el módulo principal ("__main__").
if __name__ == "__main__":
    p1 = Persona("Juan", date(1990, 5, 15))
    print(p1)  # Juan (33 años)

    p2 = Profesor("Ana", date(1985, 3, 22), "Matemáticas")
    print(p2)  # Ana (38 años)- Matemáticas

    p1.apellido = "Pérez"
    print(p1)  # Juan Pérez (33 año)
    print(vars(p1))
