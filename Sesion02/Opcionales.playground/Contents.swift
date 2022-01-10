import UIKit

let n1: Int = 10
let n2: Int? = nil

let suma = n1 + (n2 ?? 0)
print(suma)

struct Persona {
    let nombre: String
    let apellido: String
    let direccion: String?
    
    var datos: String {
        "Nombre: \(self.nombre)\nApellido: \(self.apellido)\nDirección: \(self.direccion ?? "No especificada")"
    }
    
    init(nombre: String, apellido: String, direccion: String? = nil) {
        self.nombre = nombre
        self.apellido = apellido
        self.direccion = direccion
    }
}

let objPersona = Persona(nombre: "Kenyi", apellido: "Rodriguez")
print(objPersona.datos)


extension String {
    mutating func trim() -> String {
        let result = self.replacingOccurrences(of: " ", with: "")
        self = result
        return result
    }
}

//*************** guard let / guard var ****************
/*
    Sólo aplica en funciones
    Crear variables seguras
    Detiene un flujo cuando encuentra un error y ejecuta un plan de contingencia
    Es obligatorio el return
 */

func crearUsuarioGuard1(_ nombre: String?, apellido: String?) {
    
    guard let nombreSeguro = nombre else {
        print("Nombre incorrecto")
        return
    }

    guard let apellidoSeguro = apellido else {
        print("Apellido incorrecto")
        return
    }
    
    print("El usuario \(nombreSeguro) \(apellidoSeguro) se registró correctamente")
}

func crearUsuarioGuard2(_ nombre: String?, apellido: String?) {
    
    guard var nombre = nombre, nombre.trim().count != 0 else {
        print("Nombre incorrecto")
        return
    }

    guard var apellido = apellido, apellido.trim().count != 0 else {
        print("Apellido incorrecto")
        return
    }
    
    print("El usuario \(nombre) \(apellido) se registró correctamente")
}

crearUsuarioGuard2("5656", apellido: "uhh                ")


func crearUsuarioGuard3(_ nombre: String?, apellido: String?) {
    
    guard
        var nombre = nombre, nombre.trim().count != 0,
        var apellido = apellido, apellido.trim().count != 0
    else {
        print("Datos incorrectos")
        return
    }
    
    print("El usuario \(nombre) \(apellido) se registró correctamente")
}



//******************** if let / if var ********************
/*
    Sólo aplica en funciones
    Crear variables seguras
    Las variables seguras creadas pertenecen a un nuevo contexto
 */


func crearUsuarioIf1(_ nombre: String?, apellido: String?) {
    
    if let nombre = nombre {
        
        if let apellido = apellido {
            print("El usuario \(nombre) \(apellido) se registró correctamente")
        } else {
            print("Apellido incorrecto")
        }
        
    } else {
        print("Nombre incorrecto")
    }
    
    print("Continuo con mi función")
}


func crearUsuarioIf2(_ nombre: String?, apellido: String?) {
    
    if let nombre = nombre, let apellido = apellido {
        print("El usuario \(nombre) \(apellido) se registró correctamente")
    } else {
        print("Datos incorrectos")
    }
    
    print("Continuo con mi función")
}
