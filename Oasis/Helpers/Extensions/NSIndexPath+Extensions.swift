//
//  NSIndexPath+Extensions.swift
//  Oasis
//
//  Created by Wassim Seifeddine on 12/6/17.
//  Copyright © 2017 Tedmob. All rights reserved.
//

import Foundation

extension IndexPath {
    

    var incremented : IndexPath{
        return IndexPath(item: (self as NSIndexPath).row + 1, section: (self as NSIndexPath).section)
    }
   
    
    var decremented : IndexPath{
        return IndexPath(item: (self as NSIndexPath).row - 1, section: (self as NSIndexPath).section)
    }
}

