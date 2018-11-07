//
//  UITextField+Extensions.swift
//  Base-Project
//
//  Created by Wassim on 4/13/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
extension UITextField {
    
    @IBInspectable var leftPaddingWidth: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var rigthPaddingWidth: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }

    public func addToolBar(){
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.resignFirstResponder))
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.items = [flexibleItem , barButton]
        self.inputAccessoryView = toolbar
    }
  
}
