//
//  DiceAppUseCaseTests.swift
//  DiceAppCoreTests
//
//  Created by Wilmer Barrios on 13/06/21.
//

import Foundation
import XCTest
@testable import DiceAppCore

class DiceAppUseCaseTests: XCTestCase {
    func test_init_doesNotLoadDices() {
        let (_, loader, _, _) = makeSUT()
        XCTAssertEqual(loader.messagesCount, 0)
    }
    
    func test_loadDices_fetchDices() {
        let (sut, loader, _, _) = makeSUT()
        sut.loadDices()
        
        XCTAssertEqual(loader.messagesCount, 1)
    }
    
    func test_loadDiceSucceed_presentsDice() {
        let diceData = [makeDice(), makeDice()]
        
        assert(makeSUT(), completeResult: .success(diceData), expectedDices: diceData)
    }
    
    func test_loadDiceSucceed_doesNotPresentErrorMessage() {
        let diceData = [makeDice(), makeDice()]
        
        assert(makeSUT(), completeResult: .success(diceData), expectedErrorMessage: nil)
    }
    
    func test_loadDiceFailed_doesNotPresentDices() {
        assert(makeSUT(), completeResult: .failure(makeAnyError()), expectedDices: nil)
    }
    
    func test_loadDiceFailed_presentsErrorMessage() {
        assert(makeSUT(), completeResult: .failure(makeAnyError()), expectedErrorMessage: "Load error, try again later")
    }
    
    // MARK: Helpers
    private func makeAnyError() -> NSError {
        return NSError(domain: "anyDomain", code: 1)
    }
    
    private func assert(_ sutTuple: (sut: DiceAppUseCase, loader: DiceLoaderMock, view: DiceViewMock, errorView: ErrorViewMock), completeResult: Result<[Dice], Error>, action: @escaping () -> Void = {}, expectedDices: [Dice]? = nil, expectedErrorMessage: String? = nil, file: StaticString = #file, line: UInt = #line) {
        let (sut, loader, view, errorView) = sutTuple
        sut.loadDices()

        action()
        loader.complete(completeResult)
        
        if let _ed = expectedDices {
            XCTAssertEqual(view.presentedDices, _ed, file: file, line: line)
        }
        if let _eem = expectedErrorMessage {
            XCTAssertEqual(errorView.presentedErrorMessage, _eem, file: file, line: line)
        }
    }
    
    private func makeDice(value: Int = 2) -> Dice {
        Dice(value: value)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: DiceAppUseCase, loader: DiceLoaderMock, view: DiceViewMock, errorView: ErrorViewMock) {
        let loader = DiceLoaderMock()
        let view = DiceViewMock()
        let errorView = ErrorViewMock()
        let sut = DiceAppUseCase(loader: loader, view: view, errorView: errorView)
        trackMemoryLeaks(loader, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        trackMemoryLeaks(view, file: file, line: line)
        trackMemoryLeaks(errorView, file: file, line: line)
        return (sut, loader, view, errorView)
    }
    
    // MARK: Testing Entities
    
    private class ErrorViewMock: ErrorView {
        private var messages = [String]()
        var callCount: Int { messages.count }
        var presentedErrorMessage: String? { messages.last }
        
        func present(errorMessage: String) {
            messages.append(errorMessage)
        }
    }
    
    private class DiceViewMock: DiceView {
        private var messages = [[Dice]]()
        var callCount: Int { messages.count }
        var presentedDices: [Dice]? { messages.last }
        
        func present(_ dices: [Dice]) {
            messages.append(dices)
        }
    }
    
    private class DiceLoaderMock: DiceLoader {
        private var messages = [(Result<[Dice], Error>) -> Void]()
        
        var messagesCount: Int { messages.count }
        
        func getDice(diceCount: Int, completion: @escaping (Result<[Dice], Error>) -> Void) {
            messages.append(completion)
        }
        
        // MARK: Helpers
        func complete(_ result: Result<[Dice], Error>, index: Int = 0) {
            messages[index](result)
        }
    }
}
