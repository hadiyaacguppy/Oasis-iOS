//
//  PlaceHolderHelper.swift
//  Base-Project
//
//  Created by Mojtaba Almoussawi on 7/29/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit


///Since title,description and button text can be as NSAttributedStrings to specify a font style ,
///This class will manitain as helper to create NSAttributedString instead of doing it in your ViewController
final class PlaceHolderHelper {
    
    
    static func setTitle(withtext text : String? = nil,
                         andFont font : UIFont? = nil ,
                         andTextColor textColor : UIColor? = nil
        )
        -> NSAttributedString?{
            if text == nil {
                return nil
            }
            var attributes: [NSAttributedStringKey: Any] = [:]
            if font != nil {
                attributes[.font] = font!
            }
            if textColor != nil {
                attributes[.foregroundColor] = textColor
            }
            return NSAttributedString.init(string: text!, attributes: attributes)
    }
    
    
    
    static func setDetailDescription(withtext text : String? = nil,
                                     andFont font : UIFont? = nil ,
                                     andTextColor textColor : UIColor? = nil
        )
        -> NSAttributedString?{
            if text == nil {
                return nil
            }
            var attributes: [NSAttributedStringKey: Any] = [:]
            if font != nil {
                attributes[.font] = font!
            }
            if textColor != nil {
                attributes[.foregroundColor] = textColor
            }
            return NSAttributedString.init(string: text!, attributes: attributes)
    }
    
    
    static var imageAnimation: CAAnimation? {
        let animation = CABasicAnimation.init(keyPath: "transform")
        animation.fromValue = NSValue.init(caTransform3D: CATransform3DIdentity)
        animation.toValue = NSValue.init(caTransform3D: CATransform3DMakeRotation(.pi/2, 0.0, 0.0, 1.0))
        animation.duration = 0.25
        animation.isCumulative = true
        animation.repeatCount = MAXFLOAT
        
        return animation;
    }
    
    
    
    static func setButtonTitle(forState state: UIControlState,
                               andText text : String? = nil,
                               withTextColor textColor : UIColor? = nil,
                               andFont font : UIFont? = nil
        )
        -> NSAttributedString? {
            
            if text == nil {
                return nil
            }
            var attributes: [NSAttributedStringKey: Any] = [:]
            if font != nil {
                attributes[NSAttributedStringKey.font] = font!
            }
            if textColor != nil {
                attributes[NSAttributedStringKey.foregroundColor] = textColor
            }
            return NSAttributedString.init(string: text!, attributes: attributes)
    }
    
}
