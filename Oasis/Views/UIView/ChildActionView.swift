//
//  ChildActionView.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 08/06/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import UIKit

class ChildActionView: BaseUIView {
    
    private var actionImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.autoLayout()
        return imageView
    }()
    
    private var actionLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.normal.with(size: 12), color: .black)
        lbl.textAlignment = .center
        lbl.autoLayout()
        return lbl
    }()
    
    init(actionImage img : String, actionName action: String){
        super.init(frame: .zero)
        actionImageView.image = UIImage(named: img)
        actionLabel.text = action
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private
    func setupUI(){
    
        self.addSubview(actionImageView)
        self.addSubview(actionLabel)
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 100),
            actionImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            actionImageView.widthAnchor.constraint(equalToConstant: 28),
            actionImageView.heightAnchor.constraint(equalToConstant: 28),
            actionImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            actionLabel.topAnchor.constraint(equalTo: actionImageView.bottomAnchor, constant: 9),
            actionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            actionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
