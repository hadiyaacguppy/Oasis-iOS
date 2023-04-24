//
//  Font.swift
//  Oasis
//
//  Created by Hadi on 10/7/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit

typealias MainFont = Font.Montserrat

public enum Font {
    
    public enum Montserrat: String {
        case ultraLightItalic = "UltraLightItalic"
        case medium = "Medium"
        case mediumItalic = "MediumItalic"
        case ultraLight = "ExtraLight"
        case italic = "Italic"
        case light = "Light"
        case thinItalic = "ThinItalic"
        case lightItalic = "LightItalic"
        case bold = "Bold"
        case thin = "Thin"
        case condensedBlack = "CondensedBlack"
        case condensedBold = "CondensedBold"
        case normal = "Regular"
        
        func with(size: CGFloat) -> UIFont {
            if rawValue.isEmpty{
                return UIFont(name: "Montserrat", size: size)!
            }
            return UIFont(name: "Montserrat-\(rawValue)", size: size)!
        }
    }
}
