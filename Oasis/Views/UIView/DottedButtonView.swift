//
//  DotedButton.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 12/06/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import UIKit

class DottedButtonView: BaseUIView {
    
    lazy var dottedImageView : UIImageView = {
        let imgView = UIImageView()
        imgView.image = R.image.rectangleBorder()
        imgView.autoLayout()
        return imgView
    }()
    
    lazy var buttonTitle : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.medium.with(size: 20), color: .black)
        lbl.textAlignment = .center
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var smallImageView : UIImageView = {
        let imgView = UIImageView()
        imgView.autoLayout()
        return imgView
    }()
    init(actionName action: String, viewHeight vHeight : CGFloat, viewWidth vWidth : CGFloat, viewRadius vRadius : CGFloat, numberOflines numLines : Int, innerImage smallImg : UIImage?){//height,width,radius,number of lines
        super.init(frame: .zero)
        buttonTitle.text = action
        buttonTitle.numberOfLines = numLines
        self.roundCorners = .all(radius: vRadius)
        smallImageView.image = smallImg
        
        setupUI(viewHeight: vHeight, viewWidth: vWidth, hasImage: smallImg == nil ? false : true )
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(viewHeight : CGFloat, viewWidth : CGFloat, hasImage : Bool){
        self.addSubview(dottedImageView)
        self.addSubview(buttonTitle)
        self.addSubview(smallImageView)
        
        smallImageView.widthAnchor.constraint(equalToConstant: 28).isActive = hasImage

        NSLayoutConstraint.activate([
            dottedImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dottedImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dottedImageView.topAnchor.constraint(equalTo: self.topAnchor),
            dottedImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            buttonTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            smallImageView.trailingAnchor.constraint(equalTo: buttonTitle.leadingAnchor, constant: -15),
            smallImageView.heightAnchor.constraint(equalToConstant: 28),
            smallImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
}
