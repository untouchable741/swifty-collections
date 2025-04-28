//
//  PriorityQueueTests.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 28/4/25.
//

import XCTest
@testable import SwiftyCollections

final class PriorityQueueTests: XCTestCase {
    func testIsEmpty() {
        var priorityQueue = PriorityQueue<Int>()
        XCTAssertTrue(priorityQueue.isEmpty)
        priorityQueue.enqueue(5)
        XCTAssertFalse(priorityQueue.isEmpty)
    }
    
    func testCount() {
        var priorityQueue = PriorityQueue<Int>()
        XCTAssertEqual(priorityQueue.count, 0)
        priorityQueue.enqueue(5)
        XCTAssertEqual(priorityQueue.count, 1)
    }
    
    func testPeakAscending() {
        var priorityQueue = PriorityQueue<Int>(ascending: true)
        XCTAssertNil(priorityQueue.peak)
        priorityQueue.enqueue(5)
        priorityQueue.enqueue(23)
        XCTAssertEqual(priorityQueue.peak, 5)
    }
    
    func testPeakDescending() {
        var priorityQueue = PriorityQueue<Int>(ascending: false)
        XCTAssertNil(priorityQueue.peak)
        priorityQueue.enqueue(5)
        priorityQueue.enqueue(23)
        XCTAssertEqual(priorityQueue.peak, 23)
    }
    
    func testEnqueueAndDequeueDescending() {
        var priorityQueue = PriorityQueue<Int>(ascending: false)
        priorityQueue.enqueue(24)
        priorityQueue.enqueue(2)
        priorityQueue.enqueue(8)
        XCTAssertEqual(priorityQueue.dequeue(), 24)
        XCTAssertEqual(priorityQueue.dequeue(), 8)
        XCTAssertEqual(priorityQueue.dequeue(), 2)
        XCTAssertNil(priorityQueue.dequeue())
    }
    
    func testEnqueueAndDequeueAscending() {
        var priorityQueue = PriorityQueue<Int>(ascending: true)
        priorityQueue.enqueue(24)
        priorityQueue.enqueue(2)
        priorityQueue.enqueue(8)
        XCTAssertEqual(priorityQueue.dequeue(), 2)
        XCTAssertEqual(priorityQueue.dequeue(), 8)
        XCTAssertEqual(priorityQueue.dequeue(), 24)
        XCTAssertNil(priorityQueue.dequeue())
    }
}
