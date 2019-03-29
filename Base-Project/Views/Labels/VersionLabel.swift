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
        guard  let versionNum = AppManager().versionNumber else { return }
        guard let buildNumber = AppManager().buildNumber else { return }
        self.text = "v\(versionNum)/\((buildNumber))"
    }
}

