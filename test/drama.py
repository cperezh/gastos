class Prueba:
    
    nombre = "Carlos"

    def __init__(self) -> None:
        print("ID:",id(self.nombre))
        pass

    def cambia(self):
        self.nombre = "Pedro"
        print("ID:",id(self.nombre))

    def print_name(self):
        print(self.nombre)

if __name__ == "__main__":
    p = Prueba()
    p.print_name()
    p.cambia()
    #p.print_name()
    print("P2-------------------")
    p2 = Prueba()
    #p2.print_name()