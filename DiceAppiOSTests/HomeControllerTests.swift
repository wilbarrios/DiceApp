//
//  HomeControllerTests.swift
//  DiceAppiOSTests
//
//  Created by Wilmer Barrios on 10/06/21.
//

import Foundation
import XCTest
@testable import DiceAppiOS

class HomeControllerTests: XCTestCase {
    func test_load_withExpectedBackground() {
        let sut = HomeController()
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.getBackground(), UIColor.green)
    }
}

private extension HomeController {
    func getBackground() -> UIColor? {
        view.backgroundColor
    }
}
