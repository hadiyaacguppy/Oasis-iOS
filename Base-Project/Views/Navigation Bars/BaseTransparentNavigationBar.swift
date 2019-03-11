//
//  BaseTransparentNavigationBar.swift
//  Base-Project
//
//  Created by Wassim on 7/6/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit
class BaseTransparentNavigationBar : UINavigationBar{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        
        self.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont(name: "FFYaseer-Regular", size: 19)!
        ]
    }
}
