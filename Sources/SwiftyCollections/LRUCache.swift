//
//  LRUCache.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 6/5/25.
//

public final class LRUCache<Key: Hashable, Value> {
    private typealias Entry = (key: Key, value: Value)

    private var capacity: Int = 0
    private var dict: [Key: DoublyLinkedList<Entry>.Node] = [:]
    private var list = DoublyLinkedList<Entry>()
    
    public init(capacity: Int) {
        self.capacity = capacity
    }
    
    public func get(_ key: Key) -> Value? {
        guard let node = dict[key] else { return nil }
        list.moveToFront(node)
        return node.value.value
    }
    
    public func put(_ key: Key, _ value: Value) {
        if let node = dict[key] {
            node.value = (key, value)
            list.moveToFront(node)
            return
        }
        
        if dict.count >= capacity {
            if let last = list.removeLast() {
                dict.removeValue(forKey: last.key)
            }
        }
        
        let node = list.prepend((key, value))
        dict[key] = node
    }
}
