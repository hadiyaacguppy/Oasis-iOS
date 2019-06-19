//
//  UIView+CornerRounded.swift
//  Base-Project
//
//  Created by Mojtaba Al Moussawi on 6/19/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit

extension UIView {
    
    /** Corner radius of the view - Specifies the corners */
    enum RoundCorners: Equatable {
        
        /** *None* of the corners will be round */
        case none
        
        /** *All* of the corners will be round */
        case all(radius: CGFloat)
        
        /** Only the *top* left and right corners will be round */
        case top(radius: CGFloat)
        
        /** Only the *top* right corner will be round */
        case topRight(radius: CGFloat)
        
        /** Only the *top* left  corner will be round */
        case topLeft(radius: CGFloat)
        
        /** Only the *bottom* left and right corners will be round */
        case bottom(radius: CGFloat)
        
        /** Only the *bottom* right corner will be round */
        case bottomRight(radius: CGFloat)
        
        /** Only the *bottom* left corner will be round */
        case bottomLeft(radius: CGFloat)
        
        var hasRoundCorners: Bool {
            switch self {
            case .none:
                return false
            default:
                return true
            }
        }
        
        var cornerValues: (value: UIRectCorner, radius: CGFloat)? {
            switch self {
            case .all(radius: let radius):
                return (value: .allCorners, radius: radius)
            case .top(radius: let radius):
                return (value: .top, radius: radius)
            case .bottom(radius: let radius):
                return (value: .bottom, radius: radius)
            case .none:
                return nil
            case .topRight(let radius):
                return (value: .topRight, radius: radius)
            case .topLeft(let radius):
                return (value: .topLeft, radius: radius)
            case .bottomRight(let radius):
                return (value: .bottomRight, radius: radius)
            case .bottomLeft(let radius):
                return (value: .bottomLeft, radius: radius)
            }
        }
        
        static func == (lhs: RoundCorners, rhs: RoundCorners) -> Bool {
            switch (lhs, rhs) {
                
            case (.none,.none):
                return true
                
            case let (.all( lRadius), .all( rRadius)):
                return lRadius == rRadius
            case (.top(let lRadius), .top(let rRadius)):
                return lRadius == rRadius
            case (.topRight(let lRadius), .topRight(let rRadius)):
                return lRadius == rRadius
            case (.topLeft(let lRadius), .topLeft(let rRadius)):
                return lRadius == rRadius
            case (.bottom(let lRadius), .bottom(let rRadius)):
                return lRadius == rRadius
            case (.bottomRight(let lRadius), .bottomRight(let rRadius)):
                return lRadius == rRadius
            case (.bottomLeft(let lRadius), .bottomLeft(let rRadius)):
                return lRadius == rRadius
                
            default:
                return false
            }
        }
    }
}

