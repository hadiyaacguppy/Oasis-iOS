//
//  OasisVioletButton.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 22/04/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import UIKit

class OasisVioletButton: BaseButton {
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
        self.style = .init(titleFont: MainFont.bold.with(size: 14),
                           titleColor: .white,
                           backgroundColor: Constants.Colors.appGreen)
        self.roundCorners = .all(radius: 24)
        self.autoLayout()
    }
}
