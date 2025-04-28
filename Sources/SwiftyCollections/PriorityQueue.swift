//
//  PriorityQueue.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 28/4/25.
//

import Foundation

public struct PriorityQueue<Element: Comparable> {
    private var heap: Heap<Element>
    private let order: (Element, Element) -> Bool
    
    public var isEmpty: Bool {
        heap.isEmpty
    }
    
    public var count: Int {
        heap.count
    }
    
    public var peak: Element? {
        heap.peek()
    }
    
    public init(ascending: Bool = true) {
        self.order = ascending ? (<) : (>)
        self.heap = Heap(order: order)
    }
    
    public mutating func enqueue(_ element: Element) {
        heap.insert(element)
    }
    
    @discardableResult
    public mutating func dequeue() -> Element? {
        heap.remove()
    }
}
