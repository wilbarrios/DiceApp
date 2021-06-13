//
//  DiceAppUseCaseTests.swift
//  DiceAppCoreTests
//
//  Created by Wilmer Barrios on 13/06/21.
//

import Foundation
import XCTest

struct Dice: Equatable {
    let value: Int
}

protocol DiceLoader {
    func getDice(diceCount: Int, completion: @escaping (Result<[Dice], Error>) -> Void)
}

protocol DiceView {
    func present(_ dices: [Dice])
}

protocol ErrorView {
    func present(errorMessage: String)
}

class DiceAppUseCase {
    // MARK: Datasource
    private let loader: DiceLoader
    
    // MARK: Presentation
    private let view: DiceView
    private let errorView: ErrorView
    
    private var DICE_COUNT: Int { 2 }
    
    init(loader: DiceLoader, view: DiceView, errorView: ErrorView) {
        self.loader = loader
        self.view = view
        self.errorView = errorView
    }
    
    func loadDices() {
        loader.getDice(diceCount: DICE_COUNT) { [weak self] result in
            if let dices = try? result.get() {
                self?.view.present(dices)
            }
        }
    }
}

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
        let (sut, loader, view, _) = makeSUT()
        
        sut.loadDices()
        let diceData = [makeDice(), makeDice()]
        loader.complete(.success(diceData))
        
        XCTAssertEqual(view.presentedDices, diceData)
    }
    
    // MARK: Helpers
    
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
