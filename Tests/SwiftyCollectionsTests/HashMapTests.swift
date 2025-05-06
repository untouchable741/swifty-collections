//
//  HashMapTests.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 6/5/25.
//

import XCTest
@testable import SwiftyCollections

final class HashMapTests: XCTestCase {

    func testPutAndGet() {
        var map = HashMap<String, Int>()
        map.put(key: "apple", value: 3)
        map.put(key: "banana", value: 5)

        XCTAssertEqual(map.get(key: "apple"), 3)
        XCTAssertEqual(map.get(key: "banana"), 5)
        XCTAssertNil(map.get(key: "orange"))
    }

    func testOverwriteValue() {
        var map = HashMap<String, String>()
        map.put(key: "lang", value: "Swift")
        map.put(key: "lang", value: "Rust")

        XCTAssertEqual(map.get(key: "lang"), "Rust")
        XCTAssertEqual(map.count, 1)
    }

    func testRemoveKey() {
        var map = HashMap<Int, String>()
        map.put(key: 1, value: "one")
        map.put(key: 2, value: "two")

        XCTAssertTrue(map.remove(key: 1))
        XCTAssertNil(map.get(key: 1))
        XCTAssertEqual(map.count, 1)

        XCTAssertFalse(map.remove(key: 100))
    }

    func testContainsKey() {
        var map = HashMap<Character, Bool>()
        map.put(key: "a", value: true)

        XCTAssertTrue(map.contains(key: "a"))
        XCTAssertFalse(map.contains(key: "z"))
    }

    func testCountAndIsEmpty() {
        var map = HashMap<Int, Int>()
        XCTAssertEqual(map.count, 0)

        map.put(key: 100, value: 999)
        XCTAssertEqual(map.count, 1)

        XCTAssertTrue(map.remove(key: 100))
        XCTAssertEqual(map.count, 0)
    }

    func testSubscriptAccess() {
        var map = HashMap<String, String>()
        map["lang"] = "Swift"
        XCTAssertEqual(map["lang"], "Swift")

        map["lang"] = "Go"
        XCTAssertEqual(map["lang"], "Go")

        map["lang"] = nil
        XCTAssertNil(map["lang"])
    }

    func testResizeWithManyKeys() {
        var map = HashMap<Int, String>()

        for i in 0..<100 {
            map.put(key: i, value: "Item \(i)")
        }

        XCTAssertEqual(map.count, 100)

        for i in 0..<100 {
            XCTAssertEqual(map.get(key: i), "Item \(i)")
        }
    }
}
