//
//  CalculadoraManager.swift
//  Calculator
//
//  Created by Aloc SP08608 on 22/11/2017.
//  Copyright © 2017 CINQ. All rights reserved.
//

import Foundation

struct CalculadorManager {
    
    enum Operation {
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
        case unknow
    }
    
    private struct PreviousBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand : Double
        func perform(with secondOperand:Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    private var accumulator : Double = 0.0
    private var binaryOperationMemory : PreviousBinaryOperation?
    private let operations = [
        "+" : Operation.binaryOperation({ $0 + $1 }),
        "-" : Operation.binaryOperation({ $0 - $1 }),
        "⨉" : Operation.binaryOperation({ $0 * $1 }),
        "÷" : Operation.binaryOperation({ $0 / $1 }),
        "±" : Operation.unaryOperation({ -$0 }),
        "√" : Operation.unaryOperation(sqrt),
        "=" : Operation.equals
    ]
    
    var result : Double {
        get {
            return accumulator
        }
    }
    
    mutating func performOperation(_ symbol : String) {
        guard let operation = operations[symbol] else {
            return
        }

        switch operation {
        case .unaryOperation(let op):
            accumulator = op(accumulator)
        case .binaryOperation(let op):
            binaryOperationMemory = PreviousBinaryOperation(function: op, firstOperand: accumulator)
        case .equals:
            doPrevieusBinaryOperation()
        default:
            break
        }
        
    }

    mutating func doPrevieusBinaryOperation() {
        guard let memory = binaryOperationMemory else { return }
        accumulator = memory.perform(with: accumulator)
        self.binaryOperationMemory = nil
    }

    mutating func setOperand(_ operation : Double) {
        accumulator = operation
    }
    
}
