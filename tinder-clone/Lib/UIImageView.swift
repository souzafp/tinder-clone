//
//  UIImageView.swift
//  tinder-clone
//
//  Created by Filipe Souza on 14/06/21.
//

import UIKit

extension UIImageView {
    
    static func  fotoImageView (named: String? = nil ) -> UIImageView{
        let imageView = UIImageView()
        if let named = named {
            imageView.image = UIImage(named: named)
        }
        //foto não distorcer
        imageView.contentMode = .scaleAspectFill
        // foto não vazar
        imageView.clipsToBounds = true
        return imageView
    }
    
    static func iconCard (named: String) -> UIImageView{
        let imageView = UIImageView()
        imageView.image = UIImage(named: named)
        imageView.size(size: .init(width: 70, height: 70))
        imageView.alpha = 0.0
        return imageView
    }
    
}
