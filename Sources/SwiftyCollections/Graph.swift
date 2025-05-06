//
//  Graph.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 6/5/25.
//


public struct Graph<Node: Hashable> {
    private var adjacencyList: [Node: Set<Node>] = [:]
    
    public init() { }
    
    public mutating func addNode(_ node: Node) {
        adjacencyList[node] = adjacencyList[node] ?? []
    }
    
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

// MARK: DFS Traversal
extension Graph {
    public func dfs(from start: Node, visit: (Node) -> Void) {
        var visited = Set<Node>()
        dfsHelper(start, &visited, visit)
    }
    
    private func dfsHelper(_ node: Node, _ visited: inout Set<Node>, _ visit: (Node) -> Void) {
        guard !visited.contains(node) else { return }
        
        visit(node)
        visited.insert(node)
        
        for neighbor in neighbors(of: node) {
            dfsHelper(neighbor, &visited, visit)
        }
    }
}

// MARK: BFS Traversal
extension Graph {
    public func bfs(from start: Node, visit: (Node) -> Void) {
        var visited = Set<Node>()
        var queue: [Node] = [start]
        
        while !queue.isEmpty {
            let current = queue.removeFirst()
            if visited.contains(current) { continue }
            
            visit(current)
            visited.insert(current)
            
            for neighbor in neighbors(of: current) where !visited.contains(neighbor){
                queue.append(neighbor)
            }
        }
    }
}
