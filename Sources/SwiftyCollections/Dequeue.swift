//
//  Dequeue.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 28/4/25.
//

import Foundation

public struct Dequeue<Element> {
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
    
    public var back: Element? {
        array.last
    }
    
    public mutating func appendFront(_ element: Element) {
        array.insert(element, at: 0)
    }
    
    public mutating func appendBack(_ element: Element) {
        array.append(element)
    }
    
    @discardableResult
    public mutating func removeFront() -> Element? {
        guard !isEmpty else { return nil }
        return array.removeFirst()
    }
    
    @discardableResult
    public mutating func removeBack() -> Element? {
        guard !isEmpty else { return nil }
        return array.removeLast()
    }
}
