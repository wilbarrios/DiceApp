//
//  ErrorView.swift
//  DiceAppCore
//
//  Created by Wilmer Barrios on 13/06/21.
//

import Foundation

public protocol ErrorView {
    func present(errorMessage: String)
}
