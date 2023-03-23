//
//  VersionLabel.swift
//  Oasis
//
//  Created by Wassim on 1/15/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit
class VersionLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let versionNum = AppManager.current.versionNumber
        let buildNumber = AppManager.current.buildNumber
        self.text = "v\(versionNum)/\((buildNumber))"
    }
}

