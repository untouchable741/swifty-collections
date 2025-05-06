//
//  GraphTests.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 6/5/25.
//

import XCTest
@testable import SwiftyCollections

final class GraphTests: XCTestCase {
    
    func testUndirectedEdgeInsertion() {
        var graph = Graph<String>()
        graph.addEdge(from: "A", to: "B") // default: undirected
        graph.addEdge(from: "A", to: "C")
        
        XCTAssertTrue(graph.hasEdge(from: "A", to: "B"))
        XCTAssertTrue(graph.hasEdge(from: "B", to: "A")) // undirected
        XCTAssertTrue(graph.hasEdge(from: "A", to: "C"))
        XCTAssertTrue(graph.hasEdge(from: "C", to: "A"))
        XCTAssertFalse(graph.hasEdge(from: "B", to: "C"))
    }
    
    func testDirectedEdgeInsertion() {
        var graph = Graph<String>()
        graph.addEdge(from: "X", to: "Y", directed: true)
        
        XCTAssertTrue(graph.hasEdge(from: "X", to: "Y"))
        XCTAssertFalse(graph.hasEdge(from: "Y", to: "X")) // directed
    }
    
    func testNeighborLookup() {
        var graph = Graph<String>()
        graph.addEdge(from: "A", to: "B")
        graph.addEdge(from: "A", to: "C")
        
        let neighbors = graph.neighbors(of: "A")
        XCTAssertTrue(neighbors.contains("B"))
        XCTAssertTrue(neighbors.contains("C"))
        XCTAssertFalse(neighbors.contains("D"))
    }
    
    func testAllNodes() {
        var graph = Graph<String>()
        graph.addEdge(from: "A", to: "B")
        graph.addEdge(from: "C", to: "D", directed: true)
        
        let all = graph.nodes
        XCTAssertTrue(all.contains("A"))
        XCTAssertTrue(all.contains("B"))
        XCTAssertTrue(all.contains("C"))
        XCTAssertTrue(all.contains("D"))
        XCTAssertEqual(all.count, 4)
    }
    
    func testMultipleEdgesFromSameNode() {
        var graph = Graph<String>()
        graph.addEdge(from: "A", to: "B")
        graph.addEdge(from: "A", to: "C")
        graph.addEdge(from: "A", to: "D")
        
        let neighbors = Set(graph.neighbors(of: "A"))
        XCTAssertEqual(neighbors, ["B", "C", "D"])
    }
    
    func makeSampleGraph() -> Graph<String> {
        var graph = Graph<String>()
        graph.addEdge(from: "A", to: "B")
        graph.addEdge(from: "A", to: "C")
        graph.addEdge(from: "B", to: "D")
        graph.addEdge(from: "C", to: "E")
        graph.addEdge(from: "D", to: "F")
        return graph
    }
    
    func testDFSOrder() {
        let graph = makeSampleGraph()
        var visited: [String] = []
        
        graph.dfs(from: "A") { visited.append($0) }
        
        // Since DFS is recursive, multiple valid orders exist.
        // So we test for full coverage, not strict sequence.
        XCTAssertEqual(Set(visited), Set(["A", "B", "C", "D", "E", "F"]))
        XCTAssertEqual(visited.first, "A") // DFS always starts from A
    }
    
    func testBFSOrder() {
        var graph = Graph<String>()
        graph.addEdge(from: "A", to: "B")
        graph.addEdge(from: "A", to: "C")
        graph.addEdge(from: "B", to: "D")
        graph.addEdge(from: "C", to: "E")
        graph.addEdge(from: "E", to: "F")
        
        var visited: [String] = []
        graph.bfs(from: "A") { visited.append($0) }
        let expectedSet: Set = ["A", "B", "C", "D", "E", "F"]
        XCTAssertEqual(Set(visited), expectedSet)
    }
    
    func testDFSFromLeaf() {
        let graph = makeSampleGraph()
        var visited: [String] = []
        
        graph.dfs(from: "F") { visited.append($0) }
        
        XCTAssertTrue(visited.contains("F"))
        XCTAssertTrue(visited.count > 1) // DFS spreads through the graph
    }
    
    func testBFSFromIsolatedNode() {
        var graph = makeSampleGraph()
        graph.addNode("Z") // Disconnected
        var visited: [String] = []
        
        graph.bfs(from: "Z") { visited.append($0) }
        
        XCTAssertEqual(visited, ["Z"])
    }
    
    func testDFSPartialGraph() {
        var graph = Graph<String>()
        graph.addEdge(from: "A", to: "B", directed: true)
        graph.addEdge(from: "B", to: "D", directed: true)
        graph.addEdge(from: "D", to: "F", directed: true)
        graph.addEdge(from: "A", to: "C", directed: true)
        graph.addEdge(from: "C", to: "E", directed: true)
        var visited: [String] = []
        
        graph.dfs(from: "B") { visited.append($0) }
        
        XCTAssertTrue(visited.contains("B"))
        XCTAssertTrue(visited.contains("D"))
        XCTAssertTrue(visited.contains("F"))
        XCTAssertFalse(visited.contains("C"))
    }
}
