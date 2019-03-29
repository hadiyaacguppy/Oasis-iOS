//
//  AppBaseButton.swift
//  Base-Project
//
//  Created by Mohammad Rizk on 2/10/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class BaseButton: UIButton {
    
    private var disposeBag = DisposeBag()
    public var isBusy = ActivityIndicator()
    private var buttonTitle: String?
    
    override
    func awakeFromNib() {
        super.awakeFromNib()
        subscribeToBusyStatus()
    }
    
    
    override
    func layoutSubviews() {
        super.layoutSubviews()
        configureButton()
    }
    
    override
    init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    
    required
    init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureButton()
    }
    
    
    fileprivate
    func subscribeToBusyStatus(){
       
        isBusy.asObservable()
            .bind(to: self.rx.isLoading)
            .disposed(by: disposeBag)
        
        isBusy.asObservable()
            .skip(1)
            .subscribe(onNext: { (value) in
                if value == true{
                    self.buttonTitle = self.titleLabel?.text
                    self.setTitle("", for: .normal)
                }else{
                    
                    self.setTitle(self.buttonTitle, for: .normal)
                    
                }
            }).disposed(by: disposeBag)
    }
    
    fileprivate func configureButton(){
        
    }
}

