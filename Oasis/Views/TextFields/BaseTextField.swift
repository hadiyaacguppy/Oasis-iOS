//
//  BaseTextFielod.swift
//  Oasis
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
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addToolBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addToolBar()
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
