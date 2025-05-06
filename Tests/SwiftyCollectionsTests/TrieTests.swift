//
//  TrieTests.swift
//  SwiftyCollections
//
//  Created by TAI VUONG on 6/5/25.
//

import XCTest
@testable import SwiftyCollections

final class TrieTests: XCTestCase {

    func testInsertAndContains() {
        let trie = Trie()
        trie.insert("apple")
        trie.insert("banana")
        trie.insert("band")

        XCTAssertTrue(trie.contains("apple"))
        XCTAssertTrue(trie.contains("banana"))
        XCTAssertTrue(trie.contains("band"))
        XCTAssertFalse(trie.contains("ban"))
        XCTAssertFalse(trie.contains("app"))
    }

    func testPrefixSearch() {
        let trie = Trie()
        trie.insert("cat")
        trie.insert("car")
        trie.insert("cap")

        XCTAssertTrue(trie.starts(with: "ca"))
        XCTAssertTrue(trie.starts(with: "car"))
        XCTAssertFalse(trie.starts(with: "cab"))
        XCTAssertFalse(trie.starts(with: "dog"))
    }

    func testDuplicateInsertDoesNotBreak() {
        let trie = Trie()
        trie.insert("go")
        trie.insert("go")
        trie.insert("go")

        XCTAssertTrue(trie.contains("go"))
        XCTAssertFalse(trie.contains("god"))
    }

    func testEmptyString() {
        let trie = Trie()
        XCTAssertFalse(trie.contains(""))
        trie.insert("")
        XCTAssertTrue(trie.contains(""))
        XCTAssertTrue(trie.starts(with: ""))
    }

    func testPrefixIsFullWord() {
        let trie = Trie()
        trie.insert("app")
        trie.insert("apple")

        XCTAssertTrue(trie.contains("app"))
        XCTAssertTrue(trie.starts(with: "app"))
        XCTAssertTrue(trie.contains("apple"))
    }

    func testMultipleWordsSharingPrefix() {
        let trie = Trie()
        let words = ["top", "to", "tone", "tonic"]
        words.forEach { trie.insert($0) }

        for word in words {
            XCTAssertTrue(trie.contains(word))
        }

        XCTAssertTrue(trie.starts(with: "to"))
        XCTAssertTrue(trie.starts(with: "ton"))
        XCTAssertFalse(trie.starts(with: "tor"))
    }

    func testDeepPrefix() {
        let trie = Trie()
        trie.insert("abcdefgh")

        XCTAssertTrue(trie.starts(with: "a"))
        XCTAssertTrue(trie.starts(with: "abcde"))
        XCTAssertTrue(trie.starts(with: "abcdefg"))
        XCTAssertFalse(trie.starts(with: "abcdefgz"))
        XCTAssertFalse(trie.contains("abcde"))
        XCTAssertTrue(trie.contains("abcdefgh"))
    }
}
