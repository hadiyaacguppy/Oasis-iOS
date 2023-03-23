//
//  BaseButton.swift
//  Oasis
//
//  Created by Mojtaba Al Moussawi on 1/08/22.
//  Copyright © 2022 Tedmob. All rights reserved.
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
        
        public init(titleFont: UIFont = MainFont.bold.with(size: 15),
                    titleColor: UIColor, backgroundColor: UIColor){
            self.titleFont = titleFont
            self.titleColor = titleColor
            self.backgroundColor = backgroundColor
        }
    }
    
    /** button image style descriptor */
    @available(iOS 15.0, *)
    public struct ButtonImageStyle {
        
        /** The foreground image the button displays. */
        public var image: UIImage
        
        /** The distance between the button’s image and text. */
        public var imagePadding: CGFloat
        
        /** he edge against which the button places the image. */
        public var imagePlacement : NSDirectionalRectEdge
        
        /** A block that transforms the image color when the button state changes. */
        public var imageColorTransformer : UIConfigurationColorTransformer?
        
        public init(image: UIImage,
                    imagePadding: CGFloat,
                    imagePlacement: NSDirectionalRectEdge,
                    imageColorTransformer: UIConfigurationColorTransformer? = nil){
            self.image = image
            self.imagePadding = imagePadding
            self.imagePlacement = imagePlacement
            self.imageColorTransformer = imageColorTransformer
        }
    }
    
    /// Shadow to apply on the View
    public var shadow = UIView.Shadow.none{
        didSet{
            configureDropShadow()
        }
    }
    
    //* Backgroundview it's main objective is to add the shadow on it if exists in system versions less than 11
    private var backgroundView : BaseUIView!
    
    private var backgroundViewFrame : CGRect!
    
    ///Animating Corners
    public var isCornersAnimatable : Bool = false {
        didSet{
            removeFrameStyle()
            UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut) {
                self.prepareToApplyFrameStyle()
            }.startAnimation()
        }
    }
    
    ///Corners Animation Duration, default value is 1.0
    public var cornersAnimationDuration : TimeInterval = 1.0
    
    ///Corners Animation, default value is easeInOut
    public var cornersAnimationCurve : UIView.AnimationCurve = .easeInOut
    
    /// Corner value to set on the View
    public var roundCorners = UIView.RoundCorners.none{
        didSet{
            if #available(iOS 15.0, *) {
                applyButtonConfiguration()
            }
            if isCornersAnimatable{
                UIViewPropertyAnimator(duration: cornersAnimationDuration,
                                       curve: cornersAnimationCurve) {
                    self.prepareToApplyFrameStyle()
                }.startAnimation()
            } else { self.prepareToApplyFrameStyle() }
        }
    }
    
    /// Border to set on the View
    public var border = UIView.Border.none{
        didSet{
            if isCornersAnimatable{
                UIViewPropertyAnimator(duration: cornersAnimationDuration,
                                       curve: cornersAnimationCurve) {
                    self.prepareToApplyFrameStyle()
                }.startAnimation()
            } else { self.prepareToApplyFrameStyle() }
        }
    }
    
    private let lockQueue = DispatchQueue(label: "button.configuration.lock.queue")
    
    private let  busyOperationsGroup = DispatchGroup()
    
    private var disposeBag = DisposeBag()
    
    public var isBusy = ActivityIndicator()
    
    private var buttonTitle: String?
    
    /// default value white
    var activityIndicatorColor : UIColor = .white
    
    public
    var style : ButtonStyle = .init(titleFont: MainFont.bold.with(size: 15),
                                    titleColor: .blue,
                                    backgroundColor: .white){
        didSet{
            add(style: style)
        }
    }
    
    private var _imageStyle: Any? = nil{
        didSet{
            if #available(iOS 15.0, *) {
                applyButtonConfiguration()
            }
        }
    }
    
    @available(iOS 15.0, *)
    public var imageStyle: ButtonImageStyle? {
        get {
            return _imageStyle as? ButtonImageStyle
        } set {
            _imageStyle = newValue
        }
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
                UIView.animate(withDuration: animatedScaleDurationWhenHighlighted,
                               animations: {
                    self.transform = CGAffineTransform(scaleX: self.animatedScaleWhenHighlighted,
                                                       y: self.animatedScaleWhenHighlighted)
                })
            }
            else {
                UIView.animate(withDuration: animatedScaleDurationWhenHighlighted,
                               animations: {
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
                self.transform = CGAffineTransform(scaleX: self.animatedScaleWhenSelected,
                                                   y: self.animatedScaleWhenSelected)
            }) { (finished) in
                UIView.animate(withDuration: self.animatedScaleDurationWhenSelected,
                               animations: {
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
    
    var rippleColor: UIColor = UIColor(white: 1.0,
                                       alpha: 0.3)
    var rippleSpeed: Double = 1.0
    
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
}

//MARK:- ViewLifeCycle
extension BaseButton{
    override
    func layoutSubviews() {
        super.layoutSubviews()
        if #available(iOS 11.0, *) {} else {
            if backgroundView != nil {
                backgroundView.frame = backgroundViewFrame
            }
        }
        if roundCorners == .none && border == .none{
            return
        }
        if isCornersAnimatable{
            UIViewPropertyAnimator(duration: cornersAnimationDuration,
                                   curve: cornersAnimationCurve) {
                self.prepareToApplyFrameStyle()
            }.startAnimation()
        } else { self.prepareToApplyFrameStyle() }
    }
}

//MARK:- ActivityIndicator
extension BaseButton{
    /**
     Show a loader inside the button, and enable or disable user interaction while loading
     */
    func showLoader(){
        // lockQueue.sync{
        guard self.subviews.contains(indicator) == false else {
            return
        }
        isLoading = true
        self.isUserInteractionEnabled = false
        UIView.transition(with: self, duration: 0.5,
                          options: .curveEaseOut,
                          animations: {
            if #available(iOS 15.0, *) {
                self.buttonTitle = self.titleLabel?.text
                self.configuration?.title = nil
                self.configuration?.attributedTitle = nil
                self.configuration?.image = nil
            } else {
                let prevTitle = self.titleLabel?.text
                self.setTitle("", for: .normal)
                self.imageAlpha = 0.0
                self.buttonTitle = prevTitle
            }
            
        }) { (finished) in
            self.addSubview(self.indicator)
            self.centerIndicator()
            self.indicator.startAnimating()
            self.busyOperationsGroup.leave()
        }
        //}
    }
    
    func hideLoader(){
        // lockQueue.sync{
        guard self.subviews.contains(indicator) == true else {
            return
        }
        isLoading = false
        self.isUserInteractionEnabled = true
        self.indicator.stopAnimating()
        self.indicator.removeFromSuperview()
        UIView.transition(with: self, duration: 0.5,
                          options: .curveEaseIn,
                          animations: {
            self.setTitle(self.buttonTitle, for: .normal)
            self.imageAlpha = 1.0
            if #available(iOS 15.0, *){
                self.lockQueue.sync {
                    self.configuration?.image = self.imageStyle?.image
                }
            }
        }) { (finished) in
        }
        // }
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

//MARK:- Configuration
extension BaseButton{
    
    private func configureButton(){
        addIsBusyObservable()
    }
    
    private func add(style : ButtonStyle){
        
        if #available(iOS 15.0, *) {
            applyButtonConfiguration()
        } else {
            self.backgroundColor = style.backgroundColor
            self.setTitleColor(style.titleColor, for: .normal)
            self.titleLabel?.font = style.titleFont
        }
    }
    
    @available(iOS 15.0, *)
    private func applyButtonConfiguration() {
        lockQueue.sync {
            var buttonConfig = UIButton.Configuration.filled()
            buttonConfig.baseBackgroundColor = style.backgroundColor
            buttonConfig.baseForegroundColor = style.titleColor
            buttonConfig.cornerStyle = .fixed
            buttonConfig.background.cornerRadius = roundCorners.cornerValues?.radius ?? cornerRadius
            var attText = AttributedString.init(buttonTitle ?? "")
            attText.font = style.titleFont
            buttonConfig.attributedTitle = attText
            if let imageStyle = imageStyle{
                buttonConfig.image = imageStyle.image
                buttonConfig.imagePadding = imageStyle.imagePadding
                buttonConfig.imagePlacement = imageStyle.imagePlacement
                buttonConfig.imageColorTransformer = imageStyle.imageColorTransformer
            }
            self.configuration = buttonConfig
        }
    }
}

//MARK:- Observables
extension BaseButton{
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == "backgroundColor" {
            /// Background color has changed
            /// Your view which backgroundColor it is
            /*
             guard let view = object as? UIView else {return}
             print(view.backgroundColor)
             */
            //OR
            guard let color = change?[.newKey] as? UIColor else {return}
            if self.backgroundView != nil{ self.backgroundView.backgroundColor = color}
        }
    }
    
    private func addIsBusyObservable(){
        isBusy
            .asObservable()
            .skip(1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (value) in
                switch value {
                case true :
                    self.busyOperationsGroup.enter()
                    self.showLoader()
                case false :
                    self.busyOperationsGroup.notify(queue: .main){
                        self.hideLoader()
                    }
                }
            })
            .disposed(by: self.disposeBag)
    }
}

