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
}
