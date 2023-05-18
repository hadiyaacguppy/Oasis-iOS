//
//  SuggestedTitlesCollectionViewCell.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 15/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import UIKit

class SuggestedTitlesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var greenBGView: BaseUIView!{
        didSet{
            greenBGView.backgroundColor = .clear
            greenBGView.roundCorners = .all(radius: 14)
        }
    }
    
    @IBOutlet weak var taskLabel: BaseLabel!{
        didSet{
            taskLabel.style = .init(font: MainFont.bold.with(size: 10),
                                        color: .black)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(taskTitle : String, indexOfCell : Int){
        taskLabel.text = taskTitle
        if indexOfCell == 0{
                greenBGView.backgroundColor = Constants.Colors.aquaMarine
                taskLabel.textColor = .white
            }else{
                greenBGView.backgroundColor = .clear
                taskLabel.textColor = .black
            }
    }
}
