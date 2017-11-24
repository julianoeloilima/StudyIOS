//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


var nro = 5;

var soma = nro + 3;

soma += 2;

let novaVar = 3;

// let é constante
// var é variavel
//novaVar += 3;

let `let` = 7; print(`let`)

//var novasoma = "2" + 3;


let nome: String
nome = "456"
nome + "123"

let nome2 : String? = "sf"

nome2!.description + "nome"

let numeroNil : Int? = 1
let numero : Int = numeroNil!


let str2 = """
escrevendo
uma linha
com varias
quebras
"""

let ssoma = "2 + 2 =\(str2)"

// ARRAYS

let array : [Float] = []
let array2 = [Double]()
let array3 = ["1", "2"]
let array4 = ["3", "4"]
let array6 = [1,2,3,4,5,6]
array3[0]
array3[1]
//erro
//array3[2]

//erro tamanho
//let int:Int = Int.max + 1

//concatenar array
let array5 = array3 + array4

// erro tipos diferentes
//array4 + array6

let array7 : [Any] = [1.2, 1.3, 1.4, 1.5, "1"]

var myTuple = (0, var1: 0,"2")

//desconsiderando a terceira variavel da tupla
let (a, b, _) = myTuple
a == myTuple.0
b == myTuple.var1


//dicionarios

//criando um dicionario vazio
//var nameofEmail = [String:String]()


var nameofEmail : [String:String] = [:]
nameofEmail["Juliano Elói"] = "julianoeloilima@scopus.com.br"
nameofEmail["Juliano Elói"]

let emailofName = [
    "Juliano Elói" : "julianoeloilima@scopus.com.br"
]



let m1, m2, m3 : Int

let i💖Swift = false;

"""
fazendo
um
comentario
com quebra
de linha
"""

/*
     /*
        Um
        comentario
        dentro
        de outro
        comentario
     */
 */

typealias int = Int
let nomeInt1 : int = 0b1
let nomeInt2 : int = 0x10
let nomeInt3 : Double = 1.25e2
let nomeInt4 : Double = 1.25e-2


let onemilion = 10_000_000
1000
0001

//Octal
0o0017


var myOptionalValue : Any?
myOptionalValue = Int(2.2)
myOptionalValue = "233"
myOptionalValue = 8979
myOptionalValue = Float(2.2) / 1

myOptionalValue = UInt(2.2)
myOptionalValue = UInt8(255)
myOptionalValue = UInt16(255)
myOptionalValue = UInt32(255)
myOptionalValue = UInt64(255)

myOptionalValue = 2


if (myOptionalValue != nil) {
    print("Tenho um valor")
}
else {
    print("N")
}

if let myVar = myOptionalValue {
    print("Nao sou nil : \(myVar)")
}



var umNomeQualquer = String(34)
var umIntQualquer = Int("a")




if let firstNumber = Int("4"), let secondNumber = Int("42"),
    firstNumber < secondNumber && secondNumber < 100 {
    
    "\(firstNumber) < \(secondNumber) < 100"
    
}


/* CAST */

// Nao funciona
//Int(myOptionalValue!) + 1
myOptionalValue = nil
myOptionalValue = 3
//(myOptionalValue as? Int)! + 1

(myOptionalValue as? Int ?? 2) + 1







str = "Hello, playground"
// nao funciona
//text[0...5]

// String completa
str[str.startIndex..<str.endIndex]

//Do inicio a metada da string
let metadeIndex = str.index(str.startIndex, offsetBy: str.count / 2)
str[str.startIndex..<metadeIndex]

let buscar:Character = ","
let indiceDaVirgula = str.index(of:buscar) ?? str.startIndex


let range1 = 1...5
let range2 = 1..<5
var array1 = [1,2,3,4,5]
array1[0...1] = [0,1]
array1


//

switch "v5" {
case "v1", "v2":
    print("v1 ou v2")
case let x where x.hasSuffix("5"):
    print("Termina com 5")
default:
    break
}





























