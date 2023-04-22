//
//  RecentActivityView.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 22/04/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import UIKit

class RecentActivityView: BaseUIView {
    
    lazy var theTitleLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.medium.with(size: 12),
                          color: .black)
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var dateLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.medium.with(size: 11),
                          color: .black)
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var amountLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 12),
                          color: .black,
                          alignment: .right)
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var currencyLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.medium.with(size: 11),
                          color: .black)
        lbl.autoLayout()
        return lbl
    }()
    
    private var iconImageView : BaseImageView = {
        let img = BaseImageView(frame: .zero)
        img.autoLayout()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private var titleText : String = ""
    private var dateText : String = ""
    private var amountText : String = ""
    private var currencyText : String = ""
    
    init(title titleTxt : String, date dateTxt : String, amount amountTxt : String, currency currencyTxt : String, iconName icon: String) {
        super.init(frame: .zero)
        self.titleText = titleTxt
        self.dateText = dateTxt
        self.amountText = amountTxt
        self.currencyText = currencyTxt
        self.iconImageView.image = UIImage(named: icon)
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
        self.shadow = .active(with: .init(color: .gray,
                                          opacity: 0.3,
                                          radius: 6))
        self.roundCorners = .all(radius: 20)
        self.backgroundColor = Constants.Colors.lightGrey
        
        self.addSubview(iconImageView)
        self.addSubview(theTitleLabel)
        self.addSubview(dateLabel)
        self.addSubview(amountLabel)
        self.addSubview(currencyLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            theTitleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20),
            theTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            theTitleLabel.heightAnchor.constraint(equalToConstant: 15),
            theTitleLabel.trailingAnchor.constraint(equalTo: amountLabel.leadingAnchor, constant: 8),
            
            dateLabel.topAnchor.constraint(equalTo: theTitleLabel.bottomAnchor, constant: 1),
            dateLabel.heightAnchor.constraint(equalToConstant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: theTitleLabel.leadingAnchor),
            
            amountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            amountLabel.heightAnchor.constraint(equalToConstant: 15),
            amountLabel.topAnchor.constraint(equalTo: theTitleLabel.topAnchor),
            amountLabel.widthAnchor.constraint(equalToConstant: 80),
            
            currencyLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 1),
            currencyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            currencyLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        theTitleLabel.text = self.titleText
        dateLabel.text = self.dateText
        amountLabel.text = self.amountText
        currencyLabel.text = self.currencyText
    }
}

