//
//  Heap.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 27/4/25.
//

import Foundation

public struct Heap<Element> {
    private var elements: [Element] = []
    private let order: (Element, Element) -> Bool
    
    public init(order: @escaping (Element, Element) -> Bool) {
        self.elements = []
        self.order = order
    }
    
    public var isEmpty: Bool {
        elements.isEmpty
    }
    
    public var count: Int {
        elements.count
    }
    
    public func peek() -> Element? {
        elements.first
    }
    
    public mutating func insert(_ element: Element) {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }
    
    @discardableResult
    public mutating func remove() -> Element? {
        guard !elements.isEmpty else { return nil }
        elements.swapAt(0, elements.count - 1)
        let removedElement = elements.removeLast()
        siftDown(from: 0)
        return removedElement
    }
    
    mutating private func siftDown(from index: Int) {
        var parentIndex = index
        while true {
            let leftChildIndex = leftChildIndex(of: parentIndex)
            let rightChildIndex = rightChildIndex(of: parentIndex)
            var candidateIndex = parentIndex
            
            if leftChildIndex < elements.count, order(elements[leftChildIndex], elements[candidateIndex]) {
                candidateIndex = leftChildIndex
            }
            
            if rightChildIndex < elements.count, order(elements[rightChildIndex], elements[candidateIndex]) {
                candidateIndex = rightChildIndex
            }
            
            if candidateIndex == parentIndex { return }
            elements.swapAt(parentIndex, candidateIndex)
            parentIndex = candidateIndex
        }
    }
    
    mutating private func siftUp(from index: Int) {
        var childIndex = index
        let child = elements[childIndex]
        var parentIndex = parentIndex(of: childIndex)
        while childIndex > 0 && order(child, elements[parentIndex]) {
            elements[childIndex] = elements[parentIndex]
            childIndex = parentIndex
            parentIndex = self.parentIndex(of: childIndex)
        }
        elements[childIndex] = child
    }
    
    private func parentIndex(of index: Int) -> Int {
        (index - 1) / 2
    }
    
    private func leftChildIndex(of index: Int) -> Int {
        2 * index + 1
    }
    
    private func rightChildIndex(of index: Int) -> Int {
        2 * index + 2
    }
}

public struct MinHeap<Element: Comparable> {
    private var heap: Heap<Element>
    public init() {
        self.heap = Heap(order: <)
    }
    
    public var isEmpty: Bool { heap.isEmpty }
    public var count: Int { heap.count }
    public func peek() -> Element? { heap.peek() }
    public mutating func insert(_ value: Element) { heap.insert(value) }
    @discardableResult
    public mutating func remove() -> Element? { heap.remove() }
}

public struct MaxHeap<Element: Comparable> {
    private var heap: Heap<Element>
    public init() {
        self.heap = Heap(order: >)
    }
    
    public var isEmpty: Bool { heap.isEmpty }
    public var count: Int { heap.count }
    public func peek() -> Element? { heap.peek() }
    public mutating func insert(_ value: Element) { heap.insert(value) }
    @discardableResult
    public mutating func remove() -> Element? { heap.remove() }
}
