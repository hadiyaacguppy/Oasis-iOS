//
//  AppBaseButton.swift
//  Base-Project
//
//  Created by Mohammad Rizk on 2/10/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

class BaseButton: UIButton {
    
    /** button style descriptor */
    public struct ButtonStyle {
        
        /** Font of the title */
        public var titleFont: UIFont
        
        /** Color of the title */
        public var titleColor: UIColor
        
        /** BackgroundColor of the button */
        public var backgroundColor : UIColor
        
        public init(titleFont: UIFont = UIFont.boldSystemFont(ofSize: 15), titleColor: UIColor, backgroundColor: UIColor){
            self.titleFont = titleFont
            self.titleColor = titleColor
            self.backgroundColor = backgroundColor
        }
    }
    
    public var shadow = UIView.Shadow.none{
        didSet{
            configureDropShadow()
        }
    }
    
    public var roundCorners = UIView.RoundCorners.none
    
    public var border = UIView.Border.none
    
    
    private var disposeBag = DisposeBag()
    
    public var isBusy = ActivityIndicator()
    
    //private var buttonTitle: String?
    
    /// default value white
    var activityIndicatorColor : UIColor = .white
    
    
    public
    var style : ButtonStyle = .init(titleFont: UIFont.boldSystemFont(ofSize: 15),
                                    titleColor: .blue,
                                    backgroundColor: .white){
        didSet{
            add(style: style)
        }
    }
    
    override
    func layoutSubviews() {
        super.layoutSubviews()
        self.applyFrameStyle(roundCorners: roundCorners, border: border)
    }
    
    override
    init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    deinit {
        disposeBag = DisposeBag()
    }
    
    required
    init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureButton()
    }
    
    //MARK: - Image
    ///Image UIButton content mode
    var imageViewContentMode: Int = UIView.ContentMode.scaleToFill.rawValue{
        didSet{
            imageView?.contentMode = UIView.ContentMode(rawValue: imageViewContentMode) ?? .scaleToFill
        }
    }
    var imageAlpha: CGFloat = 1.0 {
        didSet {
            if let imageView = imageView {
                imageView.alpha = imageAlpha
            }
        }
    }
    
    //MARK: - Loading
    public var isLoading: Bool = false
    
    private
    lazy var indicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.color = self.activityIndicatorColor
        activityIndicator.center = self.center
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isUserInteractionEnabled = false
        return activityIndicator
    }()
    
    //MARK: - Animations
    var animatedScaleWhenHighlighted: CGFloat = 1.0
    var animatedScaleDurationWhenHighlighted: Double = 0.2
    
    override open var isHighlighted: Bool {
        didSet {
            guard animatedScaleWhenHighlighted != 1.0 else {
                return
            }
            
            if isHighlighted{
                UIView.animate(withDuration: animatedScaleDurationWhenHighlighted, animations: {
                    self.transform = CGAffineTransform(scaleX: self.animatedScaleWhenHighlighted, y: self.animatedScaleWhenHighlighted)
                })
            }
            else{
                UIView.animate(withDuration: animatedScaleDurationWhenHighlighted, animations: {
                    self.transform = CGAffineTransform.identity
                })
            }
        }
    }
    
    var animatedScaleWhenSelected: CGFloat = 1.0
    var animatedScaleDurationWhenSelected: Double = 0.2
    
    override open var isSelected: Bool{
        didSet {
            guard animatedScaleWhenSelected != 1.0 else {
                return
            }
            
            UIView.animate(withDuration: animatedScaleDurationWhenSelected, animations: {
                self.transform = CGAffineTransform(scaleX: self.animatedScaleWhenSelected, y: self.animatedScaleWhenSelected)
            }) { (finished) in
                UIView.animate(withDuration: self.animatedScaleDurationWhenSelected, animations: {
                    self.transform = CGAffineTransform.identity
                })
            }
        }
    }
    
    //MARK: - Ripple button
    var rippleEnabled: Bool = false{
        didSet{
            self.clipsToBounds = true
        }
    }
    var rippleColor: UIColor = UIColor(white: 1.0, alpha: 0.3)
    var rippleSpeed: Double = 1.0
    
    
}


