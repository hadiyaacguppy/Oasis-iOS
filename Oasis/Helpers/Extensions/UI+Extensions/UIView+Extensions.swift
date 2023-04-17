//
//  UIView+Extensions.swift
//  Oasis
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
    
    func removeFrameStyle(){
        layer.borderColor =  UIColor.clear.cgColor
        layer.borderWidth = 0
        
        if #available(iOS 11.0, *) {
                layer.cornerRadius = 0
        } else {
            layer.mask = nil
        }
    }
    
    func applyFrameStyle(roundCorners: UIView.RoundCorners, border: UIView.Border) {
        
        let borderLayer = CAShapeLayer()
        
        var cornerRadius: CGFloat = 0
        var corners: UIRectCorner = []
        (corners, cornerRadius) = roundCorners.cornerValues ?? ([], 0)
        
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: size)
        
        if !corners.isEmpty && cornerRadius > 0 {
            
            if #available(iOS 11.0, *) {
                if let maskedCorners = roundCorners.transformToCornerMask(){
                    layer.cornerRadius = cornerRadius
                    layer.maskedCorners = .init(arrayLiteral: maskedCorners)
                    
                }
            } else {
                let maskLayer = CAShapeLayer()
                maskLayer.path = path.cgPath
                layer.mask = maskLayer
            }
            
        }
        
        if let borderValues = border.borderValues {
            if #available(iOS 11.0, *) {
                layer.borderColor =  borderValues.color.cgColor
                layer.borderWidth = borderValues.width
            }else{
                borderLayer.path = path.cgPath
                borderLayer.fillColor = UIColor.clear.cgColor
                borderLayer.strokeColor = borderValues.color.cgColor
                borderLayer.lineWidth = borderValues.width
                borderLayer.frame = bounds
                layer.addSublayer(borderLayer)
            }
        }
        if !border.hasBorder{
            layer.borderColor =  UIColor.clear.cgColor
            layer.borderWidth = 0
        }
    }
    
    @discardableResult
    func onTap( _ action : (() -> ())? ) -> Disposable{
        return self.rx.tap().bind{action?()}
    }
    
    /// Height of view.
    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    func searchVisualEffectsSubview() -> UIVisualEffectView? {
        if let visualEffectView = self as? UIVisualEffectView {
            return visualEffectView
        } else {
            for subview in subviews {
                if let found = subview.searchVisualEffectsSubview() {
                    return found
                }
            }
        }
        return nil
    }
    
    /// This is the function to get subViews of a view of a particular type
    /// https://stackoverflow.com/a/45297466/5321670
    func subViews<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T{
                all.append(aView)
            }
        }
        return all
    }
    
    
    /// This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T
    /// https://stackoverflow.com/a/45297466/5321670
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
    
    /*
     This function creates any UIView from nib file by inferring its type.
     Usage: let myCustomView: CustomView = UIView.fromNib()
     Or even : let myCustomView: CustomView = .fromNib()
     */
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

//MARK:- SafeArea&Constraints
extension UIView{
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat,
                paddingRight: CGFloat, width: CGFloat = 0, height: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor { safeAreaLayoutGuide.topAnchor }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor { safeAreaLayoutGuide.leftAnchor }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor { safeAreaLayoutGuide.bottomAnchor }

    var safeRightAnchor: NSLayoutXAxisAnchor { safeAreaLayoutGuide.rightAnchor }
}

extension UIView {
    @discardableResult
    func cornerRadius(_ radius: CGFloat) -> Self {
        self.layer.cornerRadius = radius
        clipsToBounds = true
        return self
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach({ addSubview($0) })
    }
    
    @discardableResult
    func disablingAutoresizing() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    @discardableResult
    func height(_ constant: CGFloat) -> Self {
        heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func width(_ constant: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func autoLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    func removeAllSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    

    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.frame = bounds
        mask.path = path.cgPath
        layer.mask = mask
    }
}

//MARK:- Constraints
extension UIView{
    func fillInSuperView(top: CGFloat = 0,
                         leading: CGFloat = 0,
                         bottom: CGFloat = 0,
                         trailing: CGFloat = 0) {
        if let superView = superview {
            translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superView.topAnchor, constant: top),
                bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -abs(bottom)),
                leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: leading),
                trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -abs(trailing))
            ])
        }
    }
}

extension NSObject {

    class var className: String {
        return String(describing: self)
    }
}

//MARK: - Enable/Disable
extension UIView{
    func enableView(){
        self.alpha = 1
        self.isUserInteractionEnabled = true
    }

    func disableView(){
        self.alpha = 0.5
        self.isUserInteractionEnabled = false
    }
}

//MARK: - Screenshots
extension UIView{
    func screenshotForCroppingRect(croppingRect:CGRect) -> UIImage? {

        UIGraphicsBeginImageContextWithOptions(croppingRect.size, false, UIScreen.main.scale);

        let context = UIGraphicsGetCurrentContext()
        if context == nil {
            return nil;
        }

        context!.translateBy(x: -croppingRect.origin.x, y: -croppingRect.origin.y)
        self.layoutIfNeeded()
        self.layer.render(in: context!)

        let screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshotImage
    }

    @objc var screenshot : UIImage? {
        return self.screenshotForCroppingRect(croppingRect: self.bounds)
    }
    
    static func build<T: UIView>(_ builder: ((T) -> Void)? = nil) -> T {
        let view = T()
        view.translatesAutoresizingMaskIntoConstraints = false
        builder?(view)

        return view
    }
}

