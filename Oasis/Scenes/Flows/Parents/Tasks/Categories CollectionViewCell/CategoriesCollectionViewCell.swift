//
//  CategoriesCollectionViewCell.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 21/06/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoriesContainerView: BaseUIView!{
        didSet{
            categoriesContainerView.backgroundColor = Constants.Colors.appGrey
        }
    }
    
    @IBOutlet weak var categoryLabel: BaseLabel!{
        didSet{
            categoryLabel.style = .init(font: MainFont.normal.with(size: 12),
                                        color: .black,
                                        alignment: .center,
                                        numberOfLines: 1)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(category : String){
        categoryLabel.text = category
    }
}
