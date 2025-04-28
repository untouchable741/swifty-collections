//
//  SwiftySet.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 28/4/25.
//

import Foundation

public enum HashingStrategy {
    case linear
    case chaining
    //    case openAddressing
}

public struct SwiftySet<Element: Hashable> {
    private var elements: [Element] // Used only for .linear
    private var buckets: [[Element]]? // Used only for .chaining
    private var strategy: HashingStrategy
    private var capacity: Int
    private let maxLoadFactor: Double = 0.75
    
    public init(strategy: HashingStrategy = .chaining, initialCapacity: Int = 16) {
        self.strategy = strategy
        self.capacity = initialCapacity
        self.elements = []
        if strategy == .linear {
            self.elements = []
            self.buckets = nil
        } else {
            self.elements = []
            self.buckets = Array(repeating: [], count: initialCapacity)
        }
    }
    
    public var isEmpty: Bool {
        count == 0
    }
    
    public var count: Int {
        switch strategy {
        case .linear:
            return elements.count
        case .chaining:
            return buckets?.reduce(0) { $0 + $1.count } ?? 0
        }
    }
    
    
    public func contains(_ element: Element) -> Bool {
        switch strategy {
        case .linear:
            return elements.contains(element)
        case .chaining:
            return containsChaining(element)
        }
    }
    
    @discardableResult
    public mutating func insert(_ newElement: Element) -> Bool {
        switch strategy {
        case .linear:
            return insertLinear(newElement)
        case .chaining:
            return insertChaining(newElement)
        }
    }
    
    @discardableResult
    public mutating func remove(_ element: Element) -> Bool {
        switch strategy {
        case .linear:
            return removeLinear(element)
        case .chaining:
            return removeChaining(element)
        }
    }
}

// Linear strategy
private extension SwiftySet {
    private mutating func insertLinear(_ element: Element) -> Bool {
        if elements.contains(element) { return false }
        elements.append(element)
        return true
    }
    
    private mutating func removeLinear(_ element: Element) -> Bool {
        if let index = elements.firstIndex(of: element) {
            elements.remove(at: index)
            return true
        }
        return false
    }
    
}

// Chaining strategy
private extension SwiftySet {
    private mutating func insertChaining(_ element: Element) -> Bool {
        guard buckets != nil else { return false }
        
        if needsResize() {
            resize()
        }
        let index = abs(element.hashValue) % capacity
        if self.buckets![index].contains(element) {
            return false
        }
        self.buckets![index].append(element)
        return true
    }
    
    private mutating func removeChaining(_ element: Element) -> Bool {
        guard buckets != nil else { return false }
        let index = abs(element.hashValue) % capacity
        if let idx = self.buckets![index].firstIndex(of: element) {
            self.buckets![index].remove(at: idx)
            return true
        }
        return false
    }
    
    private func containsChaining(_ element: Element) -> Bool {
        guard let buckets = buckets else { return false }
        let index = abs(element.hashValue) % capacity
        return buckets[index].contains(element)
    }
}

// Resizing
private extension SwiftySet {
    private func needsResize() -> Bool {
        guard let buckets = buckets else { return false }
        return Double(count) / Double(buckets.count) > maxLoadFactor
    }
    
    private mutating func resize() {
        guard strategy == .chaining else { return }
        guard let oldBuckets = buckets else { return }
        
        capacity *= 2
        buckets = Array(repeating: [], count: capacity)
        
        for bucket in oldBuckets {
            for element in bucket {
                let index = abs(element.hashValue) % capacity
                buckets![index].append(element)
            }
        }
    }
}
