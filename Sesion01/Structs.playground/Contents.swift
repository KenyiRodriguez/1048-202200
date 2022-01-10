import UIKit

struct Persona {
    
    let nombre: String
    let apellido: String
    var direccion: String
    
    var nombreCompleto: String {
        "\(self.nombre) \(self.apellido)".lowercased().capitalized
    }
    
    var iniciales: String {
        let inicialesNombre = self.nombre.prefix(1).uppercased()
        let inicialesApellido = self.apellido.prefix(1).uppercased()
        return inicialesNombre + inicialesApellido
    }
    
    init(nombre: String, apellido: String, direccion: String = "No especificada") {
        self.nombre = nombre
        self.apellido = apellido
        self.direccion = direccion
    }
    
    func goToHome() {
        print("Vamos a casa ubicada en: \(self.direccion)")
    }
}

var obj1 = Persona(nombre: "KeNyI", apellido: "Rodriguez", direccion: "Calle los olvidados del señor 666")
print(obj1.iniciales)
obj1.direccion = "fgfgfgfg"

var obj2 = Persona(nombre: "Javier", apellido: "Siancas")


