import UIKit

/*

 ***************** Funciones ***************
 
 * func / class func / static func
 * nombreDelMetodo
 * Entre paréntesis el o los argumentos (parámetros)
 * Tipo de dato a retornar
        Si es un tipo de dato vacio ( -> Void ) o simplemente no poder nada
        Si es un tipo de dato como Int, Float, etc... ( -> TipoDato )
 
 =============
 IMPORTANTE:
 =============
 
 Argumentos, parámetros o variables: Estos se separan por comas
 
    * Descripción de la variable o mas conocido como alias
            1. nada (la variable se auto describe)
            2. _ ( la variable no tiene descripción)
            3. un texto (es la descripción de la variable)

    * El nombre de la variable
    
    * El tipo de dato
        (: TipoDeDato)
 
    Combinaciones:
        A. (numero: Int)
        B. (_ numero: Int)
        C. (numero1 n1: Int)
 
    registarAlumno("Kenyi", "Rodriguez", 31)
    registarAlumno("Fernando", "Mateo", 31)
 
 */

//JAMAS LO HAGAS
func sumar(_ n1: Int, _ n2: Int) -> Int { n1 + n2 }
sumar(5, 9)


//RECOMENDADO
func sumar(numero1 n1: Int, conNumero2 n2: Int) -> Int { n1 + n2 }
sumar(numero1: 9, conNumero2: 3)

func sumar(numero1: Int, numero2: Int) -> Int { numero1 + numero2 }
sumar(numero1: 6, numero2: 9)

func sumarNumero1(_ numero1: Int, numero2: Int) -> Int { numero1 + numero2 }
sumarNumero1(6, numero2: 7)

//=================
//SUPER RECOMENDADO
//=================
func sumarNumero1(_ n1: Int, conNumero2 n2: Int) -> Int { n1 + n2 }
sumarNumero1(6, conNumero2: 8)

func registrarUsuarioConNomnbre(_ nombre: String, apellido: String, edad: Int) {
    
}

registrarUsuarioConNomnbre("Kenyi", apellido: "Rodriguez", edad: 31)
registrarUsuarioConNomnbre("Fernando", apellido: "Mateo", edad: 31)

func registrarUsuarioConNomnbre(_ nombre: String, apellido: String, pais: String = "Perú") {
    print("Nombre: \(nombre)\nApellido: \(apellido)\nPaís: \(pais)")
}

registrarUsuarioConNomnbre("Kenyi", apellido: "Rodriguez")
print("\n\n")
registrarUsuarioConNomnbre("Fernando", apellido: "Mateo", pais: "Mexico")
