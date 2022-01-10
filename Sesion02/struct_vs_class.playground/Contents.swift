import UIKit

class PersonaClass {
    
    var nombre: String
    var apellido: String

    init(nombre: String, apellido: String) {
        self.nombre = nombre
        self.apellido = apellido
    }
}

struct PersonaStruct {
    
    var nombre: String
    var apellido: String

    init(nombre: String, apellido: String) {
        self.nombre = nombre
        self.apellido = apellido
    }
}

var personaClass1 = PersonaClass(nombre: "Kenyi", apellido: "Rodriguez")
let personaClass2 = personaClass1

print("Persona1: \(personaClass1.nombre) \(personaClass1.apellido)")

personaClass2.nombre = "Javier"
personaClass2.apellido = "Siancas"

print("Persona1: \(personaClass1.nombre) \(personaClass1.apellido)")
print("Persona2: \(personaClass2.nombre) \(personaClass2.apellido)")


print("\n\n==================================\n\n")

var personaStrcut1 = PersonaStruct(nombre: "Kenyi", apellido: "Rodriguez")
var personaStrcut2 = personaStrcut1

print("Persona1: \(personaStrcut1.nombre) \(personaStrcut1.apellido)")

personaStrcut2.nombre = "Javier"
personaStrcut2.apellido = "Siancas"

print("Persona1: \(personaStrcut1.nombre) \(personaStrcut1.apellido)")
print("Persona2: \(personaStrcut2.nombre) \(personaStrcut2.apellido)")
