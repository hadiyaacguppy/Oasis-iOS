//
//  PlaceHolderView.swift
//  Base-Project
//
//  Created by Mojtaba Almoussawi on 7/29/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit

public class PlaceHolderView: UIView {
    
    fileprivate
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor.clear
        contentView.isUserInteractionEnabled = true
        contentView.alpha = 0
        return contentView
    }()
    
    fileprivate
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.accessibilityIdentifier = "empty set background image"
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
    fileprivate
    lazy var circularProgressIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        activityIndicator.center = self.center
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(activityIndicator)
        return activityIndicator
    }()
    
    fileprivate
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = UIColor.clear
        
        titleLabel.font = UIFont.systemFont(ofSize: 27.0)
        titleLabel.textColor = UIColor(white: 0.6, alpha: 1.0)
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.accessibilityIdentifier = "empty set title"
        self.contentView.addSubview(titleLabel)
        return titleLabel
    }()
    
    fileprivate
    lazy var detailLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.backgroundColor = UIColor.clear
        
        detailLabel.font = UIFont.systemFont(ofSize: 17.0)
        detailLabel.textColor = UIColor(white: 0.6, alpha: 1.0)
        detailLabel.textAlignment = .center
        detailLabel.lineBreakMode = .byWordWrapping
        detailLabel.numberOfLines = 0
        detailLabel.accessibilityIdentifier = "empty set detail label"
        self.contentView.addSubview(detailLabel)
        return detailLabel
    }()
    
    
    lazy var button: UIButton = {
        let button = UIButton.init(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.accessibilityIdentifier = "empty set button"
        
        self.contentView.addSubview(button)
        return button
    }()
    
    private
    var canShowImage: Bool {
        return imageView.image != nil
    }
    
    private
    var canShowTitle: Bool {
        if let attributedText = titleLabel.attributedText {
            return attributedText.length > 0
        }
        return false
    }
    
    private
    var canShowDetail: Bool {
        if let attributedText = detailLabel.attributedText {
            return attributedText.length > 0
        }
        return false
    }
    
    private
    var canShowButton: Bool {
        if let attributedTitle = button.attributedTitle(for: .normal) {
            return attributedTitle.length > 0
        } else if let _ = button.image(for: .normal) {
            return true
        }
        
        return false
    }
    
    
    var customView: UIView? {
        willSet {
            if let customView = customView {
                customView.removeFromSuperview()
            }
        }
        didSet {
            if let customView = customView {
                customView.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(customView)
            }
        }
    }
    var config : PlaceHolderConfigurator?
    private var fadeInOnDisplay = false
    private var verticalOffset: CGFloat = 0
    private var verticalSpace: CGFloat = 11
    private var progressActive = false
    private var mustShowProgress = false
    
    var didTapContentViewHandle: (() -> Void)?
    var didTapDataButtonHandle: (() -> Void)?
    var willAppearHandle: (() -> Void)?
    var didAppearHandle: (() -> Void)?
    var willDisappearHandle: (() -> Void)?
    var didDisappearHandle: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMoveToSuperview() {
        if let superviewBounds = superview?.bounds {
            frame = CGRect(x: 0, y: 0, width: superviewBounds.width, height: superviewBounds.height)
        }
        if fadeInOnDisplay {
            UIView.animate(withDuration: 0.25) {
                self.contentView.alpha = 1
            }
        } else {
            contentView.alpha = 1
        }
    }
    
    // MARK: - Action Methods
    
    func removeAllConstraints() {
        removeConstraints(constraints)
        contentView.removeConstraints(contentView.constraints)
    }
    
    func prepareForReuse() {
        titleLabel.text = nil
        detailLabel.text = nil
        imageView.image = nil
        progressActive = false
        mustShowProgress = false
        button.backgroundColor = .clear
        button.dropShadow = false
        button.rounded = false
        button.layer.cornerRadius = 0
        button.setImage(nil, for: .normal)
        button.setImage(nil, for: .highlighted)
        button.setAttributedTitle(nil, for: .normal)
        button.setAttributedTitle(nil, for: .highlighted)
        button.setBackgroundImage(nil, for: .normal)
        button.setBackgroundImage(nil, for: .highlighted)
        customView = nil
        
        removeAllConstraints()
    }
    
    
    // MARK: - Auto-Layout Configuration
    func setupConstraints() {
        
        // First, configure the content view constaints
        // The content view must alway be centered to its superview
        let centerXConstraint = NSLayoutConstraint(item: contentView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        
        self.addConstraints([centerXConstraint, centerYConstraint])
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView]|", options: [], metrics: nil, views: ["contentView": contentView]))
        
        // When a custom offset is available, we adjust the vertical constraints' constants
        if (verticalOffset != 0 && constraints.count > 0) {
            centerYConstraint.constant = verticalOffset
        }
        
        if let customView = customView {
            let centerXConstraint = NSLayoutConstraint(item: customView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
            let centerYConstraint = NSLayoutConstraint(item: customView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
            
            let customViewHeight = customView.frame.height
            let customViewWidth = customView.frame.width
            var heightConstarint: NSLayoutConstraint!
            var widthConstarint: NSLayoutConstraint!
            
            if(customViewHeight == 0) {
                heightConstarint = NSLayoutConstraint(item: customView, attribute: .height, relatedBy: .lessThanOrEqual, toItem: self, attribute: .height, multiplier: 1, constant: 0.0)
            } else {
                heightConstarint = NSLayoutConstraint(item: customView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: customViewHeight)
            }
            if(customViewWidth == 0) {
                widthConstarint = NSLayoutConstraint(item: customView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: self, attribute: .width, multiplier: 1, constant: 0.0)
            } else {
                widthConstarint = NSLayoutConstraint(item: customView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: customViewWidth)
            }
            
            // When a custom offset is available, we adjust the vertical constraints' constants
            if (verticalOffset != 0) {
                centerYConstraint.constant = verticalOffset
            }
            self.addConstraints([centerXConstraint, centerYConstraint])
            self.addConstraints([heightConstarint, widthConstarint])
            //            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[customView]|", options: [], metrics: nil, views: ["customView": customView]))
            //            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[customView]|", options: [], metrics: nil, views: ["customView": customView]))
        } else {
            
            let width = frame.width > 0 ? frame.width : UIScreen.main.bounds.width
            let padding = roundf(Float(width/16))
            let verticalSpace = self.verticalSpace  // Default is 11 pts
            
            var subviewStrings: [String] = []
            var views: [String: UIView] = [:]
            let metrics = ["padding": padding]
            
            // Assign the image view's horizontal constraints
            if canShowImage {
                imageView.isHidden = false
                circularProgressIndicator.isHidden = true
                subviewStrings.append("imageView")
                views[subviewStrings.last!] = imageView
                
                contentView.addConstraint(NSLayoutConstraint.init(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
            } else {
                imageView.isHidden = true
                circularProgressIndicator.isHidden = !mustShowProgress
                subviewStrings.append("circularProgress")
                if progressActive{
                    circularProgressIndicator.startAnimating()
                }else{
                    circularProgressIndicator.stopAnimating()
                }
                views[subviewStrings.last!] = circularProgressIndicator
                contentView.addConstraint(NSLayoutConstraint.init(item: circularProgressIndicator, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
            }
            
            // Assign the title label's horizontal constraints
            if (canShowTitle) {
                titleLabel.isHidden = false
                subviewStrings.append("titleLabel")
                views[subviewStrings.last!] = titleLabel
                
                contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(padding)-[titleLabel(>=0)]-(padding)-|", options: [], metrics: metrics, views: views))
            } else {
                titleLabel.isHidden = true
            }
            
            // Assign the detail label's horizontal constraints
            if (canShowDetail) {
                detailLabel.isHidden = false
                subviewStrings.append("detailLabel")
                views[subviewStrings.last!] = detailLabel
                
                contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(padding)-[detailLabel(>=0)]-(padding)-|", options: [], metrics: metrics, views: views))
            } else {
                detailLabel.isHidden = true
            }
            
            // Assign the button's horizontal constraints
            if (canShowButton) {
                button.isHidden = false
                subviewStrings.append("button")
                
                views[subviewStrings.last!] = button
                contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(padding)-[button(>=0)]-(padding)-|", options: [], metrics: ["padding" : width/4], views: views))
            } else {
                button.isHidden = true
            }
            
            var verticalFormat = String()
            
            // Build a dynamic string format for the vertical constraints, adding a margin between each element. Default is 11 pts.
            for i in 0 ..< subviewStrings.count {
                let string = subviewStrings[i]
                verticalFormat += "[\(string)]"
                
                if i < subviewStrings.count - 1 {
                    verticalFormat += "-(\(verticalSpace))-"
                }
            }
            
            // Assign the vertical constraints to the content view
            if !verticalFormat.isEmpty {
                contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|\(verticalFormat)|", options: [], metrics: metrics, views: views))
            }
            
        }
        
    }
    
}



extension PlaceHolderView {
    
    
    /// Set title for the PlaceHolder
    /// Fixed font style will be used by defualt, if no attributes are set. If you want a different font style, return a attributed string.
    @discardableResult
    public func titleLabelString(_ attributedString: NSAttributedString?) -> Self {
        titleLabel.attributedText = attributedString
        return self
    }
    
    /// Set description for the PlaceHolder
    /// Fixed font style will be used by defualt, if no attributes are set. If you want a different font style, return a attributed string.
    @discardableResult
    public func detailLabelString(_ attributedString: NSAttributedString?) -> Self {
        detailLabel.attributedText = attributedString
        return self
    }
    
    /// Set the image for the PlaceHolder
    @discardableResult
    public func image(_ image: UIImage?) -> Self {
        imageView.image = image
        return self
    }
    
    /// Set the tint color of the Image. Default is nil.
    @discardableResult
    public func imageTintColor(_ imageTintColor: UIColor?) -> Self {
        imageView.tintColor = imageTintColor
        return self
    }
    
    ///
    @discardableResult
    public func imageAnimation(_ imageAnimation: CAAnimation?) -> Self {
        if let ani = imageAnimation {
            imageView.layer.add(ani, forKey: nil)
        }
        return self
    }
    
    ///  Title to be used for the specified button state.
    /// Fixed font style will be used by defualt, if no attributes are set. If you want a different font style, return a attributed string.
    @discardableResult
    public func buttonTitle(_ buttonTitle: NSAttributedString?, for state: UIControlState) -> Self {
        button.setAttributedTitle(buttonTitle, for: state)
        return self
    }
    
    /// Image to be used for the specified button state.
    
    @discardableResult
    public func buttonImage(_ buttonImage: UIImage?, for state: UIControlState) -> Self {
        button.setImage(buttonImage, for: state)
        return self
    }
    
    @discardableResult
    public func setButtonBorderWidth(_ width : CGFloat?) -> Self{
        button.layer.borderWidth = width ?? 0
        return self
    }
    
    @discardableResult
    public func setButtonBorderColor(_ borderColor : UIColor?) -> Self{
        button.layer.borderColor = borderColor?.cgColor ?? UIColor.clear.cgColor
        return self
    }
    
    @discardableResult
    public func setButtonBackgroundColor(_ backgroundColor : UIColor?) -> Self{
        button.backgroundColor = backgroundColor
        return self
    }
    
    /*
    @discardableResult
    public func setButtonSize(_ size : CGSize?) -> Self{
        if size != nil {
            button.frame.size = size!
        }
        return self
    }
    */
    
    @discardableResult
    public func isButtonRounded(_ rounded : Bool?) -> Self{
        if rounded != nil {
            button.rounded = rounded!
        }
        return self
    }
    
    @discardableResult
    public func buttonCornerRadius(_ cornerRaduis : CGFloat? ) -> Self{
        button.layer.cornerRadius = cornerRaduis ?? CGFloat(0)
        return self
    }
    
    @discardableResult
    public func shouldAddButtonShadow(_ bool : Bool?) -> Self{
        if bool != nil {
            button.dropShadow = bool!
            self.layer.shadowRadius = 5
        }
        return self
    }
    
    /// The Background image to be used for the specified button state.
    /// There is no default style for this call.
    @discardableResult
    public func buttonBackgroundImage(_ buttonBackgroundImage: UIImage?, for state: UIControlState) -> Self {
        button.setBackgroundImage(buttonBackgroundImage, for: state)
        return self
    }
    
    /// The Background color of the dataset. Default is clear color.
    @discardableResult
    public func dataSetBackgroundColor(_ backgroundColor: UIColor?) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }
    
    /// A custom view to be displayed instead of the default views such as labels, imageview and button. Default is nil.
    /// Use this method to show an activity view indicator for loading feedback, or for complete custom empty data set.
    /// Returning a custom view will ignore -offsetForEmptyDataSet and -spaceHeightForEmptyDataSet configurations.
    @discardableResult
    public func customView(_ customView: UIView?) -> Self {
        self.customView = customView
        return self
    }
    
    /// Sets offset for vertical alignment of the content. Default is 0.
    @discardableResult
    public func verticalOffset(_ offset: CGFloat) -> Self {
        verticalOffset = offset
        return self
    }
    
    /// Set vertical space between elements. Default is 11 pts.
    @discardableResult
    public func verticalSpace(_ space: CGFloat) -> Self {
        verticalSpace = space
        return self
    }
    
    
    /// This method used to set if the PlaceHolderView should fade in when displayed. Default is true.
    @discardableResult
    public func shouldFadeIn(_ bool: Bool) -> Self {
        fadeInOnDisplay = bool
        return self
    }
    
    /// This method used to set if the PlaceHolderView should be rendered and displayed. Default is true.
    @discardableResult
    public func shouldDisplay(_ bool: Bool) -> Self {
        isHidden = !bool
        return self
    }
    
    /// Set if user interaction allowed. Default is true.
    @discardableResult
    public func isTouchAllowed(_ bool: Bool) -> Self {
        isUserInteractionEnabled = bool
        return self
    }
    
    /// set Scroll permission. Default is false.
    @discardableResult
    public func isScrollAllowed(_ bool: Bool) -> Self {
        if let superview = superview as? UIScrollView {
            superview.isScrollEnabled = bool
        }
        return self
    }
    
    /// Get image view animation permission. Default is false.
    /// Make sure to return a valid CAAnimation object from imageAnimationForEmptyDataSet:
    @discardableResult
    public func isImageViewAnimateAllowed(_ bool: Bool) -> Self {
        if !bool {
            imageView.layer.removeAllAnimations()
        }
        return self
    }
    
    ///State whether the Activity Indicator must start animating. Defaukt is false.
    @discardableResult
    public func shouldStartAnimatingProgress(_ bool : Bool) -> Self{
        progressActive = bool
        return self
    }
    
    ///Default is false.
    @discardableResult
    public func mustShowProgress(_ bool : Bool) -> Self{
        mustShowProgress = bool
        return self
    }
    
    
    /// Tells the PlaceHolderView that the view was tapped.
    /// Use this method either to resignFirstResponder of a textfield or searchBar.
    @discardableResult
    public func didTapContentView(_ closure: @escaping () -> (Void)) -> Self {
        didTapContentViewHandle = closure
        return self
    }
    
    /// Tells the PlaceHolderView that the action button was tapped.
    @discardableResult
    public func didTapDataButton(_ closure: @escaping () -> (Void)) -> Self {
        didTapDataButtonHandle = closure
        return self
    }
    
    
}
