//
//  ExtensionTest.swift
//  SwiftTestes
//
//  Created by Aloc SP08608 on 27/11/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import XCTest

class NomeClasseSubscript {
    
    private var value = 1
    
    subscript (index : Int) -> Int {
        get {
            return value * index
        }
        set {
            value = newValue
        }
    }
    
    subscript (key : String, value : Int) -> Int {
        return (Int(key) ?? 1) * self.value * value
    }
    
    subscript (indexes: Int...) -> Int {
        var product = value
        for v in indexes {
            product *= v
        }
        return product
    }
    
    
}

class PropertObserver {
    
    init() {
        print("Inicializado \(PropertObserver.instanceCount)")
        PropertObserver.instanceCount += 1
    }
    
    static var instanceCount = 0
    lazy var instance = PropertObserver()
    

    var test = 0
    var value = 0 {
        
        willSet  {
            print("Setting +1 on willSet")
            test += 1
        }
        
        didSet {
            print("Settion +2 on didSet")
            test += 2
        }
        
    }
    
}

class ExtensionTest: XCTestCase {

    func testObserver() {
        let obs = PropertObserver()
        obs.value = 1
    }
    
    func testLazyInstanciate() {
        let v = PropertObserver()
        print(v.instance)
    }
    
    func testOperatorAsFunction() {
        func arithmetic(v1 : Double, v2 : Double, op : ((Double, Double) -> Double)) -> Double {
            return op(v1, v2)
        }

        XCTAssertEqual(4, arithmetic(v1: 2, v2: 2, op: + ))
        XCTAssertEqual(4, arithmetic(v1: 6, v2: 2, op: - ))
        XCTAssertEqual(3, arithmetic(v1: 6, v2: 2, op: / ))
        XCTAssertEqual(12, arithmetic(v1: 6, v2: 2, op: * ))

    }
    
    func testSubscript() {
        XCTAssertEqual(4, NomeClasseSubscript()[4])
        XCTAssertEqual(256, NomeClasseSubscript()[2,2,2,2,2,2,2,2])
        XCTAssertEqual(4, NomeClasseSubscript()["2", 2])
        
        var xx = NomeClasseSubscript()
        print(xx["2", 2])
    }
}





