//
//  MemoryTests.swift
//  SwiftTestes
//
//  Created by Aloc SP08608 on 28/11/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import XCTest

class A {
    
    var refB : B? = nil
    var refC : C? = nil
    
    deinit {
        print("A morreu!!!")
    }

}

class B {

    weak var refA : A? = nil
    
    deinit {
        print("B morreu!!!")
    }

}

class C {

    unowned private var refA : A = A()
    
    deinit {
        print("C morreu!!!")
    }

}


class MemoryTests: XCTestCase {
    
    func testARC() {
        var a1 : A? = A()
        var a2 : A? = a1
        var a3 : A? = a1
        
        a1 = nil
        a2 = nil
        a3 = nil

        
    }

    func testDeallocation() {
        var a : A? = A()
        var b : B? = B()
        
        a?.refB = b
        b?.refA = a
        
        a = nil
        b = nil
        
        
    }

}