//MARK:- FrameStyle
extension BaseButton{
    /** Before Applying Frame style this method will be called to check,*/
    /** if shadow is enabled and if we are running on iOS less than 11 */
    /** If so, we need to apply corner radius to background view also */
    private func prepareToApplyFrameStyle(){
        if #available(iOS 15.0, *){
            applyiOS15FrameStyle(roundCorners: roundCorners,
                                 border: border)
            return
        }
        if #available(iOS 11.0, *) {
            applyFrameStyle(roundCorners: roundCorners,
                            border: border)
        } else {
            if shadow.isActive{
                if backgroundView != nil {
                    var cornerRadius: CGFloat = 0
                    (_, cornerRadius) = roundCorners.cornerValues ?? ([], 0)
                    backgroundView.cornerRadius =  cornerRadius
                    applyFrameStyle(roundCorners: .all(radius: cornerRadius),
                                    border: border)
                }
            }
        }
    }
}

//MARK:- Shadow
extension BaseButton{
    // Apply drop shadow
    private func configureDropShadow() {
        switch shadow {
        case .active(with: let value):
            if #available(iOS 11.0, *) {
                applyDropShadow(withOffset: value.offset,
                                opacity: value.opacity,
                                radius: value.radius,
                                color: value.color)
            } else {
                if backgroundView == nil {
                    createBackgroundView {
                        applyBackgroundViewShadow(withValue: value)
                    }
                }
            }
            
        case .none:
            if #available(iOS 11.0, *) {
                removeDropShadow()
            } else {
                backgroundView.removeDropShadow()
            }
        }
    }
    
    //Create another view (BackgroundView) for applying Shadow
    private func createBackgroundView(addedCompletion : () -> ()) {
        backgroundView = BaseUIView(frame: .zero)
        self.backgroundViewFrame = CGRect(x: self.frame.origin.x,
                                          y: self.frame.origin.y,
                                          width: bounds.width,
                                          height: bounds.height)
        backgroundView.frame = self.backgroundViewFrame
        backgroundView.backgroundColor = self.backgroundColor
        superview?.insertSubview(backgroundView,
                                 belowSubview: self)
        addedCompletion()
    }
    
    // Apply shadow on backgroundView
    private func applyBackgroundViewShadow(withValue value : UIView.Shadow.Value) {
        backgroundView.applyDropShadow(withOffset: value.offset,
                                       opacity: value.opacity,
                                       radius: value.radius,
                                       color: value.color)
    }
}

