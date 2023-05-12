//
//  SuggestedTaskView.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 11/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import UIKit

class SuggestedTaskView : BaseUIView {
    
    lazy var backgroudGreyView : BaseUIView = {
        let view = BaseUIView()
        view.backgroundColor = Constants.Colors.lightGrey
        view.roundCorners = .all(radius: 14)
        view.shadow = .active(with: .init(color: .gray,
                                                   opacity: 0.3,
                                                   radius: 6))
        view.autoLayout()
        return view
    }()
    
    lazy var taskTitleLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.medium.with(size: 11),
                                    color: .black)
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var subtitleLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 15),
                                        color: .black, numberOfLines: 3)
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var assignButton : OasisAquaButton = {
        let btn = OasisAquaButton()
        btn.setTitle("Assign".localized, for: .normal)
        btn.autoLayout()
        return btn
    }()
    
    
    init(taskTitle titleTask : String, taskSubTitle subTitletask : String){
        super.init(frame: .zero)
        self.taskTitleLabel.text = titleTask
        self.subtitleLabel.text = subTitletask
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        //setupUI()
    }
    
    private func setupUIStandered(){
        self.autoLayout()
        self.backgroundColor = .clear
        
        self.addSubview(taskTitleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(assignButton)
        
        NSLayoutConstraint.activate([
            taskTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 19),
            taskTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            taskTitleLabel.heightAnchor.constraint(equalToConstant: 14),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: taskTitleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: taskTitleLabel.bottomAnchor, constant: 12),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 57),
            
            assignButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 19),
            assignButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 19),
            assignButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 5),
            assignButton.heightAnchor.constraint(equalToConstant: 34),
            assignButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
}
