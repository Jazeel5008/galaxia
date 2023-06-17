//
//  UIViewController+Extension.swift
//  galaxia
//
//  Created by Meridian Mac Mini on 11/01/23.
//

import UIKit



extension UIViewController {
    
    func registerCell(collectionview : UICollectionView, reuseIdentifier: String) {
        
        collectionview.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionview.delegate = (self as! UICollectionViewDelegate)
        collectionview.dataSource = (self as! UICollectionViewDataSource)
        collectionview.showsVerticalScrollIndicator = false
    }
    
}
