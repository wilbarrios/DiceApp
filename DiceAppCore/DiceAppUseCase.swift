//
//  DiceAppUseCase.swift
//  DiceAppCore
//
//  Created by Wilmer Barrios on 13/06/21.
//

import Foundation

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
            switch result {
            case .success(let dices):
                self?.view.present(dices)
            case .failure(let error):
                self?.errorView.present(errorMessage: DiceAppUseCase.parseError(error))
            }
        }
    }
    
    private static func parseError(_ error: Error) -> String {
        return "Load error, try again later"
    }
}
