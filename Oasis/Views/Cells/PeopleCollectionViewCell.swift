//
//  PeopleCollectionViewCell.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import UIKit

class PeopleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            //imageView.cornerRadius = imageView.height / 2
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(){
        imageView.image = R.image.ovalCopy9()!
    }
}
