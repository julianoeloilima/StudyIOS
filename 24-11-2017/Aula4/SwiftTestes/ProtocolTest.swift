//
//  ProtocolTest.swift
//  SwiftTestes
//
//  Created by Aloc SP08608 on 27/11/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import XCTest


// Definição de Interface

protocol Geometry {
    
    static var cornes : Double { get }
    var x: Double { get set }
    var y: Double { get set }
    
    func area () -> Double
    
    mutating func translate(_ dx : Double, _ dy : Double)
    
    static func new(from point : CGPoint) -> Geometry
}

class Rect: Geometry {
    static func new(from point: CGPoint) -> Geometry {
        return Rect(x: Double(point.x), y: Double(point.y))
    }
    
    static var cornes : Double {
        get { return 4 }
    }
    
    var x : Double
    var y : Double
    var width : Double
    var heigth : Double
    
    init(x : Double, y : Double, width : Double, heigth : Double) {
        self.x = x
        self.y = y
        self.width = width
        self.heigth = heigth
    }

    convenience init(x : Double, y : Double) {
        self.init(x : x, y : y, width: 1, heigth: 1)
    }

    func area() -> Double {
        return self.width * self.heigth
    }
    
    func translate(_ dx: Double, _ dy: Double) {
        self.x += dx
        self.y += dy
    }
}

struct Circle : Geometry {
    static var cornes: Double {
        return Double.infinity
    }
    
    var radius : Double
    var x: Double
    var y: Double
    
    func area() -> Double {
        return radius * radius * Double.pi
    }
    
    mutating func translate(_ dx: Double, _ dy: Double) {
        self.x += dx
        self.y += dy
    }
    
    static func new(from point: CGPoint) -> Geometry {
        return Circle(radius: 1, x: Double(point.x), y: Double(point.y))
    }
    
    
}

extension CGPoint : Geometry {
    static var cornes: Double {
        return 0
    }
    
    var x: Double {
        get {
            return self.x
        }
        set {
            self.x = newValue
        }
    }
    
    var y: Double {
        get {
            return self.y
        }
        set {
            self.y = newValue
        }
    }
    
    func area() -> Double {
        return Double.nan
    }
    
    mutating func translate(_ dx: Double, _ dy: Double) {
        self.x += dx
        self.y += dy
    }
    
    static func new(from point: CGPoint) -> Geometry {
        return point
    }
}



class ProtocolTest: XCTestCase {
    
    func testInstance() {
        let rect = Rect(x: 10, y: 20, width: 10, heigth: 10)
        let circle = Circle(radius: 10, x: 2, y: 9)
        XCTAssertEqual(rect.area(), 100)
        XCTAssertEqual(circle.area(), 100 * Double.pi)
        
        XCTAssert(rect is Geometry)
        XCTAssert(circle is Geometry)
    }
}