//MARK: ActivityIndicator
extension BaseButton{
    
    /**
     Show a loader inside the button, and enable or disable user interection while loading
     */
    func showLoader(){
        guard self.subviews.contains(indicator) == false else {
            return
        }
        isLoading = true
        self.isUserInteractionEnabled = false
        UIView.transition(with: self, duration: 0.5, options: .curveEaseOut, animations: {
            self.titleLabel?.alpha = 0.0
            self.imageAlpha = 0.0
        }) { (finished) in
            self.addSubview(self.indicator)
            self.centerIndicator()
            self.indicator.startAnimating()
        }
    }
    
    func hideLoader(){
        guard self.subviews.contains(indicator) == true else {
            return
        }
        isLoading = false
        self.isUserInteractionEnabled = true
        self.indicator.stopAnimating()
        self.indicator.removeFromSuperview()
        UIView.transition(with: self, duration: 0.5, options: .curveEaseIn, animations: {
            self.titleLabel?.alpha = 1.0
            self.imageAlpha = 1.0
        }) { (finished) in
        }
    }
    
    private func centerIndicator(){
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX,
                                                   relatedBy: .equal, toItem: indicator,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY,
                                                   relatedBy: .equal, toItem: indicator,
                                                   attribute: .centerY,
                                                   multiplier: 1,
                                                   constant: 0)
        self.addConstraint(yCenterConstraint)
    }
    
}

//MARK: Configuration
extension BaseButton{
    
    fileprivate
    func configureButton(){
        addisBusyObservable()
    }
    
    fileprivate
    func addisBusyObservable(){
        isBusy
            .asObservable()
            .skip(1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (value) in
                switch value {
                case true :
                    self.showLoader()
                case false :
                    self.hideLoader()
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    fileprivate
    func add(style : ButtonStyle){
        self.backgroundColor = style.backgroundColor
        self.tintColor = style.titleColor
        self.titleLabel?.font = style.titleFont
    }
    
    // Apply drop shadow
    fileprivate
    func configureDropShadow() {
        switch shadow {
        case .active(with: let value):
            applyDropShadow(withOffset: value.offset,
                            opacity: value.opacity,
                            radius: value.radius,
                            color: value.color)
        case .none:
            removeDropShadow()
        }
    }
}


//MARK: Ripple Button
extension BaseButton: CAAnimationDelegate{
    
    //MARK: Material touch animation for ripple button
    open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        guard rippleEnabled == true else {
            return true
        }
        
        let tapLocation = touch.location(in: self)
        
        let aLayer = CALayer()
        aLayer.backgroundColor = rippleColor.cgColor
        let initialSize: CGFloat = 20.0
        
        aLayer.frame = CGRect(x: 0, y: 0, width: initialSize, height: initialSize)
        aLayer.cornerRadius = initialSize/2
        aLayer.masksToBounds = true
        aLayer.position = tapLocation
        self.layer.insertSublayer(aLayer, below: self.titleLabel?.layer)
        
        // Create a basic animation changing the transform.scale value
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        // Set the initial and the final values+
        animation.toValue = 10.5 * max(self.frame.size.width, self.frame.size.height) / initialSize
        
        // Set duration
        animation.duration = rippleSpeed
        
        // Set animation to be consistent on completion
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        // Add animation to the view's layer
        let fade = CAKeyframeAnimation(keyPath: "opacity")
        fade.values = [1.0, 1.0, 0.5, 0.5, 0.0]
        fade.duration = 0.5
        
        let animGroup = CAAnimationGroup()
        animGroup.duration = 0.5
        animGroup.delegate = self
        animGroup.animations = [animation, fade]
        animGroup.setValue(aLayer, forKey: "animationLayer")
        aLayer.add(animGroup, forKey: "scale")
        
        return true
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let layer: CALayer? = anim.value(forKeyPath: "animationLayer") as? CALayer
        if layer != nil{
            layer?.removeAnimation(forKey: "scale")
            layer?.removeFromSuperlayer()
        }
    }
}
