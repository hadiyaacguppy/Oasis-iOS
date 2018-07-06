//
//  UICollectionView+Extensions.swift
//  Base-Project
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
    
}
