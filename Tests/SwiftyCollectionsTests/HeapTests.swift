//
//  HeapTests.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 27/4/25.
//

import XCTest
@testable import SwiftyCollections

final class HeapTests: XCTestCase {
    func testMinHeapInsertAndPeek() {
        var minHeap = Heap<Int>(sortOrder: <)
            minHeap.insert(5)
            minHeap.insert(2)
            minHeap.insert(10)

            XCTAssertEqual(minHeap.peek(), 2)
        }

        func testMinHeapRemove() {
            var minHeap = Heap<Int>(sortOrder: >)
            minHeap.insert(5)
            minHeap.insert(2)
            minHeap.insert(10)
            _ = minHeap.remove()

            XCTAssertEqual(minHeap.peek(), 5)
        }
}
