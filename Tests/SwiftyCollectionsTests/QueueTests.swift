//
//  QueueTests.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 28/4/25.
//

import XCTest
@testable import SwiftyCollections

final class QueueTests: XCTestCase {
    func testQueueIsEmpty() {
        var queue = Queue<Int>()
        XCTAssertTrue(queue.isEmpty)
        queue.enqueue(1)
        XCTAssertFalse(queue.isEmpty)
    }
    
    func testQueueCount() {
        var queue = Queue<Int>()
        XCTAssertEqual(queue.count, 0)
        queue.enqueue(1)
        XCTAssertEqual(queue.count, 1)
        queue.enqueue(2)
        XCTAssertEqual(queue.count, 2)
    }
    
    func testEnqueueAndDequeue() {
        var queue = Queue<Int>()
        queue.enqueue(1)
        XCTAssertEqual(queue.dequeue(), 1)
        XCTAssertTrue(queue.isEmpty)
    }
    
    func testFront() {
        var queue = Queue<Int>()
        queue.enqueue(1)
        queue.enqueue(2)
        XCTAssertEqual(queue.front, 1)
    }
}
