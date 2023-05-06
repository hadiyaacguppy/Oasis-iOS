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
        label.autoLayout()
        label.style = .init(font: MainFont.medium.with(size: 22), color: .black)
        return label
    }()
    
    lazy var anyTextField : AmountTextField = {
        let txtF = AmountTextField()
        return txtF
    }()
    
    private var underlineView : BaseUIView = {
        let view = BaseUIView(frame: .zero)
        view.autoLayout()
        view.backgroundColor = .black
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
    
    private var hasEditingView : Bool = false
    private var isitAgeRequest : Bool = false
    
    init(requestTitle requesT : String, placeHolderTxt pHolder : String, usertext txt : String, isAgeRequest isAge : Bool, hasEditView editview : Bool){
        super.init(frame: .zero)
        self.requestTitleLabel.text = requesT
        self.anyTextField.text = txt
        self.anyTextField.placeholder = pHolder
        self.hasEditingView = editview
        self.isitAgeRequest = isAge
        
        setupUIStandered()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUIStandered()
    }
    
    private func setupUIStandered(){
        self.autoLayout()
        self.backgroundColor = .clear
        
        self.addSubview(requestTitleLabel)
        self.addSubview(anyTextField)
        self.addSubview(underlineView)
        self.addSubview(yearsOldLabel)
        
        if hasEditingView{
            self.addSubview(editingtview)
            self.editingtview.isHidden = false
        }else{
            self.editingtview.isHidden = true
        }
        
        if !isitAgeRequest{
            yearsOldLabel.text = ""
        }
                
        NSLayoutConstraint.activate([
            requestTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            requestTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            requestTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            requestTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            anyTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            anyTextField.topAnchor.constraint(equalTo: self.requestTitleLabel.bottomAnchor),
            anyTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            anyTextField.heightAnchor.constraint(equalToConstant: 45),
            
            underlineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            underlineView.topAnchor.constraint(equalTo: self.anyTextField.bottomAnchor),
            underlineView.heightAnchor.constraint(equalToConstant: 1),
            underlineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            yearsOldLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            yearsOldLabel.leadingAnchor.constraint(equalTo: self.underlineView.trailingAnchor),
            yearsOldLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 71),
            yearsOldLabel.bottomAnchor.constraint(equalTo: self.underlineView.bottomAnchor),
            yearsOldLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
