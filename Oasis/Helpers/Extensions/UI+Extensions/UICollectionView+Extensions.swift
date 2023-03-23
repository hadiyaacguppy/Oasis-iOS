//
//  UICollectionView+Extensions.swift
//  Oasis
//
//  Created by Wassim on 7/6/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit
extension UICollectionView {
    
    func setHorizontalLayout(){
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        self.collectionViewLayout = layout
        
    }
    
    public func indexPathForLastItem(inSection section: Int) -> IndexPath? {
        guard section >= 0 else {
            return nil
        }
        guard section < numberOfSections else {
            return nil
        }
        guard numberOfItems(inSection: section) > 0 else {
            return IndexPath(item: 0, section: section)
        }
        return IndexPath(item: numberOfItems(inSection: section) - 1, section: section)
    }
    public func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}
