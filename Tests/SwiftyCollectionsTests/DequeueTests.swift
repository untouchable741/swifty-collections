//
//  File.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 28/4/25.
//

import XCTest
@testable import SwiftyCollections

final class DequeueTests: XCTestCase {
    func testDequeueEmpty() {
        var dequeue = Dequeue<Int>()
        XCTAssertTrue(dequeue.isEmpty)
        dequeue.appendBack(1)
        XCTAssertFalse(dequeue.isEmpty)
    }
    
    func testEnqueueBackAndFront() {
        var dequeue = Dequeue<Int>()
        dequeue.appendBack(1)
        dequeue.appendBack(2)
        dequeue.appendFront(0)
        XCTAssertEqual(dequeue.removeFront(), 0)
        XCTAssertEqual(dequeue.removeFront(), 1)
    }
    
    func testRemoveBackAndFront() {
        var dequeue = Dequeue<Int>()
        dequeue.appendBack(1)
        dequeue.appendBack(2)
        dequeue.appendFront(0)
        XCTAssertEqual(dequeue.removeBack(), 2)
        XCTAssertEqual(dequeue.removeFront(), 0)
    }
    
    func testFrontAndBack() {
        var dequeue = Dequeue<Int>()
        dequeue.appendBack(1)
        dequeue.appendBack(2)
        dequeue.appendFront(0)
        XCTAssertEqual(dequeue.front, 0)
        XCTAssertEqual(dequeue.back, 2)
    }
    
    func testDequeueCount() {
        var dequeue = Dequeue<Int>()
        XCTAssertEqual(dequeue.count, 0)
        dequeue.appendBack(1)
        XCTAssertEqual(dequeue.count, 1)
        dequeue.appendBack(2)
        XCTAssertEqual(dequeue.count, 2)
        dequeue.appendFront(0)
        XCTAssertEqual(dequeue.count, 3)
    }
}
