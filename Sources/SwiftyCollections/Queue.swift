//
//  Queue.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 28/4/25.
//

public struct Queue<Element> {
    private var array: [Element] = []
    
    public var isEmpty: Bool {
        array.isEmpty
    }
    
    public var count: Int {
        array.count
    }
    
    public var front: Element? {
        array.first
    }
    
    public mutating func enqueue(_ element: Element) {
        array.append(element)
    }
    
    @discardableResult
    public mutating func dequeue() -> Element? {
        guard !isEmpty else { return nil }
        return array.removeFirst()
    }
}
