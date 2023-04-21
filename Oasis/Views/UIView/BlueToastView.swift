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
        lbl.style = .init(font: MainFont.medium.with(size: 12),
                          color: .white)
        lbl.autoLayout()
        return lbl
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
        self.roundCorners = .all(radius: 17)
        self.backgroundColor = Constants.Colors.blueToastViewColor
        
        self.addSubview(noteLabel)
        
        NSLayoutConstraint.activate([
            self.noteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            self.noteLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.noteLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        noteLabel.text = noteText
    }
}

