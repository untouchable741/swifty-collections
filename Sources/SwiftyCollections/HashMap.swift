//
//  HashMap.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 6/5/25.
//

struct HashTable<Key: Hashable, Value> {
    private var buckets: [[(Key, Value)]]
    private(set) var count = 0
    private let maxLoadFactor = 0.75
    
    init(capacity: Int = 16) {
        buckets = Array(repeating: [], count: capacity)
    }
    
    mutating func insert(_ key: Key, _ value: Value) {
        let index = abs(key.hashValue) % buckets.count
        
        for i in 0..<buckets[index].count {
            if buckets[index][i].0 == key {
                buckets[index][i].1 = value
                return
            }
        }
        
        buckets[index].append((key, value))
        count += 1
        
        if Double(count) / Double(buckets.count) > maxLoadFactor {
            // Resize
        }
    }
    
    func get(_ key: Key) -> Value? {
        let index = abs(key.hashValue) % buckets.count
        return buckets[index].first { $0.0 == key }?.1
    }
    
    mutating func remove(_ key: Key) -> Bool {
        let index = abs(key.hashValue) % buckets.count
        if let i = buckets[index].firstIndex(where: { $0.0 == key }) {
            buckets[index].remove(at: i)
            count -= 1
            return true
        }
        return false
    }
    
    private mutating func resize() {
        let oldBuckets = buckets
        buckets = Array(repeating: [], count: oldBuckets.count * 2)
        count = 0
        
        for bucket in oldBuckets {
            for (k, v) in bucket {
                insert(k, v)
            }
        }
    }
}

public struct HashMap<Key: Hashable, Value> {
    private var table = HashTable<Key, Value>()
    public var count: Int { table.count }
    
    public mutating func put(key: Key, value: Value) {
        table.insert(key, value)
    }
    
    public func get(key: Key) -> Value? {
        table.get(key)
    }
    
    public mutating func remove(key: Key) -> Bool {
        table.remove(key)
    }
    
    public func contains(key: Key) -> Bool {
        return get(key: key) != nil
    }
    
    public subscript (key: Key) -> Value? {
        get {
            return get(key: key)
        } set {
            if let value = newValue {
                put(key: key, value: value)
            } else {
                _ = remove(key: key)
            }
        }
    }
}
