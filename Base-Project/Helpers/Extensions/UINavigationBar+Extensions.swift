//
//  UINavigationBar+Extensions.swift
//  Base-Project
//
//  Created by Wassim on 4/13/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    var isTransparent : Bool {
        get {
            return self.shadowImage != nil
        }
        set {
            switch newValue {
            case true :
                self.setBackgroundImage(UIImage(), for: .default)
                self.shadowImage = UIImage()
                
            case false :
                self.shadowImage = nil
                self.setBackgroundImage(nil, for: .default)
            }
        }
    }
}

