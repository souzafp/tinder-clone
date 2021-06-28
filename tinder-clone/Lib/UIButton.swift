//
//  UIButton.swift
//  tinder-clone
//
//  Created by Filipe Souza on 14/06/21.
//

import UIKit

extension  UIButton {
    
    static func iconMenu (named: String) -> UIButton {
        let button = UIButton()
        button.size(size: .init(width: 32, height: 32))
        button.setImage(UIImage(named: named), for: .normal)
        
        return button
    }
    
    static func iconFooter (named: String) -> UIButton{
        let button = UIButton()
        button.size(size: .init(width: 64, height: 64))
        button.setImage(UIImage(named: named), for: .normal)
        button.backgroundColor = .white
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.cornerRadius = 32
        button.layer.shadowRadius = 3.0
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.masksToBounds = false
        
        return button
    }
}
