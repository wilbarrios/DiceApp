//
//  RollController.swift
//  DiceAppiOS
//
//  Created by Wilmer Barrios on 13/06/21.
//

import Foundation
import UIKit

public final class RollController {
    public var onUserRequestRoll: (() -> Void)?
    
    public init() { }
    
    public lazy var view: UIView = {
        let v = UIView()
        button.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: button.centerXAnchor)
        ])
        
        return v
    }()
    
    internal lazy var button: UIButton = {
        let b = UIButton()
        b.setTitle("Roll", for: .normal)
        b.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        return b
    }()
    
    @objc
    private func buttonHandler() {
        onUserRequestRoll?()
    }
}
