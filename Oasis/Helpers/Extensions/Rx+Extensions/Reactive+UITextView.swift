//
//  Reactive+UITextView.swift
//  Oasis
//
//  Created by Mojtaba Al Moussawi on 4/12/21.
//  Copyright © 2021 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

/// This is to add the ability for checking for UITextField.text even if changes wasn't done by the user - Keyboard input
/// For cases when text property is edited from code, picker etc..
extension Reactive where Base: UITextView {
    var textChanged : Observable<String?>{
        return Observable.merge(self.base.rx.observe(String.self, "text"),
                                self.base.rx.didChange.map{self.base.text})
    }
}
