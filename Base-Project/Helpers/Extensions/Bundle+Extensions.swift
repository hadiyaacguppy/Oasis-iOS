//
//  Bundle+Extensions.swift
//  Base-Project
//
//  Created by Hadi Yaacoub on 9/27/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation


extension Bundle {
    
    static
    var appName: String? {
        return self.main.infoDictionary?["CFBundleName"] as? String
    }
    
    static
    var bundleId: String? {
        return self.main.bundleIdentifier
    }
    
    static
    var versionNumber: String? {
        return self.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    static
    var buildNumber: String? {
        return self.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
}
