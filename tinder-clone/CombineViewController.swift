//
//  CombineViewController.swift
//  tinder-clone
//
//  Created by Filipe Souza on 12/06/21.
//

import UIKit

enum Acao {
    case deslike
    case like
    case superLike
}

class CombineViewController: UIViewController {
    
    var usuarios : [Usuario] = []
    var deslikeButton : UIButton = .iconFooter(named: "icone-deslike")
    var likeButton: UIButton = .iconFooter(named: "icone-like")
    var superLikeButton: UIButton = .iconFooter(named: "icone-superlike")
    var perfilButton: UIButton = .iconMenu(named: "icone-perfil")
    var chatButton: UIButton = .iconMenu(named: "icone-chat")
    var logoButton: UIButton = .iconMenu(named: "icone-logo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.systemGroupedBackground
        
        let loading = Loading(frame: view.frame)
        view.insertSubview(loading, at: 0)
        
        self.adicionaHeader()
        self.adicionarFooter()
        self.buscaUsuarios() 
    }
    
    func buscaUsuarios (){
//        self.usuarios = UsuarioService.shared.buscaUsuarios()
//        self.adicionarCards()

        UsuarioService.shared.buscaUsuarios { (usuarios, err) in
            if let usuarios = usuarios {
                DispatchQueue.main.async {
                    self.usuarios = usuarios
                    self.adicionarCards()
                }
            }
        }
        
    }
    
}

extension CombineViewController{
    func adicionaHeader(){
        let window = UIApplication.shared.windows.first {$0.isKeyWindow}
        let top: CGFloat = window?.safeAreaInsets.top ?? 44
        
        let stackView = UIStackView(arrangedSubviews: [perfilButton, logoButton, chatButton])
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        stackView.preencher(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, padding: .init(top: top, left: 16, bottom: 0, right: 16))
    }
    
    func adicionarFooter (){
        let stackview = UIStackView(arrangedSubviews: [UIView(), deslikeButton, superLikeButton, likeButton, UIView()])
        stackview.distribution = .equalCentering
        
        view.addSubview(stackview)
        stackview.preencher(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, padding: .init(top: 0, left: 16, bottom: 34, right: 16))
        
        
        deslikeButton.addTarget(self, action: #selector(deslikeClique), for: .touchUpInside)
        superLikeButton.addTarget(self, action: #selector(superLikeClique), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(likeClique), for: .touchUpInside)
    }
}

extension CombineViewController{
    func adicionarCards() {
        for usuario in usuarios {
            let card = CombineCardView()
            card.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 32, height: view.bounds.height * 0.7)
            
            card.center = view.center
            card.usuario = usuario
            card.tag = usuario.id
            
            card.callback = { (data) in
                self.visualizarDetalhe(usuario: data)
            }
            
            let gesture = UIPanGestureRecognizer()
            gesture.addTarget(self, action: #selector(handlerCard))
            card.addGestureRecognizer(gesture)
        
            //add card
            view.insertSubview(card, at: 1)
        }
    }
        
    func removerCard (card: UIView){
        card.removeFromSuperview()
        
        self.usuarios = self.usuarios.filter({ (usuario) -> Bool in
        return usuario.id != card.tag
        })
    }
    
    func verificarMatch (usuario: Usuario){
        if usuario.match{
            let matchVC = MatchViewController()
            matchVC.usuario = usuario
            matchVC.modalPresentationStyle = .fullScreen
            self.present(matchVC, animated: true, completion: nil)
            
        }
    }
    
    func visualizarDetalhe (usuario: Usuario){
        let detalheVC = DetalheViewController()
        detalheVC.modalPresentationStyle = .fullScreen
        
        self.present(detalheVC, animated: true, completion: nil)
    }
}



// Controle de rotação do card e Ação do usuário
extension CombineViewController {

    @objc func handlerCard (_ gesture : UIPanGestureRecognizer){
        if let card = gesture.view as? CombineCardView {
            let point = gesture.translation(in: view)
            
            card.center = CGPoint(x: view.center.x + point.x , y: view.center.y + point.y)
            
            let rotationAngle = point.x / view.bounds.width * 0.4
            
            if point.x > 0 {
                card.likeImageView.alpha = rotationAngle * 5
                card.deslikeImageView.alpha = 0
            } else{
                card.deslikeImageView.alpha = rotationAngle * 5 * -1
                card.likeImageView.alpha = 0
            }
            
            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
            
//            Gestos do usuário. Voltar card ao centro. like/Deslike Gestos
            if gesture.state == .ended{
//              Like
                if card.center.x > self.view.bounds.width + 50 {
                    self.animarCard(rotationAngle: rotationAngle, acao: .like)
                    return
                }
//              Deslike
                if card.center.x < -50 {
                    self.animarCard(rotationAngle: rotationAngle, acao: .deslike)
                    return
                }
                
                UIView.animate(withDuration: 0.2){
                    card.center = self.view.center
                    card.transform = .identity
                    card.likeImageView.alpha = 0
                    card.deslikeImageView.alpha = 0
                }
            }
        }
    }
    
    @objc func deslikeClique () {
        self.animarCard(rotationAngle: -0.4, acao: .deslike)
    }
    @objc func likeClique () {
        self.animarCard(rotationAngle: 0.4, acao: .like)
    }
    @objc func superLikeClique () {
        self.animarCard(rotationAngle: 0, acao: .superLike)
    }
    
    func animarCard(rotationAngle: CGFloat, acao: Acao ) {
        if let usuario = self.usuarios.first {
            for view in self.view.subviews{
                if view.tag == usuario.id{
                    if let card = view as? CombineCardView{
                        let center: CGPoint
                        var like: Bool
                        switch acao {
                        case .deslike:
                            center = CGPoint (x:card.center.x - self.view.bounds.width, y: card.center.y + 50)
                            like = false
                        case .like:
                            center = CGPoint (x: card.center.x + self.view.bounds.width, y: card.center.y + 50)
                            like = true
                        case .superLike:
                            center = CGPoint (x: card.center.x, y: card.center.y - self.view.bounds.height)
                            like = true
                        }

                        UIView.animate(withDuration: 0.2, animations: {
                            card.center = center
                            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
                            card.deslikeImageView.alpha = like == false ? 1 : 0
                            card.likeImageView.alpha = like == true ? 1 : 0
                        }) { (_) in
                            if like {
                                self.verificarMatch(usuario: usuario)
                            }
                            self.removerCard(card: card)
                        
                        }
                    }
                }
            }
        }
    }
}
