//
//  Font.swift
//  Base-Project
//
//  Created by Hadi on 10/7/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit

typealias MainFont = Font.HelveticaNeue

enum Font {
    
    enum HelveticaNeue: String {
        case ultraLightItalic = "UltraLightItalic"
        case medium = "Medium"
        case mediumItalic = "MediumItalic"
        case ultraLight = "UltraLight"
        case italic = "Italic"
        case light = "Light"
        case thinItalic = "ThinItalic"
        case lightItalic = "LightItalic"
        case bold = "Bold"
        case thin = "Thin"
        case condensedBlack = "CondensedBlack"
        case condensedBold = "CondensedBold"
        case boldItalic = "BoldItalic"
        case normal = ""
        
        func with(size: CGFloat) -> UIFont {
            if rawValue.isEmpty{
                return UIFont(name: "HelveticaNeue", size: size)!
            }
            return UIFont(name: "HelveticaNeue-\(rawValue)", size: size)!
        }
    }
}
