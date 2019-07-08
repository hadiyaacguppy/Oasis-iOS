//
//  UIImageView+Extensions.swift
//  Base-Project
//
//  Created by Mojtaba Al Mousawi on 8/8/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//
import UIKit
import SDWebImage

extension UIImageView{
    
    
    /** The image indicator applied to the ImageView when request is loading */
    enum ImageIndicator {
        /** No indicator */
        case none
        
        /** Progres Indicator */
        case progressIndictor(style : SDWebImageProgressIndicator)
        
        /** Activity Indicator */
        case activityIndicator(style : SDWebImageActivityIndicator)
        
    }
    
    /** Loader Appearance */
    struct ImageLoaderAppearance{
        
        /// placeholder image
        var placeholderImage : UIImage
        
        /// placeholder image contentMode
        var placeholderContentMode : UIView.ContentMode
        
        /// Image indicator Style
        var imageIndicator : ImageIndicator
        
        /// State if the indicator should animate
        var indicatorEnabled : Bool
        
        init(indicatorEnabled : Bool = true,
             imageIndicatorStyle : ImageIndicator,
             placeholderImage : UIImage = UIImage.from(color: .lightGray),
             placeholderContentMode : UIView.ContentMode) {
            self.indicatorEnabled = indicatorEnabled
            self.imageIndicator = imageIndicatorStyle
            self.placeholderImage = placeholderImage
            self.placeholderContentMode = placeholderContentMode
        }
    }
    
    
    /// Sets the image by using SDWebImage Library with the provided url,with activity indicator enabled.
    /// To set image with more option take a look at setImage method.
    /// - Parameter url: url that holds the image link
    func setNormalImage(withURL url : URL?){
        let appearance = ImageLoaderAppearance.init(indicatorEnabled: true,
                                                    imageIndicatorStyle: .activityIndicator(style: .gray),
                                                    placeholderContentMode: self.contentMode
        )
        
        self.setImage(forURL: url,
                      withAppearance: appearance)
    }
    
    /// Flexible method to set the image using SDWebImage Library wihtout getting touch with the library details.
    ///
    /// - Parameters:
    ///   - url: The link for the image to set.
    ///   - appearance: imageLoaderAppearance
    func setImage(forURL url : URL?,
                  withAppearance appearance : ImageLoaderAppearance){
        
        let oldContentModel = self.contentMode
        self.contentMode = appearance.placeholderContentMode
        
        if  appearance.indicatorEnabled {
            switch appearance.imageIndicator{
            case let .progressIndictor(style):
                self.sd_imageIndicator = style
            case let .activityIndicator(style):
                self.sd_imageIndicator = style
            case .none:
                break
            }
        }
        
        self.sd_setImage(with: url, placeholderImage: appearance.placeholderImage){ [weak self](_, _, _, _) in
            guard let self = self else { return }
            self.contentMode = oldContentModel
        }
    }
    
    public func blur(withStyle style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        addSubview(blurEffectView)
        clipsToBounds = true
    }
}
