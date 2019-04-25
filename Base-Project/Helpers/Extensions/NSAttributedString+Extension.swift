//
//  NSAttributedString+Extension.swift
//  Base-Project
//
//  Created by Mojtaba Al Mousawi on 8/16/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import UIKit

extension NSAttributedString {
    ///Returns an NSAttributedString object initialized with a given string and an aligment.
    convenience init(text: String, aligment: NSTextAlignment) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = aligment
        self.init(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
}
extension NSMutableAttributedString {
    
    /*
     
     let attrString = NSMutableAttributedString()
     .appendWith(color: .red , weight: .bold, ofSize: 20, "NOT ALLLOWED \n\n\n")
     .appendWith(color: .white, ofSize: 18.0, "What you are doing is not allowed")

     */
    @discardableResult func appendWith(color: UIColor = UIColor.darkText, weight: UIFont.Weight = .regular, ofSize: CGFloat = 12.0, _ text: String) -> NSMutableAttributedString{
        let attrText = NSAttributedString.makeWith(color: color, weight: weight, ofSize:ofSize, text)
        self.append(attrText)
        return self
    }
    
}
extension NSAttributedString {
    
    public static func makeWith(color: UIColor = UIColor.darkText, weight: UIFont.Weight = .regular, ofSize: CGFloat = 12.0, _ text: String) -> NSMutableAttributedString {
        
        let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: ofSize, weight: weight), NSAttributedString.Key.foregroundColor: color]
        return NSMutableAttributedString(string: text, attributes:attrs)
    }
}
