//
//  SettingsClickableOptionView.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 24/04/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import UIKit

class SettingsClickableOptionView: BaseUIView {
    
    lazy var titleLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.medium.with(size: 14),
                          color: .black)
        lbl.autoLayout()
        return lbl
    }()
    
    private var iconImageView : BaseImageView = {
        let view = BaseImageView(frame: .zero)
        view.autoLayout()
        view.backgroundColor = .clear
        return view
    }()
    
    
    init(title : String, iconName : String, height: CGFloat) {
        super.init(frame: .zero)
        setupUI()
        
        self.titleLabel.text = title
        self.iconImageView.image = UIImage(named: iconName)?.withRenderingMode(.alwaysOriginal)
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
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
        self.shadow = .active(with: .init(color: .gray,
                                          opacity: 0.3,
                                          radius: 6))
        self.roundCorners = .all(radius: 20)
        self.backgroundColor = Constants.Colors.lightGrey

        self.addSubview(iconImageView)
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 17),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

