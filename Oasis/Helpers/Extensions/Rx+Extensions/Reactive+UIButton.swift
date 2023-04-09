//
//  Extensions.swift
//  Oasis
//
//  Created by Hadi on 6/12/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import GLKit
import RxSwift
import RxCocoa


extension Reactive where Base : UIButton {
    
    /// Enable/disable button 
    var isEnabledAndHighlighted : Binder<Bool>{
        return Binder(self.base) { (button, value) in
            switch value{
            case true:
                button.isEnabled = true
                button.alpha = 1.0
            case false :
                button.isEnabled = false
                button.alpha = 0.8
            }
        }
    }
}

