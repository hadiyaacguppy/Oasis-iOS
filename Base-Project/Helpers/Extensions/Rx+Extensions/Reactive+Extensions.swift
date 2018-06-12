//
//  Extensions.swift
//  Base-Project
//
//  Created by Hadi on 6/12/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import GLKit
import RxSwift
import RxCocoa

//Used to enable/disable buttons
extension Reactive where Base : UIButton {
    
    var isEnabledAndHighlighted : Binder<Bool>{
        return Binder(self.base) { (control, value) in
            if value {
                (self.base as! UIButton).isEnabled = true
                (self.base as! UIButton).alpha = 1.0
            }else{
                (self.base as! UIButton).isEnabled = false
                (self.base as! UIButton).alpha = 0.5
            }
        }
    }
}
