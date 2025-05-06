//
//  LRUCacheTests.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 6/5/25.
//

import XCTest
@testable import SwiftyCollections

final class LRUCacheTests: XCTestCase {

    func testPutAndGet() {
        let cache = LRUCache<String, Int>(capacity: 2)
        cache.put("a", 1)
        cache.put("b", 2)

        XCTAssertEqual(cache.get("a"), 1)
        XCTAssertEqual(cache.get("b"), 2)
        XCTAssertNil(cache.get("c"))
    }

    func testEvictionOrder() {
        let cache = LRUCache<String, Int>(capacity: 2)
        cache.put("a", 1)
        cache.put("b", 2)
        cache.get("a")            // mark "a" as recently used
        cache.put("c", 3)         // "b" should be evicted

        XCTAssertEqual(cache.get("a"), 1)
        XCTAssertNil(cache.get("b"))
        XCTAssertEqual(cache.get("c"), 3)
    }

    func testOverwriteValue() {
        let cache = LRUCache<String, Int>(capacity: 2)
        cache.put("a", 1)
        cache.put("a", 100)

        XCTAssertEqual(cache.get("a"), 100)
    }

    func testSingleCapacityEviction() {
        let cache = LRUCache<Int, Int>(capacity: 1)
        cache.put(1, 10)
        cache.put(2, 20)

        XCTAssertNil(cache.get(1))
        XCTAssertEqual(cache.get(2), 20)
    }

    func testEvictionWithAccess() {
        let cache = LRUCache<String, Int>(capacity: 3)
        cache.put("a", 1)
        cache.put("b", 2)
        cache.put("c", 3)

        _ = cache.get("a")      // use "a"
        _ = cache.get("b")      // use "b"

        cache.put("d", 4)       // "c" should be evicted

        XCTAssertNil(cache.get("c"))
        XCTAssertEqual(cache.get("a"), 1)
        XCTAssertEqual(cache.get("b"), 2)
        XCTAssertEqual(cache.get("d"), 4)
    }

    func testRepeatedAccessPreservesItem() {
        let cache = LRUCache<Int, String>(capacity: 2)
        cache.put(1, "One")
        cache.put(2, "Two")
        for _ in 0..<10 { _ = cache.get(1) } // repeatedly access 1
        cache.put(3, "Three") // should evict 2, not 1

        XCTAssertNotNil(cache.get(1))
        XCTAssertNil(cache.get(2))
        XCTAssertEqual(cache.get(3), "Three")
    }

    func testPutSameKeyUpdatesAndMovesToFront() {
        let cache = LRUCache<String, String>(capacity: 2)
        cache.put("x", "X1")
        cache.put("y", "Y1")
        cache.put("x", "X2") // updates value and usage

        cache.put("z", "Z1") // should evict "y", not "x"

        XCTAssertEqual(cache.get("x"), "X2")
        XCTAssertNil(cache.get("y"))
        XCTAssertEqual(cache.get("z"), "Z1")
    }

    func testEmptyCacheReturnsNil() {
        let cache = LRUCache<Int, Int>(capacity: 1)
        XCTAssertNil(cache.get(999))
    }

    func testAccessAfterEvictionReturnsNil() {
        let cache = LRUCache<Int, Int>(capacity: 2)
        cache.put(1, 1)
        cache.put(2, 2)
        cache.put(3, 3) // evicts 1

        XCTAssertNil(cache.get(1))
        XCTAssertEqual(cache.get(2), 2)
        XCTAssertEqual(cache.get(3), 3)
    }

    func testLRUWithComplexType() {
        struct User: Equatable, Hashable {
            let id: Int
            let name: String
        }

        let cache = LRUCache<Int, User>(capacity: 2)
        let alice = User(id: 1, name: "Alice")
        let bob = User(id: 2, name: "Bob")
        let charlie = User(id: 3, name: "Charlie")

        cache.put(alice.id, alice)
        cache.put(bob.id, bob)
        cache.put(charlie.id, charlie) // evicts Alice

        XCTAssertNil(cache.get(alice.id))
        XCTAssertEqual(cache.get(bob.id), bob)
        XCTAssertEqual(cache.get(charlie.id), charlie)
    }
}
