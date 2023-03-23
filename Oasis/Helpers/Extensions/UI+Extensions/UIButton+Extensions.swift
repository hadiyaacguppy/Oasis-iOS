//
//  UIButton+Extensions.swift
//  Oasis
//
//  Created by Hadi on 6/12/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    /**
     Disables a UIButton and dims it
     */
    func disable(){
        self.isEnabled = false
        self.alpha = 0.5
    }
    
    /**
     Enables a UIButton an undims it
     */
    func enable(){
        self.isEnabled = true
        self.alpha = 1
    }
}
