//
//  ExtensionTest.swift
//  Aula4Tests
//
//  Created by Aloc SP08608 on 24/11/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import XCTest

extension Array {
    
    mutating func embaralhar() {

        let lastIndex : Int = self.count - 1
        let maxIndex = UInt32(self.count - 1)
        
        for i in 0...lastIndex  {
            let newIndex = Int(arc4random_uniform(maxIndex))
            swapAt(i, newIndex)
            
        }
    }
}

extension String {

    enum StringError : Error {
        case SubstringException(UInt, UInt, Int)
    }
    
    /*
    func substring(startIndex p1 : UInt, endIndex p2 : UInt) -> String? {
        guard p1 < self.count && p2 < self.count else {
            return nil
        }
        
        let d1 = String.IndexDistance(p1)
        let d2 = String.IndexDistance(p2)
        let i1 = self.index(self.startIndex, offsetBy: d1)
        let i2 = self.index(self.startIndex, offsetBy: d2)
        return String(self[i1..<i2])
    }
    */
    
    func substring(startIndex p1 : UInt, count p2 : UInt) throws -> String? {
        return try self.substring(startIndex: p1, endIndex: (p1 + p2))
    }

    func substring(startIndex p1 : UInt, endIndex p2 : UInt) throws -> String {
        guard p1 < self.count && p2 < self.count else {
            throw StringError.SubstringException(p1, p2, self.count)
        }
        
        let d1 = String.IndexDistance(p1)
        let d2 = String.IndexDistance(p2)
        let i1 = self.index(self.startIndex, offsetBy: d1)
        let i2 = self.index(self.startIndex, offsetBy: d2)
        return String(self[i1..<i2])
    }

    static func substring(_ str : String, startIndex p1 : UInt, endIndex p2 : UInt) throws -> String {
        guard p1 < str.count && p2 < str.count else {
            throw StringError.SubstringException(p1, p2, str.count)
        }
        
        let d1 = String.IndexDistance(p1)
        let d2 = String.IndexDistance(p2)
        let i1 = str.index(str.startIndex, offsetBy: d1)
        let i2 = str.index(str.startIndex, offsetBy: d2)
        return String(str[i1..<i2])
    }

    
}

class ExtensionTest: XCTestCase {
    
    func testeSubstring() {
        //XCTAssertEqual("234", "012345".substring(startIndex: 2, endIndex : 5))
        //XCTAssertEqual("234", "012345".substring(startIndex: 15, endIndex: 20))
        //XCTAssertEqual("234", "012345".substring(startIndex: 2, count: 3)!)
    }

    func testeException() {
        let str = "ABCDEF"

        do {
            let result : String = try str.substring(startIndex: 2, endIndex: 3)
            print(result)
        } catch String.StringError.SubstringException(let startIndex, let endIndex, let count) {
            XCTFail("Range [\(startIndex), \(endIndex)] ⊄ [0, \(count)]")
        } catch {
            XCTFail("Sem Exception")
        }
    }

    func testeStaticException() {
        let str = "012345"
        
        do {
            let result : String = try String.substring(str, startIndex: 2, endIndex: 5)
            print(result)
        } catch String.StringError.SubstringException(let startIndex, let endIndex, let count) {
            XCTFail("Range [\(startIndex), \(endIndex)] ⊄ [0, \(count)]")
        } catch {
            XCTFail("Sem Exception")
        }
    }
    
    func embaralharArray() {
        var array = [1,2,3,4,5,6,7,8,9]
        print(array)
        array.embaralhar()
        print(array)
        XCTAssert(true)
    }

}
