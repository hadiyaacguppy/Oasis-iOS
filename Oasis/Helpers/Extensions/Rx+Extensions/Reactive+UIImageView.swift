//
//  Reactive+UIImageView.swift
//  Oasis
//
//  Created by Mojtaba Al Mousawi on 8/8/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit


extension Reactive where Base: UIImageView {
    
    /// Bindable sink for setNormalImage function
    var imageURL : Binder<URL?> {
        return Binder(base) { imageView, url in
            imageView.setNormalImage(withURL: url)
        }
    }
}
