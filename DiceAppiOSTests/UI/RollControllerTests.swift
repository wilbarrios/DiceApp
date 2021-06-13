//
//  RollControllerTests.swift
//  DiceAppiOSTests
//
//  Created by Wilmer Barrios on 13/06/21.
//

import Foundation
import XCTest

final class RollController {
    var onUserRequestRoll: (() -> Void)?
}

class RollControllerTests: XCTestCase {
    func test_init_doesNotTriggerUserAction() {
        var userActionCallCount = 0
        let _ = makeSUT(onUserInteraction: { userActionCallCount += 1 })
        
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
