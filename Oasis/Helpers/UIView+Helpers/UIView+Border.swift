//
//  UIVi.swift
//  Oasis
//
//  Created by Mojtaba Al Moussawi on 6/19/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit

extension UIView {
    
    
    /** The border around the entry */
    enum Border : Equatable {
        
        /** No border */
        case none
        
        /** Border wirh color and width */
        case value(color: UIColor, width: CGFloat)
        
        var hasBorder: Bool {
            switch self {
            case .none:
                return false
            default:
                return true
            }
        }
        
        var borderValues: (color: UIColor, width: CGFloat)? {
            switch self {
            case .value(color: let color, width: let width):
                return(color: color, width: width)
            case .none:
                return nil
            }
        }
        
        static func == (lhs: Border, rhs: Border) -> Bool {
            switch (lhs, rhs) {
                
            case (.none,.none):
                return true
                
            case (.value(let lcolor, let lwidth), .value(let rcolor, let rwidth)):
                return lcolor == rcolor && lwidth == rwidth
                
            default:
                return false
            }
        }
    }
}
