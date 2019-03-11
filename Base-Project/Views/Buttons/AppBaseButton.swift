//
//  AppBaseButton.swift
//  Base-Project
//
//  Created by Mohammad Rizk on 2/10/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit

class AppBaseButton: UIButton {
    
    override
    func awakeFromNib() {
        super.awakeFromNib()
        configureButton()
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
    
    
    fileprivate func configureButton(){

    }
}



