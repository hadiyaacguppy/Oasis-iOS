//
//  BaseLabel.swift
//  Base-Project
//
//  Created by Mojtaba Al Moussawi on 6/19/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit

class BaseLabel : UILabel{
    
    
    /** Label style descriptor */
    public struct LabelStyle {
        
        /** Font of the text */
        public var font: UIFont
        
        /** Color of the text */
        public var color: UIColor
        
        /** Text Alignment */
        public var alignment: NSTextAlignment
        
        /** Number of lines */
        public var numberOfLines: Int
        
        public init(font: UIFont, color: UIColor, alignment: NSTextAlignment = .left, numberOfLines: Int = 0) {
            self.font = font
            self.color = color
            self.alignment = alignment
            self.numberOfLines = numberOfLines
        }
    }
    
    public
    var style : LabelStyle = .init(font: MainFont.normal.with(size: UIFont.systemFontSize), color: .black){
        didSet{
            add(style: style)
        }
    }
    
    required
    init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup()
        
    }
    
    override
    init(frame: CGRect){
        super.init(frame: frame)
        self.setup()
    }
    
    private
    func setup(){
        self.text = self.text
        self.textColor = self.textColor
        self.font = self.font
        self.layer.display()
    }
    
    private
    func add(style : LabelStyle){
        font = style.font
        textAlignment = style.alignment
        numberOfLines = style.numberOfLines
        textColor = style.color
    }
}
