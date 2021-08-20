//
//  UINavigationBar+Extensions.swift
//  Base-Project
//
//  Created by Wassim on 4/13/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    var isTransparent : Bool {
        get {
            return self.shadowImage != nil
        }
        set {
            switch newValue {
            case true :
                self.setBackgroundImage(UIImage(), for: .default)
                self.shadowImage = UIImage()
                
            case false :
                self.shadowImage = nil
                self.setBackgroundImage(nil, for: .default)
            }
        }
    }
    
    var seperatorIsVisible : Bool {
        get {
            return self.shadowImage != nil
        }
        set {
            switch newValue {
            case false :
                self.shadowImage = UIImage()
                self.setBackgroundImage(UIImage(), for: .default)
            case true :
                self.shadowImage = nil
                self.setBackgroundImage(nil, for: .default)
            }
        }
    }
    
    func applyTransparency (){
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            backgroundColor = appearance.backgroundColor
            tintColor = .white
            appearance.shadowColor = .clear
            appearance.backgroundColor = .clear
            appearance.backgroundColor = UIColor.white.withAlphaComponent(0.0)
            appearance.backgroundImage = UIImage()
            appearance.shadowImage = UIImage()
            appearance.backgroundEffect = nil
            standardAppearance = appearance
            scrollEdgeAppearance = appearance
            compactAppearance = appearance
            setNeedsLayout()
        } else {
            self.setBackgroundImage(UIImage(), for: .default)
            self.shadowImage = UIImage()
            self.isTranslucent = true
            self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            self.tintColor = .white//Optional
        }
    }
    
    func applyStyle(appearance : NavigationBarType.NavigationBarAppearance){
        if #available(iOS 13.0, *) {
            let app = UINavigationBarAppearance()
            app.configureWithDefaultBackground()
            if appearance.backgroundImage != nil {
                app.backgroundImage = appearance.backgroundImage
            }
            app.backgroundColor = appearance.barTintColor
            if appearance.titleTextAttributes != nil {
                app.titleTextAttributes = appearance.titleTextAttributes!
            }
            app.shadowImage = appearance.shadowImage
            app.shadowColor = appearance.shadowColor
            self.standardAppearance = app
            self.scrollEdgeAppearance = app
            self.compactAppearance = app
            setNeedsLayout()
            self.tintColor = appearance.tintColor
            self.isTranslucent = appearance.isTranslucent
        } else {
            if appearance.backgroundImage != nil {
                if appearance.position != nil {
                    self.setBackgroundImage(appearance.backgroundImage,
                                            for: appearance.position!,
                                            barMetrics: appearance.metrics)
                } else {
                    self.setBackgroundImage(appearance.backgroundImage,
                                            for: appearance.metrics)
                }
            }
            self.barTintColor = appearance.barTintColor
            self.tintColor = appearance.tintColor
            self.titleTextAttributes = appearance.titleTextAttributes
            self.shadowImage = appearance.shadowImage
            self.clipsToBounds = appearance.shouldClipsToBound
            self.isTranslucent = appearance.isTranslucent
        }
    }
    
    func resetAppearance(){
        if #available(iOS 13.0, *) {
            let app = UINavigationBarAppearance()
            app.configureWithOpaqueBackground()
            standardAppearance = app
            scrollEdgeAppearance = app
            compactAppearance = app
            setNeedsLayout()
        } else {
            self.shadowImage = nil
            self.titleTextAttributes = nil
            self.setBackgroundImage(nil, for: .default)
            self.barTintColor = nil
            self.tintColor = nil
        }
    }
}

