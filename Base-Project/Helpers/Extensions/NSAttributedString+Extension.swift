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
