//
//  TeensTasksCollectionViewCell.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 26/06/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import UIKit

class TeensTasksCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var whiteBgView: BaseUIView!{
        didSet{
            whiteBgView.backgroundColor = .white
            whiteBgView.roundCorners = .all(radius: 14)
        }
    }
    
    @IBOutlet weak var newTaskIconImageView: BaseImageView!{
        didSet{
            newTaskIconImageView.image = R.image.newTaskicon()
        }
    }
    
    @IBOutlet weak var tickImageView: BaseImageView!{
        didSet{
            tickImageView.image = R.image.ellipse4()
        }
    }
    
    @IBOutlet weak var taskTypeLabel: BaseLabel!{
        didSet{
            taskTypeLabel.style = .init(font: MainFont.normal.with(size: 11), color: .black)
        }
    }
    
    
    @IBOutlet weak var descriptionLabel: BaseLabel!{
        didSet{
            descriptionLabel.style = .init(font: MainFont.bold.with(size: 18), color: .black, alignment: .left, numberOfLines: 2)

        }
    }
    
    @IBOutlet weak var amountLabel: BaseLabel!{
        didSet{
            amountLabel.style = .init(font: MainFont.medium.with(size: 20), color: .black)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUI(model : TeensTasksModels.ViewModels.Task){
        taskTypeLabel.text = model.taskTitle
        descriptionLabel.text = model.taskDescription
        amountLabel.text = "\(model.amount ?? 0)  " + (model.currency ?? "")
    }

}
