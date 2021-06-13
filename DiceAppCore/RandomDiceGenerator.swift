//
//  RandomDiceGenerator.swift
//  DiceAppCore
//
//  Created by Wilmer Barrios on 13/06/21.
//

import Foundation

final class RandomDiceGenerator {
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
