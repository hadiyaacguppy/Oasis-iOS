//
//  WhiteBorderButton.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 06/04/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import UIKit

class WhiteBorderButton: BaseButton {
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
        self.style = .init(titleFont: MainFont.bold.with(size: 16),
                           titleColor: .white,
                           backgroundColor: .clear)
        self.border = .value(color: .white, width: 1.0)
        self.roundCorners = .all(radius: 28)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
