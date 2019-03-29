//
//  BaseUIImageView.swift
//  Base-Project
//
//  Created by Mojtaba Al Moussawi on 3/29/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class BaseImageView : UIImageView{
    
    private var disposeBag = DisposeBag()
    var isBusy = ActivityIndicator()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        disposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isBusy.asObservable()
            .bind(to: self.rx.isLoading)
            .disposed(by: disposeBag)
    }
}
