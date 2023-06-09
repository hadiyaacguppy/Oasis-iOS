//
//  FriendsCollectionViewCell.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 29/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import UIKit

class FriendsCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var friendimageview: BaseImageView!{
        didSet{
            friendimageview.contentMode = .scaleAspectFit
            friendimageview.roundCorners = .all(radius: 38)
        }
    }
    
    @IBOutlet weak var friendNameLabel: BaseLabel!{
        didSet{
            friendNameLabel.style = .init(font: MainFont.bold.with(size: 14), color: .black, numberOfLines: 2)
        }
    }
    
    @IBOutlet weak var bottomButton: OasisAquaButton!{
        didSet{
            bottomButton.setTitle("Remove", for: .normal)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(viewModel : FriendsModels.ViewModels.Friend){
        friendimageview.setNormalImage(withURL: viewModel.image)
        friendNameLabel.text = viewModel.name
        
    }

}
