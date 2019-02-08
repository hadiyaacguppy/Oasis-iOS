//
//  VersionLabel.swift
//  Base-Project
//
//  Created by Wassim on 1/15/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit
class VersionLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.text = "v\(Bundle.versionNumber)/\(Bundle.buildNumber)"
    }
    
}

