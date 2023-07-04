//
//  OasisBlueButton.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/07/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import UIKit

class OasisBlueButton: BaseButton {
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
                           backgroundColor: Constants.Colors.appViolet)
        self.roundCorners = .all(radius: 53)
        self.autoLayout()
    }
}