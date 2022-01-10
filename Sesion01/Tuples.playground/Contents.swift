import UIKit

/*
 
 Estructuras de datos:
 
 enums
 struct
 class
 tuples
 
 */

typealias Persona = (nombre: String, apellido: String, edad: Int)

let datos1: Persona = ("Kenyi", "Apellido", 31)
print(datos1.nombre)
print(datos1.apellido)
print(datos1.edad)

let datos2: Persona = ("Javier", "Siancas", 25)
print(datos2.nombre)
print(datos2.apellido)
print(datos2.edad)

var arrayPersonas = [Persona]()
arrayPersonas.append(datos1)
arrayPersonas.append(datos2)

print("\n\n=========================================")

for persona in arrayPersonas {
    print("\nNombre: \(persona.nombre)\nApellido: \(persona.apellido)\nEdad: \(persona.edad)\n")
}
