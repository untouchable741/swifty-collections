//
//  LinkedList.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 28/4/25.
//

import Foundation

private class Node<Element> {
    var value: Element
    var next: Node?
    
    init(value: Element) {
        self.value = value
    }
}

public struct LinkedList<Element> {
    private var head: Node<Element>?
    private var tail: Node<Element>?
    private(set) public var count: Int = 0
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public var first: Element? {
        head?.value
    }
    
    public mutating func append(_ value: Element) {
        let newNode = Node(value: value)
        if let tailNode = tail {
            tailNode.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
        count += 1
    }
    
    public mutating func prepend(_ value: Element) {
        let newNode = Node(value: value)
        newNode.next = head
        head = newNode
        if tail == nil {
            tail = head
        }
        count += 1
    }
    
    @discardableResult
    public mutating func removeFirst() -> Element? {
        guard let headNode = head else { return nil }
        head = headNode.next
        if head == nil {
            tail = nil
        }
        count -= 1
        return headNode.value
    }
    
    @discardableResult
    public mutating func removeLast() -> Element? {
        guard let headNode = head else { return nil }
        
        if headNode.next == nil {
            let value = headNode.value
            head = nil
            tail = nil
            count = 0
            return value
        }
        
        var current = headNode
        while let next = current.next, next.next != nil {
            current = next
        }
        
        let value = current.next?.value
        current.next = nil
        tail = current
        count -= 1
        return value
    }
}
