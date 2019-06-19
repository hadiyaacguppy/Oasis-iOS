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
    
    
    public var shadow = UIView.Shadow.none{
        didSet{
            configureDropShadow()
        }
    }
    
    public var roundCorners = UIView.RoundCorners.none{
        didSet{
            self.applyFrameStyle(roundCorners: roundCorners, border: border)
        }
    }
    
    public var border = UIView.Border.none{
        didSet{
            self.applyFrameStyle(roundCorners: roundCorners, border: border)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if roundCorners == .none && border == .none{
            return
        }
        self.applyFrameStyle(roundCorners: roundCorners, border: border)
    }
    
    deinit {
        disposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let activityIndicatorPosition : UIView.ActivityIndicatorPostion = shouldReplacedWhenLoading ? .bounds : .center
        let replaceByBinder = self.rx.addLoadingIndicator(color: self.activityIndicatorColor,
                                                          position: activityIndicatorPosition)
        isBusy.asObservable()
            .bind(to: replaceByBinder)
            .disposed(by: disposeBag)
        
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
    
    
    
    // Apply drop shadow
    private func configureDropShadow() {
        switch shadow {
        case .active(with: let value):
            applyDropShadow(withOffset: value.offset, opacity: value.opacity, radius: value.radius, color: value.color)
            self.layer.cornerRadius = 15
            self.layer.masksToBounds = false
        case .none:
            removeDropShadow()
        }
    }
}
