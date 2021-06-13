//
//  HomeController.swift
//  DiceAppiOS
//
//  Created by Wilmer Barrios on 10/06/21.
//

import Foundation
import UIKit

class HomeController: UIViewController {
    // MARK: Helpers
    private func setupLayout() {
        view.backgroundColor = UIColor.systemBackground
    }
    
    // MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}
