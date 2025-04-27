//
//  HeapTests.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 27/4/25.
//

import XCTest
@testable import SwiftyCollections

final class HeapTests: XCTestCase {
    
    func testHeapCount() {
        var heap = Heap<Int>(order: >)
        heap.insert(2)
        heap.insert(5)
        heap.insert(23)
        XCTAssertEqual(heap.count, 3)
    }
    
    func testHeapIsEmpty() {
        XCTAssertEqual(Heap<Int>(order: <).isEmpty, true)
    }
    
    func testMinHeapInsertAndPeek() {
        var minHeap = MinHeap<Int>()
        minHeap.insert(5)
        minHeap.insert(2)
        minHeap.insert(10)
        
        XCTAssertEqual(minHeap.peek(), 2)
        XCTAssertEqual(minHeap.count, 3)
        XCTAssertEqual(minHeap.isEmpty, false)
    }
    
    func testMinHeapRemove() {
        var minHeap = MinHeap<Int>()
        minHeap.insert(4)
        minHeap.insert(2)
        minHeap.insert(10)
        _ = minHeap.remove()
        
        XCTAssertEqual(minHeap.peek(), 4)
    }
    
    func testMaxHeapInsertAndPeek() {
        var maxHeap = MaxHeap<Int>()
        maxHeap.insert(3)
        maxHeap.insert(5)
        maxHeap.insert(2)
        maxHeap.insert(10)
        
        XCTAssertEqual(maxHeap.peek(), 10)
        XCTAssertEqual(maxHeap.count, 4)
        XCTAssertEqual(maxHeap.isEmpty, false)
    }
    
    func testMaxHeapRemove() {
        var maxHeap = MaxHeap<Int>()
        maxHeap.insert(5)
        maxHeap.insert(2)
        maxHeap.insert(10)
        _ = maxHeap.remove()
        
        XCTAssertEqual(maxHeap.peek(), 5)
    }
}
