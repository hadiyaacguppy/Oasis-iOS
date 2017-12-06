//
//  UIView+Extensions.swift
//  Base-Project
//
//  Created by Wassim Seifeddine on 12/6/17.
//  Copyright © 2017 Tedmob. All rights reserved.
//


import UIKit
import GLKit
import Foundation
extension UIView {
    /// Adds the ability to circle the corners of anyview
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        } set {
            layer.borderColor = newValue.cgColor
            layer.masksToBounds = true
        }
    }
    @IBInspectable var borderWidth : CGFloat {
        get {
            return self.layer.borderWidth
        }set{
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var  dropShadow : Bool  {
        
        get {
            
            return self.layer.shadowColor != nil
        }set {
            if newValue {
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowOpacity = 0.5
                self.layer.shadowOffset = CGSize(width: -1, height: 1)
                self.layer.shadowRadius = 1
            }else {
                self.layer.shadowColor = nil
                self.layer.shadowOpacity = 0.0
                self.layer.shadowOffset = CGSize(width: -1, height: 1)
                self.layer.shadowRadius = 0
            }
            
        }
    }
    
    func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue =   CGPoint(x: self.center.x - 10 , y: self.center.y)
        animation.toValue =   CGPoint(x: self.center.x + 10 , y: self.center.y)
        self.layer.add(animation, forKey: "position")
        
    }


}
