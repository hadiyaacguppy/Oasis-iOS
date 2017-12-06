//
//  Utilities.swift
//  Base-Project
//
//  Created by Wassim Seifeddine on 12/6/17.
//  Copyright © 2017 Tedmob. All rights reserved.
//

import Foundation
import UIKit

struct Utilities  {
    struct  CollectionView {
        static public func setHorizontalLayout(forCollectionView collectionView: UICollectionView) {
            
            let layout = UICollectionViewFlowLayout()
            
            layout.scrollDirection = .horizontal
            
            collectionView.collectionViewLayout = layout
        }
        

    }
}



