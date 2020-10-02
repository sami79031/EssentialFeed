//
//  XCTestCase+ trackForMemoryLeaks.swift
//  EssentialFeedTests
//
//  Created by Sami Ali on 10/2/20.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been dealocated", file: file, line: line)
        }
    }
}
