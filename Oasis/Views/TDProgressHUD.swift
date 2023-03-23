//
//  TDProgressHUD.swift
//  Oasis
//
//  Created by Hadi on 12/12/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit

class TDProgressHUD: UIVisualEffectView {
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    var indicatorStyle : UIActivityIndicatorView.Style = .gray{
        didSet{
            activityIndictor.style = indicatorStyle
        }
    }

    private var blurEffectStyle : UIBlurEffect.Style!
    private var activityIndictor: UIActivityIndicatorView!
    private var blurEffect : UIBlurEffect!
    private let label: UILabel = UILabel()
    private let vibrancyView: UIVisualEffectView
    
    init(text: String, indicatorStyle : UIActivityIndicatorView.Style, blurEffectStyle : UIBlurEffect.Style) {
        self.text = text
        self.indicatorStyle = indicatorStyle
        self.blurEffectStyle = blurEffectStyle
        self.blurEffect = UIBlurEffect(style: blurEffectStyle)
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.indicatorStyle = .gray
        self.blurEffectStyle = .dark
        self.blurEffect = UIBlurEffect(style: self.blurEffectStyle)
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        activityIndictor = UIActivityIndicatorView(style: indicatorStyle)
        contentView.addSubview(vibrancyView)
        contentView.addSubview(activityIndictor)
        contentView.addSubview(label)
        activityIndictor.startAnimating()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            
            let width = superview.frame.size.width / 2.3
            let height: CGFloat = 50.0
            self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2,
                                y: superview.frame.height / 2 - height / 2,
                                width: width,
                                height: height)
            vibrancyView.frame = self.bounds
            
            let activityIndicatorSize: CGFloat = 40
            activityIndictor.frame = CGRect(x: 5,
                                            y: height / 2 - activityIndicatorSize / 2,
                                            width: activityIndicatorSize,
                                            height: activityIndicatorSize)
            
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            label.text = text
            label.textAlignment = NSTextAlignment.center
            label.frame = CGRect(x: activityIndicatorSize + 5,
                                 y: 0,
                                 width: width - activityIndicatorSize - 15,
                                 height: height)
            label.textColor = UIColor.gray
            label.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
}
