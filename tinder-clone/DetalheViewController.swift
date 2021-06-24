//
//  DetalheViewController.swift
//  tinder-clone
//
//  Created by Filipe Souza on 22/06/21.
//

import UIKit

class HeaderLayout: UICollectionViewFlowLayout {
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let layoutAttributes = super.layoutAttributesForElements(in: rect)
    
    layoutAttributes?.forEach({ (attribute) in
      if attribute.representedElementKind == UICollectionView.elementKindSectionHeader {
        
        guard let collectionView = collectionView else {return}
        let contentOffSetY = collectionView.contentOffset.y
        
        attribute.frame = CGRect(x: 0, y: contentOffSetY, width: collectionView.bounds.width, height: attribute.bounds.height - contentOffSetY)
        
      }
    })
    return layoutAttributes
  }
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
}


class DetalheViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    init() {
        super.init(collectionViewLayout: HeaderLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInsetAdjustmentBehavior = .never
    
        collectionView.backgroundColor = .red
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(DetalheHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! DetalheHeaderView
//      header.usuario = self.usuario
      return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return .init(width: view.bounds.width, height: view.bounds.height * 0.7)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = UIScreen.main.bounds.width
        var height: CGFloat = UIScreen.main.bounds.width * 0.66
        
      return .init(width: width, height: height)
    }
}
