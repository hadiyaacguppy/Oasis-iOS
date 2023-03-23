//
//  File.swift
//  Oasis
//
//  Created by Mojtaba Al Moussawi on 6/19/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit

enum NavigationBarType{
    
    case normal
    
    case transparent
    
    case hidden
    
    case custom(NavigationBarAppearance)
    
    case appDefault
    
    struct NavigationBarAppearance {
        var barTintColor : UIColor?
        var tintColor : UIColor
        var isTranslucent : Bool
        var titleTextAttributes : [NSAttributedString.Key : Any]?
        var shadowImage : UIImage?
        var shadowColor: UIColor?//For iOS 13
        var shouldClipsToBound : Bool
        var backgroundImage : UIImage?
        var position : UIBarPosition?
        var metrics : UIBarMetrics
        
        init(barTintColor : UIColor?,
             tintColor: UIColor,
             isTranslucent : Bool,
             titleTextAttributes :[NSAttributedString.Key : Any]? = nil,
             shadowImage : UIImage? = nil,
             shadowColor: UIColor? = nil ,
             shouldClipsToBound : Bool = false,
             barPosition : UIBarPosition? = nil,
             barMetrics : UIBarMetrics = .default,
             backgroundImage : UIImage? = nil) {
            self.barTintColor = barTintColor
            self.tintColor = tintColor
            self.isTranslucent = isTranslucent
            self.shadowImage = shadowImage
            self.shadowColor = nil
            self.shouldClipsToBound  = shouldClipsToBound
            self.titleTextAttributes = titleTextAttributes
            self.backgroundImage = backgroundImage
            self.position = barPosition
            self.metrics = barMetrics
        }
        
        init() {
            self.isTranslucent = false
            self.shouldClipsToBound = false
            self.metrics = .default
            self.tintColor = .blue
        }
    }
    
    var isTransparent : Bool{
        switch self {
        case .transparent:
            return true
        default:
            return false
        }
    }
    
    var isHidden : Bool{
        switch self {
        case .hidden:
            return true
        default:
            return false
        }
    }
}

extension NavigationBarType.NavigationBarAppearance{
    
    func getAppBaseStyle() -> NavigationBarType.NavigationBarAppearance{
        var appearance = NavigationBarType.NavigationBarAppearance()
        appearance.backgroundImage = UIImage()
        appearance.metrics = .default
        appearance.shadowImage = UIImage()
        appearance.titleTextAttributes = [ .foregroundColor : UIColor.black]
        appearance.barTintColor = .white
        return appearance
    }
}
