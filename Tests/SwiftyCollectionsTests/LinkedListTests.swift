//
//  LinkedListTests.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 28/4/25.
//

import XCTest
@testable import SwiftyCollections

final class LinkedListTests: XCTestCase {
    func testIsEmpty() {
        var list = LinkedList<Int>()
        XCTAssertTrue(list.isEmpty)
        list.append(1)
        XCTAssertFalse(list.isEmpty)
    }
    
    func testCount() {
        var list = LinkedList<Int>()
        XCTAssertEqual(list.count, 0)
        list.append(1)
        XCTAssertEqual(list.count, 1)
        list.prepend(2)
        XCTAssertEqual(list.count, 2)
    }
    
    func testAppendAndPrepend() {
        var list = LinkedList<Int>()
        list.append(1)
        list.append(2)
        list.prepend(0)
        XCTAssertEqual(list.count, 3)
    }
    
    func testRemoveFirstAndLast() {
        var list = LinkedList<Int>()
        list.append(4)
        list.append(5)
        list.prepend(3)
        list.prepend(2)
        list.prepend(1)
        XCTAssertEqual(list.removeFirst(), 1)
        XCTAssertEqual(list.removeLast(), 5)
        XCTAssertEqual(list.count, 3)
    }
    
    func testRemoveFromEmpty() {
        var list = LinkedList<Int>()
        XCTAssertNil(list.removeFirst())
        XCTAssertNil(list.removeLast())
    }
}
