//
//  BaseUIView.swift
//  Base-Project
//
//  Created by Mojtaba Al Moussawi on 3/29/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//


import UIKit
import RxSwift

class BaseUIView: UIView{
    
    private var disposeBag = DisposeBag()
    
    public var isBusy = ActivityIndicator()
    
    /// If true, the view will be replaced by loading progress. Default is false
    public var shouldReplacedWhenLoading : Bool = false
    
    /// Indicates if Hit area of view must be expanded. Default value is false.
    public var shouldExpandHitArea : Bool = false
    
    /// default value white
    public var activityIndicatorColor : UIColor = .white
    
    /// default value is 20
    public var extendedHitAreaValue: CGFloat = 20
    
    //* Backgroundview it's main objective is to apply the shadow on it (if exists) in system versions less than iOS 11
    private var backgroundView : BaseUIView!
    
   private var backgroundViewFrame : CGRect!
    
    /// Shadow to apply on the View
    public var shadow = UIView.Shadow.none{
        didSet{
            configureDropShadow()
        }
    }
    
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
            if isCornersAnimatable{
            UIViewPropertyAnimator(duration: cornersAnimationDuration,
                                   curve: cornersAnimationCurve) {
                self.prepareToApplyFrameStyle()
                }.startAnimation()
            }else { self.prepareToApplyFrameStyle() }
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
            }else { self.prepareToApplyFrameStyle() }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    deinit {
        disposeBag = DisposeBag()
    }
    
    override
    open func point(inside point: CGPoint,
                    with event: UIEvent?)
        -> Bool {
            guard self.shouldExpandHitArea else { return super.point(inside: point, with: event)}
            let relativeFrame = self.bounds
            
            let hitTestEdgeInsets = UIEdgeInsets(top: -extendedHitAreaValue,
                                                 left: -extendedHitAreaValue,
                                                 bottom: -extendedHitAreaValue,
                                                 right: -extendedHitAreaValue)
            
            let hitFrame = relativeFrame.inset(by: hitTestEdgeInsets)
            
            return hitFrame.contains(point)
    }
    
}

//MARK:- ViewLifeCycle
extension BaseUIView{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let activityIndicatorPosition : UIView.ActivityIndicatorPostion = shouldReplacedWhenLoading ? .bounds : .center
        let replaceByBinder = self.rx.addLoadingIndicator(color: self.activityIndicatorColor,
                                                          position: activityIndicatorPosition)
        isBusy.asObservable()
            .bind(to: replaceByBinder)
            .disposed(by: disposeBag)
        
    }
    
    override func layoutSubviews() {
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
        }else { self.prepareToApplyFrameStyle() }
    }
}

//MARK:- Observables
extension BaseUIView{
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == "backgroundColor" {
            guard let color = change?[.newKey] as? UIColor else {return}
            if self.backgroundView != nil{ self.backgroundView.backgroundColor = color}
        }
    }
}

//MARK:- FrameStyle
extension BaseUIView{
    
    /** Before Applying Frame style this method will be called to check,*/
    /** if shadow is enabled and if we are running on iOS less than 11 */
    /** If so, we need to apply corner radius to background view also */
    private func prepareToApplyFrameStyle(){
        if #available(iOS 11.0, *) {
            applyFrameStyle(roundCorners: roundCorners, border: border)
        }else{
            if shadow.isActive{
                if backgroundView != nil {
                    var cornerRadius: CGFloat = 0
                    (_, cornerRadius) = roundCorners.cornerValues ?? ([], 0)
                    backgroundView.cornerRadius =  cornerRadius
                    applyFrameStyle(roundCorners: .all(radius: cornerRadius), border: border)
                }
            }
        }
    }
}

//MARK:- Shadow
extension BaseUIView{
    
    // Apply drop shadow on the actual View
    private func configureDropShadow() {
        switch shadow {
        case .active(with: let value):
            if #available(iOS 11.0, *) {
                applyDropShadow(withOffset: value.offset,
                                opacity: value.opacity,
                                radius: value.radius,
                                color: value.color)
            }else{
                if backgroundView == nil {
                    createBackgroundView {
                        applyBackgroundViewShadow(withValue: value)
                    }
                }
            }
            
        case .none:
            if #available(iOS 11.0, *) {
                removeDropShadow()
            }else{
                backgroundView.removeDropShadow()
            }
        }
    }
    
    //Create another view (BackgroundView) for applying Shadow
    private func createBackgroundView(addedCompletion : () -> ()){
        backgroundView = BaseUIView(frame: .zero)
        self.backgroundViewFrame = CGRect(x: self.frame.origin.x,
                                          y: self.frame.origin.y,
                                          width: bounds.width,
                                          height: bounds.height)
        backgroundView.frame = self.backgroundViewFrame
        backgroundView.backgroundColor = self.backgroundColor
        superview?.insertSubview(backgroundView, belowSubview: self)
        addedCompletion()
    }
    
    // Apply shadow on backgroundView
    private func applyBackgroundViewShadow(withValue value : UIView.Shadow.Value){
        backgroundView.applyDropShadow(withOffset: value.offset,
                                       opacity: value.opacity,
                                       radius: value.radius,
                                       color: value.color)
    }
}
