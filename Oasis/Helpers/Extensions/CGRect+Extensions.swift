//
//  CGRect+Extensions.swift
//  Oasis
//
//  Created by Wassim on 11/9/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import UIKit

public extension CGRect {
    
    ///aspect ratio of the rect, i.e. width/height. For a height of 0 the aspect ratio is 0
    var aspectRatio: CGFloat {
        guard self.size.height > 0 else { return 0 }
        return self.size.width / self.size.height
    }
}
