# En Pythom no hay demasiada encapsulacion, pero se puede simular


class MiClase:
    atributo_publico = 1  # Atributo público de clase
    __atributo_privado = 2  # Atributo privado de clase
    _protected = "protegido"

    def get_atributo_privado(self):
        return self.__atributo_privado

    def set_atributo_privado(self, valor):
        self.__atributo_privado = valor

    def __init__(self, valor: int) -> None:
        self.atributo_publico = valor


if __name__ == "__main__":
    obj = MiClase(5)
    print(obj.atributo_publico)  # 5
    print(obj.get_atributo_privado())  # 2
    obj.set_atributo_privado(10)
    print(obj.get_atributo_privado())  # 10
    

    obj.__atributo_privado = 20  # Esto no debería funcionar.
    print(obj.get_atributo_privado())  # Pero lo hace.
    print(vars(obj))
    print(
        obj.__atributo_privado
    )  # Esto generará un error, ya que __atributo_privado es privado
    # Esto generará un error, ya que __atributo_privado es privado
    # print(obj.__atributo_privado)  # AttributeError: 'MiClase' object has no attribute '__atributo_privado'

print(interna)
