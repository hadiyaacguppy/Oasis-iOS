//
//  CGPoint+Extensions.swift
//  Oasis
//
//  Created by Wassim on 11/9/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit

public extension CGPoint {
    /// Overloads + operator for two CGPoints addition
    ///
    /// - parameter lhs: as lef hand side parameter - CGPoint type
    /// - parameter rhs: as right hand side parameter - CGPoint type
    ///
    /// - returns: new CGPoint calculated from adding two given points
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return self.init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    /// Overloads - operator for two CGPoints substraction
    ///
    /// - parameter lhs: as lef hand side parameter - CGPoint type
    /// - parameter rhs: as right hand side parameter - CGPoint type
    ///
    /// - returns: new CGPoint calculated from substractiong two given points
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return self.init(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}
