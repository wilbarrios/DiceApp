//
//  DiceAppUseCaseTests.swift
//  DiceAppCoreTests
//
//  Created by Wilmer Barrios on 13/06/21.
//

import Foundation
import XCTest

struct Dice {
    let value: Int
}

protocol DiceLoader {
    func getDice(diceCount: Int, completion: @escaping (Result<[Dice], Error>) -> Void)
}

class DiceAppUseCase {
    private let loader: DiceLoader
    private var DICE_COUNT: Int { 2 }
    
    init(loader: DiceLoader) {
        self.loader = loader
    }
    
    func loadDices() {
        loader.getDice(diceCount: DICE_COUNT) {_ in }
    }
}

class DiceAppUseCaseTests: XCTestCase {
    func test_init_doesNotLoadDices() {
        let (_, loader) = makeSUT()
        XCTAssertEqual(loader.messagesCount, 0)
    }
    
    func test_loadDices_fetchDices() {
        let (sut, loader) = makeSUT()
        sut.loadDices()
        
        XCTAssertEqual(loader.messagesCount, 1)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: DiceAppUseCase, loader: DiceLoaderMock) {
        let loader = DiceLoaderMock()
        let sut = DiceAppUseCase(loader: loader)
        trackMemoryLeaks(loader, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }
    
    private class DiceLoaderMock: DiceLoader {
        private var messages = [(Result<[Dice], Error>) -> Void]()
        
        var messagesCount: Int { messages.count }
        
        func getDice(diceCount: Int, completion: @escaping (Result<[Dice], Error>) -> Void) {
            messages.append(completion)
        }
    }
}
