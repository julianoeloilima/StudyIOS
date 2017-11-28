//: Playground - noun: a place where people can play

import UIKit

class LLNode<T: Equatable> {

    var value : T!
    var next : LLNode<T>!
    var prior : LLNode<T>!
}



class LinkedList<T: Equatable> {
    
    private var headNode : LLNode<T>!
    private var lastNode : LLNode<T>!
    
    init() {
        headNode = nil
        lastNode = nil
    }
    
    init!(_ values: Array<T>) {
        if values.count == 0 {
            return nil
        }
        for value in values {
            insert(value)
        }
    }
    
    func insert(_ value : T){
        if (headNode == nil){
            headNode = LLNode<T>()
            headNode.prior = nil
            headNode.value = value
            headNode.next = nil
            lastNode = headNode
        }
        else {
            let newNode = LLNode<T>()
            newNode.next = nil
            newNode.prior = lastNode
            newNode.value = value
            
            lastNode.next = newNode
            lastNode = newNode
        }
    }

    var last : T? {
        get {
            if let l = lastNode {
                return l.value
            }
            return nil
        }
    }

    var first : T? {
        get {
            if let h = headNode {
                return h.value
            }
            return nil
        }
    }
    
    var pennultimate : T? {
        get {
            if lastNode != nil && lastNode.prior != nil {
                return lastNode.prior.value
            }
            return nil
        }
    }

    var length : Int {
        get {
            var count = 0
            var node = headNode
            while (node != nil) {
                count += 1
                node = node?.next
            }
            return count
        }
    }

    var reverse : LinkedList<T> {
        get {
            let rev = LinkedList<T>()
            var node = lastNode
            while (node != nil) {
                rev.insert(node!.value)
                node = node?.prior
            }
            return rev
        }
    }


    func get(index : Int) -> T? {
        if index > -1 {
            var i = 0
            var node = headNode
            while (node != nil && i < index) {
                i += 1
                node = node?.next
            }
            return node?.value
        }
        return nil
    }
    
    func isPalindrome() -> Bool {
        var start = headNode
        var finish = lastNode

        if start == nil {
            return false
        }
        
        while start !== finish {
            start?.value
            if !(start?.value == finish?.value) {
                return false
            }
            start = start?.next
            finish = finish?.prior
        }
        return true
    }

    func compress() -> LinkedList<T> {
        let comp = LinkedList<T>()
        var node = headNode
        var value : T?
        if node != nil {
            value = node!.value
            comp.insert(value!)
            node = node!.next
        }
        
        while node != nil {
            if node?.value != value! {
                value = node!.value
                comp.insert(value!)
            }
            node = node?.next
        }
        return comp
    }
    
    func duplicate() -> LinkedList<T> {
        return duplicate(times: 2)
    }

    func duplicate(times : UInt) -> LinkedList<T> {
        let dup = LinkedList<T>()
        var node = headNode
        while node != nil {
            var t = 0
            while t < times {
                dup.insert(node!.value)
                t += 1
            }
            node = node!.next
        }
        return dup
    }
    
    func drop(index : UInt) -> LinkedList<T> {
        let newList = LinkedList<T>()
        var node = headNode
        var i = 0
        while node != nil {
            if i != index {
                newList.insert(node!.value)
            }
            node = node!.next
            i += 1
        }
        return newList
    }

    func split(index : UInt) -> (LinkedList<T>, LinkedList<T>) {
        let firstList = LinkedList<T>()
        let lastList = LinkedList<T>()
    
        var node = headNode
        var i = 0
        while node != nil {
            if i <= index {
                firstList.insert(node!.value)
            }
            else {
                lastList.insert(node!.value)
            }
            node = node!.next
            i += 1
        }
        return (firstList, lastList)
    }

    func slice(startIndex : UInt, endIndexExcluded : UInt) -> LinkedList<T> {
        let newList = LinkedList<T>()
        var node = headNode
        var i = 0
        
        while i < startIndex && node != nil {
            i += 1
            node = node?.next
        }
        
        while i < endIndexExcluded && node != nil {
            newList.insert(node!.value)
            i += 1
            node = node?.next
        }
        
        return newList
    }
    
    
}


//var numbers : Array[Int] = [4,6,8]
//var list = LinkedList(numbers)

var list = LinkedList<Int>()
list.insert(2)
//list.insert(0)
list.insert(3)
//list.insert(0)
list.insert(4)

list.first

list.drop(index: 1).length


// 01 - Ok
list.last

// 02 - Ok
list.pennultimate

// 03 - Ok
list.get(index: 2)

// 04 - Ok
list.length

// 05 - Ok
list.reverse.first
list.reverse.last

// 06 - Ok
list.isPalindrome()

//XXXXXXX - 07 - NOk

// 08 - Ok
list.compress().first
list.compress().last
list.compress().pennultimate

//XXXXXXX - 09 - NOk

// 14 - Ok
list.duplicate().length

// 14 - Ok
list.duplicate(times: 3).length


var count = 0
for _ in stride(from: 1, to: 2.5, by: 0.5) {
    count += 1
}

for i in 0 ..< list.length {
    list.get(index: i)
}

print("Qtde iterações: \(count)")
