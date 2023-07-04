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
        label.style = .init(font: MainFont.medium.with(size: 22), color: .black)
        label.autoLayout()
        return label
    }()
    
    
    lazy var amountTextField : AmountTextField = {
        let txtF = AmountTextField()
        txtF.keyboardType = .numberPad
        txtF.autoLayout()
        return txtF
    }()
    
    lazy var currencyLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.medium.with(size: 18),color: .black)
        lbl.autoLayout()
        return lbl
    }()
    
    private var underlineView : BaseUIView = {
        let view = BaseUIView(frame: .zero)
        view.backgroundColor = .black
        view.autoLayout()
        return view
    }()
    
    lazy var currencyPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.contentMode = .center
        picker.autoLayout()
        return picker
    }()
    
    
    init(amountPlaceHolder : Float, amount : Int?, currency : String, titleLbl : String, frame : CGRect, textColor : UIColor, textSize : CGFloat) {
        super.init(frame: frame)
        
        self.amountTextField.attributedPlaceholder = NSAttributedString(string: "\(amountPlaceHolder)", attributes: [NSAttributedString.Key.foregroundColor : textColor])
        self.amountTextField.textColor = textColor
        self.amountTextField.font = MainFont.medium.with(size: textSize)

        self.amountTitleLabel.text = titleLbl
        self.amountTitleLabel.textColor = textColor
        self.amountTitleLabel.font = MainFont.medium.with(size: textSize)

        self.underlineView.backgroundColor = textColor
        
        self.currencyLabel.textColor = textColor
        self.currencyLabel.text = currency

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
        self.addSubview(currencyPicker)
        
        currencyPicker.isHidden = true
        currencyLabel.onTap {
            self.currencyPicker.isHidden = false
        }
        
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
            currencyLabel.widthAnchor.constraint(equalToConstant: 45),
            
            currencyPicker.trailingAnchor.constraint(equalTo: self.currencyLabel.trailingAnchor),
            currencyPicker.heightAnchor.constraint(equalToConstant: 100),
            currencyPicker.widthAnchor.constraint(equalToConstant: 100),
            currencyPicker.topAnchor.constraint(equalTo: self.currencyLabel.topAnchor)
        ])
        
    }
}

