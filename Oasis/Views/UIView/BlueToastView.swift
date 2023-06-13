//
//  BlueToastView.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 21/04/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import UIKit

class BlueToastView: BaseUIView {
    
    lazy var noteLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.medium.with(size: 15),
                          color: .white)
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var exitImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.navClose()
        imageView.autoLayout()
        return imageView
    }()
    
    private var noteText : String = ""
    
    init(noteLabelText text : String) {
        super.init(frame: .zero)
        self.noteText = text
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI(){
        self.autoLayout()
        self.roundCorners = .all(radius: 37)
        self.backgroundColor = Constants.Colors.appViolet
        
        self.addSubview(noteLabel)
        self.addSubview(exitImageView)
        
        NSLayoutConstraint.activate([
            self.noteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            self.noteLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.noteLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.exitImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.exitImageView.widthAnchor.constraint(equalToConstant: 24),
            self.exitImageView.heightAnchor.constraint(equalToConstant: 24),
            self.exitImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        noteLabel.text = noteText
    }
}

