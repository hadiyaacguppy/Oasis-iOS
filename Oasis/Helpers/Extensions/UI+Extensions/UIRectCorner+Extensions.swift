//
//  UIRect+Extensions.swift
//  Oasis
//
//  Created by Mojtaba Al Moussawi on 6/19/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit

extension UIRectCorner {
    static let top: UIRectCorner = [.topLeft, .topRight]
    static let bottom: UIRectCorner = [.bottomLeft, .bottomRight]
    static let topLeftBottomRight : UIRectCorner = [.topLeft,.bottomRight]
    static let topRightBottomLeft : UIRectCorner = [.topRight,.bottomLeft]
    static let topLeftBottomLeft : UIRectCorner = [.topLeft,.bottomLeft]
    static let topRightBottomRight : UIRectCorner = [.topRight,.bottomRight]
    static let none: UIRectCorner = []
}
