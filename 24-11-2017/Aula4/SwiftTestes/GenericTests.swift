//
//  GenericTests.swift
//  SwiftTestes
//
//  Created by Aloc SP08608 on 27/11/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import XCTest

protocol ArrayDataStructure {
    associatedtype T
    var items : [T] { get }
}

class Stack<T> : ArrayDataStructure {

    var items : [T] = [T]()
    
    init(items : [T]) {
        self.items = items
    }
    
    func push(item : T) {
        self.items.append(item)
    }
    
    func pop() -> T? {
        guard !items.isEmpty else {
            return nil
        }
        return self.items.removeLast()
    }
    
    var peek : T? {
        return self.items.last
    }

}

class GenericTests: XCTestCase {
    
    func testGenericsUsage() {
        let _ = [Int]()
        let _ = Array<Int>()
        
        let _ = [Int:Int]()
        let _ = Dictionary<Int, Int>()
        
        let _ :Int?
        let _ :Optional<Int>
        
        let stack = Stack(items: [1,2,3])
        stack.push(item: 5)
        XCTAssertEqual(5, stack.pop())
        XCTAssertEqual(3, stack.peek)
    }
    
    
}
