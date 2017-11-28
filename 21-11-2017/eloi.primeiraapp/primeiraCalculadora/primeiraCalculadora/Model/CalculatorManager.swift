//
//  CalculadoraManager.swift
//  primeiraCalculadora
//
//  Created by Aloc SP08608 on 22/11/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import Foundation

struct CalculatorManager {
    
    private var symbolOperation : String? = nil
    private var n1: Double = 0.0
    private var n2: Double? = nil
    private var res : Double? = nil
    
    enum Operation {
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case BinaryOptionalOperation((Double, Double?) -> Double)
    }
    
    private let operations : [String : Operation] = [
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "-" : Operation.BinaryOperation({ $0 - $1 }),
        "x" : Operation.BinaryOperation({ $0 * $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        "√" : Operation.UnaryOperation(sqrt),
        "%" : Operation.BinaryOptionalOperation({
            if let v2 = $1 {
                return $0 * v2 / 100.0
            }
            return $0 / 100.0
        })
    ]
    
    var result : Double? {
        get {
            return self.res
        }
    }
    
    var number1 : Double {
        get {
            return self.n1
        }
    }
    
    var number2 : Double? {
        get {
            return self.n2
        }
    }
    
    mutating func performOperation() {
        guard let symbol = self.symbolOperation else { return }
        guard let operation : Operation  = operations[symbol] else { return }
        
        if res != nil {
            n1 = res!
        }
        
        switch operation {
        case Operation.UnaryOperation(let op):
            res = op(self.n1)
        case Operation.BinaryOperation(let op):
            res = op(self.n1, self.n2!)
        case Operation.BinaryOptionalOperation(let op):
            res = op(self.n1, self.n2)
        default:
            break
        }
    }
    
    
    mutating func setFirstNumber(_ number : Double) {
        self.n1 = number
        self.n2 = nil
        self.symbolOperation = nil
    }

    //Float.ulpOfOne
    //Double.ulpOfOne
    // Menor valor possível de um número

    mutating func setSecondNumber(_ number : Double) {
        self.n2 = number
    }

    mutating func setSymbolOperation(_ symbol : String) {
        self.symbolOperation = symbol
    }
    
    mutating func clean() {
        if (res != nil) {
            cleanAll()
        }
        else if (n2 != nil) {
            n2 = nil
            res = nil
        }
        else {
            cleanAll()
        }
    }

    private mutating func cleanAll() {
        n1 = 0.0
        n2 = nil
        symbolOperation = nil
        res = nil
    }
    
    var isCleanAC : Bool {
        return symbolOperation != nil
    }

}
