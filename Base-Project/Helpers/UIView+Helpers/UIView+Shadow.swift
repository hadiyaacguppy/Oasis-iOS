//
//  File.swift
//  Base-Project
//
//  Created by Mojtaba Al Moussawi on 6/19/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//
import UIKit

extension UIView{
    
    /** The shadow around the view */
    enum Shadow {
        
        /** No shadow */
        case none
        
        /** Shadow with value */
        case active(with: Value)
        
        /** The shadow properties */
        struct Value {
            let radius: CGFloat
            let opacity: Float
            let color: UIColor
            let offset: CGSize
            
            init(color: UIColor = .black, opacity: Float, radius: CGFloat, offset: CGSize = .zero) {
                self.color = color
                self.radius = radius
                self.offset = offset
                self.opacity = opacity
            }
        }
        
        var isActive: Bool {
            switch self {
            case .none:
                return false
            default:
                return true
            }
        }
    }
    
}

extension UIView.Shadow.Value{
    
    static let appDefaultShadow = UIView.Shadow.Value(opacity: 0.8, radius: 2)
    static let offsetAppDefaultShadow = UIView.Shadow.Value(opacity: 0.3, radius: 8, offset: CGSize(width: 0, height: 1))
    
}


