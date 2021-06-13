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
    
    lazy var view: UIView = {
        let v = UIView()
        button.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: button.centerXAnchor)
        ])
        
        return v
    }()
    
    private lazy var button: UIButton = {
        let b = UIButton()
        b.setTitle("Roll", for: .normal)
        b.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        return b
    }()
    
    @objc
    private func buttonHandler() {
        onUserRequestRoll?()
    }
}

class RollControllerTests: XCTestCase {
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
    
}
