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
    case openAddressing
}

public struct SwiftySet<Element: Hashable> {
    private var elements: [Element] // Used only for .linear
    private var buckets: [[Element]]? // Used only for .chaining
    private var slots: [Slot<Element>] // Used only for .openAddressing
    
    private var strategy: HashingStrategy
    private var capacity: Int
    private let maxLoadFactor: Double = 0.75
    
    public init(strategy: HashingStrategy = .chaining, initialCapacity: Int = 16) {
        self.strategy = strategy
        self.capacity = initialCapacity
        switch strategy {
        case .linear:
            self.elements = []
            self.buckets = nil
            self.slots = []
        case .chaining:
            self.elements = []
            self.buckets = Array(repeating: [], count: initialCapacity)
            self.slots = []
        case .openAddressing:
            self.elements = []
            self.buckets = nil
            self.slots = Array(repeating: .empty, count: initialCapacity)
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
        case .openAddressing:
            return slots.filter {
                if case .occupied = $0 { return true }
                return false
            }.count
        }
    }
    
    
    public func contains(_ element: Element) -> Bool {
        switch strategy {
        case .linear:
            return elements.contains(element)
        case .chaining:
            return containsChaining(element)
        case .openAddressing:
            return containsOpenAddressing(element)
        }
    }
    
    @discardableResult
    public mutating func insert(_ newElement: Element) -> Bool {
        switch strategy {
        case .linear:
            return insertLinear(newElement)
        case .chaining:
            return insertChaining(newElement)
        case .openAddressing:
            return insertOpenAddressing(newElement)
        }
    }
    
    @discardableResult
    public mutating func remove(_ element: Element) -> Bool {
        switch strategy {
        case .linear:
            return removeLinear(element)
        case .chaining:
            return removeChaining(element)
        case .openAddressing:
            return removeOpenAddressing(element)
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

// Open Addressing
private extension SwiftySet {
    private enum Slot<Value: Hashable> {
        case occupied(Value)
        case empty
        case tombstone
        
        var element: Value? {
            if case .occupied(let value) = self {
                return value
            } else {
                return nil
            }
        }
    }
    
    private mutating func insertOpenAddressing(_ element: Element) -> Bool {
        if needsResizeOpenAddressing() {
            resizeOpenAddressing()
        }
        
        var index = abs(element.hashValue) % slots.count
        let originalIndex = index
        
        repeat {
            switch slots[index] {
            case .empty, .tombstone:
                slots[index] = .occupied(element)
                return true
            case .occupied(let existing):
                if existing == element { return false } // Already exist
            }
            index = (index + 1) % slots.count
        } while index != originalIndex
        
        return false // Full slots (shouldn't happen after resize)
    }
    
    private func containsOpenAddressing(_ element: Element) -> Bool {
        var index = abs(element.hashValue) % slots.count
        let originalIndex = index
        
        repeat {
            switch slots[index] {
            case .empty:
                return false
            case .occupied(let existing):
                if existing == element { return true }
            case .tombstone:
                break
            }
            index = (index + 1) % slots.count
        } while index != originalIndex
        
        return false
    }
    
    mutating func removeOpenAddressing(_ element: Element) -> Bool {
        var index = abs(element.hashValue) % slots.count
        let originalIndex = index
        
        repeat {
            switch slots[index] {
            case .empty:
                return false
            case .occupied(let existing):
                if existing == element {
                    slots[index] = .tombstone
                    return true
                }
            case .tombstone:
                break
            }
            index = (index + 1) % slots.count
        } while index != originalIndex
        
        return false
    }
    
    
    private mutating func resizeOpenAddressing() {
        let oldSlots = slots
        slots = Array(repeating: .empty, count: slots.count * 2)
        for slot in oldSlots {
            if case .occupied(let element) = slot {
                _ = insertOpenAddressing(element) // Reinsert with new hash
            }
        }
    }
    
    private func loadFactorOpenAddressing() -> Double {
        let activeCount = slots.filter {
            if case .occupied = $0 { return true }
            return false
        }.count
        return Double(activeCount) / Double(slots.count)
    }
    
    private func needsResizeOpenAddressing() -> Bool {
        return loadFactorOpenAddressing() > maxLoadFactor
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
