//
//  Reactive+UIView.swift
//  Base-Project
//
//  Created by Mojtaba Al Moussawi on 3/29/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base : UIView{
    
    
    
    var isEnabledAndOpaque : Binder<Bool>{
        return Binder(self.base) { (view, value) in
            switch value{
            case true:
                view.isUserInteractionEnabled = true
                view.alpha = 1.0
            case false :
                view.isUserInteractionEnabled = false
                view.alpha = 0.5
            }
        }
    }
    
    var isLoading : Binder<Bool?>{
        return Binder(base) { view, value in
            switch value{
            case true:
                self.base.isUserInteractionEnabled = false
                self.base.alpha = 0.5
                self.base.showMyActivityIndicator()
            default :
                self.base.isUserInteractionEnabled = true
                self.base.alpha = 1
                self.base.hideMyActivityIndicator()
            }
        }
    }
    
    
    
}
