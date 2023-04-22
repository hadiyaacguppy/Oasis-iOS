//
//  ChildrenFSPagerViewCell.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 22/04/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import UIKit
import FSPagerView

class ChildrenFSPagerViewCell: FSPagerViewCell {

    @IBOutlet weak var childNameLabel: BaseLabel!{
        didSet{
            childNameLabel.style = .init(font: MainFont.bold.with(size: 22),
                                         color: .black)
        }
    }
    @IBOutlet weak var ageLabel: BaseLabel!{
        didSet{
            ageLabel.style = .init(font: MainFont.medium.with(size: 14),
                                         color: .black)
        }
    }
    @IBOutlet weak var kidImageView: UIImageView!
    
    @IBOutlet weak var shapeImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(childName : String, age : String, imageName : String){
        childNameLabel.text = childName
        ageLabel.text = age
        kidImageView.image = UIImage(named: imageName)
    }
    
}
