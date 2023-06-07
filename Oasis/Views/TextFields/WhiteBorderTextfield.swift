//
//  WhiteBorderTextfield.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/04/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import UIKit

class WhiteBorderTextfield: BaseTextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    lazy var whiteLine : BaseUIView = {
        let vw = BaseUIView()
        vw.backgroundColor = .white
        vw.autoLayout()
        return vw
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPreferences()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPreferences()
    }
    
    func setupPreferences(){
        //self.borderWidth = 1.0
        //self.borderColor = .white
        //self.borderStyle = .line
        
        self.font = MainFont.medium.with(size: 28)
        self.cornerRadius = 14
        self.textColor = .white
        self.backgroundColor = .clear
        self.autoLayout()

        self.addSubview(whiteLine)
        
        whiteLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        whiteLine.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        whiteLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        whiteLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

extension WhiteBorderTextfield {
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
