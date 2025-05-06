//
//  Trie.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 6/5/25.
//

//(root)
//  ├── c
//  │   └── a
//  │       ├── t  (isWord ✅)
//  │       └── r  (isWord ✅)
//  └── d
//      └── o
//          └── g  (isWord ✅)

public final class Trie {
    private final class Node {
        var isWord: Bool = false
        var children: [Character: Node] = [:]
    }
    
    private let root = Node()
    
    public init() {}
    
    public func insert(_ word: String) {
        var current = root
        for char in word {
            if current.children[char] == nil {
                current.children[char] = Node()
            }
            current = current.children[char]!
        }
        current.isWord = true
    }
    
    public func contains(_ word: String) -> Bool {
        guard let node = findNode(word) else {
            return false
        }
        
        return node.isWord
    }
    
    public func starts(with prefix: String) -> Bool {
        return findNode(prefix) != nil
    }
    
    private func findNode(_ str: String) -> Node? {
        var current = root
        for char in str {
            guard let next = current.children[char] else {
                return nil
            }   
            current = next
        }
        return current
    }
}
