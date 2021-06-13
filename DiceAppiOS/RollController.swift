//
//  RollController.swift
//  DiceAppiOS
//
//  Created by Wilmer Barrios on 13/06/21.
//

import Foundation
import UIKit

private struct Sizes {
    static var CONTAINER_SIZE: CGSize { CGSize(width: 220, height: 60) }
    static var BUTTON_SIZE: CGSize { CGSize(width: 120, height: 40) }
}

public final class RollController {
    public var onUserRequestRoll: (() -> Void)?
    
    public init() { }
    
    public lazy var view: UIView = {
        let v = UIView(frame: .init(origin: .zero, size: Sizes.CONTAINER_SIZE))
        button.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            button.topAnchor.constraint(equalTo: v.topAnchor),
            button.leadingAnchor.constraint(equalTo: v.leadingAnchor),
            button.bottomAnchor.constraint(equalTo: v.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: v.trailingAnchor)
        ])
        
        return v
    }()
    
    internal lazy var button: UIButton = {
        let b = UIButton()
        b.setTitle("Roll", for: .normal)
        b.setTitleColor(UIColor.systemGray2, for: .normal)
        b.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        return b
    }()
    
    @objc
    private func buttonHandler() {
        onUserRequestRoll?()
    }
}
