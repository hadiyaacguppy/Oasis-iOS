//
//  CGFloat+Extensions.swift
//  Base-Project
//
//  Created by Hadi on 6/12/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
