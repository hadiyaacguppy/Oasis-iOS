//
//  ChildTaskCollectionViewCell.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/06/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import UIKit

class ChildTaskCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var taskContainerView: BaseUIView!{
        didSet{
            taskContainerView.backgroundColor = .white
            taskContainerView.roundCorners = .all(radius: 14)
        }
    }
    
    @IBOutlet weak var taskTypeLabel: BaseLabel!{
        didSet{
            taskTypeLabel.style = .init(font: MainFont.normal.with(size: 11), color: .black)
        }
    }
    
    @IBOutlet weak var taskTitleLabel: BaseLabel!{
        didSet{
            taskTitleLabel.style = .init(font: MainFont.bold.with(size: 18), color: .black)
            taskTitleLabel.numberOfLines = 2
        }
    }
    
    @IBOutlet weak var amountLabel: BaseLabel!{
        didSet{
            amountLabel.style = .init(font: MainFont.medium.with(size: 14), color: .black)
        }
    }
    
    @IBOutlet weak var childImageView: BaseImageView!{
        didSet{
            childImageView.roundCorners = .all(radius: 22)
        }
    }
    
    @IBOutlet weak var statusLabel: BaseLabel!{
        didSet{
            statusLabel.style = .init(font: MainFont.normal.with(size: 10), color: .black)
            statusLabel.numberOfLines = 2
        }
    }
    
    @IBOutlet weak var actionButton: BaseButton!{
        didSet{
            actionButton.roundCorners = .all(radius: 34)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(viewModel : ChildDetailsModels.ViewModels.TaskDetails){
        taskTypeLabel.text = viewModel.taskType?.uppercased()
        taskTitleLabel.text = viewModel.taskTitle
        amountLabel.text = viewModel.amount
        statusLabel.text = viewModel.status
        actionButton.setTitle(viewModel.actionTitle, for: .normal)
        childImageView.image = UIImage(named: viewModel.childImage!)
        
        if viewModel.actionTitle == "Pay off"{
            actionButton.style = .init(titleFont: MainFont.bold.with(size: 11), titleColor: .white, backgroundColor: Constants.Colors.aquaMarine)
            
        }else{
            actionButton.style = .init(titleFont: MainFont.bold.with(size: 11), titleColor: .white, backgroundColor: Constants.Colors.appYellow)
            
        }
    }

}
