import UIKit
import CoreGraphics

class Persona {
    
    let nombre: String
    let apellido: String
    
    var nombreCompleto: String {
        "\(self.nombre) \(self.apellido)".lowercased().capitalized
    }
    
    var iniciales: String {
        let inicialesNombre = self.nombre.prefix(1).uppercased()
        let inicialesApellido = self.apellido.prefix(1).uppercased()
        return inicialesNombre + inicialesApellido
    }
    
    init(nombre: String, apellido: String) {
        self.nombre = nombre
        self.apellido = apellido
    }
}


class Alumno: Persona {
    
    var direccion: String
    
    init(nombre: String, apellido: String, direccion: String = "No especificada") {
        self.direccion = direccion
        super.init(nombre: nombre, apellido: apellido)
    }
    
    func goToHome() {
        print("Vamos a casa ubicada en: \(self.direccion)")
    }
}

class Profesor: Persona {
    
    var direccion: String
    
    init(nombre: String, apellido: String, direccion: String = "No especificada") {
        self.direccion = direccion
        super.init(nombre: nombre, apellido: apellido)
    }
    
    func goToHome() {
        print("Vamos a casa ubicada en: \(self.direccion)")
    }
}


var arrayPersonas = [Persona]()
arrayPersonas.append(Alumno(nombre: "Javier", apellido: "Siancas"))
arrayPersonas.append(Alumno(nombre: "Flavia", apellido: "Figueroa"))
arrayPersonas.append(Profesor(nombre: "KeNyI", apellido: "Rodriguez"))
arrayPersonas.append(Profesor(nombre: "Renzo", apellido: "Martinez"))

for persona in arrayPersonas {
    print(persona.nombreCompleto)
}
