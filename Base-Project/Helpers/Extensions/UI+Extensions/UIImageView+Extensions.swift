//
//  UIImageView+Extensions.swift
//  Base-Project
//
//  Created by Mojtaba Al Mousawi on 8/8/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView{
    
    
    /// Sets the image by using SDWebImage Library with the provided url,with activity indicator enabled.
    /// To set image with more option take a look at setImage method.
    /// - Parameter url: url that holds the image link
    func setNormalImage(withURL url : URL?){
        self.setImage(forURL: url,
                      withIndicatorEnabled: true,
                      andIndicatorStyle: .gray
        )
    }
    
    /// Flexible method to set the image using SDWebImage Library wihtout getting touch with the library details.
    ///
    /// - Parameters:
    ///   - url: The link for the image to set.
    ///   - activityEnabled: Enable or disable the activity indicator
    ///   - style: supported styles, gray,white and largeWhite.
    ///   - placeholderImage: a placeHolder image to show when the image is not available. Default a lightGray image.
    func setImage(forURL url : URL?,
                  withIndicatorEnabled activityEnabled : Bool? = nil,
                  andIndicatorStyle style : UIActivityIndicatorViewStyle,
                  withPlaceHolderImage placeholderImage : UIImage? = nil){
        
        if let enabled = activityEnabled{
            self.sd_setShowActivityIndicatorView(enabled)
            self.sd_setIndicatorStyle(style)
        }
        
        guard placeholderImage != nil else{
            self.sd_setImage(with: url,
                             placeholderImage: UIImage.from(color: .lightGray),
                             completed: nil
            )
            return
        }
        
        self.sd_setImage(with: url,
                         placeholderImage: placeholderImage!,
                         completed: nil
        )
        
    }
}
