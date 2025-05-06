//
//  DoublyLinkedList.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 28/4/25.
//

public struct DoublyLinkedList<Element> {
    public class Node {
        var value: Element
        var next: Node?
        weak var previous: Node?
        
        init(value: Element) {
            self.value = value
        }
    }
    private var head: Node?
    private var tail: Node?
    private(set) public var count: Int = 0
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public var front: Element? {
        head?.value
    }
    
    public var back: Element? {
        tail?.value
    }
    
    public mutating func prepend(_ element: Element) -> Node {
        let newNode = Node(value: element)
        if let headNode = head {
            newNode.next = headNode
            headNode.previous = newNode
        } else {
            tail = newNode
        }
        head = newNode
        count += 1
        return newNode
    }
    
    public mutating func append(_ element: Element) {
        let newNode = Node(value: element)
        if let tailNode = tail {
            tailNode.next = newNode
            newNode.previous = tailNode
        } else {
            head = newNode
        }
        tail = newNode
        count += 1
    }
    
    @discardableResult
    public mutating func removeFirst() -> Element? {
        guard let headNode = head else { return nil }
        let value = headNode.value
        head = headNode.next
        head?.previous = nil
        if head == nil {
            tail = nil
        }
        count -= 1
        return value
    }
    
    @discardableResult
    public mutating func removeLast() -> Element? {
        guard let tailNode = tail else { return nil }
        let value = tailNode.value
        tail = tailNode.previous
        tailNode.next = nil
        if tail == nil {
            head = nil
        }
        count -= 1
        return value
    }
    
    mutating func moveToFront(_ node: Node) {
        if node === head { return }
        
        if let prev = node.previous {
            prev.next = node.next
        }
        
        if let next = node.next {
            next.previous = node.previous
        }
        
        if node === tail {
            tail = node.previous
        }
        
        node.previous = nil
        node.next = head
        head?.previous = node
        head = node
        
        if tail == nil {
            tail = head
        }
    }
}
