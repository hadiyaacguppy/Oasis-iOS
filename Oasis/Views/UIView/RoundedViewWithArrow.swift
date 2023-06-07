//
//  RoundedViewWithArrow.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 07/06/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import UIKit

class RoundedViewWithArrow: BaseUIView {
    private lazy var arrowImage : BaseImageView = {
        let img = BaseImageView(frame: .zero)
        img.image = R.image.longWhiteArrow()!
        img.contentMode = .scaleAspectFit
        img.autoLayout()
        return img
    }()
   
    required override init(frame : CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private
    func setupUI(){
        self.backgroundColor = UIColor(hexFromString: "#D9D9D9", alpha: 0.3)
        self.roundCorners = .all(radius: 43)
        self.autoLayout()
        self.addSubview(arrowImage)
        
        NSLayoutConstraint.activate([
            arrowImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            arrowImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            arrowImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            arrowImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
}
