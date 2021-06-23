//
//  Loading.swift
//  tinder-clone
//
//  Created by Filipe Souza on 22/06/21.
//

import UIKit

class Loading: UIView {
    
    let loadview: UIView = {
        let load = UIView()
        load.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        load.backgroundColor = UIColor(red: 218/255, green: 99/255, blue: 111/255, alpha: 1)
        load.layer.cornerRadius = 50
        load.layer.borderWidth = 1
        load.layer.borderColor = UIColor.red.cgColor
        return load
    }()
    
    let perfilImageView: UIImageView = {
        let imagem = UIImageView()
        imagem.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imagem.layer.cornerRadius = 50
        imagem.layer.borderWidth = 5
        imagem.layer.borderColor = UIColor.white.cgColor
        imagem.clipsToBounds = true
        imagem.image = UIImage(named: "perfil")
        return imagem
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(loadview)
        loadview.center = center
        self.animacao()
        
        addSubview(perfilImageView)
        perfilImageView.center = center
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented.")
    }
    
    func animacao(){
        UIView.animate(withDuration: 1.3, animations: {
            self.loadview.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
            self.loadview.center = self.center
            self.loadview.layer.cornerRadius = 125
            self.loadview.alpha = 0.3
            
        }) { (_) in
            
            self.loadview.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            self.loadview.center = self.center
            self.loadview.layer.cornerRadius = 50
            self.loadview.alpha = 1
            
            self.animacao()
            
        }
    }
    
}
