//
//  UILabel+Extensions.swift
//  Base-Project
//
//  Created by Wassim Seifeddine on 12/6/17.
//  Copyright © 2017 Tedmob. All rights reserved.
//

import Foundation
import UIKit
extension UILabel {
    @IBInspectable var adjustWidthDynamically: Bool {
        get {
            return self.adjustsFontSizeToFitWidth
        } set {
            self.adjustsFontSizeToFitWidth = newValue
        }
    }
}
