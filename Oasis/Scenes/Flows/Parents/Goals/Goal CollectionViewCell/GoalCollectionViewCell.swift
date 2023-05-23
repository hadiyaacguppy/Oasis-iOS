//
//  GoalCollectionViewCell.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 12/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import UIKit

class GoalCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var goalImageView: BaseImageView!{
        didSet{
            goalImageView.contentMode = .scaleAspectFill
            goalImageView.roundCorners = .all(radius: 14)
//            goalImageView.roundCorners = .topLeft(radius: 14)
//            goalImageView.roundCorners = .topRight(radius: 14)
            
        }
    }
    
    @IBOutlet weak var containerView: BaseUIView!{
        didSet{
            containerView.backgroundColor = Constants.Colors.lightGrey
            containerView.roundCorners = .all(radius: 14)

        }
    }
    
    @IBOutlet weak var goalTitle: BaseLabel!{
        didSet{
            goalTitle.style = .init(font: MainFont.bold.with(size: 18),
                                        color: .black, numberOfLines: 2)
        }
    }
    
    @IBOutlet weak var savedlabel: BaseLabel!{
        didSet{
            savedlabel.text = "saved".localized
            savedlabel.style = .init(font: MainFont.medium.with(size: 13),
                                        color: .black)
        }
    }
    
    @IBOutlet weak var savedValueLabel: BaseLabel!{
        didSet{
            savedValueLabel.text = "saved".localized
            savedValueLabel.style = .init(font: MainFont.bold.with(size: 14),
                                        color: .black)
        }
    }
    
    @IBOutlet weak var outofLabel: BaseLabel!{
        didSet{
            outofLabel.text = "Out Of".localized
            outofLabel.style = .init(font: MainFont.medium.with(size: 13),
                                        color: .black)
        }
    }
    
    @IBOutlet weak var outOfValuelabel: BaseLabel!{
        didSet{
            outOfValuelabel.text = "saved".localized
            outOfValuelabel.style = .init(font: MainFont.bold.with(size: 14),
                                        color: .black)
        }
    }
    
    @IBOutlet weak var bottomGreenView: BaseUIView!{
        didSet{
            bottomGreenView.backgroundColor = Constants.Colors.lightGreen
            bottomGreenView.roundCorners = .all(radius: 14)
        }
    }
    
    @IBOutlet weak var percentageGreenView: BaseUIView!{
        didSet{
            percentageGreenView.backgroundColor = Constants.Colors.aquaMarine
            percentageGreenView.roundCorners = .all(radius: 8)
            
        }
    }
    
    @IBOutlet weak var percentageLabel: BaseLabel!
    {
        didSet{
            percentageLabel.style = .init(font: MainFont.bold.with(size: 18), color: .white)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(titleForGoal : String, savedValue : String, outOfValue : String, percentageValue : Int, goalImage : String ){
        goalTitle.text = titleForGoal
        savedValueLabel.text = savedValue
        outOfValuelabel.text = outOfValue
        percentageLabel.text = "\(percentageValue)"
        updatePercentageView(percentage: percentageValue)
        goalImageView.image = UIImage(named: goalImage)
        
    }
    
    func updatePercentageView(percentage : Int){
    
        let percentageWidth = (percentage * Int(bottomGreenView.frame.size.width)) / 100
        NSLayoutConstraint.activate([
            percentageGreenView.widthAnchor.constraint(equalToConstant: CGFloat(percentageWidth))
        ])
    }
}
