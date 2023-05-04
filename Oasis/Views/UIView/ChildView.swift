//
//  ChildView.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 04/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import UIKit
import Foundation

class ChildView: BaseUIView {
    lazy var childNamelabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 22),
                          color: .black)
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var childAgelabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 12),
                          color: .black)
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var spentlabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.medium.with(size: 13),
                          color: .black)
        lbl.text = "Spent"
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var valueSpentlabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 16),
                          color: .black)
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var totalValuelabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.medium.with(size: 10),
                          color: .black)
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var taskslabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.medium.with(size: 13),
                          color: .black)
        lbl.text = "Tasks"
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var goalslabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.medium.with(size: 13),
                          color: .black)
        lbl.text = "Goals"
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var numberOfTaskslabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 18),
                          color: .black)
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var numberOfGoalslabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 18),
                          color: .black)
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var thinLineView : BaseUIView = {
        let view = BaseUIView(frame: .zero)
        
        view.backgroundColor = .black
        view.autoLayout()
        return view
    }()
    
    lazy var childImageView : BaseImageView = {
        let imageview = BaseImageView(frame: .zero)
        
        imageview.contentMode = .scaleAspectFill
        imageview.autoLayout()
        return imageview
    }()
    
    lazy var valueBar : BaseUIView = {
        let view = BaseUIView(frame: .zero)
        
        view.backgroundColor = .orange
        view.roundCorners = .all(radius: 11)
        view.autoLayout()
        view.shadow = .active(with: .init(color: .orange,
                                          opacity: 0.3,
                                          radius: 6))
        return view
    }()
    
    lazy var childInfoView : BaseUIView = {
        let view = BaseUIView(frame: .zero)
        
        view.backgroundColor = .clear
        view.autoLayout()
        return view
    }()
    
    private var nameText : String = ""
    private var ageText : String = ""
    private var valueSpentText : String = ""
    private var totalValueText : String = ""
    private var numberOfTasksText : String = ""
    private var numberOfGoalsText : String = ""
    private var childIndex : Int = 0
    
    init(name nameTxt : String, age ageTxt : String, valueSpent valueSpentTxt : String, totalValue totalValueTxt : String, tasks tasksTxt : String, goals goalsTxt : String, imageName childImage: String){
        super.init(frame: .zero)
        self.nameText = nameTxt
        self.ageText = ageTxt
        self.valueSpentText = valueSpentTxt
        self.totalValueText = totalValueTxt
        self.numberOfTasksText = tasksTxt
        self.numberOfGoalsText = goalsTxt
        self.childImageView.image = UIImage(named: childImage)
        
        //Setup UI
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
        self.clipsToBounds = true
        self.autoLayout()
        self.shadow = .active(with: .init(color: .gray,
                                          opacity: 0.3,
                                          radius: 6))
        self.roundCorners = .all(radius: 14)
        self.backgroundColor = Constants.Colors.lightGrey
        
        self.addSubview(childImageView)
        self.addSubview(childAgelabel)
        self.addSubview(childInfoView)
        
        self.childInfoView.addSubview(childNamelabel)
        self.childInfoView.addSubview(spentlabel)
        self.childInfoView.addSubview(valueSpentlabel)
        self.childInfoView.addSubview(totalValuelabel)
        self.childInfoView.addSubview(taskslabel)
        self.childInfoView.addSubview(goalslabel)
        self.childInfoView.addSubview(numberOfTaskslabel)
        self.childInfoView.addSubview(numberOfGoalslabel)
        self.childInfoView.addSubview(thinLineView)
        self.childInfoView.addSubview(valueBar)

        NSLayoutConstraint.activate([
            childImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            childImageView.leadingAnchor.constraint(equalTo: self.centerXAnchor),
            childImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            childNamelabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 26),
            childNamelabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            
            childAgelabel.centerYAnchor.constraint(equalTo: self.childNamelabel.centerYAnchor),
            childAgelabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -26),
            childAgelabel.bottomAnchor.constraint(equalTo: childImageView.topAnchor),

            childInfoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            childInfoView.trailingAnchor.constraint(equalTo: childImageView.leadingAnchor, constant: 50),
            childInfoView.topAnchor.constraint(equalTo: self.childNamelabel.bottomAnchor, constant: 20),
            childInfoView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
           
            spentlabel.topAnchor.constraint(equalTo: self.childInfoView.topAnchor),
            spentlabel.leadingAnchor.constraint(equalTo: self.childInfoView.leadingAnchor),
           
            valueSpentlabel.topAnchor.constraint(equalTo: self.spentlabel.bottomAnchor),
            
            valueSpentlabel.leadingAnchor.constraint(equalTo: self.childInfoView.leadingAnchor),
            valueBar.topAnchor.constraint(equalTo: self.valueSpentlabel.bottomAnchor, constant: 2),
            valueBar.leadingAnchor.constraint(equalTo: self.childInfoView.leadingAnchor),
            valueBar.heightAnchor.constraint(equalToConstant: 17),
            valueBar.trailingAnchor.constraint(equalTo: self.childInfoView.trailingAnchor),
           
            totalValuelabel.topAnchor.constraint(equalTo: self.valueBar.bottomAnchor, constant: 5),
            totalValuelabel.leadingAnchor.constraint(equalTo: self.childInfoView.leadingAnchor),
           
            taskslabel.topAnchor.constraint(equalTo: self.totalValuelabel.bottomAnchor, constant: 18),
            taskslabel.leadingAnchor.constraint(equalTo: self.childInfoView.leadingAnchor),
            
            numberOfTaskslabel.topAnchor.constraint(equalTo: self.taskslabel.bottomAnchor),
            numberOfTaskslabel.leadingAnchor.constraint(equalTo: self.childInfoView.leadingAnchor),
            
            thinLineView.topAnchor.constraint(equalTo: self.taskslabel.topAnchor),
            thinLineView.leadingAnchor.constraint(equalTo: self.taskslabel.trailingAnchor, constant: 10),
            thinLineView.widthAnchor.constraint(equalToConstant: 1),
            thinLineView.bottomAnchor.constraint(equalTo: self.numberOfTaskslabel.bottomAnchor),
           
            goalslabel.topAnchor.constraint(equalTo: self.taskslabel.topAnchor),
            goalslabel.leadingAnchor.constraint(equalTo: self.thinLineView.trailingAnchor, constant: 30),
           
            numberOfGoalslabel.topAnchor.constraint(equalTo: self.goalslabel.bottomAnchor),
            numberOfGoalslabel.leadingAnchor.constraint(equalTo: self.goalslabel.leadingAnchor)
            
        ])
        
        childNamelabel.text = self.nameText
        childAgelabel.text = self.ageText
        numberOfGoalslabel.text = self.numberOfGoalsText
        numberOfTaskslabel.text = self.numberOfTasksText
        valueSpentlabel.text = self.valueSpentText
        totalValuelabel.text = self.totalValueText
        

    }
    
}
