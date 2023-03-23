//
//  UIScreen+Extensions.swift
//  Oasis
//
//  Created by Wassim on 11/9/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//
import UIKit


import Foundation
extension UIScreen {
    
    public class var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    public class var heightWithoutStatusBar: CGFloat {
        return currentOrientation.isPortrait ? height - statusBarHeight :
            UIScreen.main.bounds.size.width - statusBarHeight
    }
    
    
    @objc public class var currentOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    @objc public class var size: CGSize {
        return CGSize(width: width, height: height)
    }
    
    @objc public class var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    @objc public class var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
}
