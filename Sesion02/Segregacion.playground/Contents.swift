import UIKit

protocol Persona {
    var nombre: String { get set }
    var apellido: String { get set }
    
    func saludar()
}

extension Persona {
    var nombreCompleto: String {
        "\(self.nombre) \(self.apellido)"
    }
    
    func saludar() {
        print("Hola soy: \(self.nombreCompleto)")
    }
}

protocol Empleado {
    var codEmpleado: String { get set }
}

protocol Docente {
    var especialidad: String { get set }
}

protocol Mentor {
    
}

//==================================

struct Profesor: Persona, Empleado, Docente, Mentor {
    var nombre: String
    var apellido: String
    var codEmpleado: String
    var especialidad: String
    
    init(nombre: String, apellido: String, codEmpleado: String, especialidad: String) {
        self.nombre = nombre
        self.apellido = apellido
        self.codEmpleado = codEmpleado
        self.especialidad = especialidad
    }
}

struct Auxiliar: Persona, Empleado, Docente, Mentor {
    var nombre: String
    var apellido: String
    var codEmpleado: String
    var especialidad: String
    
    init(nombre: String, apellido: String, codEmpleado: String, especialidad: String) {
        self.nombre = nombre
        self.apellido = apellido
        self.codEmpleado = codEmpleado
        self.especialidad = especialidad
    }
}

struct Director: Persona, Empleado {
    var nombre: String
    var apellido: String
    var codEmpleado: String
    
    init(nombre: String, apellido: String, codEmpleado: String) {
        self.nombre = nombre
        self.apellido = apellido
        self.codEmpleado = codEmpleado
    }
}

struct Alumno: Persona {
    var nombre: String
    var apellido: String
    
    init(nombre: String, apellido: String) {
        self.nombre = nombre
        self.apellido = apellido
    }
}

struct Secretario: Persona, Empleado {
    var nombre: String
    var apellido: String
    var codEmpleado: String
    
    init(nombre: String, apellido: String, codEmpleado: String) {
        self.nombre = nombre
        self.apellido = apellido
        self.codEmpleado = codEmpleado
    }
}

let objAlumno = Alumno(nombre: "Kenyi", apellido: "Rodriguez")
objAlumno.saludar()
