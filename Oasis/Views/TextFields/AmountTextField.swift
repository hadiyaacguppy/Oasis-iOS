//
//  AmountTextField.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import UIKit

class AmountTextField: BaseTextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPreferences()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPreferences()
    }
    
    func setupPreferences(){
        self.font = MainFont.light.with(size: 25)
        self.textColor = .black
        self.backgroundColor = .clear
        self.autoLayout()
    }
}

extension AmountTextField {

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
