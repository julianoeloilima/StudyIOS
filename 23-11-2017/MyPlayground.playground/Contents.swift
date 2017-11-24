//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

switch "v5" {
case let x where x.hasSuffix("5"):
    "Termina com 5"
default:
    "Termina com alguma coisa"
    break
}


switch ("curto", "text") {
case let (v1, v2) where v1 == v2:
    "São iguais"
case ("curto", _):
    "Encontrei curto"
default:
    break
}

let switchint : UInt64 = UInt64(2<<(7*2)-1)
//let switchint : UInt64 = UInt64(Int.max)

switch (switchint) {
case 0...UInt64(UInt8.max):
    print("UInt8 interval")
case 0...UInt64(UInt16.max):
    print("UInt16 interval")
case 0...UInt64(UInt32.max):
    print("UInt32 interval")
case 0...UInt64(UInt64.max):
    print("UInt64 interval")
default:
    print("big interval")
    break;
}

let switchTuple = (580, "Server offline")
switch switchTuple {
case (200,"OK"):
    "Status OK"
case (200, let msg):
    "Status OK - MSG: \(msg)"
case (500...600, let msg):
    "Status falha - Erro do servidor \(msg)"
    fallthrough
case (100...700, _):
    "Status HTTP"
default:
    break
}


var total = 0

for i in 1...100 {
    total += i
}
total

for c in "Scopus" {
    print(c)
}

var array = [1,2,3,4,5]
for (i, n) in array.enumerated() {
    print("\(i) - \(n)")
}
print("")
print("")
print("Decrescente:")

for (i, n) in array.reversed().enumerated() {
    print("\(i) - \(n)")
}

var dic = ["A" : 1, "B" : 2, "C" : 3]


for d in dic {
    print("Key: \(d.key) - Value: \(d.value)")
}

var int = 0
repeat {
    int += 1
} while int < 10
int


func soma(com a : Int, e b : Int) -> Int {
    return a + b
}

soma(com: 5, e: 7)

func somaSubtrai(_ a : Int, _ b : Int) -> (Int, Int) {
    return (a+b, a-b)
}

var resultado = somaSubtrai(3, 4)

func soma(inicio : Int, valores:Int...) -> Int {
    var retorno = inicio;
    for val in valores {
        retorno += val
    }
    return retorno
}

var totalSoma:Int = 0

// Variavel por referencia
func soma(referencia : inout Int, valores:Int...) {
    for val in valores {
        referencia += val
    }
}

soma(inicio:0, valores: 1,2,3,4)
soma(referencia: &totalSoma, valores: 1,2,3,4,5,6)



func find(inArray values : [Any], withPredicate predicate : (Any) -> Bool) -> Int? {

    for (i,v) in values.enumerated() {
        if predicate(v) {
            return i
        }
    }
    return nil
}

func predicate(valor : Any) -> Bool {
    return valor as! String == "c"
}

var index = find(inArray: ["a", "b", "c", "d", "e"], withPredicate: predicate)

index = find(inArray: ["a", "b", "c", "d", "e"]) { $0 as! String == "c" }



func getOperation(operation : String) -> ((Int, Int) -> Int)? {
    if "+".elementsEqual(operation) {
        return { return $0 + $1 }
    }
    else if "-".elementsEqual(operation) {
        return { return $0 - $1 }
    }
    else if "*".elementsEqual(operation) {
        return { return $0 - $1 }
    }

    return nil;
}


var funcao = getOperation(operation: "+")?(2,3)



func findText(text : String, find : Character, index : Int) -> String {
    var result = ""
    var finded = 0
    for char in text {
        if (char == find) {
            finded += 1
        }
        
        if finded >= index {
            result.append(char)
        }
    }
    return result
}


findText(text : "Juliano Eloi de Lima", find : "i", index: 1)

// CLOSURE
func iterator(array : [Int]) -> () -> Int? {
    var i = 0
    return {
        i += 1
        return i <= array.count ? array[i-1] : nil
    }
}


let array10 = [1,2,3,4,5]
let it = iterator(array: array10)
it()
it()
it()
it()
it()
it()


// GUARDLET

func processUser(_ name : String) -> (Float, String)? {
    
    var dic1 = ["Juliano" : Float(5000.0), "Fabio" : Float(3000.0)]
    var dic2 = ["Juliano" : "Elói", "Fabio" : "Santos"]
    
    guard let money = dic1[name] else { return nil }
    guard let sobrenome = dic2[name] else { return nil }

    return (Float(money), "\(name) \(sobrenome)")
}

processUser("Juliano")

var overflow : Int = Int.max
overflow &+ 1


2 + 2 + 2
2 << 2
2 << 2 + 2

// Nao funciona, colocar precedencia
//2 << 2 << 2
(2 << 2) << 2

1 << 2 + 5

3 & 2 | 3 | 4 ^ 1


//var idade = 30
//assert (idade >= 0, "A idade nao pode ser negativa")

class Movie {

    static let defaultTitle = "Titulo nao informado"
    static let defaultDirector = "Diretor nao informado"

    static func printDefaultMovieTitle() {
        print(Movie.defaultTitle)
    }
    
    var title : String
    var durationInMinutes : Double
    let director : String
  
    var description : String {
        return "\(self.title): \(self.director)"
    }
    
    var durationInHours : Double {
        get {
            return self.durationInMinutes / 60.0
        }
        set (novoValor) {
            //self.durationInMinutes = newValue * 60.0
            self.durationInMinutes = novoValor * 60.0
        }
    }
    
    // designated initializer
    init(title : String, director : String, durationInMinutes : Double) {
        self.director = director
        self.title = title
        self.durationInMinutes = durationInMinutes
    }
    
    convenience init(title : String, director : String) {
        self.init(title: title, director: director, durationInMinutes: 0.0)
    }

    convenience init(title : String) {
        self.init(title: title, director: Movie.defaultDirector)
    }

    deinit {
        print("Movie sendo destruido \(title) do diretor \(director)")
    }
    
}

class FightMovie : Movie {
    
    var bloodLevel : Int
    
    init(title: String, director: String, durationInMinutes : Double, bloodLevel : Int) {
        self.bloodLevel = bloodLevel
        super.init(title: title, director: director, durationInMinutes : durationInMinutes)
    }
    
    override var description : String {
        return "\(self.title): \(self.director) -> \(bloodLevel)"
    }
}

var fMovie : FightMovie = FightMovie(title: "Luta", director: "Diretor", durationInMinutes: 89, bloodLevel: 3)
fMovie.bloodLevel
fMovie.description

var movie = Movie(title: "Karate Kid", director: "Fabao")
movie.durationInHours = 1.5
movie.durationInHours
movie.durationInMinutes
//movie.title = "Karate Kid"
//movie.director = "Fabao"
movie.durationInMinutes = 120
movie.durationInHours
movie.durationInMinutes

var otherMovie = Movie(title: "Karate Kid", director: "Fabao")
otherMovie.durationInHours = 1.5
otherMovie.durationInHours
otherMovie.durationInMinutes
//movie.title = "Karate Kid"
//movie.director = "Fabao"
otherMovie.durationInMinutes = 120
otherMovie.durationInHours
otherMovie.durationInMinutes

movie === otherMovie

var movieOp : Movie? = Movie(title : "Outro filme", director: "OutroDirector")
movieOp
movieOp = nil

























