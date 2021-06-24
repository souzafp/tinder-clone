//
//  DetalheHeaderView.swift
//  tinder-clone
//
//  Created by Filipe Souza on 23/06/21.
//

import UIKit

class DetalheHeaderView: UICollectionReusableView {
  
  var usuario: Usuario? {
    didSet {
      if let usuario = usuario {
        fotoImageView.image = UIImage(named: usuario.foto)
      }
    }
  }
  
  var fotoImageView: UIImageView = .fotoImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(fotoImageView)
    fotoImageView.preencherSuperView()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
