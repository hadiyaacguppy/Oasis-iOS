//
//  TasksCollectionViewCell.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 08/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import UIKit

class TasksCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var taskContainerView: BaseUIView!{
        didSet{
            taskContainerView.backgroundColor = Constants.Colors.lightGrey
            taskContainerView.roundCorners = .all(radius: 14)
            taskContainerView.shadow = .active(with: .init(color: .gray,
                                                       opacity: 0.3,
                                                       radius: 6))
        }
    }
    
    @IBOutlet weak var taskTitleLabel: BaseLabel!{
        didSet{
            taskTitleLabel.style = .init(font: MainFont.medium.with(size: 11),
                                        color: .black)
        }
    }
    
    @IBOutlet weak var subtitleLabel:  BaseLabel!{
        didSet{
            subtitleLabel.style = .init(font: MainFont.bold.with(size: 15),
                                        color: .black, numberOfLines: 3)
        }
    }
    
    @IBOutlet weak var assignButton: OasisAquaButton!{
        didSet{
            assignButton.setTitle("Assign".localized, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(title : String, subTitle : String){
        self.taskTitleLabel.text = title
        self.subtitleLabel.text = subTitle
    }

}
