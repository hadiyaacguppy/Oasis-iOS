//
//  InterestsCollectionViewCell.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 11/04/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import UIKit

class InterestsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            imageView.cornerRadius = 20.0
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.layer.borderWidth = 3.0
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.font = MainFont.medium.with(size: 16)
            descriptionLabel.textColor = .white
        }
    }
    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    
    
    var image: UIImage? {
        didSet {
            if let image = image {
                imageView.image = image
            } else {
                imageView.backgroundColor = .lightGray
            }
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? PinterestLayoutAttributes {
            //change image view height by changing its constraint
            imageViewHeightLayoutConstraint.constant = attributes.imageHeight
        }
    }
}
