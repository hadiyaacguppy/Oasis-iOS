//
//  OccasionCollectionViewCell.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import UIKit

class OccasionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: BaseImageView!
    
    @IBOutlet weak var nameLabel: BaseLabel!{
        didSet{
            nameLabel.style = .init(font: MainFont.medium.with(size: 14), color: .black, alignment: .center)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(){
        imageView.image = R.image.birthday()!
        nameLabel.text = "Birthday"
    }
}
