//
//  XCTestCase+Extensions.swift
//  DiceAppCoreTests
//
//  Created by Wilmer Barrios on 13/06/21.
//

import Foundation
import XCTest

extension XCTestCase {
    func trackMemoryLeaks(_ object: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock {
            [weak object] in
            XCTAssertNil(object, "\(String(describing: object)) instance should be deallocated, potential memory leak", file: file, line: line)
        }
    }
}
