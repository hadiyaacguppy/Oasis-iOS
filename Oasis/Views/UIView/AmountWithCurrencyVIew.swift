//
//  AmountWithCurrencyVIew.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import UIKit

class AmountWithCurrencyView: BaseUIView {
    
    lazy var amountTitleLabel : BaseLabel = {
        let label = BaseLabel()
        label.autoLayout()
        label.style = .init(font: MainFont.medium.with(size: 22), color: .black)
        return label
    }()
    
    
    lazy var amountTextField : AmountTextField = {
        let txtF = AmountTextField()
        return txtF
    }()
    
    lazy var currencyLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.medium.with(size: 18),
                          color: .black)
        lbl.autoLayout()
        return lbl
    }()
    
    private var underlineView : BaseUIView = {
        let view = BaseUIView(frame: .zero)
        view.autoLayout()
        view.backgroundColor = .black
        return view
    }()
    
    var currencyValue : String = ""
    
    init(defaultValue defaultV : Float = 0.0, currency : String, titleLbl : String) {
        super.init(frame: .zero)
        self.amountTextField.text = "\(defaultV)"
        self.currencyValue = currency
        self.amountTitleLabel.text = titleLbl
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
        self.backgroundColor = .clear
        
        self.addSubview(amountTitleLabel)
        self.addSubview(amountTextField)
        self.addSubview(underlineView)
        self.addSubview(currencyLabel)
        
        
        NSLayoutConstraint.activate([
            
            amountTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            amountTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            amountTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            amountTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            amountTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            amountTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            amountTextField.topAnchor.constraint(equalTo: self.amountTitleLabel.bottomAnchor, constant: 10),
            
            underlineView.leadingAnchor.constraint(equalTo: amountTextField.leadingAnchor),
            underlineView.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 4),
            underlineView.heightAnchor.constraint(equalToConstant: 1),
            underlineView.trailingAnchor.constraint(equalTo: amountTextField.trailingAnchor),
            
            currencyLabel.leadingAnchor.constraint(equalTo: amountTextField.trailingAnchor, constant: 10),
            currencyLabel.bottomAnchor.constraint(equalTo: underlineView.bottomAnchor),
            currencyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            currencyLabel.widthAnchor.constraint(equalToConstant: 45)
        ])
        
        currencyLabel.text = currencyValue
    }
}

