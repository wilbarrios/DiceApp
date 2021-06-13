//
//  RollControllerTests.swift
//  DiceAppiOSTests
//
//  Created by Wilmer Barrios on 13/06/21.
//

import Foundation
import XCTest
@testable import DiceAppiOS

class RollControllerTests: XCTestCase {
    func test_controller_presentsExpectedTitle() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.presentedTitle, "Roll")
    }
    
    func test_init_doesNotTriggerUserAction() {
        var userActionCallCount = 0
        let _ = makeSUT(onUserInteraction: { userActionCallCount += 1 })
        
        XCTAssertEqual(userActionCallCount, 0)
    }
    
    func test_onUserInteration_deliversMessage() {
        var userActionCallCount = 0
        let sut = makeSUT(onUserInteraction: { userActionCallCount += 1 })
        sut.simulateUserRequestRoll()
        XCTAssertEqual(userActionCallCount, 0)
    }
    
    // MARK: Helpers
    private func makeSUT(onUserInteraction: (() -> Void)? = nil, file: StaticString = #file, line: UInt = #line) -> RollController {
        let sut = RollController()
        sut.onUserRequestRoll = onUserInteraction
        trackMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}

private extension RollController {
    func simulateUserRequestRoll() {
        button.sendActions(for: .touchUpInside)
    }
    
    var presentedTitle: String? {
        button.title(for: .normal)
    }
}
