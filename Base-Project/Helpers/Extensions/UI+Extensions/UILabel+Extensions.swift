//
//  UILabel+Extensions.swift
//  Base-Project
//
//  Created by Wassim Seifeddine on 12/6/17.
//  Copyright © 2017 Tedmob. All rights reserved.
//

import Foundation
import UIKit
extension UILabel {
    @IBInspectable var adjustWidthDynamically: Bool {
        get {
            return self.adjustsFontSizeToFitWidth
        } set {
            self.adjustsFontSizeToFitWidth = newValue
        }
    }
    
    var isTruncated : Bool {
        guard let string = text else {
            return false
        }
        
        let rectSize = CGSize(width: self.frame.width, height: .greatestFiniteMagnitude)
        let size: CGSize = (string as NSString).boundingRect(with: rectSize,
                                                             options: .usesLineFragmentOrigin,
                                                             attributes: [NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)],
                                                             context: nil).size
        return (size.height > self.bounds.size.height)
    }
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
}
