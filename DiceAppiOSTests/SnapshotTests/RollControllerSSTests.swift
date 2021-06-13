//
//  RollControllerSSTests.swift
//  DiceAppiOSTests
//
//  Created by Wilmer Barrios on 13/06/21.
//

import Foundation
import XCTest
import SnapshotTesting
@testable import DiceAppiOS

class RollControllerSSTests: XCTestCase {
    func test_light() {
        let sut = RollController().view
        let result = verifySnapshot(matching: sut, as: .image(),
                                    named: "default-light",
//                                    record: true,
                                    testName: "RollController-default-light")
        XCTAssertNil(result)
    }
}
