//
//  UIApplication+Extensions.swift
//  Oasis
//
//  Created by Wassim on 7/6/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit
extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

//MARK:- SafeArea
extension UIApplication{

    var windowSafeAreaInsets : UIEdgeInsets{ self.windows.first{$0.isKeyWindow }?.safeAreaInsets ?? .zero }
     
    var bottomWindowIndicatorHeight : CGFloat{ self.windows.first{$0.isKeyWindow }?.safeAreaInsets.bottom ?? 0 }
}
