//
//  BalanceCardView.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/06/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import UIKit

class BalanceCardView: BaseUIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 19
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = R.image.fishRight()
        imgView.autoLayout()
        return imgView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = R.image.guppyLogo()
        imgView.autoLayout()
        return imgView
    }()

    private lazy var titleLabel : BaseLabel = {
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 20), color: .white)
        label.text = "Balance"
        label.autoLayout()
        return label
    }()
    
    private lazy var amountLabel : BaseLabel = {
        let label = BaseLabel()
        label.style = .init(font: MainFont.bold.with(size: 40), color: .white)
        label.text = "0.00"
        label.autoLayout()
        return label
    }()
    
    private lazy var currencyLabel : BaseLabel = {
        let label = BaseLabel()
        label.style = .init(font: MainFont.bold.with(size: 40), color: .white)
        label.text = "LBP"
        label.autoLayout()
        return label
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
