//
//  HomeControllerSSTests.swift
//  DiceAppiOSTests
//
//  Created by Wilmer Barrios on 10/06/21.
//

import Foundation
import SnapshotTesting
import XCTest
@testable import DiceAppiOS

class HomeControllerSSTests: XCTestCase {
    func test_home() {
        let sut = HomeController()
        let result = verifySnapshot(matching: sut,
                                    as: .image(on: .iPhoneX,
                                               traits: UITraitCollection(userInterfaceStyle: .dark)),
                                    named: "default",
//                                    record: true,
                                    testName: "HomeController-default")
        XCTAssertNil(result)
    }
}
