//
//  Stack.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 27/4/25.
//

/// A generic stack (Last-In-First-Out collection).
public struct Stack<Element> {
    
    private var array: [Element] = []
    
    public var isEmpty: Bool {
        array.isEmpty
    }
    
    public var count: Int {
        array.count
    }
    
    public var top: Element? {
        array.last
    }
    
    public mutating func push(_ element: Element) {
        array.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> Element? {
        guard !isEmpty else { return nil }
        return array.removeLast()
    }
}
