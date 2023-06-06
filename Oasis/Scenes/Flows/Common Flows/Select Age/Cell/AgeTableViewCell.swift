//
//  AgeTableViewCell.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/04/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import UIKit

class AgeTableViewCell: UITableViewCell {

    @IBOutlet weak var selectionView: BaseUIView!{
        didSet{
            selectionView.roundCorners = .all(radius: 15)
            selectionView.backgroundColor = UIColor(hexFromString: "#D9D9D9", alpha: 0.3)
        }
    }
    @IBOutlet weak var ageNumberLabel: BaseLabel!{
        didSet{
            ageNumberLabel.style = .init(font: MainFont.bold.with(size: 35), color: .white, alignment: .center)
        }
    }
    
    @IBOutlet weak var ageTitleLabel: BaseLabel!{
        didSet{
            ageTitleLabel.style = .init(font: MainFont.bold.with(size: 35), color: .white)
        }
    }
    
    func setupCell(ageNumber : String, fontSize : CGFloat = 65, isAgeSelected : Bool = false){
        self.ageNumberLabel.text = ageNumber
        
        if isAgeSelected{
            selectionView.backgroundColor = UIColor(red: 25/255, green: 22/255, blue: 31/255, alpha: 0.47)
            ageNumberLabel.style = .init(font: MainFont.bold.with(size: fontSize),
                                         color: .white,
                                         alignment: .center)
        }else{
            selectionView.backgroundColor = .clear
            ageNumberLabel.style = .init(font: MainFont.medium.with(size: fontSize),
                                         color: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7),
                                         alignment: .center)
        }
    }
    
}
