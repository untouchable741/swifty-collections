//
//  Graph.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 6/5/25.
//


public struct Graph<Node: Hashable> {
    private var adjacencyList: [Node: Set<Node>] = [:]
    
    public init() { }
    
    public mutating func addEdge(from: Node, to: Node, directed: Bool = false) {
        // Ensure both node are registered
        // Register `from` node
        if adjacencyList[from] == nil {
            adjacencyList[from] = []
        }
        // Register `to` node
        if adjacencyList[to] == nil {
            adjacencyList[to] = []
        }
        adjacencyList[from]?.insert(to)
        
        if !directed {
            adjacencyList[to, default: []].insert(from)
        }
    }
    
    public func neighbors(of node: Node) -> [Node] {
        return Array(adjacencyList[node] ?? [])
    }
    
    public var nodes: [Node] {
        return Array(adjacencyList.keys)
    }
    
    public func hasEdge(from: Node, to: Node) -> Bool {
        return adjacencyList[from]?.contains(to) ?? false
    }
}
