//
//  UpcomingPaymentCollectionViewCell.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 22/04/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import UIKit

class UpcomingPaymentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: BaseUIView!{
        didSet{
            containerView.backgroundColor = Constants.Colors.lightGrey
            containerView.roundCorners = .all(radius: 14)
            containerView.shadow = .active(with: .init(color: .gray,
                                                       opacity: 0.3,
                                                       radius: 6))
        }
    }
    
    @IBOutlet weak var theTitleLabel: BaseLabel!{
        didSet{
            theTitleLabel.style = .init(font: MainFont.bold.with(size: 18),
                                        color: .black, numberOfLines: 2)
        }
    }
    @IBOutlet weak var subtitleLabel: BaseLabel!{
        didSet{
            subtitleLabel.style = .init(font: MainFont.bold.with(size: 12),
                                        color: .black, numberOfLines: 1)
        }
    }
    @IBOutlet weak var amountLabel: BaseLabel!{
        didSet{
            amountLabel.style = .init(font: MainFont.medium.with(size: 14),
                                      color: .black, numberOfLines: 1)
        }
    }
    @IBOutlet weak var payNowButton: OasisVioletButton!{
        didSet{
            payNowButton.setTitle("Pay Now".localized, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(title : String, subtitle : String, amount : String){
        self.theTitleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.amountLabel.text = amount
    }
}
