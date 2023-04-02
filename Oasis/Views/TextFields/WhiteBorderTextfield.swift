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
    }
}
