//
//  TitleWithTextFieldView.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 05/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import UIKit

class TitleWithTextFieldView: BaseUIView {
    
    lazy var requestTitleLabel : BaseLabel = {
        let label = BaseLabel()
        label.numberOfLines = 1
        label.autoLayout()
        return label
    }()
    
    lazy var anyTextField : AmountTextField = {
        let txtF = AmountTextField()
        txtF.autoLayout()
        return txtF
    }()
    
    private var underlineView : BaseUIView = {
        let view = BaseUIView(frame: .zero)
        view.autoLayout()
        return view
    }()
    
    private var editingtview : BaseUIView = {
        let view = BaseUIView(frame: .zero)
        view.autoLayout()
        view.backgroundColor = .clear
        return view
    }()
    
    private var yearsOldLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.text = "Years old"
        lbl.style = .init(font: MainFont.medium.with(size: 15), color: .black)
        lbl.autoLayout()
        return lbl
    }()
    
    private var labelHeight : CGFloat = 89
    private var hasEditingView : Bool = false
    private var isitAgeRequest : Bool = false
    
    init(requestTitle requesT : String, placeHolderTxt pHolder : String, usertext txt : String, isAgeRequest isAge : Bool, hasEditView editview : Bool){
        super.init(frame: .zero)
        self.requestTitleLabel.text = requesT
        self.requestTitleLabel.style = .init(font: MainFont.medium.with(size: 22), color: .black)
        self.underlineView.backgroundColor = .black
        self.anyTextField.text = txt
        self.anyTextField.placeholder = pHolder
        self.hasEditingView = editview
        self.isitAgeRequest = isAge
        
        setupUIStandered()
    }
    
    init(requestTitle requestT : String, textsColor txtColor : UIColor, usertext txt : String, textSize txtSize: CGFloat, isAgeRequest isAge : Bool, labelHeight lblHeight: CGFloat){
        super.init(frame: .zero)
        self.requestTitleLabel.text = requestT
        self.requestTitleLabel.style = .init(font: MainFont.medium.with(size: txtSize), color: txtColor)
        self.anyTextField.text = txt
        self.anyTextField.textColor = txtColor
        self.isitAgeRequest = isAge
        self.underlineView.backgroundColor = txtColor
        self.labelHeight = lblHeight

        setupUIStandered()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setupUIStandered()
    }
    
    private func setupUIStandered(){
        self.autoLayout()
        self.backgroundColor = .clear
        
        self.addSubview(requestTitleLabel)
        self.addSubview(anyTextField)
        self.addSubview(underlineView)
                
        NSLayoutConstraint.activate([
            requestTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            requestTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            requestTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            requestTitleLabel.heightAnchor.constraint(equalToConstant: self.labelHeight),
            
            anyTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            anyTextField.topAnchor.constraint(equalTo: self.requestTitleLabel.bottomAnchor, constant: 10),
            anyTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            anyTextField.heightAnchor.constraint(equalToConstant: 45),
            
            underlineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            underlineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            underlineView.topAnchor.constraint(equalTo: self.anyTextField.bottomAnchor, constant: 4),
            underlineView.heightAnchor.constraint(equalToConstant: 1)
            //underlineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            /*yearsOldLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            yearsOldLabel.leadingAnchor.constraint(equalTo: self.underlineView.trailingAnchor),
            yearsOldLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 71),
            yearsOldLabel.bottomAnchor.constraint(equalTo: self.underlineView.bottomAnchor),
            yearsOldLabel.heightAnchor.constraint(equalToConstant: 30)*/
        ])
    }
}
