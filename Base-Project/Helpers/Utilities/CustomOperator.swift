//
//  CustomOperator.swift
//  Base-Project
//
//  Created by Mojtaba Al Moussawi on 3/29/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import Foundation
import UIKit


infix operator <=>
func <=>(lhs: UIImage?, rhs: UIImage?) -> Bool {
    if lhs == nil && rhs == nil { return true }
    if lhs == nil { return false }
    if rhs == nil { return false }
    if let lhsData = lhs!.pngData(), let rhsData = rhs!.pngData() {
        return lhsData == rhsData
    }
    return false
}

postfix operator %
postfix func % (percentage: Int) -> Double {
    return (Double(percentage) / 100)
}
