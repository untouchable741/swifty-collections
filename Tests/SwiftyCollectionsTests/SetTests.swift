//
//  SetTests.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 28/4/25.
//

import XCTest
@testable import SwiftyCollections

final class SetTests: XCTestCase {

    func testInsertAndContainsLinear() {
        var set = SwiftySet<Int>(strategy: .linear)

        XCTAssertTrue(set.insert(1))
        XCTAssertTrue(set.insert(2))
        XCTAssertTrue(set.insert(3))

        XCTAssertTrue(set.contains(1))
        XCTAssertTrue(set.contains(2))
        XCTAssertTrue(set.contains(3))
        XCTAssertFalse(set.contains(4))
    }

    func testInsertAndContainsChaining() {
        var set = SwiftySet<Int>(strategy: .chaining)

        XCTAssertTrue(set.insert(10))
        XCTAssertTrue(set.insert(20))
        XCTAssertTrue(set.insert(30))

        XCTAssertTrue(set.contains(10))
        XCTAssertTrue(set.contains(20))
        XCTAssertTrue(set.contains(30))
        XCTAssertFalse(set.contains(40))
    }

    func testRemoveLinear() {
        var set = SwiftySet<Int>(strategy: .linear)
        set.insert(1)
        set.insert(2)

        XCTAssertTrue(set.remove(1))
        XCTAssertFalse(set.contains(1))
        XCTAssertTrue(set.contains(2))
    }

    func testRemoveChaining() {
        var set = SwiftySet<Int>(strategy: .chaining)
        set.insert(5)
        set.insert(15)

        XCTAssertTrue(set.remove(5))
        XCTAssertFalse(set.contains(5))
        XCTAssertTrue(set.contains(15))
    }

    func testDuplicateInsertLinear() {
        var set = SwiftySet<Int>(strategy: .linear)
        XCTAssertTrue(set.insert(1))
        XCTAssertFalse(set.insert(1))
        XCTAssertEqual(set.count, 1)
    }

    func testDuplicateInsertChaining() {
        var set = SwiftySet<Int>(strategy: .chaining)
        XCTAssertTrue(set.insert(10))
        XCTAssertFalse(set.insert(10))
        XCTAssertEqual(set.count, 1)
    }

    func testIsEmptyAndCountLinear() {
        var set = SwiftySet<Int>(strategy: .linear)
        XCTAssertTrue(set.isEmpty)

        set.insert(1)
        XCTAssertFalse(set.isEmpty)
        XCTAssertEqual(set.count, 1)

        set.remove(1)
        XCTAssertTrue(set.isEmpty)
    }

    func testIsEmptyAndCountChaining() {
        var set = SwiftySet<Int>(strategy: .chaining)
        XCTAssertTrue(set.isEmpty)

        set.insert(5)
        XCTAssertFalse(set.isEmpty)
        XCTAssertEqual(set.count, 1)

        set.remove(5)
        XCTAssertTrue(set.isEmpty)
    }

    func testResizeChaining() {
        var set = SwiftySet<Int>(strategy: .chaining, initialCapacity: 4)

        let numberOfItems = 100

        for i in 0..<numberOfItems {
            XCTAssertTrue(set.insert(i), "Should insert \(i) successfully")
        }

        XCTAssertEqual(set.count, numberOfItems, "Set count mismatch after inserts")

        for i in 0..<numberOfItems {
            XCTAssertTrue(set.contains(i), "Set should contain \(i) after resize")
        }
    }
}
