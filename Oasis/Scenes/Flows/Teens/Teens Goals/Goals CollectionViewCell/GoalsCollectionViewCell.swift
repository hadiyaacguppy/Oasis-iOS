//
//  GoalsCollectionViewCell.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/07/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import UIKit

class GoalsCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var goalTitleLabel: BaseLabel!{
        didSet{
            goalTitleLabel.style = .init(font: MainFont.bold.with(size: 23), color: .white, alignment: .left, numberOfLines: 2)
        }
    }
    
    @IBOutlet weak var amountLabel: BaseLabel!{
        didSet{
            amountLabel.style = .init(font: MainFont.medium.with(size: 22), color: .white, alignment: .left, numberOfLines: 2)
        }
    }
    
    @IBOutlet weak var addMoneyButton: BaseButton!{
        didSet{
            addMoneyButton.style = .init(titleFont: MainFont.bold.with(size: 22), titleColor: .white, backgroundColor: Constants.Colors.teensYellow)
            addMoneyButton.setTitle("Add Money".localized, for: .normal)
            addMoneyButton.roundCorners = .all(radius: 37)
        }
    }
    
    @IBOutlet weak var percentageLabel: BaseLabel!{
        didSet{
            percentageLabel.style = .init(font: MainFont.bold.with(size: 25), color: .black, alignment: .center, numberOfLines: 1)

        }
    }
    
    @IBOutlet weak var percentageView: BaseUIView!{
        didSet{
            percentageView.backgroundColor = Constants.Colors.aquaMarine
            percentageView.roundCorners = .all(radius: 10)
        }
    }
    
    @IBOutlet weak var backPercentageView: BaseUIView!{
        didSet{
            backPercentageView.backgroundColor = Constants.Colors.teensGoals
            backPercentageView.roundCorners = .all(radius: 10)

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setupCell(vm : TeensGoalsModels.ViewModels.Goal){
        goalTitleLabel.text = vm.goalTitle
        amountLabel.text = "\(vm.amount!)\n\(vm.currency!)"
        updatePercentageView(amount: vm.amount!, saved: vm.saved!)
    }
    
    func updatePercentageView(amount : Int, saved : Int){
        let percentage = (saved * 100)/amount
        let percentageWidth = (percentage * Int(backPercentageView.frame.size.width)) / 100
        percentageLabel.text = " \(percentage) %"
        NSLayoutConstraint.activate([
            percentageView.widthAnchor.constraint(equalToConstant: CGFloat(percentageWidth))
        ])
    }
}
