//
//  Int+Extensions.swift
//  Base-Project
//
//  Created by Wassim on 7/6/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
extension Optional where Wrapped == Int {
    var  toBool : Bool{
        
        if self == nil {
            return false
        }
        return self! == 1 ? true : false
    }
}
