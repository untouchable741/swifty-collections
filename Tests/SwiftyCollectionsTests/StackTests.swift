//
//  StackTests.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 27/4/25.
//

import XCTest
@testable import SwiftyCollections

final class StackTests: XCTestCase {
    func testStackPush() {
        var stack = Stack<Int>()
        stack.push(5)
        stack.push(6)
        stack.push(1)
        XCTAssertFalse(stack.isEmpty)
        XCTAssertEqual(stack.count, 3)
    }
    
    func testStackPop() {
        var stack = Stack<Int>()
        stack.push(12)
        stack.push(56)
        stack.push(25)
        XCTAssertEqual(stack.pop(), 25)
        XCTAssertEqual(stack.pop(), 56)
        XCTAssertEqual(stack.pop(), 12)
        XCTAssertNil(stack.pop())
        XCTAssertEqual(stack.count, 0)
        XCTAssertTrue(stack.isEmpty)
    }
    
    func testStackTop() {
        var stack = Stack<Int>()
        (0..<10).forEach { stack.push($0) }
        XCTAssertEqual(stack.top, 9)
    }
    
    func testStackTopNil() {
        XCTAssertNil(Stack<Int>().top)
    }
}
