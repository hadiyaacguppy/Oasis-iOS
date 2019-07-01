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
import RxSwift


fileprivate let kIndicatorViewTag = 998


extension UIView {
    
    enum ActivityIndicatorPostion{
        case center
        case bounds
    }
    
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
    var rounded : Bool {
        get {
            return self.layer.cornerRadius == self.frame.width / 2
        }
        set {
            self.layer.cornerRadius = newValue ? self.frame.width / 2 : 0
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

   
    
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
    
    @objc
    public func translateSubviews() {
        if subviews.isEmpty {
            return
        }
        
        for subview in subviews {
            translate(subview)
            if #available(iOS 9.0, *), let stackView = subview as? UIStackView {
                stackView.arrangedSubviews.forEach {
                    self.translate($0)
                    $0.translateSubviews()
                }
            } else {
                subview.translateSubviews()
            }
        }
    }
    
    private func translate(_ subview: UIView) {
        if let label = subview as? UILabel {
            label.text = NSLocalizedString(label.text ?? "", comment: "")
        } else if let textField = subview as? UITextField {
            textField.text = NSLocalizedString(textField.text ?? "", comment: "")
            textField.placeholder = NSLocalizedString(textField.placeholder ?? "", comment: "")
        } else if let textView = subview as? UITextView {
            textView.text = NSLocalizedString(textView.text, comment: "")
        } else if let button = subview as? UIButton {
            let states: [UIControl.State] = [.normal, .selected, .highlighted, .disabled, .application, .reserved]
            for state in states where button.title(for: state) != nil {
                button.setTitle(NSLocalizedString(button.title(for: state) ?? "", comment: ""), for: state)
            }
        }
    }

    func addActivityIndicator(at postion : ActivityIndicatorPostion,
                              withColor color : UIColor? = .white){
        guard self.viewWithTag(kIndicatorViewTag) == nil else { return }
        createActivityIndicator(at: postion, withColor: color ?? .white)
    }
    
    
    func hideActivityIndicator(at postion : ActivityIndicatorPostion){
        switch postion{
        case .center:
            guard let indicator = self.viewWithTag(kIndicatorViewTag) as? UIActivityIndicatorView else { return }
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        case .bounds:
            guard let indicator = self.superview?.viewWithTag(kIndicatorViewTag) as? UIActivityIndicatorView else { return }
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
        
    }
    
    func createActivityIndicator(at postion : ActivityIndicatorPostion,withColor color : UIColor){
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = color
        //        activityIndicator.activityIndicatorViewStyle = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.tag = kIndicatorViewTag
        activityIndicator.isUserInteractionEnabled = false
        
        switch postion {
        case .center:
            self.addSubview(activityIndicator)
            let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX,
                                                       relatedBy: .equal, toItem: activityIndicator,
                                                       attribute: .centerX,
                                                       multiplier: 1,
                                                       constant: 0)
            self.addConstraint(xCenterConstraint)
            
            let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY,
                                                       relatedBy: .equal, toItem: activityIndicator,
                                                       attribute: .centerY,
                                                       multiplier: 1,
                                                       constant: 0)
            self.addConstraint(yCenterConstraint)
        case .bounds:
            guard let superview = self.superview else {
                self.alpha = 0.5
                self.addSubview(activityIndicator)
                let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX,
                                                           relatedBy: .equal, toItem: activityIndicator,
                                                           attribute: .centerX,
                                                           multiplier: 1,
                                                           constant: 0)
                self.addConstraint(xCenterConstraint)
                
                let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY,
                                                           relatedBy: .equal, toItem: activityIndicator,
                                                           attribute: .centerY,
                                                           multiplier: 1,
                                                           constant: 0)
                self.addConstraint(yCenterConstraint)
                return
            }
            superview.addSubview(activityIndicator)
            superview.bringSubviewToFront(activityIndicator)
            //  activityIndicator.bindFrame(toBounds: self)
            let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX,
                                                       relatedBy: .equal, toItem: activityIndicator,
                                                       attribute: .centerX,
                                                       multiplier: 1,
                                                       constant: 0)
            superview.addConstraint(xCenterConstraint)
            
            let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY,
                                                       relatedBy: .equal, toItem: activityIndicator,
                                                       attribute: .centerY,
                                                       multiplier: 1,
                                                       constant: 0)
            superview.addConstraint(yCenterConstraint)
        }
        
        //Start animating
        activityIndicator.startAnimating()
    }
    
    func applyDropShadow(withOffset offset: CGSize, opacity: Float, radius: CGFloat, color: UIColor) {
        layer.applyDropShadow(withOffset: offset, opacity: opacity, radius: radius, color: color)
    }
    
    func removeDropShadow() {
        layer.removeDropShadow()
    }
    
    func applyFrameStyle(roundCorners: UIView.RoundCorners, border: UIView.Border) {
        
        let borderLayer = CAShapeLayer()
        
        var cornerRadius: CGFloat = 0
        var corners: UIRectCorner = []
        (corners, cornerRadius) = roundCorners.cornerValues ?? ([], 0)
        
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: size)
        
        if !corners.isEmpty && cornerRadius > 0 {
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            layer.mask = maskLayer
        }
        
        if let borderValues = border.borderValues {
            borderLayer.path = path.cgPath
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = borderValues.color.cgColor
            borderLayer.lineWidth = borderValues.width
            borderLayer.frame = bounds
            layer.addSublayer(borderLayer)
        }
    }
    
    @discardableResult
    func onTap( _ action : (() -> ())? ) -> Disposable{
        return self.rx.tap().bind{action?()}
    }
}
