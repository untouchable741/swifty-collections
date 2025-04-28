//
//  DoublyLinkedListTests.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 28/4/25.
//

import XCTest
@testable import SwiftyCollections

final class DoublyLinkedListTests: XCTestCase {
    func testIsEmpty() {
        var list = DoublyLinkedList<Int>()
        XCTAssertTrue(list.isEmpty)
        list.append(1)
        XCTAssertFalse(list.isEmpty)
    }
    
    func testcount() {
        var list = DoublyLinkedList<Int>()
        XCTAssertEqual(list.count, 0)
        list.append(1)
        XCTAssertEqual(list.count, 1)
        list.append(2)
        XCTAssertEqual(list.count, 2)
    }
    
    func testFrontAndBack() {
        var list = DoublyLinkedList<Int>()
        list.append(1)
        list.append(2)
        XCTAssertEqual(list.front, 1)
        XCTAssertEqual(list.back, 2)
    }
    
    func testAppendAndPrepend() {
        var list = DoublyLinkedList<Int>()
        list.append(1)
        list.append(2)
        list.prepend(0)
        XCTAssertEqual(list.front, 0)
        XCTAssertEqual(list.back, 2)
    }
    
    func testRemoveFirstAndLast() {
        var list = DoublyLinkedList<Int>()
        list.append(1)
        list.append(2)
        list.append(3)
        
        XCTAssertEqual(list.removeFirst(), 1)
        XCTAssertEqual(list.removeLast(), 3)
        XCTAssertEqual(list.front, 2)
    }
    
    func testRemoveWhenEmpty() {
        var list = DoublyLinkedList<Int>()
        XCTAssertNil(list.removeFirst())
        XCTAssertNil(list.removeLast())
    }
}
