import UIKit

/*
************** Tipos Variables **************
 
 Mutables (var)
    * Son aquellas que puedes cambiar su valor a lo largo de su ciclo de vida.
 
 Inmutables (let)
    * Son aquellas que mantienen su valor iniciar durante todo su ciclo de vida.
    OJO: no son constantes
 */

var distancia = 25
distancia = 26
distancia = 27

var precioDolar = 4.1
precioDolar = 3.96
precioDolar = 2.5



/*
    ********* Tipos de declaración *********
 
 Implícita:
    * Deja que swift detecte que tipo de dato se esta asignando a la variable
    * No se especifica el tipo de dato
 
 Explícita:
    * Se debe especificar el tipo de dato que recibira la variable
 
 */


let precio: Float = 11.634
let impuesto: Double = 2.34

let precioTotal1 = Double(precio) + impuesto
let precioTotal2 = precio + Float(impuesto)


let nombre = "Kenyi"
let apellido: String = "Rodriguez"
let edad = 31

let info1 = nombre + apellido
let info2 = nombre + " " + apellido
let info3 = nombre + " " + apellido + " " + String(edad)
let info4 = "Name: \(nombre) - LastName: \(apellido) - Age: \(edad)"
let info5 = "Name: \(nombre) \nLastName: \(apellido) \nAge: \(edad)"

print(info5)
