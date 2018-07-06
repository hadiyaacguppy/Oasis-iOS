//
//  Bool+Extensions.swift
//  Base-Project
//
//  Created by Wassim on 7/6/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
extension Bool {
    var toInt : Int {
        if self == false {
            return 0
        }
        return 1
    }
}