//MARK:- Ripple Button
extension BaseButton: CAAnimationDelegate{
    
    //MARK: Material touch animation for ripple button
    open override func beginTracking(_ touch: UITouch,
                                     with event: UIEvent?) -> Bool {
        
        guard rippleEnabled == true else {
            return true
        }
        
        let tapLocation = touch.location(in: self)
        
        let aLayer = CALayer()
        aLayer.backgroundColor = rippleColor.cgColor
        let initialSize: CGFloat = 20.0
        
        aLayer.frame = CGRect(x: 0,
                              y: 0,
                              width: initialSize,
                              height: initialSize)
        aLayer.cornerRadius = initialSize/2
        aLayer.masksToBounds = true
        aLayer.position = tapLocation
        self.layer.insertSublayer(aLayer,
                                  below: self.titleLabel?.layer)
        
        // Create a basic animation changing the transform.scale value
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        // Set the initial and the final values+
        animation.toValue = 10.5 * max(self.frame.size.width,
                                       self.frame.size.height) / initialSize
        
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
    
    public func animationDidStop(_ anim: CAAnimation,
                                 finished flag: Bool) {
        let layer: CALayer? = anim.value(forKeyPath: "animationLayer") as? CALayer
        if layer != nil {
            layer?.removeAnimation(forKey: "scale")
            layer?.removeFromSuperlayer()
        }
    }
}

//MARK:- Button's Title
extension BaseButton{
    override func setTitle(_ title: String?,
                           for state: UIControl.State) {
        guard #available(iOS 15.0, *) else {
            super.setTitle(title, for: state)
            return
        }
        lockQueue.sync {
            guard configuration != nil else {
                buttonTitle = title ?? buttonTitle
                super.setTitle(nil, for: state)
                self.configuration = UIButton.Configuration.filled()
                var attText = AttributedString.init(buttonTitle ?? "")
                attText.font = style.titleFont
                self.configuration!.attributedTitle = attText
                return
            }
            super.setTitle(nil, for: state)
            buttonTitle = title ?? buttonTitle
            var attText = AttributedString.init(buttonTitle ?? "")
            //            attText.obliqueness = 0.2 // To set the slant of the text
            attText.font = style.titleFont
            self.configuration!.attributedTitle = attText
        }
    }
}

//MARK:-
extension BaseButton{
    
    @available(iOS 15.0, *)
    func applyiOS15FrameStyle(roundCorners: UIView.RoundCorners,
                              border: UIView.Border) {
        
        if let borderValues = border.borderValues {
            layer.borderColor =  borderValues.color.cgColor
            layer.borderWidth = borderValues.width
            layer.cornerRadius = configuration?.background.cornerRadius ?? cornerRadius
        }
        if !border.hasBorder {
            layer.borderColor =  UIColor.clear.cgColor
            layer.borderWidth = 0
        }
    }
}
