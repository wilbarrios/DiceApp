//
//  RandomDiceGeneratorTests.swift
//  DiceAppCoreTests
//
//  Created by Wilmer Barrios on 13/06/21.
//

import Foundation
import XCTest
@testable import DiceAppCore

class RandomDiceGenerator {
    private let lowerBound: Int
    private let higherBound: Int
    
    private static var LOWER_BOUND: Int { 1 }
    private static var HIGHER_BOUND: Int { 7 }
    
    init(lowerBound: Int = LOWER_BOUND, higherBound: Int = HIGHER_BOUND) {
        self.lowerBound = lowerBound
        self.higherBound = higherBound
    }
    
    func generate() -> Int {
        Int.random(in: (lowerBound ... higherBound))
    }
}

extension RandomDiceGenerator: DiceLoader {
    func getDice(diceCount: Int, completion: @escaping (Result<[Dice], Error>) -> Void) {
        var result = [Dice]()
        for _ in (0..<diceCount) {
            result.append(map(value: generate()))
        }
        completion(.success(result))
    }
    
    private func map(value: Int) -> Dice {
        Dice(value: value)
    }
}

class RandomDiceGeneratorUseCaseTests: XCTestCase {
    func test_getOneDice_succeed() {
        assert(makeSUT(), dicesCount: 2)
        assert(makeSUT(), dicesCount: 3)
        assert(makeSUT(), dicesCount: 4)
        assert(makeSUT(), dicesCount: 10)
    }
    
    // MARK: Helpers
    private func assert(_ sut: RandomDiceGenerator, dicesCount: Int, file: StaticString = #file, line: UInt = #line) {
        var resultDices: [Dice]?
        sut.getDice(diceCount: dicesCount, completion: { result in
            if let dices = try? result.get() {
                resultDices = dices
            }
        })
        XCTAssertEqual(resultDices?.count, dicesCount, file: file, line: line)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> RandomDiceGenerator {
        let sut = RandomDiceGenerator()
        trackMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
