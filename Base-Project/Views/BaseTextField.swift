//
//  BaseTextFielod.swift
//  Base-Project
//
//  Created by Wassim on 1/26/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit
import  RxSwift


class BaseTextField : UITextField {
    
    var validationExpression : InputValidationExpression? = nil{
        didSet {
            if validationExpression != nil {
                setupValidation()
            }
        }
    }
    
    var validationSubscription : Disposable?
    
    deinit {
        validationSubscription?.dispose()
    }
    
    var isValidated : ReplaySubject<Bool> = ReplaySubject<Bool>.create(bufferSize: 1)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let  barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.resignFirstResponder))
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.items = [flexibleItem , barButton]
        self.inputAccessoryView = toolbar
    }
    
    func setupValidation(){
        validationSubscription = self.rx
            .text
            .asObservable()
            .filter{
                $0 != nil
            }
            .flatMap { str in
                Observable.just(str!.validate(withExpression: self.validationExpression!))
            }.bind(to: self.isValidated)
        
    }
}
