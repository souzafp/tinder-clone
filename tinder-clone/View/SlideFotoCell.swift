//
//  SlideFotoCell.swift
//  tinder-clone
//
//  Created by Filipe Souza on 24/06/21.
//

import UIKit

class SlideFotoCell: UICollectionViewCell {
  
  var fotoImageView: UIImageView = .fotoImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    layer.cornerRadius = 8
    clipsToBounds = true
    
    addSubview(fotoImageView)
    fotoImageView.preencherSuperView()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
}
