//
//  RandomDiceGeneratorTests.swift
//  DiceAppCoreTests
//
//  Created by Wilmer Barrios on 13/06/21.
//

import Foundation
import XCTest

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



class RandomDiceGeneratorUseCaseTests: XCTestCase {
    func test_init_doesNotRequestDices() {
        
    }
}
