//
//  BaseUIView.swift
//  Base-Project
//
//  Created by Mojtaba Al Moussawi on 3/29/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//


import Foundation
import UIKit
import RxSwift

class BaseUIView: UIView {
    
    private var disposeBag = DisposeBag()
    var isBusy = ActivityIndicator()
    private var buttonTitle: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isBusy.asObservable()
            .bind(to: self.rx.isLoading)
            .disposed(by: disposeBag)
    }
    
    deinit {
        disposeBag = DisposeBag()
    }
    
    
}
