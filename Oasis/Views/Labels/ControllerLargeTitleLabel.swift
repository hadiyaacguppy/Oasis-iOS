//
//  ControllerLargeTitleLabel.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 21/04/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import UIKit

class ControllerLargeTitleLabel : BaseLabel{
    
    required
    init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override
    init(frame: CGRect){
        super.init(frame: frame)
        self.setup()
    }
    
    private
    func setup(){
        self.style = .init(font: MainFont.medium.with(size: 27),
                           color: .black)
    }
}
