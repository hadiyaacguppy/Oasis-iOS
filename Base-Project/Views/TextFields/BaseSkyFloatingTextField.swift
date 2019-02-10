//
//  BaseSkyFloatingTextField.swift
//  Base-Project
//
//  Created by Mohammad Rizk on 2/10/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SkyFloatingLabelTextField


class BaseSkyFloatingTextField : SkyFloatingLabelTextField {
    
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
        self.addToolBar()
        self.keyboardAppearance = .dark
        
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleFormatter = { text in
            
            return text
        }
     
      configureTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.titleFormatter = { text in
            
            return text
        }
    
        configureTextField()
    
    }
 
    func configureTextField(){
     
        self.titleFont = UIFont.boldSystemFont(ofSize: 14)
        
        self.tintColor = .black
        
        self.selectedTitleColor =  .black
        
        self.titleColor = .black
        
        self.selectedLineColor = .black
        
        self.lineColor = .black
        
        self.borderStyle = .none
    }
    
    
}

