//
//  OverloadTests.swift
//  SwiftTestes
//
//  Created by Aloc SP08608 on 27/11/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import XCTest

postfix operator -
infix operator ×
postfix operator ++

struct Vector2D {
    var x : Double
    var y : Double
    
    static func + (left: Vector2D, right : Vector2D) -> Vector2D {
            return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }

    static func == (left: Vector2D, right : Vector2D) -> Bool {
        return left.x == right.x && left.y == right.y
    }

    static func != (left: Vector2D, right : Vector2D) -> Bool {
        return !(left == right)
    }

    static func += (left: inout Vector2D, right : Vector2D) {
        left = (left + right)
    }

    static prefix func - (right : Vector2D) -> Vector2D {
        return Vector2D(x: -right.x, y: -right.y)
    }

    static postfix func - (left : Vector2D) -> Vector2D {
        return -left
    }
    
    static func × (left: Vector2D, rigth : Vector2D) -> Double {
        return left.x * rigth.x + left.y * rigth.y
    }
}

extension Int {
    
    static postfix func ++ (left: inout Int) -> Int {
        let temp = left
        left = (left + 1)
        return temp
    }

    static prefix func ++ (left : inout Int) -> Int {
        left = (left + 1)
        return left
    }

    
}

class OverloadTests: XCTestCase {
    
    func testVectorSum() {
        var result = Vector2D(x: 2, y: 2) + Vector2D(x: 3, y: 3)
        XCTAssert(result == Vector2D.init(x: 5, y: 5))
        XCTAssert(result != Vector2D.init(x: 8, y: 85))
        
        result += Vector2D(x: 3, y: 3)
        XCTAssert(result == Vector2D(x: 8, y: 8))
        XCTAssert(-result == result-)
        XCTAssert((Vector2D(x: 2, y: 2) × Vector2D(x: 2, y: 2)) == 8)
        
        var x = 3
        
        XCTAssert(++x == 4)
        XCTAssert(x++ == 4)
        XCTAssert(x == 5)

    }
    
}
