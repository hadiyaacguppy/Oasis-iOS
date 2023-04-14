//
//  WhiteBorderTextfield.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/04/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import UIKit

class WhiteBorderTextfield: BaseTextField {

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
        self.borderWidth = 1.0
        self.borderColor = .white
        self.font = MainFont.medium.with(size: 28)
        self.cornerRadius = 14
        self.textColor = .white
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension WhiteBorderTextfield {

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
