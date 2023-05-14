//
//  GoalCollectionViewCell.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 12/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import UIKit

class GoalCollectionViewCell: UICollectionViewCell {

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
            savedlabel.text = "saved".localized
            savedlabel.style = .init(font: MainFont.medium.with(size: 13),
                                        color: .black)
        }
    }
    
    @IBOutlet weak var outofLabel: BaseLabel!{
        didSet{
            outofLabel.text = "Out Of".localized
            savedlabel.style = .init(font: MainFont.medium.with(size: 13),
                                        color: .black)
        }
    }
    
    @IBOutlet weak var outOfValuelabel: BaseLabel!
    
    @IBOutlet weak var bottomGreenView: BaseUIView!
    
    @IBOutlet weak var percentageGreenView: BaseUIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
