//
//  Reactive+Validation.swift
//  Base-Project
//
//  Created by Wassim on 11/12/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

/// Extension Usage:
/// This is to add the ability for checking for UISearchBar.text even if changes was'nt done by user - Keyboard input
/// For cases when text property is edited from code, picker etc..
extension Reactive where Base: UISearchBar {
    var textChanged : Observable<String?>{
        return Observable.merge(self.base.rx.observe(String.self, "text"),
                                self.base.rx.text.asObservable() )
    }
}

/// Extension Usage:
/// This is to add the ability for checking for UITextField.text even if changes was'nt done by user - Keyboard input
/// For cases when text property is edited from code, picker etc..
extension Reactive where Base: UITextField {
    var textChanged : Observable<String?>{
        return Observable.merge(self.base.rx.observe(String.self, "text"),
                                self.base.rx.controlEvent(.editingChanged).withLatestFrom(self.base.rx.text))
    }
}






