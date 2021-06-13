//
//  DiceLoader.swift
//  DiceAppCore
//
//  Created by Wilmer Barrios on 13/06/21.
//

import Foundation

public protocol DiceLoader {
    func getDice(diceCount: Int, completion: @escaping (Result<[Dice], Error>) -> Void)
}
