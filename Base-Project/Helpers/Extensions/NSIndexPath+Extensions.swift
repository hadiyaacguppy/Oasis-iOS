//
//  NSIndexPath+Extensions.swift
//  Base-Project
//
//  Created by Wassim Seifeddine on 12/6/17.
//  Copyright © 2017 Tedmob. All rights reserved.
//

import Foundation

extension IndexPath {
    
    func increment() -> IndexPath {
        return IndexPath(item: (self as NSIndexPath).row + 1, section: (self as NSIndexPath).section)
    }
    
    func decrement() -> IndexPath {
        return IndexPath(item: (self as NSIndexPath).row - 1, section: (self as NSIndexPath).section)
    }
}

